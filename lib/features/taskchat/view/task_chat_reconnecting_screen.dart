import 'package:flutter/material.dart';

class TaskChatReconnectingScreen extends StatelessWidget {
  const TaskChatReconnectingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: colorScheme.primary),
          onPressed: () {},
        ),
        title: Text(
          'TaskRunner',
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.toggle_on, color: colorScheme.primary, size: 32),
            onPressed: () {},
          ),
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
          // Reconnecting Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            color: colorScheme.surfaceContainerHigh,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(colorScheme.onSurfaceVariant),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Reconnecting...',
                  style: textTheme.labelMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          // Chat Header
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              border: Border(
                bottom: BorderSide(color: colorScheme.surfaceContainerHighest),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  child: Icon(Icons.person, color: colorScheme.onSurfaceVariant),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Alex Johnson',
                        style: textTheme.labelLarge?.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Task #8492 - Furniture Assembly',
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Messages
          Expanded(
            child: Container(
              color: colorScheme.surfaceContainerLowest, // surface-muted
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Text(
                        'Today',
                        style: textTheme.labelMedium?.copyWith(
                          color: colorScheme.secondary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  _buildMessageBubble(
                    context: context,
                    text: "Hey! Just checking if you're still on track for 2 PM?",
                    time: '1:15 PM',
                    isMe: false,
                  ),
                  _buildMessageBubble(
                    context: context,
                    text: 'Hi Alex, yes I am! I just wrapped up my previous task and am heading your way now.',
                    time: '1:18 PM',
                    isMe: true,
                    statusIcon: Icons.done_all,
                  ),
                  _buildMessageBubble(
                    context: context,
                    text: 'Perfect. The boxes are in the living room. See you soon.',
                    time: '1:20 PM',
                    isMe: false,
                  ),
                  Opacity(
                    opacity: 0.7,
                    child: _buildMessageBubble(
                      context: context,
                      text: "Sounds good. My GPS says I'll be there in 15 mins.",
                      time: '1:25 PM',
                      isMe: true,
                      statusIcon: Icons.schedule,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Input
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              border: Border(
                top: BorderSide(color: colorScheme.surfaceContainerHighest),
              ),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.add_circle, color: colorScheme.secondary),
                    onPressed: null,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(24.0),
                        border: Border.all(color: colorScheme.outlineVariant.withOpacity(0.5)),
                      ),
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          hintStyle: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant.withOpacity(0.5)),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: colorScheme.primary.withOpacity(0.5)),
                    onPressed: null,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble({
    required BuildContext context,
    required String text,
    required String time,
    required bool isMe,
    IconData? statusIcon,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 300),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: isMe ? colorScheme.primaryContainer : colorScheme.surfaceContainer,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(8),
                  topRight: const Radius.circular(8),
                  bottomLeft: isMe ? const Radius.circular(8) : Radius.zero,
                  bottomRight: isMe ? Radius.zero : const Radius.circular(8),
                ),
                border: Border.all(
                  color: isMe ? colorScheme.primary.withOpacity(0.2) : colorScheme.outlineVariant.withOpacity(0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    text,
                    style: textTheme.bodyMedium?.copyWith(
                      color: isMe ? colorScheme.onPrimaryContainer : colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 10,
                          color: isMe ? colorScheme.onPrimaryContainer.withOpacity(0.7) : colorScheme.secondary,
                        ),
                      ),
                      if (statusIcon != null) ...[
                        const SizedBox(width: 4),
                        Icon(
                          statusIcon,
                          size: 12,
                          color: colorScheme.onPrimaryContainer.withOpacity(0.7),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
