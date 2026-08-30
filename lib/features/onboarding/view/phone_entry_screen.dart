import 'package:flutter/material.dart';
import '../widgets/custom_keypad.dart';
import 'package:go_router/go_router.dart';

class PhoneEntryScreen extends StatefulWidget {
  final bool hasError;
  const PhoneEntryScreen({super.key, this.hasError = false});

  @override
  State<PhoneEntryScreen> createState() => _PhoneEntryScreenState();
}

class _PhoneEntryScreenState extends State<PhoneEntryScreen> {
  final TextEditingController _controller = TextEditingController();

  void _onKeyPressed(String value) {
    if (_controller.text.length < 10) {
      _controller.text += value;
    }
  }

  void _onBackspace() {
    if (_controller.text.isNotEmpty) {
      _controller.text = _controller.text.substring(0, _controller.text.length - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              SizedBox(
                height: 48,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      if (context.canPop()) {
                        context.pop();
                      }
                    },
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Header
              Text(
                'Enter your phone number',
                style: textTheme.displayLarge?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w800,
                  fontSize: 32,
                  letterSpacing: -0.02,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'We\'ll send you an OTP to verify.',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 40),

              // Input Section
              Container(
                height: 64,
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: widget.hasError ? colorScheme.error : colorScheme.outlineVariant,
                    width: widget.hasError ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    // Country Code
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: widget.hasError ? colorScheme.error : colorScheme.outlineVariant,
                          ),
                        ),
                        color: colorScheme.surfaceContainer,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.flag, size: 16, color: colorScheme.onSurfaceVariant), // Placeholder for flag
                          const SizedBox(width: 8),
                          Text(
                            '+91',
                            style: textTheme.bodyLarge?.copyWith(
                              color: colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.arrow_drop_down,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ],
                      ),
                    ),
                    
                    // Input Field
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        readOnly: true, // Controlled by CustomKeypad
                        style: textTheme.titleLarge?.copyWith(
                          color: widget.hasError ? colorScheme.error : colorScheme.onSurface,
                          fontWeight: FontWeight.w700,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                          hintText: '000 000 0000',
                          hintStyle: TextStyle(color: colorScheme.outlineVariant),
                        ),
                      ),
                    ),
                    
                    if (widget.hasError)
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Icon(Icons.error, color: colorScheme.error),
                      )
                    else
                      IconButton(
                        icon: const Icon(Icons.close),
                        color: colorScheme.onSurfaceVariant,
                        onPressed: () {
                          _controller.clear();
                        },
                      ),
                  ],
                ),
              ),
              if (widget.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.error, color: colorScheme.error, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        'Invalid phone number',
                        style: textTheme.labelMedium?.copyWith(
                          color: colorScheme.error,
                        ),
                      ),
                    ],
                  ),
                ),

              // Spacer to push keypad to bottom
              const Spacer(),

              // Custom Keypad
              CustomKeypad(
                onKeyPressed: _onKeyPressed,
                onBackspace: _onBackspace,
              ),
              const SizedBox(height: 24),

              // CTA
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Send OTP',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.05,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
