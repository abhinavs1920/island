import 'package:flutter/material.dart';

class AddEditBankAccountScreen extends StatefulWidget {
  const AddEditBankAccountScreen({super.key});

  @override
  State<AddEditBankAccountScreen> createState() => _AddEditBankAccountScreenState();
}

class _AddEditBankAccountScreenState extends State<AddEditBankAccountScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Bank Account',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface, // nearest to surface-container-lowest
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: colorScheme.outlineVariant),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField(
                      context,
                      label: 'Account Holder Name',
                      hintText: 'John Doe',
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      context,
                      label: 'Account Number',
                      hintText: '••••••••••••',
                      isPassword: true,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      context,
                      label: 'Confirm Account Number',
                      hintText: '••••••••••••',
                      isPassword: true,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      context,
                      label: 'IFSC Code',
                      hintText: 'ABCD0123456',
                      textCapitalization: TextCapitalization.characters,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      context,
                      label: 'Bank Name',
                      hintText: 'Global Standard Bank',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Save bank account logic
                  }
                },
                style: FilledButton.styleFrom(
                  backgroundColor: colorScheme.primaryContainer,
                  foregroundColor: colorScheme.onPrimaryContainer,
                  minimumSize: const Size.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.save, size: 20),
                label: Text(
                  'Save Bank Account',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required String label,
    required String hintText,
    bool isPassword = false,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          obscureText: isPassword,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          style: theme.textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: theme.textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant),
            filled: true,
            fillColor: colorScheme.surfaceContainerHighest, // roughly surface-container-low
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colorScheme.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colorScheme.primary),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
        ),
      ],
    );
  }
}
