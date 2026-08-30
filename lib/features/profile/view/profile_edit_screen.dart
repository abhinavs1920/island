import 'package:flutter/material.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Edit Profile',
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          children: [
            // Profile Avatar Section
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: colorScheme.surface,
                            width: 4,
                          ),
                          image: const DecorationImage(
                            image: NetworkImage(
                                'https://lh3.googleusercontent.com/aida-public/AB6AXuAdGUFXARx8fHVTyognNDeORNLlXABIx6o5XfVQLiAHvVxcvfGCEg4ECN4Ffj8tQ29lDVKQ1K2wDyQntISpLNpp8u0D4SYjN_t6ibJc9aNSHstw2O69jyyexHYnRTukGUKGSHXJWKO8yIqi1p2owu_eevOFH8KRK8Ay9yutZLEl_UUzI0_8FQnGkRFUYyVx7xM-i_UT51XSXGRRCLIhfO-oRlZy7mvRe7aKyydjBsMF10k8xCAS5zAnfa0bbYiV6iHW2aFhFJxiDY0'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            shape: BoxShape.circle,
                            border: Border.all(color: colorScheme.surface),
                          ),
                          child: Icon(
                            Icons.edit,
                            color: colorScheme.onPrimary,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Tap to change photo',
                    style: textTheme.labelMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Form Fields
            _buildTextField(
              context,
              label: 'Full Name',
              icon: Icons.person,
              initialValue: 'Alex Rivera',
            ),
            const SizedBox(height: 16),
            _buildDropdownField(
              context,
              label: 'Vehicle Type',
              icon: Icons.directions_car,
              value: 'Sedan / 4-Door',
            ),
            const SizedBox(height: 16),
            _buildTextField(
              context,
              label: 'License Plate',
              icon: Icons.pin,
              initialValue: 'XYZ-1234',
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                child: const Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context,
      {required String label, required IconData icon, required String initialValue}) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.labelLarge?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: colorScheme.outline),
            filled: true,
            fillColor: colorScheme.surfaceContainerLowest,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colorScheme.outlineVariant),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colorScheme.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colorScheme.primary),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(BuildContext context,
      {required String label, required IconData icon, required String value}) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.labelLarge?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: Row(
            children: [
              Icon(icon, color: colorScheme.outline),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: value,
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down, color: colorScheme.outline),
                    items: [value]
                        .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                        .toList(),
                    onChanged: (_) {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
