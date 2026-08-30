import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/task_action_provider.dart';

class CancelTaskSheet extends ConsumerWidget {
  final String taskId;

  const CancelTaskSheet({Key? key, required this.taskId}) : super(key: key);

  static Future<void> show(BuildContext context, String taskId) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CancelTaskSheet(taskId: taskId),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(taskActionProvider);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface, // surface
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(top: BorderSide(color: Theme.of(context).colorScheme.outlineVariant)), // outline-variant
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag Handle
              Container(
                width: 48,
                height: 6,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.outlineVariant, // outline-variant
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.errorContainer, // error-container
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.warning, color: Theme.of(context).colorScheme.onErrorContainer), // on-error-container
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Cancel this task?',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'This action cannot be undone. Please select a reason if you wish to proceed.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant, // on-surface-variant
                ),
              ),
              const SizedBox(height: 16),
              
              // Chips
              Row(
                children: [
                  _buildChip(context, 'Requester unreachable'),
                  const SizedBox(width: 8),
                  _buildChip(context, 'Changed my mind'),
                ],
              ),
              const SizedBox(height: 16),
              Divider(color: Theme.of(context).colorScheme.outlineVariant, height: 1),
              const SizedBox(height: 16),
              
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.error, // error
                    foregroundColor: Theme.of(context).colorScheme.onError, // on-error
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                  ),
                  onPressed: state.isLoading ? null : () async {
                    await ref.read(taskActionProvider.notifier).cancelTask(taskId);
                    if (context.mounted && !ref.read(taskActionProvider).hasError) {
                      Navigator.pop(context);
                    }
                  },
                  child: state.isLoading 
                    ? SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Theme.of(context).colorScheme.onError, strokeWidth: 2))
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.cancel, size: 20),
                          const SizedBox(width: 8),
                          Text('Confirm cancel', style: Theme.of(context).textTheme.labelLarge?.copyWith(letterSpacing: 0.7)),
                        ],
                      ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: TextButton(
                  onPressed: state.isLoading ? null : () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.onSurface, // on-surface
                  ),
                  child: Text('Never mind', style: Theme.of(context).textTheme.labelLarge?.copyWith(letterSpacing: 0.7)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(BuildContext context, String label) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface, // surface
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Theme.of(context).colorScheme.outline), // outline
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
          letterSpacing: 0.7,
        ),
      ),
    );
  }
}
