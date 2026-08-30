import 'package:flutter/material.dart';

class ArrivedDropoffScreen extends StatelessWidget {
  const ArrivedDropoffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 1,
        shadowColor: colorScheme.shadow.withOpacity(0.1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurfaceVariant),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Task Detail',
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(
                'Online',
                style: textTheme.labelLarge?.copyWith(
                  color: Colors.green.shade600,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
            child: Column(
              children: [
                // Status Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green.shade300.withOpacity(0.5)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.green.shade600,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Icon(Icons.check_circle, color: colorScheme.onPrimary, size: 36),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "You've arrived at the dropoff.",
                        textAlign: TextAlign.center,
                        style: textTheme.titleLarge?.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Please proceed to hand over the package.',
                        textAlign: TextAlign.center,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Task Info Details
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colorScheme.outlineVariant),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 4,
                            height: 32,
                            decoration: BoxDecoration(
                              color: colorScheme.primary,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ORDER NUMBER',
                                  style: textTheme.labelLarge?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                Text(
                                  '#8492',
                                  style: textTheme.bodyLarge?.copyWith(
                                    color: colorScheme.onSurface,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 16),
                      Row(
                        children: [
                          Container(
                            width: 4,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade800,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'RECIPIENT',
                                  style: textTheme.labelLarge?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                Text(
                                  'Sarah Jenkins',
                                  style: textTheme.bodyLarge?.copyWith(
                                    color: colorScheme.onSurface,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Address Section
                Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: colorScheme.outlineVariant),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Container(
                          width: 4,
                          decoration: BoxDecoration(
                            color: colorScheme.tertiary,
                            borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.location_on, color: colorScheme.tertiary, size: 20),
                                    const SizedBox(width: 8),
                                    Text(
                                      'DROPOFF ADDRESS',
                                      style: textTheme.labelLarge?.copyWith(
                                        color: colorScheme.onSurfaceVariant,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '123 Maple Avenue,\nSuite 4B,\nIndiranagar',
                                  style: textTheme.titleLarge?.copyWith(
                                    color: colorScheme.onSurface,
                                    fontWeight: FontWeight.bold,
                                    height: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  height: 128,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: Image.network(
                                    'https://lh3.googleusercontent.com/aida-public/AB6AXuDp3yglfPXQRUzewp_WmQEARnvocIyMIb42tYRTsnlHiCRg79sMwZzIpgN1t76QKq_gksUvkFUHnlUy4xIbX-FLvx-0fRxnklBNFsRFApxUPHz_cuY0z1PRO_auueBud3fkQ7hK6sNfnInQWM8QbwtMw0NRQU8IRIVsyanjvWpm3FJUJeG_L-ez1rf3aD19KtfsBOBsZ-ibErT7TiJviIBjrgR0DvlPrh3nBnIZOGEmxrC7R8wMSg5Py8XJdlcCDdzEKK9QDCAHPVI',
                                    fit: BoxFit.cover,
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
              ],
            ),
          ),
          // Bottom CTA
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    colorScheme.surface,
                    colorScheme.surface.withOpacity(0.0),
                  ],
                ),
              ),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primaryContainer,
                  foregroundColor: colorScheme.onPrimaryContainer,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Confirm Delivery',
                      style: textTheme.titleLarge?.copyWith(
                        color: colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.assignment),
            label: 'Tasks',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chat',
          ),
          NavigationDestination(
            icon: Icon(Icons.payments_outlined),
            label: 'Earnings',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
