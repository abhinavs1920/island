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
    
    ref.listen<AsyncValue<void>>(taskActionProvider, (previous, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to complete task: ${next.error}')));
      } else if (!next.isLoading && previous?.isLoading == true) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Task completed successfully!')));
      }
    });

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFBF8FF), // surface
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)), // md says rounded-t-xl which is 12px
        border: Border(top: BorderSide(color: Color(0xFFC3C5D9)), left: BorderSide(color: Color(0xFFC3C5D9)), right: BorderSide(color: Color(0xFFC3C5D9))),
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
                  color: const Color(0xFFC3C5D9), // outline-variant
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              
              const Text(
                'Task Completed',
                style: TextStyle(
                  color: Color(0xFF191B25),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'How was your experience with Alex?',
                style: TextStyle(
                  color: Color(0xFF434656), // on-surface-variant
                  fontSize: 16,
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
                      color: index < _rating ? const Color(0xFFEAB308) : const Color(0xFFC3C5D9),
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
                child: const Text(
                  'Additional Feedback (Optional)',
                  style: TextStyle(
                    color: Color(0xFF434656),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.7,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Leave a note about the drop-off...',
                  hintStyle: TextStyle(color: const Color(0xFF434656).withOpacity(0.5)),
                  fillColor: const Color(0xFFFFFFFF),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFC3C5D9)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF003EC7)),
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
                    }
                  },
                  child: state.isLoading 
                    ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Submit and finish', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 0.7)),
                          SizedBox(width: 8),
                          Icon(Icons.check_circle, size: 20),
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
                    foregroundColor: const Color(0xFF003EC7), // primary
                  ),
                  child: const Text('Skip rating', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 0.7)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
