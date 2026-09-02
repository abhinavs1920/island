class RouteInfoModel {
  final double distanceKm;
  final double etaMinutes;
  final String? polyline;

  RouteInfoModel({
    required this.distanceKm,
    required this.etaMinutes,
    this.polyline,
  });

  factory RouteInfoModel.fromJson(Map<String, dynamic> json) {
    return RouteInfoModel(
      distanceKm: double.tryParse(json['distance_km']?.toString() ?? '') ?? 0.0,
      etaMinutes: double.tryParse(json['eta_minutes']?.toString() ?? '') ?? 0.0,
      polyline: json['polyline'] as String?,
    );
  }
}
