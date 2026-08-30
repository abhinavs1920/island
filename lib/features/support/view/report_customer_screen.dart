
import 'package:flutter/material.dart';

class ReportCustomerScreen extends StatefulWidget {
  const ReportCustomerScreen({Key? key}) : super(key: key);

  @override
  State<ReportCustomerScreen> createState() => _ReportCustomerScreenState();
}

class _ReportCustomerScreenState extends State<ReportCustomerScreen> {
  final List<String> _reasons = [
    'Abusive Language',
    'Harassment',
    'Incorrect Address',
    'Requested Illegal Activity',
    'Other',
  ];
  final Set<String> _selectedReasons = {};

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
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.primary),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
        ),
        title: Text(
          'Report Issue',
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline, color: colorScheme.primary),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: colorScheme.outlineVariant),
              ),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 80,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.error, // warning-red
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: CircleAvatar(
                      backgroundColor: colorScheme.surfaceContainerHigh,
                      child: Icon(Icons.person, color: colorScheme.onSurfaceVariant),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REPORTING CUSTOMER',
                          style: textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Sarah Jenkins',
                          style: textTheme.titleLarge?.copyWith(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.tag, size: 14, color: colorScheme.onSurfaceVariant),
                              const SizedBox(width: 4),
                              Text(
                                'Task #8492',
                                style: textTheme.labelSmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'SELECT REASON',
              style: textTheme.labelLarge?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ..._reasons.map((reason) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: colorScheme.outlineVariant),
                ),
                child: CheckboxListTile(
                  title: Text(reason, style: textTheme.bodyLarge),
                  value: _selectedReasons.contains(reason),
                  activeColor: theme.colorScheme.error,
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _selectedReasons.add(reason);
                      } else {
                        _selectedReasons.remove(reason);
                      }
                    });
                  },
                ),
              ),
            )).toList(),
            const SizedBox(height: 16),
            Text(
              'ADDITIONAL DETAILS (OPTIONAL)',
              style: textTheme.labelLarge?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Provide more context...',
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
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.warning_amber_rounded),
              label: const Text('Submit Report'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.error,
                foregroundColor: theme.colorScheme.onError,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Submitting a false report may result in account suspension.',
                textAlign: TextAlign.center,
                style: textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
