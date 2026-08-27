import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_client.dart';
import 'package:dio/dio.dart';

final chatMessagesProvider = FutureProvider.family<List<dynamic>, String>((ref, taskId) async {
  final apiClient = ref.read(apiClientProvider).dio;
  final response = await apiClient.get('/tasks/$taskId/chat');
  return response.data as List<dynamic>;
});

final chatActionProvider = Provider<ChatAction>((ref) {
  return ChatAction(ref);
});

class ChatAction {
  final Ref ref;
  ChatAction(this.ref);

  Future<void> sendMessage(String taskId, String message) async {
    final apiClient = ref.read(apiClientProvider).dio;
    await apiClient.post('/tasks/$taskId/chat', data: {'message': message});
    ref.invalidate(chatMessagesProvider(taskId));
  }
}
