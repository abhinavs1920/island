import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'auth_provider.dart';

class PhoneEntryScreen extends ConsumerStatefulWidget {
  const PhoneEntryScreen({super.key});

  @override
  ConsumerState<PhoneEntryScreen> createState() => _PhoneEntryScreenState();
}

class _PhoneEntryScreenState extends ConsumerState<PhoneEntryScreen> {
  final TextEditingController _phoneController = TextEditingController();

  void _onKeyPress(String key) {
    if (key == 'backspace') {
      if (_phoneController.text.isNotEmpty) {
        _phoneController.text = _phoneController.text.substring(0, _phoneController.text.length - 1);
      }
    } else {
      if (_phoneController.text.length < 10) {
        _phoneController.text += key;
      }
    }
  }

  void _submit() async {
    final success = await ref.read(authProvider.notifier).sendOtp(_phoneController.text);
    if (success && mounted) {
      context.push('/otp');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Back button
              IconButton(
                onPressed: () {
                  if (context.canPop()) context.pop();
                },
                icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface),
              ),
              const SizedBox(height: 24),
              Text(
                'Enter your phone number',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  height: 1.25,
                  letterSpacing: -0.64,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "We'll send you an OTP to verify.",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 40),
              // Input Box
              Container(
                height: 64,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  border: Border.all(
                    color: authState.error != null ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.outlineVariant,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border(right: BorderSide(color: Theme.of(context).colorScheme.outlineVariant)),
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            '+91',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: _phoneController,
                          readOnly: true, // using custom keypad
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '000 000 0000',
                            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.outlineVariant,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (_phoneController.text.isNotEmpty)
                      IconButton(
                        onPressed: () {
                          _phoneController.clear();
                          setState(() {});
                        },
                        icon: Icon(Icons.close, color: Theme.of(context).colorScheme.onSurfaceVariant),
                      ),
                  ],
                ),
              ),
              if (authState.error != null) ...[
                const SizedBox(height: 8),
                Text(
                  authState.error!,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ],
              const Spacer(),
              // Keypad
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                childAspectRatio: 2.5,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  for (var i = 1; i <= 9; i++) _buildKey(i.toString()),
                  const SizedBox.shrink(),
                  _buildKey('0'),
                  GestureDetector(
                    onTap: () {
                      _onKeyPress('backspace');
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Icon(Icons.backspace, color: Theme.of(context).colorScheme.onSurfaceVariant),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Send OTP Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: authState.isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: authState.isLoading
                      ? SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(color: Theme.of(context).colorScheme.onPrimary, strokeWidth: 2),
                        )
                      : Text(
                          'Send OTP',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            letterSpacing: 0.7,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKey(String value) {
    return GestureDetector(
      onTap: () {
        _onKeyPress(value);
        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
