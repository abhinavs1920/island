import 'package:flutter/material.dart';
import '../widgets/registration_app_bar.dart';
import '../widgets/registration_bottom_button.dart';
import '../widgets/registration_text_field.dart';
import '../widgets/registration_dropdown.dart';
import 'package:go_router/go_router.dart';

class VehicleDetailsScreen extends StatelessWidget {
  const VehicleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: const RegistrationAppBar(
        title: 'TaskRunner',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Vehicle Details',
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface,
                  ),
                ),
                Text(
                  'Step 2 of 3',
                  style: textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: colorScheme.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              height: 8,
              width: double.infinity,
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(4),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: 0.66,
                child: Container(
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            RegistrationDropdown<String>(
              label: 'Vehicle Type',
              hint: 'Select vehicle type',
              items: const [
                DropdownMenuItem(value: 'bicycle', child: Text('Bicycle')),
                DropdownMenuItem(value: 'motorcycle', child: Text('Motorcycle')),
                DropdownMenuItem(value: 'car', child: Text('Car')),
              ],
              onChanged: (value) {},
            ),
            const SizedBox(height: 24),
            const RegistrationTextField(
              label: 'Vehicle Make & Model',
              hint: 'e.g. Toyota Corolla, Trek FX',
            ),
            const SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'License Plate Number',
                      style: textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      'OPTIONAL FOR BIKES',
                      style: textTheme.labelMedium?.copyWith(
                        color: colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                TextFormField(
                  textCapitalization: TextCapitalization.characters,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                  decoration: InputDecoration(
                    hintText: 'e.g. ABC-1234',
                    hintStyle: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.outline,
                    ),
                    filled: true,
                    fillColor: colorScheme.surface,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
            ),
            const SizedBox(height: 24),
            RegistrationDropdown<String>(
              label: 'Vehicle Color',
              hint: 'Select primary color',
              items: const [
                DropdownMenuItem(value: 'black', child: Text('Black')),
                DropdownMenuItem(value: 'white', child: Text('White')),
                DropdownMenuItem(value: 'silver', child: Text('Silver/Grey')),
                DropdownMenuItem(value: 'red', child: Text('Red')),
                DropdownMenuItem(value: 'blue', child: Text('Blue')),
                DropdownMenuItem(value: 'other', child: Text('Other')),
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
        },
      ),
    );
  }
}
