import 'package:flutter/material.dart';

class RaceLostScreen extends StatelessWidget {
  const RaceLostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainer, // surface-container
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.hourglass_empty,
                        size: 64,
                        color: Theme.of(context).colorScheme.outline, // outline
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'This gig was just taken by another rider',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface, // on-surface
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'It happens fast! There are plenty more gigs waiting for you.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant, // on-surface-variant
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 100), // padding for bottom bar
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.all(20),
                color: Theme.of(context).colorScheme.surface,
              child: SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  child: Text(
                    'See other gigs nearby',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.white),
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
