import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/chat_provider.dart';
import '../../task_action/view/cancel_task_sheet.dart';
import '../../task_action/view/complete_task_sheet.dart';

class ChatScreen extends ConsumerWidget {
  final String taskId;
  const ChatScreen({Key? key, required this.taskId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messagesAsync = ref.watch(chatMessagesProvider(taskId));
    final textController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // surface-container-lowest
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBF8FF), // surface
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF003EC7)),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('AC Repair', style: TextStyle(color: Color(0xFF191B25), fontSize: 20, fontWeight: FontWeight.w700)),
            Text('Indiranagar', style: TextStyle(color: Color(0xFF434656), fontSize: 14, fontWeight: FontWeight.w500)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                'Online',
                style: TextStyle(color: Color(0xFF003EC7), fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 0.7),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: const Color(0xFFC3C5D9), // outline-variant
            height: 1.0,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: messagesAsync.when(
              data: (messages) {
                if (messages.isEmpty) {
                  return const _ChatEmptyState();
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    final isMe = msg['sender_id'] == 'me'; // example logic
                    
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
                              decoration: const BoxDecoration(
                                color: Color(0xFFE5E2E1), // secondary-container
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.person, size: 16, color: Color(0xFF656464)),
                            ),
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEDEDFB), // surface-container
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                    topLeft: Radius.circular(2),
                                  ),
                                  border: Border.all(color: const Color(0xFFC3C5D9)),
                                ),
                                child: Text(msg['content'] ?? '', style: const TextStyle(color: Color(0xFF191B25), fontSize: 16)),
                              ),
                            ),
                            const SizedBox(width: 48), // limit width
                          ],
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(width: 48), // limit width
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF003EC7), // primary
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                    topRight: Radius.circular(2),
                                  ),
                                ),
                                child: Text(msg['content'] ?? '', style: const TextStyle(color: Color(0xFFFFFFFF), fontSize: 16)),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                );
              },
              loading: () => const Column(
                children: [
                  _ReconnectingBanner(),
                  Spacer(),
                ],
              ),
              error: (e, st) => Center(child: Text('Error loading chat: $e')),
            ),
          ),
          
          // Fixed Footer
          Container(
            color: const Color(0xFFFBF8FF), // surface
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFC3C5D9))),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: OutlinedButton(
                          onPressed: () => CancelTaskSheet.show(context, taskId),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF191B25),
                            side: const BorderSide(color: Color(0xFF737688), width: 2),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text('Cancel task', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 0.7)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () => CompleteTaskSheet.show(context, taskId),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00875A), // Complete green
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            elevation: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.check_circle, size: 20),
                              SizedBox(width: 4),
                              Text('Mark complete', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 0.7)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: const Color(0xFF737688)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add_circle, color: Color(0xFF737688)),
                        onPressed: () {},
                      ),
                      Expanded(
                        child: TextField(
                          controller: textController,
                          decoration: const InputDecoration(
                            hintText: 'Type a message...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        width: 32,
                        height: 32,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: const BoxDecoration(
                          color: Color(0xFF003EC7),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.send, color: Colors.white, size: 16),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatEmptyState extends StatelessWidget {
  const _ChatEmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: const Color(0xFFE8E7F3), // surface-container-high
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFC4C5D7).withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.chat_bubble, size: 48, color: Color(0xFF003EC7)), // primary
            ),
            const SizedBox(height: 16),
            const Text(
              'No messages yet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1B23), // on-surface
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Say hello and confirm the details for your upcoming task.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF5F5E5E), // secondary
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                _buildQuickReply("Hi there! I'm ready for the task."),
                _buildQuickReply("Can we confirm the address?"),
                _buildQuickReply("I'll be there in 15 mins."),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickReply(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFEDEDF8), // surface-container
        border: Border.all(color: const Color(0xFFC4C5D7)), // outline-variant
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFF434654), // on-surface-variant
        ),
      ),
    );
  }
}

class _ReconnectingBanner extends StatelessWidget {
  const _ReconnectingBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        color: Color(0xFFE8E7F3), // surface-container-high
        border: Border(bottom: BorderSide(color: Color(0xFFE2E1ED))), // surface-variant
        boxShadow: [
          BoxShadow(color: Color(0x0D000000), offset: Offset(0, 1), blurRadius: 2),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SizedBox(
            width: 14,
            height: 14,
            child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF434654)), // on-surface-variant
          ),
          SizedBox(width: 8),
          Text(
            'Reconnecting...',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF434654), // on-surface-variant
            ),
          ),
        ],
      ),
    );
  }
}
