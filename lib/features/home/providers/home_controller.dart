import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_client.dart';
import '../../../core/providers/location_provider.dart';
import '../models/gig_model.dart';
import '../widgets/task_filter_dialog.dart';

final isOnlineProvider = NotifierProvider<IsOnlineController, bool>(() {
  return IsOnlineController();
});

class IsOnlineController extends Notifier<bool> {
  @override
  bool build() {
    return false; // Default offline
  }

  Future<void> toggle(bool value) async {
    // Optimistic UI update — always apply immediately
    state = value;

    // Fire-and-forget: best-effort backend sync, never revert UI
    try {
      final dio = ref.read(apiClientProvider).dio;
      await dio.put('/auth/rider/availability', data: {'is_available': value});
      // Force a fresh location push when going online
      if (value) {
        await ref.read(locationProvider.notifier).refresh();
      }
    } catch (_) {
      // Silently ignore — UI state is already correct
    }
  }
}

final taskFilterProvider = StateProvider<TaskFilterCriteria>((ref) {
  return const TaskFilterCriteria();
});

final gigsProvider = AsyncNotifierProvider<GigsController, List<Gig>>(() {
  return GigsController();
});

class GigsController extends AsyncNotifier<List<Gig>> {
  RealtimeChannel? _channel;
  List<Gig> _rawTasks = [];

  @override
  Future<List<Gig>> build() async {
    final isOnline = ref.watch(isOnlineProvider);
    final filter = ref.watch(taskFilterProvider);

    _channel?.unsubscribe();
    _channel = null;

    ref.onDispose(() {
      _channel?.unsubscribe();
    });

    if (!isOnline) {
      _rawTasks = [];
      return [];
    }

    _subscribeRealtime();
    _rawTasks = await _fetchTasks();
    return _applyFilterAndSort(_rawTasks, filter);
  }

  List<Gig> _applyFilterAndSort(List<Gig> tasks, TaskFilterCriteria filter) {
    List<Gig> result = List.from(tasks);

    // Filter by urgency
    if (filter.urgentOnly) {
      result = result.where((g) => g.tags.any((t) => t.toLowerCase().contains('urgent') || t.toLowerCase().contains('high'))).toList();
    }

    // Filter by distance if parseable
    if (filter.maxDistanceKm != null) {
      result = result.where((g) {
        final match = RegExp(r'([\d\.]+)').firstMatch(g.distance);
        if (match != null) {
          final dist = double.tryParse(match.group(1) ?? '') ?? 0.0;
          return dist <= filter.maxDistanceKm!;
        }
        return true;
      }).toList();
    }

    // Sorting
    switch (filter.sortBy) {
      case TaskSortOption.priceHighToLow:
        result.sort((a, b) => b.price.compareTo(a.price));
        break;
      case TaskSortOption.priceLowToHigh:
        result.sort((a, b) => a.price.compareTo(b.price));
        break;
      case TaskSortOption.urgencyFirst:
        result.sort((a, b) {
          final aUrgent = a.tags.any((t) => t.toLowerCase().contains('urgent'));
          final bUrgent = b.tags.any((t) => t.toLowerCase().contains('urgent'));
          if (aUrgent && !bUrgent) return -1;
          if (!aUrgent && bUrgent) return 1;
          return 0;
        });
        break;
      case TaskSortOption.postedDate:
        // Already in newest-first or by index
        break;
      case TaskSortOption.distanceNearest:
      default:
        // Default distance ordering from API
        break;
    }

    return result;
  }

  Future<void> rejectGig(String taskId) async {
    // 1. Optimistic removal from UI list
    _rawTasks.removeWhere((g) => g.id == taskId);
    final filter = ref.read(taskFilterProvider);
    state = AsyncValue.data(_applyFilterAndSort(_rawTasks, filter));

    // 2. Call backend reject endpoint to persist rejection in DB
    try {
      final dio = ref.read(apiClientProvider).dio;
      await dio.post('/tasks/$taskId/reject');
    } catch (_) {
      // Rejection failed silently on network error; UI stays clean
    }
  }

  Future<List<Gig>> _fetchTasks() async {
    try {
      final dio = ref.read(apiClientProvider).dio;
      final pos = ref.read(locationProvider);
      final lat = pos?.latitude ?? 20.5937;
      final lng = pos?.longitude ?? 78.9629;

      final response = await dio.get(
        '/tasks/available?lat=$lat&lng=$lng&limit=50',
      );
      final responseData = response.data;
      final data = (responseData is Map && responseData.containsKey('tasks')
              ? responseData['tasks'] as List?
              : responseData as List?) ??
          [];
      return data.map((e) => Gig.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  void _subscribeRealtime() {
    try {
      final supabase = Supabase.instance.client;
      _channel = supabase.channel('available_tasks').onPostgresChanges(
        event: PostgresChangeEvent.all,
        schema: 'public',
        table: 'tasks',
        callback: (payload) async {
          try {
            _rawTasks = await _fetchTasks();
            final filter = ref.read(taskFilterProvider);
            state = AsyncValue.data(_applyFilterAndSort(_rawTasks, filter));
          } catch (_) {}
        },
      ).subscribe();
    } catch (_) {}
  }
}

final activeGigsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final isOnline = ref.watch(isOnlineProvider);
  if (!isOnline) return [];

  try {
    final dio = ref.read(apiClientProvider).dio;
    final response = await dio.get('/tasks/rider/history');
    final list = (response.data as List?) ?? [];
    return list
        .whereType<Map<String, dynamic>>()
        .where((t) => t['status'] == 'rider_matched' || t['status'] == 'in_progress')
        .toList();
  } catch (e) {
    return [];
  }
});

