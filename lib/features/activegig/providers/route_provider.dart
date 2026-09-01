import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_client.dart';
import '../models/route_info_model.dart';

class RouteNotifier extends StateNotifier<AsyncValue<RouteInfoModel?>> {
  final Ref ref;

  RouteNotifier(this.ref) : super(const AsyncValue.data(null));

  Future<void> fetchRoute(String taskId, double lat, double lng) async {
    state = const AsyncValue.loading();
    try {
      final apiClient = ref.read(apiClientProvider).dio;
      final response = await apiClient.get('/tasks/$taskId/route?lat=$lat&lng=$lng');
      
      final routeInfo = RouteInfoModel.fromJson(response.data as Map<String, dynamic>);
      state = AsyncValue.data(routeInfo);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final routeProvider = StateNotifierProvider<RouteNotifier, AsyncValue<RouteInfoModel?>>(
  (ref) => RouteNotifier(ref),
);
