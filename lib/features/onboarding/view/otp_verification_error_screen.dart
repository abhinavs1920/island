import 'package:flutter/material.dart';
import 'otp_verification_screen.dart';

class OtpVerificationErrorScreen extends StatelessWidget {
  const OtpVerificationErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const OtpVerificationScreen(hasError: true);
  }
}
