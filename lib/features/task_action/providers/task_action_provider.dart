import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_client.dart';
import '../../../core/storage/secure_storage.dart';

class TaskActionNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref ref;
  TaskActionNotifier(this.ref) : super(const AsyncValue.data(null));

  Future<void> completeTask(String taskId) async {
    state = const AsyncValue.loading();
    try {
      final apiClient = ref.read(apiClientProvider).dio;
      await apiClient.post('/tasks/$taskId/complete', data: {
        'rating': 5,
        'rating_note': 'Great job',
      });
      await ref.read(storageServiceProvider).clearLatestTaskId();
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> cancelTask(String taskId) async {
    state = const AsyncValue.loading();
    try {
      final apiClient = ref.read(apiClientProvider).dio;
      await apiClient.post('/tasks/$taskId/cancel', data: {
        'reason': 'User requested',
      });
      await ref.read(storageServiceProvider).clearLatestTaskId();
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final taskActionProvider = StateNotifierProvider<TaskActionNotifier, AsyncValue<void>>((ref) {
  return TaskActionNotifier(ref);
});
