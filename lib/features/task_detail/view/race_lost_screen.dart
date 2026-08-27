import 'package:flutter/material.dart';

class RaceLostScreen extends StatelessWidget {
  const RaceLostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF8FF), // surface
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 128,
                    height: 128,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEDEDFB), // surface-container
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.hourglass_empty,
                        size: 64,
                        color: Color(0xFF737688), // outline
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'This gig was just taken by another rider',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF191B25), // on-surface
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'It happens fast! There are plenty more gigs waiting for you.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF434656), // on-surface-variant
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 100), // padding for bottom bar
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              color: const Color(0xFFFBF8FF),
              child: SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF003EC7),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                  ),
                  child: const Text(
                    'See other gigs nearby',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.7,
                    ),
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
