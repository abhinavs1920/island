import '../../../core/providers/viewing_scope_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/home_controller.dart';
import '../widgets/gig_card.dart';
import '../models/gig_model.dart';
import '../widgets/network_error_body.dart';
import '../../../core/providers/location_provider.dart';
import '../widgets/surge_alert_dialog.dart';
import '../widgets/task_filter_dialog.dart';
import '../../notifications/widgets/gig_notification_banner.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(currentViewingScopeProvider.notifier).state = ViewingHome();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) ref.read(currentViewingScopeProvider.notifier).state = null;
    });
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (ref.read(isOnlineProvider)) {
        ref.read(locationProvider.notifier).refresh();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isOnline = ref.watch(isOnlineProvider);
    final gigsAsync = ref.watch(gigsProvider);

    return Scaffold(
      backgroundColor: isOnline ? Theme.of(context).colorScheme.surface : Theme.of(context).colorScheme.surfaceVariant,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Theme.of(context).colorScheme.outlineVariant, height: 1.0),
        ),
        title: Text(
          'Flikk',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontSize: 28, // Using displayLarge style but adjusting size if needed, or maybe just displayLarge
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.local_fire_department, color: Colors.orange),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => SurgeAlertDialog(
                        onGoOnline: () {
                          Navigator.pop(context);
                          ref.read(isOnlineProvider.notifier).toggle(true);
                        },
                        onDismiss: () => Navigator.pop(context),
                      ),
                    );
                  },
                ),
                Text(
                  isOnline ? 'ONLINE' : 'OFFLINE',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: isOnline ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: 8),
                Switch(
                  value: isOnline,
                  onChanged: (val) {
                    ref.read(isOnlineProvider.notifier).toggle(val);
                  },
                  activeColor: Colors.white,
                  activeTrackColor: Theme.of(context).colorScheme.secondary,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Theme.of(context).colorScheme.surfaceVariant,
                  trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: isOnline ? _buildOnlineBody(gigsAsync) : _buildOfflineBody(),
      ),
    );
  }


  Widget _buildOfflineBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  width: 128,
                  height: 128,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(Icons.directions_walk, size: 64, color: Theme.of(context).colorScheme.outlineVariant),
                  ),
                ),
                Positioned(
                  top: -48,
                  child: Icon(Icons.arrow_upward, size: 40, color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Ready to work?',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 28),
            ),
            const SizedBox(height: 8),
            Text(
              'Go online to see gigs nearby and start earning.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                ref.read(isOnlineProvider.notifier).toggle(true);
              },
              icon: const Icon(Icons.power_settings_new, color: Colors.white),
              label: Text(
                'Go Online',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnlineBody(AsyncValue<List<Gig>> gigsAsync) {
    final activeGigsAsync = ref.watch(activeGigsProvider);
    final filterCriteria = ref.watch(taskFilterProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Reduced Prominence Online Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "You're online • Actively looking for gigs nearby",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 2. Active Gigs Section (Accepted / In-Progress Tasks)
          activeGigsAsync.when(
            data: (activeList) {
              if (activeList.isEmpty) return const SizedBox.shrink();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Active Gigs (${activeList.length})',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'In Progress',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...activeList.map((task) => _buildActiveGigCard(context, task)).toList(),
                  const SizedBox(height: 16),
                ],
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),

          // 3. Available Gigs Section Header with Filter CTA
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Available Gigs',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  TaskFilterDialog.show(
                    context,
                    currentCriteria: ref.read(taskFilterProvider),
                    onApply: (newCriteria) {
                      ref.read(taskFilterProvider.notifier).state = newCriteria;
                    },
                  );
                },
                icon: Icon(
                  Icons.filter_list,
                  size: 16,
                  color: (filterCriteria.urgentOnly || filterCriteria.maxDistanceKm != null)
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                label: Text(
                  (filterCriteria.urgentOnly || filterCriteria.maxDistanceKm != null)
                      ? 'Filtered'
                      : 'Sort & Filter',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: (filterCriteria.urgentOnly || filterCriteria.maxDistanceKm != null)
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // 4. Available Gigs List with Remove from List support
          gigsAsync.when(
            data: (gigs) {
              if (gigs.isEmpty) return _buildEmptyState();
              return Column(
                children: gigs
                    .map<Widget>((gig) => GigCard(
                          gig: gig,
                          onTap: () => context.push('/task/${gig.id}'),
                          onRemove: () async {
                            await ref.read(gigsProvider.notifier).rejectGig(gig.id);
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Gig removed from your list'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                        ))
                    .toList(),
              );
            },
            loading: () => _buildLoadingSkeletons(),
            error: (err, _) => NetworkErrorBody(
              onRetry: () {
                ref.invalidate(gigsProvider);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveGigCard(BuildContext context, Map<String, dynamic> task) {
    final status = task['status'] as String? ?? '';
    final isPending = status == 'rider_matched';
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final taskId = task['id']?.toString() ?? '';
    final category = task['category']?.toString() ?? task['title']?.toString() ?? 'Active Gig';
    final budget = task['budget_min'] != null
        ? '₹${task['budget_min']}'
        : (task['budget_max'] != null ? '₹${task['budget_max']}' : '₹--');

    return GestureDetector(
      onTap: () => context.push('/task/$taskId'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colorScheme.primary.withOpacity(0.5), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(width: 5, color: isPending ? Colors.orange : colorScheme.primary),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: isPending ? Colors.orange.withOpacity(0.15) : colorScheme.primaryContainer,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  isPending ? Icons.hourglass_top : Icons.directions_bike,
                                  size: 16,
                                  color: isPending ? Colors.orange : colorScheme.primary,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                category,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            budget,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Details row: Payment & Customer Status
                      Row(
                        children: [
                          const Icon(Icons.shield_outlined, size: 14, color: Colors.green),
                          const SizedBox(width: 4),
                          Text('Payment Secured', style: theme.textTheme.bodySmall?.copyWith(color: Colors.green, fontWeight: FontWeight.w600)),
                          const SizedBox(width: 12),
                          Icon(Icons.chat_bubble_outline, size: 14, color: colorScheme.onSurfaceVariant),
                          const SizedBox(width: 4),
                          Text('Chat Active', style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Progress / Milestone Status
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: isPending ? Colors.orange.withOpacity(0.1) : colorScheme.surfaceVariant,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isPending ? Icons.alarm : Icons.check_circle_outline,
                              size: 14,
                              color: isPending ? Colors.orange : colorScheme.primary,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                isPending ? 'Pending — Start within 3 mins' : 'Task in Progress — Heading to Destination',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: isPending ? Colors.orange.shade800 : colorScheme.onSurface,
                                ),
                              ),
                            ),
                            Icon(Icons.chevron_right, size: 16, color: colorScheme.onSurfaceVariant),
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

  Widget _buildLoadingSkeletons() {
    return Column(
      children: List.generate(
        3,
        (index) => Container(
          margin: const EdgeInsets.only(bottom: 16),
          height: 128,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 2,
                offset: Offset(0, 1),
              )
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: 4,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHigh, // Using surfaceContainerHigh or keeping 0xFFE2E1ED if desired. I'll just use a surface color
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 16, top: 16, bottom: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceContainerHigh,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Container(
                                height: 20,
                                width: index == 0 ? 200 : (index == 1 ? 160 : 220),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 16,
                                width: index == 0 ? 120 : (index == 1 ? 100 : 140),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          width: index == 1 ? 56 : (index == 2 ? 80 : 64),
                          height: 24,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 24,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        if (index != 1) ...[
                          const SizedBox(width: 8),
                          Container(
                            height: 24,
                            width: 64,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surfaceContainerHigh,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                        if (index == 2) ...[
                          const SizedBox(width: 8),
                          Container(
                            height: 24,
                            width: 64,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surfaceContainerHigh,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ]
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant, // Maybe surfaceContainer or just keep if specific
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(Icons.inbox_outlined, size: 48, color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No gigs nearby right now',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Keep this screen open. We'll notify you with a loud alert the moment a new task posts in your area.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.sync, size: 16, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Auto-refreshing active',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
