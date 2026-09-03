import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../api/api_client.dart';
import '../storage/secure_storage.dart';

/// Holds the latest known GPS position.
/// Started automatically on app launch — no manual trigger needed.
class LocationNotifier extends Notifier<Position?> {
  StreamSubscription<Position>? _sub;

  @override
  Position? build() {
    // Clean up stream when provider is disposed
    ref.onDispose(() => _sub?.cancel());

    // Kick off immediately
    _init();

    return null; // initial state before first fix
  }

  Future<void> _init() async {
    // 1. Check + request permissions
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    // 2. Get an immediate fix
    try {
      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );
      state = pos;
    } catch (_) {}

    // 3. Subscribe to continuous updates (high accuracy, every ~30m or 15s)
    final locationSettings = AndroidSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 30,       // metres before triggering update
      intervalDuration: const Duration(seconds: 15),
    );

    _sub = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen(
      (pos) {
        state = pos;
        // Sync to backend whenever position updates and rider is online
        _pushToBackend(pos);
      },
      onError: (_) {},
    );
  }

  Future<void> _pushToBackend(Position pos) async {
    final token = await ref.read(storageServiceProvider).getToken();
    if (token == null) return;
    try {
      final dio = ref.read(apiClientProvider).dio;
      await dio.put('/auth/rider/location', data: {
        'lat': pos.latitude,
        'lng': pos.longitude,
      });
    } catch (_) {
      // Ignore — best effort, will retry on next position update
    }
  }

  /// Force a fresh one-shot fetch (e.g. called when going online).
  Future<void> refresh() async {
    try {
      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );
      state = pos;
      await _pushToBackend(pos);
    } catch (_) {}
  }
}

final locationProvider = NotifierProvider<LocationNotifier, Position?>(
  LocationNotifier.new,
);
