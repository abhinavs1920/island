import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui';

class CompleteConfirmationScreen extends StatefulWidget {
  const CompleteConfirmationScreen({super.key});

  @override
  State<CompleteConfirmationScreen> createState() => _CompleteConfirmationScreenState();
}

class _CompleteConfirmationScreenState extends State<CompleteConfirmationScreen> {
  int _rating = 0;
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: Stack(
        children: [
          // Mock Background (Chat Interface)
          Positioned.fill(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Opacity(
                opacity: 0.5,
                child: Container(
                  color: theme.colorScheme.surface,
                  child: Column(
                    children: [
                      AppBar(
                        backgroundColor: theme.colorScheme.surface,
                        elevation: 0,
                        leading: Icon(Icons.arrow_back, color: theme.colorScheme.primary),
                        title: Text(
                          'Alex (Requester)',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        actions: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Center(
                              child: Text(
                                'Online',
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.all(16),
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                margin: const EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.surfaceVariant,
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  'Hey, just checking if you found the building alright?',
                                  style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                margin: const EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  "Yes, pulling up now. I'll leave it at the front desk as requested.",
                                  style: TextStyle(color: theme.colorScheme.onPrimary),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                margin: const EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.surfaceVariant,
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  "Perfect, thank you! I've marked the task as ready to complete.",
                                  style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // Scrim overlay
          Positioned.fill(
            child: Container(
              color: theme.colorScheme.onBackground.withOpacity(0.4),
            ),
          ),
          
          // Bottom Sheet Content
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 30,
                    offset: const Offset(0, -8),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Handle
                      Container(
                        width: 48,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 24),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.outlineVariant,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      
                      // Title & Context
                      Text(
                        'Task Completed',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'How was your experience with Alex?',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      
                      // Rating Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          final starValue = index + 1;
                          return IconButton(
                            iconSize: 40,
                            padding: const EdgeInsets.all(8),
                            icon: Icon(
                              _rating >= starValue ? Icons.star : Icons.star_border,
                              color: _rating >= starValue 
                                  ? theme.colorScheme.primary 
                                  : theme.colorScheme.outlineVariant,
                            ),
                            onPressed: () {
                              setState(() {
                                _rating = starValue;
                              });
                            },
                          );
                        }),
                      ),
                      const SizedBox(height: 24),
                      
                      // Feedback Input
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Additional Feedback (Optional)',
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _feedbackController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Leave a note about the drop-off...',
                          hintStyle: TextStyle(
                            color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
                          ),
                          filled: true,
                          fillColor: theme.colorScheme.surface,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: theme.colorScheme.outlineVariant,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: theme.colorScheme.outlineVariant,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Actions
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF166534), // Green #166534
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 56),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(color: Color(0xFF14532D)),
                          ),
                          elevation: 0,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Submit and finish',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.check_circle, size: 20),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: () {
                          if (context.canPop()) {
                            context.pop();
                          }
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: theme.colorScheme.primary,
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Skip rating',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
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
