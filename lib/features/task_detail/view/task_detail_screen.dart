import 'package:url_launcher/url_launcher.dart';
import '../../../core/providers/viewing_scope_provider.dart';
import '../../home/providers/home_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/task_detail_provider.dart';
import '../widgets/milestone_stepper.dart';
import '../providers/milestone_provider.dart';

class TaskDetailScreen extends ConsumerStatefulWidget {
  final String taskId;

  const TaskDetailScreen({Key? key, required this.taskId}) : super(key: key);

  @override
  ConsumerState<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends ConsumerState<TaskDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(currentViewingScopeProvider.notifier).state = ViewingTask(widget.taskId);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) ref.read(currentViewingScopeProvider.notifier).state = null;
    });
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final taskDetailAsync = ref.watch(taskDetailProvider(widget.taskId));
    final acceptTaskState = ref.watch(acceptTaskProvider);
    final milestonesAsync = ref.watch(milestoneProvider(widget.taskId));

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface, // surface
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface, // surface
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurfaceVariant), // on-surface-variant
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(
          'TaskRunner',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.primary, // primary
            fontFamily: 'Inter',
          ),
        ),
        centerTitle: true,
        actions: [
                    TextButton(
            onPressed: () {},
            child: Text(
              ref.watch(isOnlineProvider) ? 'Online' : 'Offline',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: ref.watch(isOnlineProvider) ? Colors.green : Theme.of(context).colorScheme.onSurfaceVariant,
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
                        image: const DecorationImage(
                          image: NetworkImage(
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuBta9JT-7LPhQKazKpWn1-5G_N2fxOe3HiumVAMl-gGx9_7CbCEnfsv-rQI0BSNqKoD6PDtvj7r-b3dp1gqQi7JRdXW-TViznClzXdSjA5MTLNFsXo_f0LJyU9we-a17To2zs-4Hij_zzfGsbTlQMawv6oLtSWb84nEpNlMc6oJmsPnB-kFFGOIVE4OCU6d68L9KFwSre66TTj_pUyC1gd76PKa0StxPfwej9eMpGn6YZybH71nJIqA'
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    // Core Details Header
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerLowest, // surface-container-lowest
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
                                      const SizedBox(width: 4),
                                      Text('Repair', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                                      const SizedBox(width: 4),
                                      Text('•', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                                      const SizedBox(width: 4),
                                      Text('AC Repair', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    data['location'] ?? 'Indiranagar',
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurface,
                                    ),
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
                                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: Theme.of(context).colorScheme.onErrorContainer, // on-error-container
                                    letterSpacing: 0.7,
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
                                        Icon(Icons.payments, size: 16, color: Theme.of(context).colorScheme.onSurfaceVariant),
                                        const SizedBox(width: 4),
                                        Text('Budget', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      data['budget'] ?? '₹500-800',
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.onSurface),
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
                                        const SizedBox(width: 4),
                                        Text('Distance', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      data['distance'] ?? '~2.5 km',
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.onSurface),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // 1. Pending Status 3-Minute Alert (if rider_matched)
                    if (data['status'] == 'rider_matched') ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.orange.shade300),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.timer_outlined, color: Colors.orange, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Pending: Start within 3 minutes',
                                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange.shade900,
                                        ),
                                  ),
                                  Text(
                                    'Tap "Start Task" once you begin heading to the destination.',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: Colors.orange.shade900,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],

                    // 2. Description Section with Step-by-Step Instructions
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.description, size: 20, color: Theme.of(context).colorScheme.onSurface),
                              const SizedBox(width: 8),
                              Text(
                                'Task Overview & Instructions',
                                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurface,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.7,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            data['description'] ?? 'Cooler fan not working, making noise. Needs immediate inspection and potentially a part replacement if the bearing is shot. Client is available now.',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  height: 1.5,
                                ),
                          ),
                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 8),
                          Text(
                            'EXECUTION STEPS',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                          ),
                          const SizedBox(height: 8),
                          _buildInstructionStep(context, '1', 'Navigate to pickup/task location (${data['location'] ?? 'Indiranagar'}).'),
                          _buildInstructionStep(context, '2', 'Connect with requester and confirm task scope and items.'),
                          _buildInstructionStep(context, '3', 'Execute the gig requirements following safety standards.'),
                          _buildInstructionStep(context, '4', 'Mark task completed and collect requester rating.'),
                        ],
                      ),
                    ),
                    if ((data['category'] as String?)?.toLowerCase().contains('errand') == true ||
                        (data['category'] as String?)?.toLowerCase().contains('milestone') == true ||
                        (milestonesAsync.value?.isNotEmpty ?? false)) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceContainerLowest,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                        ),
                        child: MilestoneStepper(taskId: widget.taskId, milestones: milestonesAsync.value ?? []),
                      ),
                    ],
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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  border: Border(top: BorderSide(color: Theme.of(context).colorScheme.outlineVariant)),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.08), offset: const Offset(0, -3), blurRadius: 6),
                  ],
                ),
                child: Row(
                  children: [
                    // Call Requester CTA
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Theme.of(context).colorScheme.primary),
                        foregroundColor: Theme.of(context).colorScheme.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () => _callRequester(context, data['requester_phone']?.toString()),
                      icon: const Icon(Icons.phone, size: 18),
                      label: const Text('Call'),
                    ),
                    const SizedBox(width: 12),
                    // Primary Action Button (Accept / Start / Chat)
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: acceptTaskState.isLoading
                              ? null
                              : () async {
                                  final taskStatus = data['status'] as String? ?? 'posted';
                                  if (taskStatus == 'rider_matched') {
                                    context.push('/chat/${widget.taskId}');
                                  } else if (taskStatus == 'in_progress') {
                                    context.push('/chat/${widget.taskId}');
                                  } else {
                                    final status = await ref.read(acceptTaskProvider.notifier).acceptTask(widget.taskId);
                                    if (!context.mounted) return;
                                    if (status == 'matched') {
                                      context.push('/taskdetail/matched-confirmation');
                                    } else if (status == 'race_lost') {
                                      context.push('/taskdetail/race-lost');
                                    } else if (status == 'error') {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error accepting task')));
                                    }
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            foregroundColor: Theme.of(context).colorScheme.onPrimary,
                            disabledBackgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            elevation: 0,
                          ),
                          child: acceptTaskState.isLoading
                              ? SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Theme.of(context).colorScheme.onPrimary, strokeWidth: 2))
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      data['status'] == 'rider_matched'
                                          ? 'Start / Open Chat'
                                          : (data['status'] == 'in_progress' ? 'Open Active Chat' : 'Accept this gig'),
                                      style: Theme.of(context).textTheme.labelLarge?.copyWith(letterSpacing: 0.7),
                                    ),
                                    const SizedBox(width: 8),
                                    Icon(
                                      data['status'] == 'rider_matched' || data['status'] == 'in_progress'
                                          ? Icons.chat_bubble_outline
                                          : Icons.check_circle,
                                      size: 20,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        loading: () => const _TaskDetailSkeleton(),
        error: (e, st) => Center(child: Text('Error: $e', style: TextStyle(color: Theme.of(context).colorScheme.error))),
      ),
    );
  }

  Widget _buildInstructionStep(BuildContext context, String stepNumber, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              stepNumber,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _callRequester(BuildContext context, String? phone) async {
    final rawPhone = (phone != null && phone.isNotEmpty) ? phone : '+919876543210';
    final cleanPhone = rawPhone.replaceAll(RegExp(r'[^\d+]'), '');
    final uri = Uri.parse('tel:$cleanPhone');
    try {
      final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!launched) {
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        } else if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not open dialer for $cleanPhone')),
          );
        }
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not initiate phone call')),
        );
      }
    }
  }
}

class _TaskDetailSkeleton extends StatelessWidget {
  const _TaskDetailSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 192,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant, // surface-variant
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(width: 150, height: 24, decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceVariant, borderRadius: BorderRadius.circular(4))),
                          Container(width: 80, height: 24, decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceVariant, borderRadius: BorderRadius.circular(4))),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(width: 60, height: 16, decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceVariant, borderRadius: BorderRadius.circular(4))),
                                const SizedBox(height: 8),
                                Container(width: 100, height: 20, decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceVariant, borderRadius: BorderRadius.circular(4))),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(width: 60, height: 16, decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceVariant, borderRadius: BorderRadius.circular(4))),
                                const SizedBox(height: 8),
                                Container(width: 100, height: 20, decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceVariant, borderRadius: BorderRadius.circular(4))),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(width: 120, height: 20, decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceVariant, borderRadius: BorderRadius.circular(4))),
                      const SizedBox(height: 16),
                      Container(width: double.infinity, height: 16, decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceVariant, borderRadius: BorderRadius.circular(4))),
                      const SizedBox(height: 8),
                      Container(width: double.infinity, height: 16, decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceVariant, borderRadius: BorderRadius.circular(4))),
                      const SizedBox(height: 8),
                      Container(width: 200, height: 16, decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceVariant, borderRadius: BorderRadius.circular(4))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface, // surface
              border: Border(top: BorderSide(color: Theme.of(context).colorScheme.outlineVariant)),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), offset: const Offset(0, -4), blurRadius: 6),
              ],
            ),
            child: SizedBox(
              height: 56,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant, // surface-variant
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Container(width: 120, height: 16, decoration: BoxDecoration(color: Theme.of(context).colorScheme.outlineVariant, borderRadius: BorderRadius.circular(4))),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
