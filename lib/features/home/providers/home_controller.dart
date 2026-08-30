import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/gig_model.dart';

final isOnlineProvider = NotifierProvider<IsOnlineController, bool>(() {
  return IsOnlineController();
});

class IsOnlineController extends Notifier<bool> {
  @override
  bool build() {
    return false; // Default offline
  }

  Future<void> toggle(bool value) async {
    state = value;
  }
}

final gigsProvider = AsyncNotifierProvider<GigsController, List<Gig>>(() {
  return GigsController();
});

class GigsController extends AsyncNotifier<List<Gig>> {
  @override
  Future<List<Gig>> build() async {
    final isOnline = ref.watch(isOnlineProvider);
    if (!isOnline) {
      return [];
    }
    // Dummy gigs
    return [];
  }
}
