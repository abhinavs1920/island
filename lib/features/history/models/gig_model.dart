enum GigStatus { completed, cancelled, failed }

class GigModel {
  final String id;
  final String type; // e.g. 'Grocery Delivery', 'AC Repair'
  final GigStatus status;
  final double amount;
  final DateTime date;
  final String pickupAddress;
  final String dropoffAddress;

  double get payoutAmount => amount; // added alias for requirement

  GigModel({
    required this.id,
    required this.type,
    required this.status,
    required this.amount,
    required this.date,
    required this.pickupAddress,
    required this.dropoffAddress,
  });

  factory GigModel.fromJson(Map<String, dynamic> json) {
    // Parse status
    GigStatus parsedStatus = GigStatus.completed;
    final statusStr = json['status']?.toString().toLowerCase() ?? '';
    if (statusStr == 'cancelled') parsedStatus = GigStatus.cancelled;
    else if (statusStr == 'failed') parsedStatus = GigStatus.failed;
    
    // Parse amount from budget_max or budget_min if available
    double parsedAmount = 0.0;
    if (json['budget_max'] != null) {
      parsedAmount = (json['budget_max'] is num) ? (json['budget_max'] as num).toDouble() : (double.tryParse(json['budget_max'].toString()) ?? 0.0);
    } else if (json['budget_min'] != null) {
      parsedAmount = (json['budget_min'] is num) ? (json['budget_min'] as num).toDouble() : (double.tryParse(json['budget_min'].toString()) ?? 0.0);
    }

    DateTime parsedDate = DateTime.now();
    if (json['created_at'] != null) {
      parsedDate = DateTime.tryParse(json['created_at'].toString()) ?? DateTime.now();
    }

    return GigModel(
      id: json['id']?.toString() ?? '',
      type: json['category']?.toString() ?? 'Task',
      status: parsedStatus,
      amount: parsedAmount,
      date: parsedDate,
      pickupAddress: 'Pickup location (lat: ${json['lat']}, lng: ${json['lng']})',
      dropoffAddress: 'Dropoff location', // Not provided by backend in snippet
    );
  }
}

