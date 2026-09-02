import 'package:flutter/material.dart';

class MyDocumentsScreen extends StatelessWidget {
  const MyDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () {
            Navigator.of(context).maybePop();
          },
        ),
        title: Text(
          'My Documents',
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: colorScheme.outlineVariant,
            height: 1.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Info Banner
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFFDBEAFE),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF93C5FD)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline, color: Color(0xFF1E40AF), size: 22),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Document Verification',
                          style: textTheme.titleSmall?.copyWith(
                            color: const Color(0xFF1E3A8A),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Keep your documents up to date to ensure uninterrupted access to gigs.',
                          style: textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF1E40AF),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Document Card: Driving License (Approved)
            _buildDocumentCard(
              context,
              title: 'Driving License',
              documentNumber: 'DL-KA0120220084921',
              status: 'Approved',
              statusColor: const Color(0xFF15803D),
              statusIcon: Icons.check_circle,
              statusBg: const Color(0xFFDCFCE7),
              accentColor: Colors.green,
              iconData: Icons.badge_outlined,
              expiry: 'Dec 12, 2028',
            ),
            const SizedBox(height: 14),

            // Document Card: Vehicle Registration (Pending Review)
            _buildDocumentCard(
              context,
              title: 'Vehicle Registration (RC)',
              documentNumber: 'KA-01-EQ-4829',
              status: 'Under Review',
              statusColor: const Color(0xFFB45309),
              statusIcon: Icons.schedule,
              statusBg: const Color(0xFFFEF3C7),
              accentColor: const Color(0xFFD97706),
              iconData: Icons.directions_car_outlined,
              expiry: 'Oct 01, 2026',
            ),
            const SizedBox(height: 14),

            // Document Card: Identity Verification (Aadhaar / National ID)
            _buildDocumentCard(
              context,
              title: 'Identity Proof (Aadhaar)',
              documentNumber: 'XXXX-XXXX-4819',
              status: 'Verified',
              statusColor: const Color(0xFF15803D),
              statusIcon: Icons.verified_user,
              statusBg: const Color(0xFFDCFCE7),
              accentColor: Colors.green,
              iconData: Icons.credit_card_outlined,
              expiry: 'Lifetime Valid',
            ),
            const SizedBox(height: 14),

            // Document Card: Vehicle Insurance
            _buildDocumentCard(
              context,
              title: 'Vehicle Insurance',
              documentNumber: 'POL-99210-482',
              status: 'Valid',
              statusColor: const Color(0xFF15803D),
              statusIcon: Icons.shield_outlined,
              statusBg: const Color(0xFFDCFCE7),
              accentColor: Colors.green,
              iconData: Icons.security_outlined,
              expiry: 'Mar 15, 2027',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentCard(
    BuildContext context, {
    required String title,
    required String documentNumber,
    required String status,
    required Color statusColor,
    required IconData statusIcon,
    required Color statusBg,
    required Color accentColor,
    required IconData iconData,
    required String expiry,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left Accent Stripe
          Container(
            width: 5,
            height: 90,
            color: accentColor,
          ),
          const SizedBox(width: 12),
          // Document Type Icon Badge
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(iconData, color: colorScheme.primary, size: 26),
          ),
          const SizedBox(width: 14),
          // Document Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    documentNumber,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: statusBg,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(statusIcon, color: statusColor, size: 12),
                            const SizedBox(width: 4),
                            Text(
                              status,
                              style: textTheme.labelSmall?.copyWith(
                                color: statusColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Exp: $expiry',
                        style: textTheme.bodySmall?.copyWith(
                          fontSize: 11,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Action Button
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              icon: Icon(Icons.arrow_forward_ios, size: 16, color: colorScheme.onSurfaceVariant),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$title details are up to date.'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
