import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteDoctorsNotifier extends StateNotifier<Set<String>> {
  FavoriteDoctorsNotifier() : super({}) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getStringList('favoriteDoctors')?.toSet() ?? {};
  }

  Future<void> toggleFavorite(String doctorName) async {
    final prefs = await SharedPreferences.getInstance();
    final updated = Set<String>.from(state);
    if (updated.contains(doctorName)) {
      updated.remove(doctorName);
    } else {
      updated.add(doctorName);
    }
    state = updated;
    await prefs.setStringList('favoriteDoctors', updated.toList());
  }
}

final favoriteDoctorsProvider = StateNotifierProvider<FavoriteDoctorsNotifier, Set<String>>(
  (ref) => FavoriteDoctorsNotifier(),
);
