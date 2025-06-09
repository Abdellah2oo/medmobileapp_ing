import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medmobileapp_ing/app_colors.dart';
import 'package:medmobileapp_ing/core/providers/theme_provider.dart';
import 'notification_settings_screen.dart';
import 'password_manager_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kPrimaryBlue),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: kPrimaryBlue,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: ListView(
        children: [
          _SettingsItem(
            icon: Icons.lightbulb_outline,
            text: 'Notification Setting',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const NotificationSettingsScreen()),
              );
            },
          ),
          _SettingsItem(
            icon: Icons.vpn_key,
            text: 'Password Manager',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_) => const PasswordManagerScreen()),
              );
            },
          ),
          // Dark Mode Switch
          ListTile(
            leading: Icon(Icons.dark_mode, color: kPrimaryBlue),
            title: Text(
              'Dark Mode',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            trailing: Switch(
              value: ref.watch(themeProvider) == ThemeMode.dark,
              onChanged: (value) {
                ref.read(themeProvider.notifier).toggleTheme();
              },
              activeColor: kPrimaryBlue,
            ),
          ),
          _SettingsItem(
            icon: Icons.person,
            text: 'Delete Account',
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  title: const Text(
                    'Delete Account',
                    style: TextStyle(
                      color: kPrimaryBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  content: const Text(
                    'are you sure you want to delete your account?',
                    textAlign: TextAlign.center,
                  ),
                  actionsAlignment: MainAxisAlignment.center,
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white10
                                  : kLightCard,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cancel', style: TextStyle(color: kPrimaryBlue, fontSize: 16)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: kPrimaryBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            onPressed: () {
                              Navigator.of(context).popUntil((route) => route.isFirst);
                              // Add your delete logic here if needed
                            },
                            child: const Text('Yes, Delete', style: TextStyle(color: kDarkText, fontSize: 16)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _SettingsItem({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: kPrimaryBlue),
      title: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: kUnselectedGrey),
      onTap: onTap,
    );
  }
}
