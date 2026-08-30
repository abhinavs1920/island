import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_client.dart';
import '../models/gig_model.dart';

class GigHistoryNotifier extends AsyncNotifier<List<GigModel>> {
  @override
  Future<List<GigModel>> build() async {
    return fetchHistory();
  }

  Future<List<GigModel>> fetchHistory() async {
    try {
      final apiClient = ref.read(apiClientProvider).dio;
      final response = await apiClient.get('/tasks/rider/history');
      
      final data = response.data as List;
      final gigs = data.map((e) => GigModel.fromJson(e as Map<String, dynamic>)).toList();
      return gigs;
    } catch (e, st) {
      // Return empty or throw based on your error handling preference
      throw e;
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => fetchHistory());
  }
}

final gigHistoryProvider = AsyncNotifierProvider<GigHistoryNotifier, List<GigModel>>(() {
  return GigHistoryNotifier();
});
