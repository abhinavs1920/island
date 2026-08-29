import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MatchedConfirmationScreen extends StatelessWidget {
  final String taskId;
  const MatchedConfirmationScreen({Key? key, required this.taskId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // background/surface
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
                color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2), // primary-container with opacity
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
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer, // primary-container
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.check_circle,
                        size: 48,
                        color: Theme.of(context).colorScheme.onPrimaryContainer, // on-primary-container
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "You're matched!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Message the requester to confirm details.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant, // on-surface-variant
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 32),
                  
                  // Contextual Details Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface, // surface-container-lowest
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                      boxShadow: [
                        BoxShadow(color: Color(0x0D000000), offset: Offset(0, 1), blurRadius: 2),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceContainerHigh, // surface-container-high
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.person, color: Theme.of(context).colorScheme.primary),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Alex Johnson',
                                style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface),
                              ),
                              Text(
                                'Delivery to Downtown',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.chevron_right, color: Theme.of(context).colorScheme.outline),
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
                    Theme.of(context).colorScheme.surface,
                    Theme.of(context).colorScheme.surface.withOpacity(0.0),
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
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.chat, size: 20),
                      SizedBox(width: 4),
                      Text(
                        'Open chat',
                        style: Theme.of(context).textTheme.labelLarge!,
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
