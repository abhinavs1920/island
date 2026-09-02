import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../../core/api/api_client.dart';
import '../../../core/storage/secure_storage.dart';

class TaskDetailNotifier extends FamilyAsyncNotifier<Map<String, dynamic>, String> {
  RealtimeChannel? _channel;

  @override
  Future<Map<String, dynamic>> build(String arg) async {
    _channel?.unsubscribe();
    _channel = null;

    ref.onDispose(() {
      _channel?.unsubscribe();
    });

    if (arg.isNotEmpty) {
      _subscribeRealtime(arg);
    }
    return _fetchTask(arg);
  }

  Future<Map<String, dynamic>> _fetchTask(String taskId) async {
    if (taskId.isEmpty) {
      throw Exception('No Task ID specified');
    }
    final apiClient = ref.read(apiClientProvider).dio;
    final response = await apiClient.get('/tasks/$taskId');
    if (response.data is Map<String, dynamic>) {
      return response.data as Map<String, dynamic>;
    } else if (response.data is Map) {
      return Map<String, dynamic>.from(response.data as Map);
    } else {
      throw Exception('Invalid task data returned from server');
    }
  }

  void _subscribeRealtime(String taskId) {
    try {
      final supabase = Supabase.instance.client;
      _channel = supabase.channel('task_$taskId').onPostgresChanges(
        event: PostgresChangeEvent.all,
        schema: 'public',
        table: 'tasks',
        filter: PostgresChangeFilter(
          type: PostgresChangeFilterType.eq,
          column: 'id',
          value: taskId,
        ),
        callback: (payload) async {
          try {
            final updatedTask = await _fetchTask(taskId);
            state = AsyncValue.data(updatedTask);
          } catch (e) {
            // ignore
          }
        },
      ).subscribe();
    } catch (e) {
      // ignore
    }
  }
}

final taskDetailProvider = AsyncNotifierProvider.family<TaskDetailNotifier, Map<String, dynamic>, String>(() {
  return TaskDetailNotifier();
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
      
      // Save it so the Chat tab resolves to this task
      await ref.read(storageServiceProvider).saveLatestTaskId(taskId);
      
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
