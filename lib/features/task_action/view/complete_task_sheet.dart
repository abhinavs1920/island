import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/task_action_provider.dart';

class CompleteTaskSheet extends ConsumerStatefulWidget {
  final String taskId;

  const CompleteTaskSheet({Key? key, required this.taskId}) : super(key: key);

  static Future<void> show(BuildContext context, String taskId) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CompleteTaskSheet(taskId: taskId),
    );
  }

  @override
  ConsumerState<CompleteTaskSheet> createState() => _CompleteTaskSheetState();
}

class _CompleteTaskSheetState extends ConsumerState<CompleteTaskSheet> {
  int _rating = 5;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(taskActionProvider);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface, // surface
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)), // md says rounded-t-xl which is 12px
        border: Border(top: BorderSide(color: Theme.of(context).colorScheme.outlineVariant), left: BorderSide(color: Theme.of(context).colorScheme.outlineVariant), right: BorderSide(color: Theme.of(context).colorScheme.outlineVariant)),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 20, 
            right: 20, 
            bottom: MediaQuery.of(context).viewInsets.bottom > 0 ? MediaQuery.of(context).viewInsets.bottom + 16 : 24, 
            top: 16
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag Handle
              Container(
                width: 48,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.outlineVariant, // outline-variant
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              
              Text(
                'Task Completed',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'How was your experience with Alex?',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant, // on-surface-variant
                ),
              ),
              const SizedBox(height: 24),
              
              // Stars
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    iconSize: 40,
                    padding: const EdgeInsets.all(8),
                    icon: Icon(
                      Icons.star,
                      color: index < _rating ? const Color(0xFFEAB308) : Theme.of(context).colorScheme.outlineVariant,
                    ),
                    onPressed: () {
                      setState(() {
                        _rating = index + 1;
                      });
                    },
                  );
                }),
              ),
              const SizedBox(height: 24),
              
              // Feedback
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Additional Feedback (Optional)',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    letterSpacing: 0.7,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Leave a note about the drop-off...',
                  hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5)),
                  fillColor: Theme.of(context).colorScheme.surfaceContainerLowest, // surface
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Actions
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF166534), // success
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    side: const BorderSide(color: Color(0xFF14532D)),
                    elevation: 0,
                  ),
                  onPressed: state.isLoading ? null : () async {
                    await ref.read(taskActionProvider.notifier).completeTask(widget.taskId);
                    if (context.mounted && !ref.read(taskActionProvider).hasError) {
                      Navigator.pop(context);
                      context.push('/activegig/post-gig-summary');
                    }
                  },
                  child: state.isLoading 
                    ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Submit and finish', style: Theme.of(context).textTheme.labelLarge?.copyWith(letterSpacing: 0.7)),
                          const SizedBox(width: 8),
                          const Icon(Icons.check_circle, size: 20),
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
                    foregroundColor: Theme.of(context).colorScheme.primary, // primary
                  ),
                  child: Text('Skip rating', style: Theme.of(context).textTheme.labelLarge?.copyWith(letterSpacing: 0.7)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
