import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/api/api_client.dart';
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
      if (value) await updateLocation();
    } catch (_) {
      // Silently ignore — UI state is already correct
    }
  }

  Future<void> updateLocation() async {
    try {
      final dio = ref.read(apiClientProvider).dio;
      await dio.put('/auth/rider/location', data: {'lat': 0.0, 'lng': 0.0});
    } catch (e) {
      // ignore
    }
  }
}

final gigsProvider = AsyncNotifierProvider<GigsController, List<Gig>>(() {
  return GigsController();
});

class GigsController extends AsyncNotifier<List<Gig>> {
  @override
  Future<List<Gig>> build() async {
    final isOnline = ref.watch(isOnlineProvider);
    if (!isOnline) {
      return [];
    }
    
    try {
      final dio = ref.read(apiClientProvider).dio;
      final response = await dio.get('/tasks/available?lat=0.0&lng=0.0&radius_km=10.0&limit=50');
      final responseData = response.data;
      final data = (responseData is Map && responseData.containsKey('tasks')
          ? responseData['tasks'] as List?
          : responseData as List?) ?? [];
      return data.map((e) => Gig.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Failed to load tasks: $e');
    }
  }
}
