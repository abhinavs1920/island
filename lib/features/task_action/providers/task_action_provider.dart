import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_client.dart';

class TaskActionNotifier extends StateNotifier<AsyncValue<void>> {
  TaskActionNotifier() : super(const AsyncValue.data(null));

  Future<void> completeTask(String taskId) async {
    state = const AsyncValue.loading();
    try {
      final apiClient = ApiClient();
      await apiClient.post('/complete_task', data: {'task_id': taskId});
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> cancelTask(String taskId) async {
    state = const AsyncValue.loading();
    try {
      final apiClient = ApiClient();
      await apiClient.post('/cancel_task', data: {'task_id': taskId});
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final taskActionProvider = StateNotifierProvider<TaskActionNotifier, AsyncValue<void>>((ref) {
  return TaskActionNotifier();
});
