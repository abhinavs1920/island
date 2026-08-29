import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/task_detail_provider.dart';

class TaskDetailScreen extends ConsumerWidget {
  final String taskId;

  const TaskDetailScreen({Key? key, required this.taskId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskDetailAsync = ref.watch(taskDetailProvider(taskId));
    final acceptTaskState = ref.watch(acceptTaskProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flikk'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Online',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant, // on-surface-variant
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.7,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Theme.of(context).colorScheme.outlineVariant, // outline-variant
            height: 1.0,
          ),
        ),
      ),
      body: taskDetailAsync.when(
        data: (data) => Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Map snippet
                    Container(
                      height: 192,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceVariant, // surface-variant
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant), // outline-variant
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuBta9JT-7LPhQKazKpWn1-5G_N2fxOe3HiumVAMl-gGx9_7CbCEnfsv-rQI0BSNqKoD6PDtvj7r-b3dp1gqQi7JRdXW-TViznClzXdSjA5MTLNFsXo_f0LJyU9we-a17To2zs-4Hij_zzfGsbTlQMawv6oLtSWb84nEpNlMc6oJmsPnB-kFFGOIVE4OCU6d68L9KFwSre66TTj_pUyC1gd76PKa0StxPfwej9eMpGn6YZybH71nJIqA'
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    
                    // Core Details Header
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface, // surface-container-lowest
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.handyman, color: Theme.of(context).colorScheme.primary, size: 16),
                                      SizedBox(width: 4),
                                      Text('Repair', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                                      SizedBox(width: 4),
                                      Text('•', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                                      SizedBox(width: 4),
                                      Text('AC Repair', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    data['location'] ?? 'Indiranagar',
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.errorContainer, // error-container
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'HIGH URGENCY',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.onErrorContainer, // on-error-container
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.7,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.payments, size: 16, color: Theme.of(context).colorScheme.onSurfaceVariant),
                                        SizedBox(width: 4),
                                        Text('Budget', style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      data['budget'] ?? '₹500-800',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.onSurface),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.directions_walk, size: 16, color: Theme.of(context).colorScheme.onSurfaceVariant),
                                        SizedBox(width: 4),
                                        Text('Distance', style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      data['distance'] ?? '~2.5 km',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.onSurface),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 12),

                    // Description Section
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.description, size: 20, color: Theme.of(context).colorScheme.onSurface),
                              SizedBox(width: 8),
                              Text(
                                'Task Description',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.onSurface, letterSpacing: 0.7),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Text(
                            data['description'] ?? 'Cooler fan not working, making noise. Needs immediate inspection and potentially a part replacement if the bearing is shot. Client is available now.',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Bottom Action Bar
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface, // surface
                  border: Border(top: BorderSide(color: Theme.of(context).colorScheme.outlineVariant)),
                  boxShadow: [
                    BoxShadow(color: Color(0x1A000000), offset: Offset(0, -4), blurRadius: 6),
                  ],
                ),
                child: SafeArea(
                  bottom: true,
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: SizedBox(
                      height: 56,
                      child: ElevatedButton(
                    onPressed: acceptTaskState.isLoading ? null : () async {
                      final status = await ref.read(acceptTaskProvider.notifier).acceptTask(taskId);
                      if (!context.mounted) return;
                      if (status == 'matched') {
                        context.push('/matched/$taskId');
                      } else if (status == 'race_lost') {
                        context.push('/race_lost');
                      } else if (status == 'error') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error accepting task')));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    child: acceptTaskState.isLoading
                      ? SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Accept this gig',
                              style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.white),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.check_circle, size: 20),
                          ],
                        ),
                  ),
                ),
              ),
            ),
              ),
            ),
          ],
        ),
        loading: () => Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary)),
        error: (e, st) => Center(child: Text('Error: $e', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.error))),
      ),
    );
  }
}
