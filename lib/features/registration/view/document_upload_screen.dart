import 'package:flutter/material.dart';
import '../widgets/registration_app_bar.dart';
import '../widgets/registration_bottom_button.dart';

class DocumentUploadScreen extends StatelessWidget {
  const DocumentUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: const RegistrationAppBar(
        title: 'Registration',
        stepText: 'Step 3 of 3',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Upload Documents',
              style: textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'We need to verify your documents to get you on the road.',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            _buildUploadCard(
              context: context,
              icon: Icons.upload_file,
              title: 'Driving License (Front & Back)',
              onTap: () {},
              fullWidth: true,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildUploadCard(
                    context: context,
                    icon: Icons.upload_file,
                    title: 'Vehicle Registration Certificate',
                    onTap: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildUploadCard(
                    context: context,
                    icon: Icons.add_a_photo,
                    title: 'Profile Photo',
                    onTap: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: RegistrationBottomButton(
        label: 'Submit for Review',
        onPressed: () {
          // Navigate to next step
        },
      ),
    );
  }

  Widget _buildUploadCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool fullWidth = false,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colorScheme.outlineVariant),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: 4,
              child: Container(color: colorScheme.primary),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: 36, color: colorScheme.primary),
                    const SizedBox(height: 8),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'Tap to upload',
                        style: textTheme.labelMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
