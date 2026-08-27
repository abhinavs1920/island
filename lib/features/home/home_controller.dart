import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/api/api_client.dart';
import 'gig_model.dart';

final isOnlineProvider = NotifierProvider<IsOnlineController, bool>(() {
  return IsOnlineController();
});

class IsOnlineController extends Notifier<bool> {
  @override
  bool build() {
    return false; // Default offline
  }

  Future<void> toggle(bool value) async {
    // Optimistic UI update
    state = value;
    
    // Call update_availability
    try {
      final dio = ref.read(apiClientProvider).dio;
      await dio.post('/update_availability', data: {'available': value});
      
      // Also update location when toggling
      await updateLocation();
    } catch (e) {
      // Revert on error
      state = !value;
    }
  }

  Future<void> updateLocation() async {
    try {
      final dio = ref.read(apiClientProvider).dio;
      await dio.post('/update_location', data: {'lat': 0.0, 'lng': 0.0});
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
      final response = await dio.get('/get_nearby_tasks');
      final data = response.data['tasks'] as List? ?? [];
      return data.map((e) => Gig.fromJson(e)).toList();
    } catch (e) {
      // Return mock data for demonstration if backend fails
      return [
        Gig(
          id: '1',
          title: 'Heavy Furniture Moving',
          price: 85,
          description: 'Downtown Office to Storage Unit',
          distance: '1.2 mi',
          duration: '~2 hrs',
          icon: 'local_shipping',
          tags: ['Heavy'],
        ),
        Gig(
          id: '2',
          title: 'Groceries Delivery',
          price: 22,
          description: 'Whole Foods to Elm Street',
          distance: '0.5 mi',
          duration: '~30 mins',
          icon: 'shopping_basket',
        ),
        Gig(
          id: '3',
          title: 'Post-Event Cleanup',
          price: 120,
          description: 'City Park Pavilion',
          distance: '3.4 mi',
          duration: '~4 hrs',
          icon: 'cleaning_services',
        ),
      ];
    }
  }
}
