enum GigStatus { completed, cancelled }

class GigModel {
  final String id;
  final String type; // e.g. 'Grocery Delivery', 'AC Repair'
  final GigStatus status;
  final double amount;
  final DateTime date;
  final String pickupAddress;
  final String dropoffAddress;

  GigModel({
    required this.id,
    required this.type,
    required this.status,
    required this.amount,
    required this.date,
    required this.pickupAddress,
    required this.dropoffAddress,
  });
}
