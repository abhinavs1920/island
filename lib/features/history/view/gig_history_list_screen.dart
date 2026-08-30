import 'package:flutter/material.dart';
import '../models/gig_model.dart';
import '../widgets/gig_card.dart';
import 'package:go_router/go_router.dart';

class GigHistoryListScreen extends StatefulWidget {
  const GigHistoryListScreen({Key? key}) : super(key: key);

  @override
  State<GigHistoryListScreen> createState() => _GigHistoryListScreenState();
}

class _GigHistoryListScreenState extends State<GigHistoryListScreen> {
  int _selectedTabIndex = 0;

  final List<GigModel> _mockGigs = [
    GigModel(
      id: '1',
      type: 'Grocery Delivery',
      status: GigStatus.completed,
      amount: 15.50,
      date: DateTime(2023, 6, 12, 10, 30),
      pickupAddress: 'Indiranagar',
      dropoffAddress: 'Koramangala',
    ),
    GigModel(
      id: '2',
      type: 'Package Delivery',
      status: GigStatus.completed,
      amount: 22.00,
      date: DateTime(2023, 6, 11, 14, 15),
      pickupAddress: 'Whitefield',
      dropoffAddress: 'MG Road',
    ),
    GigModel(
      id: '3',
      type: 'AC Repair',
      status: GigStatus.cancelled,
      amount: 12.50,
      date: DateTime(2023, 6, 10, 9, 0),
      pickupAddress: 'HSR Layout',
      dropoffAddress: 'BTM Layout',
    ),
    GigModel(
      id: '4',
      type: 'Food Delivery',
      status: GigStatus.completed,
      amount: 8.75,
      date: DateTime(2023, 6, 9, 18, 45),
      pickupAddress: 'Jayanagar',
      dropoffAddress: 'JP Nagar',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final filteredGigs = _mockGigs.where((gig) {
      if (_selectedTabIndex == 1) return gig.status == GigStatus.completed;
      if (_selectedTabIndex == 2) return gig.status == GigStatus.cancelled;
      return true;
    }).toList();

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
        actions: const [SizedBox(width: 48)],
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
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredGigs.length,
              itemBuilder: (context, index) {
                final gig = filteredGigs[index];
                return GigCard(
                  gig: gig,
                  onTap: () {
                    // Assuming router handles these paths, otherwise this is just an example
                    if (gig.status == GigStatus.completed) {
                      context.push('/history/completed/${gig.id}');
                    } else {
                      context.push('/history/cancelled/${gig.id}');
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(colorScheme, textTheme),
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

  Widget _buildBottomNav(ColorScheme colorScheme, TextTheme textTheme) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, -4),
            blurRadius: 12,
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.assignment, 'Tasks', false, colorScheme, textTheme),
            _buildNavItem(Icons.chat, 'Chat', false, colorScheme, textTheme),
            _buildNavItem(Icons.payments, 'Earnings', true, colorScheme, textTheme),
            _buildNavItem(Icons.person, 'Profile', false, colorScheme, textTheme),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive, ColorScheme colorScheme, TextTheme textTheme) {
    if (isActive) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: colorScheme.onPrimaryContainer),
            Text(
              label,
              style: textTheme.labelSmall?.copyWith(
                color: colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: colorScheme.onSurfaceVariant),
          Text(
            label,
            style: textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
