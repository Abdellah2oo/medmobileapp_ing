import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/home_screen.dart';
import 'app_colors.dart';

// Provider للثيم
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>(
  (ref) => ThemeNotifier(),
);

void main() {
  runApp(const ProviderScope(child: MedicalApp()));
}

class MedicalApp extends ConsumerWidget {
  const MedicalApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    // تعريف الثيمات الموحدة
    final appBarLight = AppBarTheme(
      backgroundColor: kLightAppBar,
      elevation: 0,
      iconTheme: const IconThemeData(color: kLightIcon),
      titleTextStyle: const TextStyle(
        color: kLightText,
        fontSize: kAppBarFontSize,
        fontWeight: kAppBarFontWeight,
      ),
    );
    final appBarDark = AppBarTheme(
      backgroundColor: kDarkAppBar,
      elevation: 0,
      iconTheme: const IconThemeData(color: kDarkIcon),
      titleTextStyle: const TextStyle(
        color: kDarkText,
        fontSize: kAppBarFontSize,
        fontWeight: kAppBarFontWeight,
      ),
    );
    final cardLight = CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kCardRadius),
      ),
      color: kLightCard,
    );
    final cardDark = CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kCardRadius),
      ),
      color: kDarkCard,
    );
    final bottomBarLight = const BottomNavigationBarThemeData(
      backgroundColor: kLightBottomBar,
      selectedItemColor: kPrimaryBlue,
      unselectedItemColor: kUnselectedGrey,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    );
    final bottomBarDark = const BottomNavigationBarThemeData(
      backgroundColor: kDarkBottomBar,
      selectedItemColor: kPrimaryBlue,
      unselectedItemColor: kUnselectedGrey,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medical App',
      // الثيم الفاتح
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kPrimaryBlue,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: kLightScaffold,
        appBarTheme: appBarLight,
        cardTheme: cardLight,
        bottomNavigationBarTheme: bottomBarLight,
      ),
      // الثيم المظلم
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kPrimaryBlue,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: kDarkScaffold,
        appBarTheme: appBarDark,
        cardTheme: cardDark,
        bottomNavigationBarTheme: bottomBarDark,
      ),
      themeMode: themeMode,
      home: const HomeScreen(),
    );
  }
}

// إدارة حالة الثيم
class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system); // البدء بثيم النظام

  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }

  void setTheme(ThemeMode mode) {
    state = mode;
  }

  void setSystemTheme() {
    state = ThemeMode.system;
  }
}