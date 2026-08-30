import 'package:flutter/material.dart';
import '../models/gig_model.dart';

class GigCard extends StatelessWidget {
  final Gig gig;
  final VoidCallback onTap;

  const GigCard({Key? key, required this.gig, required this.onTap}) : super(key: key);

  Color _getIconBackgroundColor(BuildContext context) {
    switch (gig.icon) {
      case 'local_shipping':
        return Theme.of(context).colorScheme.primaryContainer; // primary-container
      case 'shopping_basket':
        return Theme.of(context).colorScheme.secondaryContainer; // secondary-container
      case 'cleaning_services':
        return Theme.of(context).colorScheme.tertiaryContainer;
      default:
        return Theme.of(context).colorScheme.primaryContainer;
    }
  }

  Color _getIconColor(BuildContext context) {
    switch (gig.icon) {
      case 'local_shipping':
        return Theme.of(context).colorScheme.onPrimaryContainer; // on-primary-container
      case 'shopping_basket':
        return Theme.of(context).colorScheme.onSecondaryContainer; // on-secondary-container
      case 'cleaning_services':
        return Theme.of(context).colorScheme.onTertiaryContainer;
      default:
        return Theme.of(context).colorScheme.onPrimaryContainer;
    }
  }

  IconData _getIconData() {
    switch (gig.icon) {
      case 'local_shipping':
        return Icons.local_shipping_outlined;
      case 'shopping_basket':
        return Icons.shopping_basket_outlined;
      case 'cleaning_services':
        return Icons.cleaning_services_outlined;
      default:
        return Icons.assignment_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Highlight bar
              Container(
                width: 4,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _getIconBackgroundColor(context),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          _getIconData(),
                          color: _getIconColor(context),
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    gig.title,
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      height: 1.4,
                                      color: Theme.of(context).colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                                Text(
                                  '\$${gig.price.toInt()}',
                                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              gig.description,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 12),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    _buildTag(context, Icons.directions_walk_outlined, gig.distance),
                                    _buildTag(context, Icons.schedule_outlined, gig.duration),
                                    ...gig.tags.map((t) => _buildAlertTag(context, t)),
                                  ],
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

  Widget _buildTag(BuildContext context, IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Theme.of(context).colorScheme.onSurface),
          const SizedBox(width: 4),
          Text(
            text,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: 12, // Since 12 is smaller than normal labelLarge 14
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertTag(BuildContext context, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.errorContainer, // Using errorContainer roughly matches 0xFFFEE2E2
        border: Border.all(color: Theme.of(context).colorScheme.error), // matching 0xFFF87171 to error
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.fitness_center_outlined, size: 14, color: Theme.of(context).colorScheme.onErrorContainer),
          const SizedBox(width: 4),
          Text(
            text,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onErrorContainer,
            ),
          ),
        ],
      ),
    );
  }
}
