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
      decoration: const BoxDecoration(
        color: Color(0xFFFBF8FF), // surface
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(top: BorderSide(color: Color(0xFFC3C5D9))),
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
                  color: const Color(0xFFC3C5D9), // outline-variant
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFDAD6), // error-container
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.warning, color: Color(0xFF93000A)), // on-error-container
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Cancel this task?',
                    style: TextStyle(
                      color: Color(0xFF191B25),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'This action cannot be undone. Please select a reason if you wish to proceed.',
                style: TextStyle(
                  color: Color(0xFF434656), // on-surface-variant
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              
              // Chips
              Row(
                children: [
                  _buildChip('Requester unreachable'),
                  const SizedBox(width: 8),
                  _buildChip('Changed my mind'),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(color: Color(0xFFC3C5D9), height: 1),
              const SizedBox(height: 16),
              
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFBA1A1A), // error
                    foregroundColor: Colors.white,
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
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.cancel, size: 20),
                          SizedBox(width: 8),
                          Text('Confirm cancel', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 0.7)),
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
                    foregroundColor: const Color(0xFF191B25), // on-surface
                  ),
                  child: const Text('Never mind', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 0.7)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8FF), // surface
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF737688)), // outline
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF191B25),
          fontSize: 14,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.7,
        ),
      ),
    );
  }
}
