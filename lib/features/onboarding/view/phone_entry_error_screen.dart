import 'package:flutter/material.dart';
import 'phone_entry_screen.dart';

class PhoneEntryErrorScreen extends StatelessWidget {
  const PhoneEntryErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PhoneEntryScreen(hasError: true);
  }
}
