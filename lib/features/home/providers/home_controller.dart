import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_client.dart';
import '../../../core/providers/location_provider.dart';
import '../models/gig_model.dart';

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

final gigsProvider = AsyncNotifierProvider<GigsController, List<Gig>>(() {
  return GigsController();
});

class GigsController extends AsyncNotifier<List<Gig>> {
  RealtimeChannel? _channel;

  @override
  Future<List<Gig>> build() async {
    final isOnline = ref.watch(isOnlineProvider);

    _channel?.unsubscribe();
    _channel = null;

    ref.onDispose(() {
      _channel?.unsubscribe();
    });

    if (!isOnline) {
      return [];
    }

    _subscribeRealtime();
    return _fetchTasks();
  }

  Future<List<Gig>> _fetchTasks() async {
    try {
      final dio = ref.read(apiClientProvider).dio;

      // Use real GPS from the background location provider
      // Falls back to India's geographic centre only if no fix yet
      final pos = ref.read(locationProvider);
      final lat = pos?.latitude ?? 20.5937;
      final lng = pos?.longitude ?? 78.9629;

      final response = await dio.get(
        '/tasks/available?lat=$lat&lng=$lng&radius_km=10.0&limit=50',
      );
      final responseData = response.data;
      final data = (responseData is Map && responseData.containsKey('tasks')
              ? responseData['tasks'] as List?
              : responseData as List?) ??
          [];
      return data.map((e) => Gig.fromJson(e)).toList();
    } catch (e) {
      // Return empty list rather than throwing so the HomeScreen doesn't
      // show a false "No Internet Connection" error on API failures.
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
            final newTasks = await _fetchTasks();
            state = AsyncValue.data(newTasks);
          } catch (_) {}
        },
      ).subscribe();
    } catch (_) {}
  }
}
