import 'package:flutter/material.dart';
import '../models/gig_model.dart';
import 'package:intl/intl.dart';

class GigCard extends StatelessWidget {
  final GigModel gig;
  final VoidCallback onTap;

  const GigCard({
    Key? key,
    required this.gig,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final isCompleted = gig.status == GigStatus.completed;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      color: colorScheme.surface,
      child: InkWell(
        onTap: onTap,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 4,
                color: isCompleted ? colorScheme.primaryContainer : colorScheme.outlineVariant,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: isCompleted ? Colors.green.shade100 : colorScheme.errorContainer,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isCompleted ? Icons.check_circle : Icons.cancel,
                                  size: 14,
                                  color: isCompleted ? Colors.green.shade700 : colorScheme.error,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  isCompleted ? 'COMPLETED' : 'CANCELLED',
                                  style: textTheme.labelSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: isCompleted ? Colors.green.shade700 : colorScheme.error,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '\$${gig.amount.toStringAsFixed(2)}',
                            style: textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              decoration: isCompleted ? null : TextDecoration.lineThrough,
                              color: isCompleted ? colorScheme.onSurface : colorScheme.onSurfaceVariant.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 18, color: colorScheme.onSurfaceVariant),
                          const SizedBox(width: 8),
                          Text(
                            DateFormat('MMM dd, hh:mm a').format(gig.date),
                            style: textTheme.labelMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8),
                          border: BorderSide(color: colorScheme.surfaceContainerHighest),
                        ),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Icon(Icons.storefront, size: 18, color: isCompleted ? Colors.blue.shade700 : Colors.grey),
                                Container(
                                  width: 2,
                                  height: 20,
                                  color: colorScheme.outlineVariant,
                                  margin: const EdgeInsets.symmetric(vertical: 4),
                                ),
                                Icon(Icons.pin_drop, size: 18, color: isCompleted ? colorScheme.error : Colors.grey),
                              ],
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Pickup', style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant)),
                                  Text(gig.pickupAddress, style: textTheme.bodyMedium),
                                  const SizedBox(height: 12),
                                  Text('Dropoff', style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant)),
                                  Text(gig.dropoffAddress, style: textTheme.bodyMedium),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
