class MilestoneModel {
  final String id;
  final String taskId;
  final int milestoneNumber;
  final String milestoneName;
  final String status;
  final String? notes;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  MilestoneModel({
    required this.id,
    required this.taskId,
    required this.milestoneNumber,
    required this.milestoneName,
    required this.status,
    this.notes,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MilestoneModel.fromJson(Map<String, dynamic> json) {
    return MilestoneModel(
      id: json['id'] as String,
      taskId: json['task_id'] as String,
      milestoneNumber: json['milestone_number'] as int,
      milestoneName: json['milestone_name'] as String,
      status: json['status'] as String,
      notes: json['notes'] as String?,
      completedAt: json['completed_at'] != null ? DateTime.parse(json['completed_at'] as String) : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}
