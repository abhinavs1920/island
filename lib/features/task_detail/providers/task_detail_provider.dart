import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_client.dart';

final taskDetailProvider = FutureProvider.family<Map<String, dynamic>, String>((ref, taskId) async {
  final apiClient = ref.read(apiClientProvider).dio;
  final response = await apiClient.get('/get_task_details?task_id=$taskId');
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
      final response = await apiClient.post('/accept_task', data: {'task_id': taskId});
      state = const AsyncValue.data(true);
      return response.data['status'] as String; 
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return 'error';
    }
  }
}
