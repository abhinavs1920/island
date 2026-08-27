import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final chatMessagesProvider = StreamProvider.family<List<Map<String, dynamic>>, String>((ref, taskId) {
  final supabase = Supabase.instance.client;
  return supabase
      .from('messages')
      .stream(primaryKey: ['id'])
      .eq('task_id', taskId)
      .order('created_at', ascending: true)
      .map((event) => event);
});
