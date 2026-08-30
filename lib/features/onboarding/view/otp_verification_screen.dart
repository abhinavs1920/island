import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OtpVerificationScreen extends StatefulWidget {
  final bool hasError;
  const OtpVerificationScreen({super.key, this.hasError = false});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    bool allFilled = _controllers.every((c) => c.text.isNotEmpty);

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            }
          },
        ),
        title: Text(
          'TaskRunner',
          style: textTheme.displayLarge?.copyWith(
            color: colorScheme.primary,
            fontSize: 32,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: colorScheme.outlineVariant,
            height: 1,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background Pattern (just a subtle grid effect can be simulated, but skipping for simplicity)
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  child: Column(
                    children: [
                      // Header
                      Text(
                        'Verify Phone',
                        style: textTheme.displayLarge?.copyWith(
                          color: colorScheme.onSurface,
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                          children: [
                            const TextSpan(text: 'We sent a 6-digit code to\n'),
                            TextSpan(
                              text: '+1 (555) 019-2834',
                              style: textTheme.bodyLarge?.copyWith(
                                color: colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // OTP Inputs
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(6, (index) {
                          return SizedBox(
                            width: 48,
                            height: 64,
                            child: TextField(
                              controller: _controllers[index],
                              focusNode: _focusNodes[index],
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              onChanged: (value) => _onChanged(value, index),
                              style: textTheme.displayLarge?.copyWith(
                                fontSize: 32,
                                color: widget.hasError ? colorScheme.error : colorScheme.onSurface,
                              ),
                              decoration: InputDecoration(
                                counterText: "",
                                filled: true,
                                fillColor: colorScheme.surface,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(
                                    color: widget.hasError ? colorScheme.error : colorScheme.primary,
                                    width: 2,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(
                                    color: widget.hasError ? colorScheme.error : colorScheme.outlineVariant,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),

                      // Error message
                      if (widget.hasError)
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error, color: colorScheme.error, size: 20),
                              const SizedBox(width: 4),
                              Text(
                                'Incorrect code, try again',
                                style: textTheme.labelMedium?.copyWith(
                                  color: colorScheme.error,
                                ),
                              ),
                            ],
                          ),
                        ),

                      const SizedBox(height: 32),

                      // Resend Link
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          foregroundColor: colorScheme.primary,
                        ),
                        child: const Text(
                          'Resend in 0:28',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.05,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Bottom CTA
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  border: Border(
                    top: BorderSide(color: colorScheme.outlineVariant),
                  ),
                ),
                child: SafeArea(
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: FilledButton(
                      onPressed: allFilled ? () {} : null,
                      style: FilledButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        disabledBackgroundColor: colorScheme.surfaceVariant,
                        disabledForegroundColor: colorScheme.onSurfaceVariant,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text(
                        'Verify',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.05,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
