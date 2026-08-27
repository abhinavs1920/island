import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/task_detail_provider.dart';

class TaskDetailScreen extends ConsumerWidget {
  final String taskId;

  const TaskDetailScreen({Key? key, required this.taskId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskDetailAsync = ref.watch(taskDetailProvider(taskId));
    final acceptTaskState = ref.watch(acceptTaskProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFBF8FF), // surface
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBF8FF), // surface
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF434656)), // on-surface-variant
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'TaskRunner',
          style: TextStyle(
            color: Color(0xFF003EC7), // primary
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: 'Inter',
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Online',
              style: TextStyle(
                color: Color(0xFF434656), // on-surface-variant
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
            color: const Color(0xFFC3C5D9), // outline-variant
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
                        color: const Color(0xFFE1E1EF), // surface-variant
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFC3C5D9)), // outline-variant
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
                        color: const Color(0xFFFFFFFF), // surface-container-lowest
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFC3C5D9)),
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
                                    children: const [
                                      Icon(Icons.handyman, color: Color(0xFF003EC7), size: 16),
                                      SizedBox(width: 4),
                                      Text('Repair', style: TextStyle(color: Color(0xFF434656), fontSize: 14, fontWeight: FontWeight.w500)),
                                      SizedBox(width: 4),
                                      Text('•', style: TextStyle(color: Color(0xFF434656))),
                                      SizedBox(width: 4),
                                      Text('AC Repair', style: TextStyle(color: Color(0xFF434656), fontSize: 14, fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    data['location'] ?? 'Indiranagar',
                                    style: const TextStyle(
                                      color: Color(0xFF191B25),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFDAD6), // error-container
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  'HIGH URGENCY',
                                  style: TextStyle(
                                    color: Color(0xFF93000A), // on-error-container
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
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
                                      children: const [
                                        Icon(Icons.payments, size: 16, color: Color(0xFF434656)),
                                        SizedBox(width: 4),
                                        Text('Budget', style: TextStyle(fontSize: 14, color: Color(0xFF434656))),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      data['budget'] ?? '₹500-800',
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF191B25)),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(Icons.directions_walk, size: 16, color: Color(0xFF434656)),
                                        SizedBox(width: 4),
                                        Text('Distance', style: TextStyle(fontSize: 14, color: Color(0xFF434656))),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      data['distance'] ?? '~2.5 km',
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF191B25)),
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

                    // Description Section
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFC3C5D9)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.description, size: 20, color: Color(0xFF191B25)),
                              SizedBox(width: 8),
                              Text(
                                'Task Description',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF191B25), letterSpacing: 0.7),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            data['description'] ?? 'Cooler fan not working, making noise. Needs immediate inspection and potentially a part replacement if the bearing is shot. Client is available now.',
                            style: const TextStyle(fontSize: 16, color: Color(0xFF434656), height: 1.5),
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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: const BoxDecoration(
                  color: Color(0xFFFBF8FF), // surface
                  border: Border(top: BorderSide(color: Color(0xFFC3C5D9))),
                  boxShadow: [
                    BoxShadow(color: Color(0x1A000000), offset: Offset(0, -4), blurRadius: 6),
                  ],
                ),
                child: SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: acceptTaskState.isLoading ? null : () async {
                      final status = await ref.read(acceptTaskProvider.notifier).acceptTask(taskId);
                      if (!context.mounted) return;
                      if (status == 'matched') {
                        Navigator.pushNamed(context, '/matched_confirmation');
                      } else if (status == 'race_lost') {
                        Navigator.pushNamed(context, '/race_lost');
                      } else if (status == 'error') {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error accepting task')));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF003EC7),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: const Color(0xFF003EC7).withOpacity(0.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      elevation: 0,
                    ),
                    child: acceptTaskState.isLoading
                      ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Accept this gig',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 0.7),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.check_circle, size: 20),
                          ],
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFF003EC7))),
        error: (e, st) => Center(child: Text('Error: $e', style: const TextStyle(color: Color(0xFFBA1A1A)))),
      ),
    );
  }
}
