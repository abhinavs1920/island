import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/api/api_client.dart';
import '../../../core/utils/remote_logger.dart';
import '../../../core/storage/secure_storage.dart';

final activeTaskIdProvider = FutureProvider<String?>((ref) async {
  return await ref.read(storageServiceProvider).getLatestTaskId();
});

// State class for chat messages
class ChatState {
  final List<dynamic> messages;
  final bool isLoading;
  final String? error;

  ChatState({this.messages = const [], this.isLoading = true, this.error});

  ChatState copyWith({List<dynamic>? messages, bool? isLoading, String? error}) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

// StateNotifier to manage fetching history and listening to realtime
class ChatNotifier extends StateNotifier<ChatState> {
  final String taskId;
  final Ref ref;
  RealtimeChannel? _channel;

  ChatNotifier(this.taskId, this.ref) : super(ChatState()) {
    _init();
  }

  Future<void> _init() async {
    await _fetchHistory();
    _subscribeRealtime();
  }

  Future<void> _fetchHistory() async {
    try {
      final apiClient = ref.read(apiClientProvider).dio;
      final response = await apiClient.get('/tasks/$taskId/chat');
      
      if (mounted) {
        state = state.copyWith(messages: response.data as List<dynamic>, isLoading: false);
      }
    } catch (e) {
      if (mounted) {
        state = state.copyWith(isLoading: false, error: e.toString());
      }
      RemoteLogger.error('Failed to fetch chat history for $taskId', e);
    }
  }

  void _subscribeRealtime() {
    try {
      final supabase = Supabase.instance.client;
      _channel = supabase.channel('chat_$taskId').onPostgresChanges(
        event: PostgresChangeEvent.insert,
        schema: 'public',
        table: 'chat_messages',
        filter: PostgresChangeFilter(
          type: PostgresChangeFilterType.eq,
          column: 'task_id',
          value: taskId,
        ),
        callback: (payload) {
          final newMessage = payload.newRecord;
          if (mounted) {
            // Check if message already exists (optimistic UI)
            final exists = state.messages.any((msg) => msg['id'] == newMessage['id']);
            if (!exists) {
              state = state.copyWith(messages: [...state.messages, newMessage]);
            }
          }
        },
      ).subscribe((status, [error]) {
        if (status == RealtimeSubscribeStatus.subscribed) {
          RemoteLogger.log('Connected to chat realtime for $taskId');
        } else if (status == RealtimeSubscribeStatus.closed) {
          RemoteLogger.log('Disconnected from chat realtime for $taskId');
        } else if (status == RealtimeSubscribeStatus.channelError) {
          RemoteLogger.error('Realtime channel error for $taskId', error);
          // Manually re-fetch history if disconnected
          _fetchHistory();
        }
      });
    } catch (e) {
      RemoteLogger.error('Failed to subscribe to Supabase realtime for $taskId', e);
    }
  }

  @override
  void dispose() {
    _channel?.unsubscribe();
    super.dispose();
  }
}

final chatMessagesProvider = StateNotifierProvider.family<ChatNotifier, ChatState, String>((ref, taskId) {
  return ChatNotifier(taskId, ref);
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
    // We don't invalidate here, we rely on Supabase Realtime to push the new message down!
  }
}
