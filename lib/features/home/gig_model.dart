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
    return Gig(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      distance: json['distance'] ?? '',
      duration: json['duration'] ?? '',
      icon: json['icon'] ?? 'assignment',
      tags: List<String>.from(json['tags'] ?? []),
    );
  }
}
