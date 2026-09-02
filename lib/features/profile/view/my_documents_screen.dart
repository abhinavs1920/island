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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () {
            Navigator.of(context).pop();
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
                color: const Color(0xFFDBEAFE), // info-bg
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info, color: Color(0xFF1E40AF)), // info-blue
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Keep your documents up to date to ensure uninterrupted access to tasks.',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Document Card: Approved
            _buildDocumentCard(
              context,
              title: 'Driving License',
              status: 'Approved',
              statusColor: Colors.green,
              statusIcon: Icons.check_circle,
              statusBg: Colors.green.withOpacity(0.1),
              accentColor: Colors.green,
              expiry: 'Dec 12, 2025',
              imageUrl:
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuC1-vd4jzfDlRwNr9yAwIq0u9AKmKoE1BN7h5UW1WIsNR4SUTqd00i-DEXbjyYfkRWyztXLe3mtOwH9C4Kpvhf2zWK0mFL62Q4g-grpMoeoUkaE0rVWNnjLg5qg1CMm1AgLetyvuiXb-ZpDUwY49vp3Yv0LiB8okhCehQJVMR51M1ciS1FUQdC4KPlOHH3yC8muWHtpveeX8urLYnyxeEEFpP7w4gQhQdae_FgMa2kVZbQvNpaQ2GR8pY25kgGQVEPH6fRmsEAoz7M',
            ),
            const SizedBox(height: 16),
            // Document Card: Pending Review
            _buildDocumentCard(
              context,
              title: 'Vehicle Registration',
              status: 'Pending Review',
              statusColor: const Color(0xFFD97706), // amber
              statusIcon: Icons.pending_actions,
              statusBg: const Color(0xFFFEF3C7),
              accentColor: const Color(0xFFD97706),
              expiry: 'Oct 01, 2026',
              imageUrl:
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuDhPH6HbdW1bq0IWdP5Of26o7v6x2-fGWz3lAKG6AvJGSigqO8eeZNczBVUWV1wd2jqfAh5Fs1fczitl0opK_TKiZnTLrKNqSlYlmLoBdyjRmIwFGsebBxfP6EBir1kmxivV3E3cqdWwwOzuhxABiKK854PEqXJgDmBrMjs2O6rYI6Q-YrzykfdApL_u08EiM-8ElRIkoDsSARaKacxJSkR6slMfEK1AstVOydkoAS83Cotgov2uQ_psU0lsWdSavlZ8eexTJ5w7zU',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentCard(
    BuildContext context, {
    required String title,
    required String status,
    required Color statusColor,
    required IconData statusIcon,
    required Color statusBg,
    required Color accentColor,
    required String expiry,
    required String imageUrl,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 4,
              color: accentColor,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: colorScheme.outlineVariant),
                        image: DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.white.withOpacity(0.2),
                            BlendMode.lighten,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: textTheme.labelLarge?.copyWith(
                              color: colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: statusBg,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(statusIcon, color: statusColor, size: 14),
                                const SizedBox(width: 4),
                                Text(
                                  status,
                                  style: textTheme.labelSmall?.copyWith(
                                    color: statusColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Expires: $expiry',
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colorScheme.primary,
                        side: BorderSide(color: colorScheme.primaryContainer),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text('Update'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
