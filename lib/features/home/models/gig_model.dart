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
    double price = 0;
    if (json['budget_min'] != null) {
      price = (json['budget_min'] as num).toDouble();
    } else if (json['budget_max'] != null) {
      price = (json['budget_max'] as num).toDouble();
    }

    String desc = '';
    final constraints = json['constraints'];
    if (constraints is Map) {
      desc = constraints['details']?.toString() ?? '';
    }
    if (desc.isEmpty) desc = json['description']?.toString() ?? '';

    return Gig(
      id: json['id']?.toString() ?? '',
      title: json['category']?.toString() ?? json['title']?.toString() ?? json['task_type']?.toString() ?? 'Task',
      price: price,
      description: desc,
      distance: json['distance']?.toString() ?? '~nearby',
      duration: json['duration']?.toString() ?? '',
      icon: json['icon']?.toString() ?? 'assignment',
      tags: (json['tags'] as List?)?.map((e) => e.toString()).toList() ?? const [],
    );
  }
}
