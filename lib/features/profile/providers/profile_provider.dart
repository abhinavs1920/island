import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_client.dart';

class ProfileState {
  final String id;
  final String name;
  final String phone;
  final bool isAvailable;
  final double earnings;
  final int completedGigs;
  final int failedTasks;
  final DateTime? joinedDate;

  ProfileState({
    required this.id,
    required this.name,
    required this.phone,
    required this.isAvailable,
    required this.earnings,
    this.completedGigs = 0,
    this.failedTasks = 0,
    this.joinedDate,
  });

  factory ProfileState.fromJson(Map<String, dynamic> json) {
    DateTime? joined;
    final dateStr = json['joined_date']?.toString() ?? json['created_at']?.toString();
    if (dateStr != null && dateStr.isNotEmpty) {
      joined = DateTime.tryParse(dateStr);
    }
    return ProfileState(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Rider',
      phone: json['phone'] as String? ?? '',
      isAvailable: json['is_available'] as bool? ?? false,
      earnings: (json['earnings'] as num?)?.toDouble() ?? 0.0,
      completedGigs: (json['completed_gigs'] as num?)?.toInt() ?? 0,
      failedTasks: (json['failed_tasks'] as num?)?.toInt() ?? 0,
      joinedDate: joined,
    );
  }
}

final profileProvider = FutureProvider<ProfileState>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.dio.get('/auth/rider/me');
  return ProfileState.fromJson(response.data);
});
