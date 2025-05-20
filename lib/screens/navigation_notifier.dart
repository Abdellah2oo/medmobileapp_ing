import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationNotifier extends StateNotifier<int> {
  NavigationNotifier() : super(0);

  // Update the selected index
  void updateIndex(int index) {
    state = index;
  }
}

// Provider for the NavigationNotifier
final navigationProvider = StateNotifierProvider<NavigationNotifier, int>((ref) {
  return NavigationNotifier();
});