import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_client.dart';
import '../models/milestone_model.dart';

class MilestoneNotifier extends StateNotifier<AsyncValue<List<MilestoneModel>>> {
  final Ref ref;
  final String taskId;

  MilestoneNotifier(this.ref, this.taskId) : super(const AsyncValue.loading()) {
    fetchMilestones();
  }

  Future<void> fetchMilestones() async {
    try {
      final apiClient = ref.read(apiClientProvider).dio;
      final response = await apiClient.get('/tasks/$taskId/milestones');
      
      final milestones = (response.data as List)
          .map((m) => MilestoneModel.fromJson(m as Map<String, dynamic>))
          .toList();
      
      state = AsyncValue.data(milestones);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> advanceMilestone(int milestoneNumber, {String? notes}) async {
    try {
      final apiClient = ref.read(apiClientProvider).dio;
      
      final data = <String, dynamic>{};
      if (notes != null) {
        data['notes'] = notes;
      }
      
      await apiClient.post('/tasks/$taskId/milestones/$milestoneNumber/advance', data: data);
      
      // Refresh the list after advancing
      await fetchMilestones();
    } catch (e) {
      rethrow;
    }
  }
}

final milestoneProvider = StateNotifierProvider.family<MilestoneNotifier, AsyncValue<List<MilestoneModel>>, String>(
  (ref, taskId) => MilestoneNotifier(ref, taskId),
);
