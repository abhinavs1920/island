import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/milestone_model.dart';
import '../providers/milestone_provider.dart';

class MilestoneStepper extends ConsumerStatefulWidget {
  final String taskId;
  final List<MilestoneModel> milestones;

  const MilestoneStepper({
    Key? key,
    required this.taskId,
    required this.milestones,
  }) : super(key: key);

  @override
  ConsumerState<MilestoneStepper> createState() => _MilestoneStepperState();
}

class _MilestoneStepperState extends ConsumerState<MilestoneStepper> {
  int? _loadingMilestone;

  Future<void> _advance(int milestoneNumber) async {
    setState(() {
      _loadingMilestone = milestoneNumber;
    });
    try {
      await ref.read(milestoneProvider(widget.taskId).notifier).advanceMilestone(milestoneNumber);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) {
        setState(() {
          _loadingMilestone = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.milestones.isEmpty) {
      return const SizedBox.shrink();
    }

    final sorted = List<MilestoneModel>.from(widget.milestones)
      ..sort((a, b) => a.milestoneNumber.compareTo(b.milestoneNumber));

    final firstPendingIndex = sorted.indexWhere((m) => m.status != 'completed');
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.flag, size: 20, color: Theme.of(context).colorScheme.onSurface),
            const SizedBox(width: 8),
            Text(
              'Milestones',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    letterSpacing: 0.7,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...List.generate(sorted.length, (index) {
          final milestone = sorted[index];
          final isCompleted = milestone.status == 'completed';
          final isCurrent = index == firstPendingIndex;
          final isNextToComplete = isCurrent && milestone.milestoneNumber != 4;
          final isLast = index == sorted.length - 1;

          Color circleColor;
          Widget icon;
          TextStyle? textStyle = Theme.of(context).textTheme.bodyMedium;

          if (isCompleted) {
            circleColor = Colors.green;
            icon = const Icon(Icons.check, size: 16, color: Colors.white);
            textStyle = textStyle?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              decoration: TextDecoration.lineThrough,
            );
          } else if (milestone.milestoneNumber == 4) {
            circleColor = Theme.of(context).colorScheme.surfaceVariant;
            icon = Icon(Icons.lock, size: 16, color: Theme.of(context).colorScheme.onSurfaceVariant);
            textStyle = textStyle?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            );
          } else if (isCurrent) {
            circleColor = Theme.of(context).colorScheme.primary;
            icon = Icon(Icons.play_arrow, size: 16, color: Theme.of(context).colorScheme.onPrimary);
            textStyle = textStyle?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            );
          } else {
            circleColor = Theme.of(context).colorScheme.surfaceVariant;
            icon = Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                shape: BoxShape.circle,
              ),
            );
            textStyle = textStyle?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            );
          }

          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: circleColor,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: icon,
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 2,
                          color: Theme.of(context).colorScheme.outlineVariant,
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          milestone.milestoneName,
                          style: textStyle,
                        ),
                        if (isNextToComplete)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: FilledButton(
                                onPressed: _loadingMilestone != null
                                    ? null
                                    : () => _advance(milestone.milestoneNumber),
                                child: _loadingMilestone == milestone.milestoneNumber
                                    ? SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                          color: Theme.of(context).colorScheme.onPrimary,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text('Mark as done'),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
