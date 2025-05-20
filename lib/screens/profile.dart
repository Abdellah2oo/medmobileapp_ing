import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../main.dart'; // Import where themeProvider is defined
import 'edit_profile.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider) == ThemeMode.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF3B5AFB)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Color(0xFF3B5AFB),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Center(
            child: Stack(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                      'assets/images/profile.jpg'), // Replace with your asset
                  backgroundColor: Colors.grey,
                ),
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B5AFB),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    padding: const EdgeInsets.all(4),
                    child:
                        const Icon(Icons.edit, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'John Doe',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 32),
          _ProfileMenuItem(
            icon: Icons.person_outline,
            text: 'Edit profile',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const EditProfileScreen()),
              );
            },
          ),
          _ProfileMenuItem(
            icon: Icons.settings_outlined,
            text: 'Settings',
            onTap: () {},
          ),
          // Theme Switcher
          ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color(0xFF3B5AFB).withOpacity(0.15),
              child: Icon(
                isDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: const Color(0xFF3B5AFB),
              ),
            ),
            title: Text(
              'Dark Mode',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            trailing: Switch(
              value: isDarkMode,
              onChanged: (value) {
                ref.read(themeProvider.notifier).toggleTheme();
              },
              activeColor: const Color(0xFF3B5AFB),
            ),
          ),
          _ProfileMenuItem(
            icon: Icons.help_outline,
            text: 'Help',
            onTap: () {},
          ),
          _ProfileMenuItem(
            icon: Icons.logout,
            text: 'Logout',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _ProfileMenuItem({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color(0xFF3B5AFB).withOpacity(0.15),
        child: Icon(icon, color: const Color(0xFF3B5AFB)),
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}
