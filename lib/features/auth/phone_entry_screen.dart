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
      backgroundColor: const Color(0xFFFBF8FF),
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
                icon: const Icon(Icons.arrow_back, color: Color(0xFF191B25)),
              ),
              const SizedBox(height: 24),
              const Text(
                'Enter your phone number',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF191B25),
                  height: 1.25,
                  letterSpacing: -0.64,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "We'll send you an OTP to verify.",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  color: Color(0xFF434656),
                ),
              ),
              const SizedBox(height: 40),
              // Input Box
              Container(
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: authState.error != null ? const Color(0xFFBA1A1A) : const Color(0xFFC3C5D9),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: const BoxDecoration(
                        border: Border(right: BorderSide(color: Color(0xFFC3C5D9))),
                        color: Color(0xFFEDEDFB),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Text(
                            '+91',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF191B25),
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
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF191B25),
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '000 000 0000',
                            hintStyle: TextStyle(
                              color: Color(0xFFC3C5D9),
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
                        icon: const Icon(Icons.close, color: Color(0xFF434656)),
                      ),
                  ],
                ),
              ),
              if (authState.error != null) ...[
                const SizedBox(height: 8),
                Text(
                  authState.error!,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    color: Color(0xFFBA1A1A),
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
                        color: const Color(0xFFEDEDFB),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Icon(Icons.backspace, color: Color(0xFF434656)),
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
                    backgroundColor: const Color(0xFF003EC7),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: authState.isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : const Text(
                          'Send OTP',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
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
          color: Colors.white,
          border: Border.all(color: const Color(0xFFC3C5D9)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            value,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF191B25),
            ),
          ),
        ),
      ),
    );
  }
}
