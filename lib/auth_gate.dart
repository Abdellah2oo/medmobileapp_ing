import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/Registeration/loginscreen.dart';
import 'screens/home_screen.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool? isLoggedIn;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final loggedIn = prefs.getBool('isLoggedIn') ?? false;
      debugPrint('AuthGate: isLoggedIn = $loggedIn');
      setState(() {
        isLoggedIn = loggedIn;
      });
    } catch (e) {
      debugPrint('AuthGate: Error reading SharedPreferences: $e');
      setState(() {
        isLoggedIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return isLoggedIn! ? const HomeScreen() : const LoginScreen();
  }
}
