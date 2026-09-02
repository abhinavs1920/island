import '../providers/history_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../models/gig_model.dart';
import '../widgets/gig_card.dart';
import 'package:go_router/go_router.dart';

class GigHistoryListScreen extends ConsumerStatefulWidget {
  const GigHistoryListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<GigHistoryListScreen> createState() => _GigHistoryListScreenState();
}

class _GigHistoryListScreenState extends ConsumerState<GigHistoryListScreen> {
  int _selectedTabIndex = 0;

  

    @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final historyAsync = ref.watch(gigHistoryProvider);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 1,
        shadowColor: colorScheme.shadow.withOpacity(0.2),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurfaceVariant),
          onPressed: () {
            if (context.canPop()) context.pop();
          },
        ),
        title: Text(
          'Gig History',
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: colorScheme.onSurfaceVariant),
            onPressed: () => ref.read(gigHistoryProvider.notifier).refresh(),
          ),
          const SizedBox(width: 8)
        ],
      ),
      body: Column(
        children: [
          Container(
            color: colorScheme.surface,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildTab('All', 0, colorScheme, textTheme),
                const SizedBox(width: 32),
                _buildTab('Completed', 1, colorScheme, textTheme),
                const SizedBox(width: 32),
                _buildTab('Cancelled', 2, colorScheme, textTheme),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: historyAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(
                child: Text('Error loading history: $err', style: TextStyle(color: colorScheme.error)),
              ),
              data: (gigs) {
                final filteredGigs = gigs.where((gig) {
                  if (_selectedTabIndex == 1) return gig.status == GigStatus.completed;
                  if (_selectedTabIndex == 2) return gig.status == GigStatus.cancelled || gig.status == GigStatus.failed;
                  return true;
                }).toList();

                if (filteredGigs.isEmpty) {
                  return const Center(child: Text('No gigs found.'));
                }

                return ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                  padding: const EdgeInsets.all(16),
                  itemCount: filteredGigs.length,
                  itemBuilder: (context, index) {
                    final gig = filteredGigs[index];
                    return GigCard(
                      gig: gig,
                      onTap: () {
                        if (gig.status == GigStatus.completed) {
                          context.push('/history/completed-gig-detail', extra: gig.id);
                        } else {
                          context.push('/history/cancelled-gig-detail', extra: gig.id);
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String text, int index, ColorScheme colorScheme, TextTheme textTheme) {
    final isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.only(top: 8, bottom: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? colorScheme.primaryContainer : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          text,
          style: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: isSelected ? colorScheme.primaryContainer : colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

}
