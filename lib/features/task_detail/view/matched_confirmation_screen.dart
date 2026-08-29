import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MatchedConfirmationScreen extends StatelessWidget {
  final String taskId;
  const MatchedConfirmationScreen({Key? key, required this.taskId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF8FF), // background/surface
      body: Stack(
        children: [
          // Background decorative element
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            left: MediaQuery.of(context).size.width / 2 - 150,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: const Color(0xFF0052FF).withOpacity(0.2), // primary-container with opacity
                shape: BoxShape.circle,
              ),
              // we can use a BackdropFilter for blur, but simplicity is fine
            ),
          ),
          
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 96,
                    height: 96,
                    decoration: const BoxDecoration(
                      color: Color(0xFF0052FF), // primary-container
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.check_circle,
                        size: 48,
                        color: Color(0xFFDFE3FF), // on-primary-container
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "You're matched!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF191B25),
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.64,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Message the requester to confirm details.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF434656), // on-surface-variant
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Contextual Details Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF), // surface-container-lowest
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFC3C5D9)),
                      boxShadow: const [
                        BoxShadow(color: Color(0x0D000000), offset: Offset(0, 1), blurRadius: 2),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE7E7F5), // surface-container-high
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.person, color: Color(0xFF003EC7)),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Alex Johnson',
                                style: TextStyle(
                                  color: Color(0xFF191B25),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.7,
                                ),
                              ),
                              Text(
                                'Delivery to Downtown',
                                style: TextStyle(
                                  color: Color(0xFF434656),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: Color(0xFF737688)),
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
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    const Color(0xFFFBF8FF),
                    const Color(0xFFFBF8FF).withOpacity(0.0),
                  ],
                ),
              ),
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    context.pushReplacement('/chat/$taskId');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF003EC7),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.chat, size: 20),
                      SizedBox(width: 4),
                      Text(
                        'Open chat',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.7,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
