import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/settings_provider.dart';
import '../widgets/settings_item_button.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(settingsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFBF8FF), // background
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBF8FF),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.primary),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            }
          },
        ),
        title: Text(
          'Settings',
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.01,
          ),
        ),
        centerTitle: true,
        actions: const [
          SizedBox(width: 48), // balance leading icon
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: const Color(0xFFC4C5D7), // outline-variant
            height: 1.0,
          ),
        ),
      ),
      body: status == SettingsStatus.loading
          ? const _SettingsLoadingView()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20.0), // gutter
              child: Column(
                children: [
                  if (status == SettingsStatus.success)
                    Container(
                      margin: const EdgeInsets.only(bottom: 12), // stack-gap
                      padding: const EdgeInsets.all(16), // margin
                      decoration: BoxDecoration(
                        color: const Color(0xFFD1FAE5), // success-light
                        borderRadius: BorderRadius.circular(12), // xl
                        border: Border.all(
                          color: const Color(0xFF10B981).withOpacity(0.2), // success-emerald/20
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Color(0xFF10B981), // success-emerald
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'Settings saved successfully',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFF10B981),
                            ),
                          ),
                        ],
                      ),
                    ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF), // surface-lowest
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFC4C5D7), // outline-variant
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        SettingsItemButton(
                          icon: Icons.info,
                          text: 'App Version (v1.0.4)',
                          onTap: () {
                            ref.read(settingsProvider.notifier).saveSettings();
                          },
                        ),
                        SettingsItemButton(
                          icon: Icons.support_agent,
                          text: 'Support Contact',
                          hasTrailing: true,
                          onTap: () {},
                        ),
                        SettingsItemButton(
                          icon: Icons.logout,
                          text: 'Log out',
                          isError: true,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class _SettingsLoadingView extends StatelessWidget {
  const _SettingsLoadingView();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: _buildShimmer(width: 128, height: 24),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFC4C5D7)),
            ),
            child: Column(
              children: [
                _buildSkeletonItem(),
                _buildSkeletonItem(),
                _buildSkeletonItem(isLast: true),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: _buildShimmer(width: 96, height: 24),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFC4C5D7)),
            ),
            child: _buildSkeletonItem(isLast: true),
          ),
          const SizedBox(height: 32),
          Center(
            child: _buildShimmer(width: 200, height: 48, borderRadius: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildSkeletonItem({bool isLast = false}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(
                bottom: BorderSide(color: Color(0xFFC4C5D7), width: 0.5),
              ),
      ),
      child: Row(
        children: [
          _buildShimmer(width: 40, height: 40, borderRadius: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildShimmer(width: 150, height: 20),
                const SizedBox(height: 8),
                _buildShimmer(width: 100, height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmer({
    required double width,
    required double height,
    double borderRadius = 8,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFE2E1ED).withOpacity(0.5),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
