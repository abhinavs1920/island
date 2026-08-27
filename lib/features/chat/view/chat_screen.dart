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
              data: (messages) => ListView.builder(
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
              ),
              loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFF003EC7))),
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
