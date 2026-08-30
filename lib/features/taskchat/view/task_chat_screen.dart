import 'package:flutter/material.dart';

class TaskChatScreen extends StatelessWidget {
  const TaskChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AC Repair',
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'Indiranagar',
              style: textTheme.labelMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Online',
              style: textTheme.labelLarge?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: colorScheme.outlineVariant,
            height: 1.0,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Text(
                      'Today, 10:42 AM',
                      style: textTheme.labelMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
                _buildMessageBubble(
                  context: context,
                  text: 'Hi, are you reaching soon? The AC is completely dead.',
                  isMe: false,
                ),
                _buildMessageBubble(
                  context: context,
                  text: "Yes, I'm about 5 minutes away. Just crossed the main signal.",
                  isMe: true,
                ),
                _buildMessageBubble(
                  context: context,
                  text: 'Okay, great. The building gate might be closed, just give me a call when you are outside.',
                  isMe: false,
                ),
                _buildMessageBubble(
                  context: context,
                  text: 'Will do.',
                  isMe: true,
                  timeLabel: 'Read 10:45 AM',
                  isRead: true,
                ),
              ],
            ),
          ),
          _buildFooterActions(context),
        ],
      ),
    );
  }

  Widget _buildMessageBubble({
    required BuildContext context,
    required String text,
    required bool isMe,
    String? timeLabel,
    bool isRead = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe)
            Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.only(right: 8.0),
              decoration: BoxDecoration(
                color: colorScheme.secondaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person,
                size: 16,
                color: colorScheme.onSecondaryContainer,
              ),
            ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: isMe ? colorScheme.primary : colorScheme.surfaceContainer,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: isMe ? const Radius.circular(12) : const Radius.circular(2),
                  bottomRight: isMe ? const Radius.circular(2) : const Radius.circular(12),
                ),
                border: isMe ? null : Border.all(color: colorScheme.outlineVariant),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    text,
                    style: textTheme.bodyMedium?.copyWith(
                      color: isMe ? colorScheme.onPrimary : colorScheme.onSurface,
                    ),
                  ),
                  if (timeLabel != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.done_all,
                            size: 12,
                            color: isMe ? colorScheme.onPrimary.withOpacity(0.8) : colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            timeLabel,
                            style: TextStyle(
                              fontSize: 10,
                              color: isMe ? colorScheme.onPrimary.withOpacity(0.8) : colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (isMe)
            const SizedBox(width: 40), // Balance the avatar space
        ],
      ),
    );
  }

  Widget _buildFooterActions(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      color: colorScheme.surface,
      padding: const EdgeInsets.all(16.0),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colorScheme.onSurface,
                      side: BorderSide(color: colorScheme.outline),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                    ),
                    child: const Text('Cancel task'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.check_circle),
                    label: const Text('Mark complete'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00875A), // Green
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(24.0),
                border: Border.all(color: colorScheme.outline),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.add_circle, color: colorScheme.outline),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.send, color: colorScheme.onPrimary, size: 16),
                      onPressed: () {},
                      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
