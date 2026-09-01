import 'package:geolocator/geolocator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_client.dart';
import '../models/gig_model.dart';

/// Fetches the rider's current GPS position once.
/// Returns null if permission is denied or location services are off.
Future<Position?> _getCurrentPosition() async {
  try {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      timeLimit: const Duration(seconds: 10),
    );
  } catch (_) {
    return null;
  }
}

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
      if (value) await updateLocation();
    } catch (_) {
      // Silently ignore — UI state is already correct
    }
  }

  Future<void> updateLocation() async {
    try {
      final dio = ref.read(apiClientProvider).dio;
      final position = await _getCurrentPosition();
      final lat = position?.latitude ?? 0.0;
      final lng = position?.longitude ?? 0.0;
      await dio.put('/auth/rider/location', data: {'lat': lat, 'lng': lng});
    } catch (e) {
      // ignore
    }
  }
}

final gigsProvider = AsyncNotifierProvider<GigsController, List<Gig>>(() {
  return GigsController();
});

class GigsController extends AsyncNotifier<List<Gig>> {
  RealtimeChannel? _channel;
  Position? _lastPosition;

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

    // Fetch real position once when going online
    _lastPosition = await _getCurrentPosition();

    _subscribeRealtime();
    return _fetchTasks();
  }

  Future<List<Gig>> _fetchTasks() async {
    try {
      final dio = ref.read(apiClientProvider).dio;
      // Use real GPS coords if available, else fall back to a central default
      final lat = _lastPosition?.latitude ?? 20.5937;
      final lng = _lastPosition?.longitude ?? 78.9629;
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
      // Return empty list on any API failure rather than propagating the error.
      // The HomeScreen's "No Internet Connection" error body fires on ANY throw,
      // which misleads the user when the device IS online but the server responded
      // with an error (4xx / 5xx / timeout). An empty gig list is more honest.
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
          // Whenever a task is inserted, updated, or deleted, just refresh the list
          try {
            final newTasks = await _fetchTasks();
            state = AsyncValue.data(newTasks);
          } catch (e) {
            // Ignore fetch errors during realtime refresh to prevent breaking existing UI
          }
        },
      ).subscribe();
    } catch (e) {
      // Ignore realtime subscribe errors
    }
  }
}
