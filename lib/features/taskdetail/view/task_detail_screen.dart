import '../providers/task_detail_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class TaskDetailScreen extends ConsumerWidget {
  const TaskDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurfaceVariant),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(
          'TaskRunner',
          style: textTheme.headlineSmall?.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Text(
                'Online',
                style: textTheme.labelLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
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
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 16.0,
              bottom: 100.0, // Space for bottom action bar
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Map Snippet Hero
                Container(
                  height: 192, // h-48
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: colorScheme.outlineVariant),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuBta9JT-7LPhQKazKpWn1-5G_N2fxOe3HiumVAMl-gGx9_7CbCEnfsv-rQI0BSNqKoD6PDtvj7r-b3dp1gqQi7JRdXW-TViznClzXdSjA5MTLNFsXo_f0LJyU9we-a17To2zs-4Hij_zzfGsbTlQMawv6oLtSWb84nEpNlMc6oJmsPnB-kFFGOIVE4OCU6d68L9KFwSre66TTj_pUyC1gd76PKa0StxPfwej9eMpGn6YZybH71nJIqA',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Center(child: Icon(Icons.map, size: 48)),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Task Core Details Header
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: colorScheme.outlineVariant),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.handyman, size: 16, color: colorScheme.primary),
                                    const SizedBox(width: 4),
                                    Text('Repair', style: textTheme.labelMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
                                    const SizedBox(width: 4),
                                    Text('•', style: textTheme.labelMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
                                    const SizedBox(width: 4),
                                    Text('AC Repair', style: textTheme.labelMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text('Indiranagar', style: textTheme.titleLarge?.copyWith(color: colorScheme.onSurface)),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: colorScheme.errorContainer,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              'HIGH URGENCY',
                              style: textTheme.labelSmall?.copyWith(
                                color: colorScheme.onErrorContainer,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.payments, size: 16, color: colorScheme.onSurfaceVariant),
                                    const SizedBox(width: 4),
                                    Text('Budget', style: textTheme.labelMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text('₹500-800', style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.social_distance, size: 16, color: colorScheme.onSurfaceVariant),
                                    const SizedBox(width: 4),
                                    Text('Distance', style: textTheme.labelMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text('~2.5 km', style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                
                // Description Section
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: colorScheme.outlineVariant),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.description, size: 20, color: colorScheme.onSurface),
                          const SizedBox(width: 8),
                          Text('Task Description', style: textTheme.labelLarge?.copyWith(color: colorScheme.onSurface, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Cooler fan not working, making noise. Needs immediate inspection and potentially a part replacement if the bearing is shot. Client is available now.',
                        style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Bottom Action Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                border: Border(top: BorderSide(color: colorScheme.outlineVariant)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, -4),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: FilledButton.icon(
                onPressed: () async {
                  final result = await ref.read(acceptTaskProvider.notifier).acceptTask(taskId);
                  if (context.mounted) {
                    if (result == 'matched') {
                      context.go('/taskdetail/matched-confirmation');
                    } else if (result == 'race_lost') {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Someone else claimed this task.')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('An error occurred.')));
                    }
                  }
                },
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                icon: const Icon(Icons.check_circle),
                label: const Text('Accept this gig', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
