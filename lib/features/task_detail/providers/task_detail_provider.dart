import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../../core/api/api_client.dart';

final taskDetailProvider = FutureProvider.family<Map<String, dynamic>, String>((ref, taskId) async {
  final apiClient = ref.read(apiClientProvider).dio;
  final response = await apiClient.get('/tasks/$taskId');
  return response.data;
});

final acceptTaskProvider = StateNotifierProvider<AcceptTaskNotifier, AsyncValue<bool>>((ref) {
  return AcceptTaskNotifier(ref);
});

class AcceptTaskNotifier extends StateNotifier<AsyncValue<bool>> {
  final Ref ref;
  AcceptTaskNotifier(this.ref) : super(const AsyncValue.data(false));

  Future<String> acceptTask(String taskId) async {
    state = const AsyncValue.loading();
    try {
      final apiClient = ref.read(apiClientProvider).dio;
      await apiClient.post('/tasks/$taskId/accept');
      state = const AsyncValue.data(true);
      return 'matched';
    } on DioException catch (e, st) {
      if (e.response?.statusCode == 409) {
        state = AsyncValue.error(e, st);
        return 'race_lost';
      }
      state = AsyncValue.error(e, st);
      return 'error';
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return 'error';
    }
  }
}
