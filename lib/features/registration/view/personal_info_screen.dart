import 'package:flutter/material.dart';
import '../widgets/registration_app_bar.dart';
import '../widgets/registration_bottom_button.dart';
import '../widgets/registration_text_field.dart';
import '../widgets/registration_dropdown.dart';
import 'package:go_router/go_router.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: const RegistrationAppBar(
        title: 'Step 1 of 3',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personal Info',
              style: textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'We need a few details to get you set up and ready to work.',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 32),
            const RegistrationTextField(
              label: 'Full Name',
              hint: 'e.g. Jane Doe',
              prefixIcon: Icons.person_outline,
            ),
            const SizedBox(height: 16),
            RegistrationTextField(
              label: 'Date of Birth',
              hint: 'Select Date',
              prefixIcon: Icons.calendar_today_outlined,
              readOnly: true,
              onTap: () async {
                await showDatePicker(
                  context: context,
                  initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
              },
            ),
            const SizedBox(height: 16),
            const RegistrationTextField(
              label: 'Email Address',
              hint: 'jane@example.com',
              prefixIcon: Icons.mail_outline,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            RegistrationDropdown<String>(
              label: 'Gender',
              hint: 'Select gender',
              prefixIcon: Icons.wc_outlined,
              items: const [
                DropdownMenuItem(value: 'male', child: Text('Male')),
                DropdownMenuItem(value: 'female', child: Text('Female')),
                DropdownMenuItem(value: 'other', child: Text('Other')),
                DropdownMenuItem(value: 'prefer_not', child: Text('Prefer not to say')),
              ],
              onChanged: (value) {},
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: RegistrationBottomButton(
        label: 'Next Step',
        icon: Icons.arrow_forward,
        onPressed: () {
          // Navigate to next step
          // context.push('/registration/vehicle-details');
        },
      ),
    );
  }
}
