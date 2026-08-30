class Gig {
  final String id;
  final String title;
  final double price;
  final String description;
  final String distance;
  final String duration;
  final String icon;
  final List<String> tags;

  Gig({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.distance,
    required this.duration,
    required this.icon,
    this.tags = const [],
  });

  factory Gig.fromJson(Map<String, dynamic> json) {
    // Backend returns 'budget' as a string like "₹500-800"; extract the lower number as price
    double price = 0;
    final budgetRaw = json['budget'] ?? json['price'];
    if (budgetRaw is num) {
      price = budgetRaw.toDouble();
    } else if (budgetRaw is String) {
      final match = RegExp(r'\d+').firstMatch(budgetRaw.replaceAll(',', ''));
      if (match != null) price = double.tryParse(match.group(0)!) ?? 0;
    }

    return Gig(
      id: json['id']?.toString() ?? '',
      title: json['title'] as String? ?? json['task_type'] as String? ?? 'Task',
      price: price,
      description: json['description'] as String? ?? '',
      distance: json['distance'] as String? ?? '~nearby',
      duration: json['duration'] as String? ?? '',
      icon: json['icon'] as String? ?? 'assignment',
      tags: (json['tags'] as List?)?.map((e) => e.toString()).toList() ?? const [],
    );
  }
}
