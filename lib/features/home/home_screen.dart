import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'home_controller.dart';
import 'gig_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with WidgetsBindingObserver {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (ref.read(isOnlineProvider)) {
        ref.read(isOnlineProvider.notifier).updateLocation();
      }
    }
  }

  void _onNavTap(int index) {
    setState(() => _selectedIndex = index);
    switch (index) {
      case 0:
        // Tasks — already here
        break;
      case 1:
        // Chat — navigate to last active task chat if any
        // context.push('/chat/latest');
        break;
      case 2:
        // Earnings — placeholder
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Earnings coming soon')),
        );
        break;
      case 3:
        // Profile — placeholder
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile coming soon')),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isOnline = ref.watch(isOnlineProvider);
    final gigsAsync = ref.watch(gigsProvider);

    return Scaffold(
      backgroundColor: isOnline ? const Color(0xFFFBF8FF) : const Color(0xFFE1E1EF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBF8FF),
        elevation: 0,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: const Color(0xFFC3C5D9), height: 1.0),
        ),
        title: const Text(
          'Flikk',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: Color(0xFF003EC7),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Center(
              child: Text(
                isOnline ? 'Online' : 'Offline',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: isOnline ? const Color(0xFF10B981) : const Color(0xFF737688),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Status Hero Toggle
              Container(
                decoration: BoxDecoration(
                  color: isOnline ? const Color(0xFF10B981) : const Color(0xFF737688),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'STATUS',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.7,
                            color: isOnline ? const Color(0xFFD1FAE5) : Colors.white70,
                          ),
                        ),
                        Switch(
                          value: isOnline,
                          onChanged: (val) {
                            ref.read(isOnlineProvider.notifier).toggle(val);
                          },
                          activeColor: Colors.white,
                          activeTrackColor: const Color(0xFF059669),
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: Colors.grey.shade500,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      isOnline
                          ? "You're online — looking for gigs nearby"
                          : "You're offline — go online to find gigs",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    if (isOnline) ...[
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.radar, color: Colors.white, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Scanning your area...',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 32),

              if (isOnline) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Available Gigs',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF191B25),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_list, size: 16, color: Color(0xFF003EC7)),
                      label: const Text(
                        'Filter',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF003EC7),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                gigsAsync.when(
                  data: (gigs) {
                    if (gigs.isEmpty) return _buildEmptyState();
                    return Column(
                      children: gigs
                          .map((gig) => GigCard(
                                gig: gig,
                                onTap: () => context.push('/task/${gig.id}'),
                              ))
                          .toList(),
                    );
                  },
                  loading: () => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (err, _) => Center(
                    child: Text('Error: $err', style: const TextStyle(color: Color(0xFFBA1A1A))),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        children: const [
          Icon(Icons.inbox, size: 64, color: Color(0xFF737688)),
          SizedBox(height: 16),
          Text(
            '0 nearby gigs',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF434656),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Check back later or move to a busier area.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              color: Color(0xFF737688),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {'icon': Icons.assignment_outlined, 'activeIcon': Icons.assignment, 'label': 'Tasks'},
      {'icon': Icons.chat_bubble_outline, 'activeIcon': Icons.chat_bubble, 'label': 'Chat'},
      {'icon': Icons.payments_outlined, 'activeIcon': Icons.payments, 'label': 'Earnings'},
      {'icon': Icons.person_outline, 'activeIcon': Icons.person, 'label': 'Profile'},
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFBF8FF),
        border: Border(top: BorderSide(color: Color(0xFFC3C5D9), width: 1.0)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final isActive = _selectedIndex == index;
          final item = items[index];
          return GestureDetector(
            onTap: () => _onNavTap(index),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: isActive ? const Color(0xFF0052FF) : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      isActive ? item['activeIcon'] as IconData : item['icon'] as IconData,
                      color: isActive ? Colors.white : const Color(0xFF434656),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['label'] as String,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: isActive ? const Color(0xFF0052FF) : const Color(0xFF434656),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
