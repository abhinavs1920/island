import 'package:flutter_riverpod/flutter_riverpod.dart';

sealed class ViewingScope {}

class ViewingChat extends ViewingScope {
  final String taskId;
  ViewingChat(this.taskId);
}

class ViewingTask extends ViewingScope {
  final String taskId;
  ViewingTask(this.taskId);
}

class ViewingHome extends ViewingScope {}

final currentViewingScopeProvider = StateProvider<ViewingScope?>((ref) => null);
