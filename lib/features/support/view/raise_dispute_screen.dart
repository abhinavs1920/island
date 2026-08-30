
import 'package:flutter/material.dart';

class RaiseDisputeScreen extends StatefulWidget {
  const RaiseDisputeScreen({Key? key}) : super(key: key);

  @override
  State<RaiseDisputeScreen> createState() => _RaiseDisputeScreenState();
}

class _RaiseDisputeScreenState extends State<RaiseDisputeScreen> {
  String? _selectedIssue;

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
          icon: Icon(Icons.arrow_back, color: colorScheme.primary),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
        ),
        title: Text(
          'Raise Dispute',
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: colorScheme.outlineVariant),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 48,
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Gig Reference',
                              style: textTheme.labelMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Gig #8492 - Furniture Assembly',
                              style: textTheme.bodyLarge?.copyWith(
                                color: colorScheme.onBackground,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.build_outlined, color: colorScheme.outline),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Select Issue Type',
                  style: textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: colorScheme.outlineVariant),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: Text(
                        'Choose an option',
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      value: _selectedIssue,
                      items: const [
                        DropdownMenuItem(value: 'wrong_earnings', child: Text('Wrong Earnings')),
                        DropdownMenuItem(value: 'cancellation_fee', child: Text('Incorrect Cancellation Fee')),
                        DropdownMenuItem(value: 'customer_behaviour', child: Text('Customer Behaviour')),
                        DropdownMenuItem(value: 'other', child: Text('Other')),
                      ],
                      onChanged: (val) {
                        setState(() {
                          _selectedIssue = val;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Describe the issue',
                  style: textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Please provide details about the issue...',
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
                const SizedBox(height: 100),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.send),
              label: const Text('Submit Dispute'),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primaryContainer,
                foregroundColor: colorScheme.onPrimaryContainer,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
