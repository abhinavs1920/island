class Gig {
  final String id;
  final String title;
  final String category;
  final double price;
  final String description;
  final String distance;
  final String duration;
  final String icon;
  final List<String> tags;

  Gig({
    required this.id,
    required this.title,
    this.category = 'Task',
    required this.price,
    required this.description,
    required this.distance,
    required this.duration,
    required this.icon,
    this.tags = const [],
  });

  bool get isMilestone {
    final lowerTags = tags.map((t) => t.toLowerCase()).toList();
    final lowerCat = category.toLowerCase();
    final lowerTitle = title.toLowerCase();
    return lowerTags.any((t) => t.contains('milestone') || t.contains('errand')) ||
        lowerCat.contains('milestone') ||
        lowerCat.contains('errand') ||
        lowerCat.contains('buy') ||
        lowerTitle.contains('milestone') ||
        lowerTitle.contains('errand');
  }

  factory Gig.fromJson(Map<String, dynamic> json) {
    double price = 0;
    if (json['price'] != null) {
      price = (json['price'] is num) ? (json['price'] as num).toDouble() : (double.tryParse(json['price'].toString()) ?? 0.0);
    } else if (json['payout'] != null) {
      price = (json['payout'] is num) ? (json['payout'] as num).toDouble() : (double.tryParse(json['payout'].toString()) ?? 0.0);
    } else if (json['budget_min'] != null) {
      price = (json['budget_min'] is num) ? (json['budget_min'] as num).toDouble() : (double.tryParse(json['budget_min'].toString()) ?? 0.0);
    } else if (json['budget_max'] != null) {
      price = (json['budget_max'] is num) ? (json['budget_max'] as num).toDouble() : (double.tryParse(json['budget_max'].toString()) ?? 0.0);
    }

    String desc = '';
    final constraints = json['constraints'];
    if (constraints is Map) {
      desc = constraints['details']?.toString() ?? '';
    }
    if (desc.isEmpty) desc = json['description']?.toString() ?? '';

    final cat = json['category']?.toString() ?? json['task_type']?.toString() ?? 'Task';

    return Gig(
      id: json['id']?.toString() ?? '',
      title: cat,
      category: cat,
      price: price,
      description: desc,
      distance: json['distance']?.toString() ?? '~nearby',
      duration: json['duration']?.toString() ?? '30 mins',
      icon: json['icon']?.toString() ?? 'assignment',
      tags: (json['tags'] as List?)?.map((e) => e.toString()).toList() ?? const [],
    );
  }
}
