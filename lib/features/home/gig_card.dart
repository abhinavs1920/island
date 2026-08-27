import 'package:flutter/material.dart';
import 'gig_model.dart';

class GigCard extends StatelessWidget {
  final Gig gig;
  final VoidCallback onTap;

  const GigCard({Key? key, required this.gig, required this.onTap}) : super(key: key);

  Color _getIconBackgroundColor() {
    switch (gig.icon) {
      case 'local_shipping':
        return const Color(0xFFDDE1FF); // primary-container
      case 'shopping_basket':
        return const Color(0xFFE5E2E1); // secondary-container
      case 'cleaning_services':
        return const Color(0xFFDBEAFE);
      default:
        return const Color(0xFFDDE1FF);
    }
  }

  Color _getIconColor() {
    switch (gig.icon) {
      case 'local_shipping':
        return const Color(0xFFDFE3FF); // on-primary-container
      case 'shopping_basket':
        return const Color(0xFF656464); // on-secondary-container
      case 'cleaning_services':
        return const Color(0xFF1E40AF);
      default:
        return const Color(0xFFDFE3FF);
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
          color: Colors.white,
          border: Border.all(color: const Color(0xFFC3C5D9)), // outline-variant
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
                color: const Color(0xFF003EC7), // primary
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
                          color: _getIconBackgroundColor(),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          _getIconData(),
                          color: _getIconColor(),
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
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      height: 1.4,
                                      color: Color(0xFF191B25),
                                    ),
                                  ),
                                ),
                                Text(
                                  '\$${gig.price.toInt()}',
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 32,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF003EC7),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              gig.description,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                color: Color(0xFF434656),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                _buildTag(Icons.directions_walk_outlined, gig.distance),
                                _buildTag(Icons.schedule_outlined, gig.duration),
                                ...gig.tags.map((t) => _buildAlertTag(t)),
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

  Widget _buildTag(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFE7E7F5),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFF191B25)),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF191B25),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFEE2E2),
        border: Border.all(color: const Color(0xFFF87171)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.fitness_center_outlined, size: 14, color: Color(0xFF991B1B)),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF991B1B),
            ),
          ),
        ],
      ),
    );
  }
}
