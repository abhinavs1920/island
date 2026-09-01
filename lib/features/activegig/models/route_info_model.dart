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
      distanceKm: (json['distance_km'] as num).toDouble(),
      etaMinutes: (json['eta_minutes'] as num).toDouble(),
      polyline: json['polyline'] as String?,
    );
  }
}
