import 'package:flutter/material.dart';

enum TaskSortOption {
  postedDate,
  priceHighToLow,
  priceLowToHigh,
  distanceNearest,
  urgencyFirst,
}

class TaskFilterCriteria {
  final TaskSortOption sortBy;
  final double? maxDistanceKm;
  final bool urgentOnly;

  const TaskFilterCriteria({
    this.sortBy = TaskSortOption.distanceNearest,
    this.maxDistanceKm,
    this.urgentOnly = false,
  });

  TaskFilterCriteria copyWith({
    TaskSortOption? sortBy,
    double? maxDistanceKm,
    bool? urgentOnly,
    bool clearDistance = false,
  }) {
    return TaskFilterCriteria(
      sortBy: sortBy ?? this.sortBy,
      maxDistanceKm: clearDistance ? null : (maxDistanceKm ?? this.maxDistanceKm),
      urgentOnly: urgentOnly ?? this.urgentOnly,
    );
  }
}

class TaskFilterDialog extends StatefulWidget {
  final TaskFilterCriteria initialCriteria;
  final ValueChanged<TaskFilterCriteria> onApply;

  const TaskFilterDialog({
    Key? key,
    required this.initialCriteria,
    required this.onApply,
  }) : super(key: key);

  static Future<void> show(
    BuildContext context, {
    required TaskFilterCriteria currentCriteria,
    required ValueChanged<TaskFilterCriteria> onApply,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => TaskFilterDialog(
        initialCriteria: currentCriteria,
        onApply: onApply,
      ),
    );
  }

  @override
  State<TaskFilterDialog> createState() => _TaskFilterDialogState();
}

class _TaskFilterDialogState extends State<TaskFilterDialog> {
  late TaskSortOption _sortBy;
  late double? _maxDistanceKm;
  late bool _urgentOnly;

  @override
  void initState() {
    super.initState();
    _sortBy = widget.initialCriteria.sortBy;
    _maxDistanceKm = widget.initialCriteria.maxDistanceKm;
    _urgentOnly = widget.initialCriteria.urgentOnly;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sort & Filter Gigs',
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _sortBy = TaskSortOption.distanceNearest;
                    _maxDistanceKm = null;
                    _urgentOnly = false;
                  });
                },
                child: const Text('Reset'),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 8),
          
          // Sort Options
          Text(
            'SORT BY',
            style: theme.textTheme.labelSmall?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildChoiceChip('Nearest First', TaskSortOption.distanceNearest),
              _buildChoiceChip('Posted Date (Newest)', TaskSortOption.postedDate),
              _buildChoiceChip('Price (High to Low)', TaskSortOption.priceHighToLow),
              _buildChoiceChip('Price (Low to High)', TaskSortOption.priceLowToHigh),
              _buildChoiceChip('Urgency First', TaskSortOption.urgencyFirst),
            ],
          ),
          const SizedBox(height: 16),

          // Distance Filter
          Text(
            'MAX DISTANCE',
            style: theme.textTheme.labelSmall?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              _buildDistanceChip('Any Distance', null),
              _buildDistanceChip('< 2 km', 2.0),
              _buildDistanceChip('< 5 km', 5.0),
              _buildDistanceChip('< 10 km', 10.0),
            ],
          ),
          const SizedBox(height: 16),

          // Urgency Switch
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Show Urgent Gigs Only',
              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            subtitle: const Text('Tasks marked as high priority or immediate'),
            value: _urgentOnly,
            onChanged: (val) {
              setState(() {
                _urgentOnly = val;
              });
            },
            activeColor: colorScheme.primary,
          ),
          const SizedBox(height: 20),

          // Apply Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              widget.onApply(TaskFilterCriteria(
                sortBy: _sortBy,
                maxDistanceKm: _maxDistanceKm,
                urgentOnly: _urgentOnly,
              ));
              Navigator.pop(context);
            },
            child: const Text('Apply Filters'),
          ),
        ],
      ),
    );
  }

  Widget _buildChoiceChip(String label, TaskSortOption option) {
    final isSelected = _sortBy == option;
    final colorScheme = Theme.of(context).colorScheme;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _sortBy = option;
          });
        }
      },
      selectedColor: colorScheme.primaryContainer,
      labelStyle: TextStyle(
        color: isSelected ? colorScheme.onPrimaryContainer : colorScheme.onSurface,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  Widget _buildDistanceChip(String label, double? distance) {
    final isSelected = _maxDistanceKm == distance;
    final colorScheme = Theme.of(context).colorScheme;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _maxDistanceKm = distance;
        });
      },
      selectedColor: colorScheme.secondaryContainer,
      labelStyle: TextStyle(
        color: isSelected ? colorScheme.onSecondaryContainer : colorScheme.onSurface,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
