import 'package:flutter/material.dart';

class ProfileLoadingScreen extends StatelessWidget {
  const ProfileLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: colorScheme.onSurfaceVariant),
          onPressed: () {},
        ),
        title: _buildShimmerBox(width: 120, height: 24, borderRadius: 4),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: Column(
          children: [
            // Profile Header Skeleton
            Center(
              child: Column(
                children: [
                  _buildShimmerBox(
                    width: 96,
                    height: 96,
                    shape: BoxShape.circle,
                  ),
                  const SizedBox(height: 16),
                  _buildShimmerBox(width: 192, height: 32, borderRadius: 4),
                  const SizedBox(height: 8),
                  _buildShimmerBox(width: 128, height: 16, borderRadius: 4),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Stats Cards Skeleton Row
            Row(
              children: [
                Expanded(
                  child: _buildShimmerBox(height: 80, borderRadius: 8),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildShimmerBox(height: 80, borderRadius: 8),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildShimmerBox(height: 80, borderRadius: 8),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // List Items Skeleton
            _buildShimmerBox(height: 56, borderRadius: 8),
            const SizedBox(height: 12),
            _buildShimmerBox(height: 56, borderRadius: 8),
            const SizedBox(height: 12),
            _buildShimmerBox(height: 56, borderRadius: 8),
            const SizedBox(height: 16),
            // Additional Content Block Skeleton
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: colorScheme.outlineVariant),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildShimmerBox(width: 100, height: 24, borderRadius: 4),
                  const SizedBox(height: 16),
                  _buildShimmerBox(width: double.infinity, height: 16, borderRadius: 4),
                  const SizedBox(height: 8),
                  _buildShimmerBox(width: 250, height: 16, borderRadius: 4),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payments),
            label: 'Earnings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerBox({
    double? width,
    required double height,
    double borderRadius = 0,
    BoxShape shape = BoxShape.rectangle,
  }) {
    return Builder(
      builder: (context) {
        final color = Theme.of(context).colorScheme.surfaceContainerHighest;
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            shape: shape,
            borderRadius: shape == BoxShape.rectangle
                ? BorderRadius.circular(borderRadius)
                : null,
          ),
        );
      },
    );
  }
}
