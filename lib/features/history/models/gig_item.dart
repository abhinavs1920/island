enum GigStatus { completed, cancelled }

class GigItem {
  final String id;
  final GigStatus status;
  final double price;
  final DateTime date;
  final String pickup;
  final String dropoff;

  const GigItem({
    required this.id,
    required this.status,
    required this.price,
    required this.date,
    required this.pickup,
    required this.dropoff,
  });
}
