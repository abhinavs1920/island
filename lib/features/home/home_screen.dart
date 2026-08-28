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
        context.push('/earnings');
        break;
      case 3:
        context.push('/profile');
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
            child: Row(
              children: [
                Text(
                  isOnline ? 'ONLINE' : 'OFFLINE',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: isOnline ? const Color(0xFF10B981) : const Color(0xFF434656),
                  ),
                ),
                const SizedBox(width: 8),
                Switch(
                  value: isOnline,
                  onChanged: (val) {
                    ref.read(isOnlineProvider.notifier).toggle(val);
                  },
                  activeColor: Colors.white,
                  activeTrackColor: const Color(0xFF10B981),
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: const Color(0xFFE2E1ED),
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
      bottomNavigationBar: _buildBottomNav(),
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
                  decoration: const BoxDecoration(
                    color: Color(0xFFF3F2FE),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(Icons.directions_walk, size: 64, color: Color(0xFFC4C5D7)),
                  ),
                ),
                const Positioned(
                  top: -48,
                  child: Icon(Icons.arrow_upward, size: 40, color: Color(0xFF002B92)),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Ready to work?',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1B23),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Go online to see gigs nearby and start earning.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                color: Color(0xFF434656),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                ref.read(isOnlineProvider.notifier).toggle(true);
              },
              icon: const Icon(Icons.power_settings_new, color: Colors.white),
              label: const Text(
                'Go Online',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF002B92),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnlineBody(AsyncValue<List<Gig>> gigsAsync) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF10B981),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFC4C5D7)),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(Icons.radar, color: Colors.white, size: 24),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "You're online",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Looking for gigs nearby...',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: 0.25,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
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
            loading: () => _buildLoadingSkeletons(),
            error: (err, _) => Center(
              child: Text('Error: $err', style: const TextStyle(color: Color(0xFFBA1A1A))),
            ),
          ),
        ],
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
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFC4C5D7)),
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
                  decoration: const BoxDecoration(
                    color: Color(0xFFE2E1ED),
                    borderRadius: BorderRadius.only(
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
                          decoration: const BoxDecoration(
                            color: Color(0xFFE2E1ED),
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
                                  color: const Color(0xFFE2E1ED),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 16,
                                width: index == 0 ? 120 : (index == 1 ? 100 : 140),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE2E1ED),
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
                            color: const Color(0xFFE2E1ED),
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
                            color: const Color(0xFFE2E1ED),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        if (index != 1) ...[
                          const SizedBox(width: 8),
                          Container(
                            height: 24,
                            width: 64,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE2E1ED),
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
                              color: const Color(0xFFE2E1ED),
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
        color: const Color(0xFFF3F2FE),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFC4C5D7)),
      ),
      child: Column(
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: const BoxDecoration(
              color: Color(0xFFE2E1ED),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(Icons.inbox_outlined, size: 48, color: Color(0xFF747686)),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No gigs nearby right now',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1B23),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Keep this screen open. We'll notify you with a loud alert the moment a new task posts in your area.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              color: Color(0xFF434656),
            ),
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF002B92).withOpacity(0.1),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.sync, size: 16, color: Color(0xFF002B92)),
                SizedBox(width: 8),
                Text(
                  'Auto-refreshing active',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF002B92),
                  ),
                ),
              ],
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
