import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_client.dart';

class ProfileState {
  final String id;
  final String name;
  final String phone;
  final bool isAvailable;
  final double earnings;

  ProfileState({
    required this.id,
    required this.name,
    required this.phone,
    required this.isAvailable,
    required this.earnings,
  });

  factory ProfileState.fromJson(Map<String, dynamic> json) {
    return ProfileState(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Unknown',
      phone: json['phone'] as String? ?? '',
      isAvailable: json['is_available'] as bool? ?? false,
      earnings: (json['earnings'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

final profileProvider = FutureProvider<ProfileState>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.dio.get('/auth/rider/me');
  return ProfileState.fromJson(response.data);
});
