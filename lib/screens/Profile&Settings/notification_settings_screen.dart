import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationSettingsProvider = StateNotifierProvider<NotificationSettingsNotifier, Map<String, bool>>((ref) => NotificationSettingsNotifier());

class NotificationSettingsNotifier extends StateNotifier<Map<String, bool>> {
  NotificationSettingsNotifier()
      : super({
          'General Notification': true,
          'Sound': true,
          'Sound Call': true,
          'Vibrate': false,
          'Special Offers': false,
          'Payments': true,
          'Promo And Discount': false,
          'Cashback': true,
        });

  void toggle(String key) {
    state = {...state, key: !(state[key] ?? false)};
  }
}

class NotificationSettingsScreen extends ConsumerWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(notificationSettingsProvider);
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
          'Notification Setting',
          style: TextStyle(
            color: Color(0xFF3B5AFB),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: ListView(
        children: settings.keys.map((key) {
          return SwitchListTile(
            title: Text(
              key,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            value: settings[key]!,
            onChanged: (_) => ref.read(notificationSettingsProvider.notifier).toggle(key),
            activeColor: Color(0xFF3B5AFB),
          );
        }).toList(),
      ),
    );
  }
}
