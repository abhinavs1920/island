import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../home/models/gig_model.dart';
import '../../task_detail/providers/task_detail_provider.dart';

class GigNotificationBanner extends ConsumerStatefulWidget {
  final Gig gig;
  final VoidCallback onDismiss;

  const GigNotificationBanner({
    Key? key,
    required this.gig,
    required this.onDismiss,
  }) : super(key: key);

  @override
  ConsumerState<GigNotificationBanner> createState() => _GigNotificationBannerState();
}

class _GigNotificationBannerState extends ConsumerState<GigNotificationBanner> {
  static const int totalSeconds = 30;
  int _secondsRemaining = totalSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_secondsRemaining <= 1) {
        timer.cancel();
        widget.onDismiss();
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _handleAccept(BuildContext context) async {
    _timer?.cancel();

    // Show Acceptance Confirmation Modal
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.check_circle_outline, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
            const Text('Accept This Gig?'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.gig.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Payout: ₹${widget.gig.price.toInt()} • ${widget.gig.distance}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Once accepted, you will have 3 minutes in pending status to start heading to the location.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx, false),
            child: const Text('Review Later'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () => Navigator.pop(dialogCtx, true),
            child: const Text('Confirm & Accept'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      widget.onDismiss();
      final status = await ref.read(acceptTaskProvider.notifier).acceptTask(widget.gig.id);
      if (!context.mounted) return;
      if (status == 'matched') {
        context.push('/taskdetail/matched-confirmation');
      } else if (status == 'race_lost') {
        context.push('/taskdetail/race-lost');
      } else {
        context.push('/task/${widget.gig.id}');
      }
    } else {
      widget.onDismiss();
    }
  }

  void _handleViewDetails(BuildContext context) {
    _timer?.cancel();
    widget.onDismiss();
    context.push('/task/${widget.gig.id}');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isMilestone = widget.gig.isMilestone;

    return Material(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colorScheme.primary.withOpacity(0.3), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top Countdown Progress Bar
            LinearProgressIndicator(
              value: _secondsRemaining / totalSeconds,
              backgroundColor: colorScheme.surfaceVariant,
              valueColor: AlwaysStoppedAnimation<Color>(
                _secondsRemaining <= 10 ? colorScheme.error : colorScheme.primary,
              ),
              minHeight: 4,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Row
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isMilestone ? colorScheme.tertiaryContainer : colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isMilestone ? Icons.route : Icons.bolt,
                              size: 14,
                              color: isMilestone ? colorScheme.onTertiaryContainer : colorScheme.onPrimaryContainer,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              isMilestone ? 'MULTI-STEP GIG' : 'NEW GIG ALERT',
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: isMilestone ? colorScheme.onTertiaryContainer : colorScheme.onPrimaryContainer,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Icon(
                            Icons.timer_outlined,
                            size: 14,
                            color: _secondsRemaining <= 10 ? colorScheme.error : colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${_secondsRemaining}s',
                            style: theme.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: _secondsRemaining <= 10 ? colorScheme.error : colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(Icons.close, size: 18, color: colorScheme.onSurfaceVariant),
                        onPressed: widget.onDismiss,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Title & Price
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.gig.title,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            if (widget.gig.description.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(
                                widget.gig.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '₹${widget.gig.price.toInt()}',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Meta Info (Duration, Distance)
                  Row(
                    children: [
                      if (widget.gig.distance.isNotEmpty) ...[
                        Icon(Icons.directions_walk_outlined, size: 14, color: colorScheme.onSurfaceVariant),
                        const SizedBox(width: 4),
                        Text(
                          widget.gig.distance,
                          style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                        ),
                        const SizedBox(width: 12),
                      ],
                      if (widget.gig.duration.isNotEmpty) ...[
                        Icon(Icons.schedule_outlined, size: 14, color: colorScheme.onSurfaceVariant),
                        const SizedBox(width: 4),
                        Text(
                          widget.gig.duration,
                          style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Actions Row: Dismiss & Branching CTA (Accept vs View Details)
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: colorScheme.outlineVariant),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: widget.onDismiss,
                          child: const FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text('Dismiss'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: isMilestone
                            ? ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: colorScheme.primary,
                                  foregroundColor: colorScheme.onPrimary,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                onPressed: () => _handleViewDetails(context),
                                icon: const Icon(Icons.arrow_forward, size: 18),
                                label: const Text('View Details'),
                              )
                            : ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: colorScheme.primary,
                                  foregroundColor: colorScheme.onPrimary,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                onPressed: () => _handleAccept(context),
                                icon: const Icon(Icons.check_circle_outline, size: 18),
                                label: const Text('Accept Gig'),
                              ),
                      ),
                    ],
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
