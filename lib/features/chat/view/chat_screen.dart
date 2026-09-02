import 'package:url_launcher/url_launcher.dart';
import '../../../core/providers/viewing_scope_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/chat_provider.dart';
import '../../../core/storage/secure_storage.dart';
import '../../task_action/view/cancel_task_sheet.dart';
import '../../task_action/view/complete_task_sheet.dart';
import '../../task_detail/providers/task_detail_provider.dart';
import '../../task_action/providers/task_action_provider.dart';

// ─── Router shell: resolve 'latest' task id ──────────────────────────────────
class ChatScreen extends ConsumerWidget {
  final String taskId;
  const ChatScreen({Key? key, required this.taskId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (taskId == 'latest') {
      final activeTaskAsync = ref.watch(activeTaskIdProvider);
      return activeTaskAsync.when(
        data: (activeId) {
          if (activeId == null || activeId.isEmpty) {
            return const _EmptyChatScreen();
          }
          return _ActiveChatScreen(taskId: activeId);
        },
        loading: () => Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary)),
        ),
        error: (e, st) => const _EmptyChatScreen(),
      );
    }

    if (taskId == 'empty') {
      return const _EmptyChatScreen();
    }

    return _ActiveChatScreen(taskId: taskId);
  }
}

// ─── Empty state ─────────────────────────────────────────────────────────────
class _EmptyChatScreen extends StatelessWidget {
  const _EmptyChatScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Theme.of(context).colorScheme.outlineVariant, height: 1.0),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat_bubble_outline, size: 64, color: Theme.of(context).colorScheme.outline),
            const SizedBox(height: 16),
            Text(
              'No active chat',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            const SizedBox(height: 8),
            Text(
              'Accept a task to start chatting.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Active chat (StatefulWidget to manage controllers) ──────────────────────
class _ActiveChatScreen extends ConsumerStatefulWidget {
  final String taskId;
  const _ActiveChatScreen({required this.taskId});

  @override
  ConsumerState<_ActiveChatScreen> createState() => _ActiveChatScreenState();
}

class _ActiveChatScreenState extends ConsumerState<_ActiveChatScreen> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _sendMessage() async {
    final text = _textController.text.trim();
    if (text.isEmpty) return;
    _textController.clear();
    try {
      await ref.read(chatActionProvider).sendMessage(widget.taskId, text);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to send message')),
        );
      }
    }
  }

  Future<void> _onCancelTapped() async {
    await CancelTaskSheet.show(context, widget.taskId);
    if (!mounted) return;
    // If task was cancelled the latest_task_id was cleared — navigate home
    final latestId = await ref.read(storageServiceProvider).getLatestTaskId();
    if (latestId == null && mounted) {
      context.go('/home');
    }
  }

  Future<void> _onCompleteTapped() async {
    await CompleteTaskSheet.show(context, widget.taskId);
    if (!mounted) return;
    // If task was completed the latest_task_id was cleared — navigate home
    final latestId = await ref.read(storageServiceProvider).getLatestTaskId();
    if (latestId == null && mounted) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final messagesAsync = ref.watch(chatMessagesProvider(widget.taskId));
    final taskAsync = ref.watch(taskDetailProvider(widget.taskId));
    final taskStatus = taskAsync.value?['status'] as String?;

    // Auto-scroll when new messages arrive
    ref.listen(chatMessagesProvider(widget.taskId), (prev, next) {
      if (next.messages.length != (prev?.messages.length ?? 0)) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
      }
    });

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Active Task', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface)),
            Text('Chat with requester', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.phone, color: Theme.of(context).colorScheme.primary),
            tooltip: 'Call Requester',
            onPressed: () async {
              final taskData = taskAsync.value;
              final phone = taskData?['requester_phone']?.toString() ?? '+919876543210';
              final uri = Uri.parse('tel:$phone');
              try {
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                } else {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Could not open phone dialer')),
                    );
                  }
                }
              } catch (_) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Could not initiate call')),
                  );
                }
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                'Online',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Theme.of(context).colorScheme.outlineVariant, height: 1.0),
        ),
      ),
      body: Column(
        children: [
          // ── Message List ──────────────────────────────────────────────────
          Expanded(
            child: Builder(
              builder: (context) {
                if (messagesAsync.isLoading && messagesAsync.messages.isEmpty) {
                  return Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary));
                }
                if (messagesAsync.error != null && messagesAsync.messages.isEmpty) {
                  return Center(
                    child: Text(
                      'Could not load messages.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  );
                }

                final messages = messagesAsync.messages;
                if (messages.isEmpty) {
                  return Center(
                    child: Text(
                      'No messages yet. Say hello!',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index] as Map<String, dynamic>;
                    final isMe = msg['sender_type'] == 'rider';
                    return _ChatBubble(message: msg, isMe: isMe);
                  },
                );
              },
            ),
          ),

          // ── Footer ───────────────────────────────────────────────────────
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(top: BorderSide(color: Theme.of(context).colorScheme.outlineVariant)),
            ),
            child: SafeArea(
              bottom: true,
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Cancel / Complete buttons
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: OutlinedButton(
                              onPressed: _onCancelTapped,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Theme.of(context).colorScheme.onSurface,
                                side: BorderSide(color: Theme.of(context).colorScheme.outline, width: 2),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text(
                                'Cancel task',
                                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (taskStatus == 'rider_matched') {
                                  await ref.read(taskActionProvider.notifier).startTask(widget.taskId);
                                } else {
                                  _onCompleteTapped();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.secondary,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(taskStatus == 'rider_matched' ? Icons.play_arrow : Icons.check_circle, size: 20),
                                  const SizedBox(width: 4),
                                  Text(
                                    taskStatus == 'rider_matched' ? 'Start task' : 'Mark complete',
                                    style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Message input
                    Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Theme.of(context).colorScheme.outline),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        children: [
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _textController,
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                hintText: 'Type a message...',
                                hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                                isDense: true,
                              ),
                              onSubmitted: (_) => _sendMessage(),
                            ),
                          ),
                          Container(
                            width: 36,
                            height: 36,
                            margin: const EdgeInsets.only(right: 4),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.send, color: Colors.white, size: 18),
                              onPressed: _sendMessage,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Chat bubble ─────────────────────────────────────────────────────────────
class _ChatBubble extends StatelessWidget {
  final Map<String, dynamic> message;
  final bool isMe;
  const _ChatBubble({required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    final content = message['content'] as String? ?? '';

    if (!isMe) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.person, size: 16, color: Theme.of(context).colorScheme.onSecondaryContainer),
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                    topLeft: Radius.circular(2),
                  ),
                  border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                ),
                child: Text(
                  content,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
              ),
            ),
            const SizedBox(width: 48),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 48),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                  topRight: Radius.circular(2),
                ),
              ),
              child: Text(
                content,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
