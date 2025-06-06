import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medmobileapp_ing/app_colors.dart';
import 'package:medmobileapp_ing/screens/Doctors/doctors.dart';
import '../models/doctor.dart';
import 'home_screen.dart';
import 'Profile&Settings/profile.dart';

final appointmentTabProvider = StateProvider<int>((ref) => 0);

class AppointmentsScreen extends ConsumerWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabIndex = ref.watch(appointmentTabProvider);
    final tabs = ['Complete', 'Upcoming', 'Cancelled'];
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
          'All Appointment',
          style: TextStyle(
            color: kPrimaryBlue,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(tabs.length, (i) {
              final selected = tabIndex == i;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: ChoiceChip(
                  label: Text(
                    tabs[i],
                    style: TextStyle(
                      color: selected ? Colors.white : kPrimaryBlue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  selected: selected,
                  selectedColor: kPrimaryBlue,
                  backgroundColor: kLightCard,
                  onSelected: (_) =>
                      ref.read(appointmentTabProvider.notifier).state = i,
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: doctors.length,
              itemBuilder: (context, i) {
                final doctor = doctors[i % doctors.length];
                return _AppointmentCard(
                  doctor: doctor,
                  tabIndex: tabIndex,
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: kPrimaryBlue,
        unselectedItemColor: kUnselectedGrey,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_search_rounded), label: "Doctors"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: "Appointment"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: 2, // Appointment tab selected
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DoctorsScreen()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProfileScreen(),
              ),
            );
          }
          // index 2 is current (Appointment), index 3 (Profile) can be added as needed
        },
      ),
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  final Doctor doctor;
  final int tabIndex;
  const _AppointmentCard({required this.doctor, required this.tabIndex});

  @override
  Widget build(BuildContext context) {
    final isComplete = tabIndex == 0;
    final isUpcoming = tabIndex == 1;
    final isCancelled = tabIndex == 2;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      elevation: isDark ? 2 : 4,
      color: isDark ? kDarkCard : kLightScaffold,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 32,
              backgroundImage: AssetImage(doctor.imageUrl),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.name,
                    style: TextStyle(
                      color: kPrimaryBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    doctor.specialty,
                    style: TextStyle(
                      color: isDark ? kDarkText.withOpacity(0.7) : Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                  if (isUpcoming) ...[
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              size: 18, color: kPrimaryBlue),
                          const SizedBox(width: 6),
                          const Text('Sunday, 12 June',
                              style: TextStyle(
                                  color: kPrimaryBlue, fontSize: 13)),
                          const SizedBox(width: 12),
                          const Icon(Icons.access_time,
                              size: 18, color: kPrimaryBlue),
                          const SizedBox(width: 6),
                          const Text('9:30 AM - 10:00 AM',
                              style: TextStyle(
                                  color: kPrimaryBlue, fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                  if (isComplete) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color:
                                isDark ? kDarkScaffold : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.amber, size: 16),
                              const SizedBox(width: 4),
                              Text('${doctor.rating}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.favorite,
                            color: kPrimaryBlue, size: 18),
                      ],
                    ),
                  ],
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      if (isComplete) ...[
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: kPrimaryBlue),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22)),
                            ),
                            child: const Text('Re-Book',
                                style: TextStyle(color: kPrimaryBlue)),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryBlue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22)),
                          ),
                          child: Text(
                            isUpcoming
                                ? 'Details'
                                : isCancelled
                                    ? 'Add Review'
                                    : 'Add Review',
                            style: const TextStyle(color: kDarkText),
                          ),
                        ),
                      ),
                      if (isUpcoming) ...[
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.check_circle,
                              color: kPrimaryBlue),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon:
                              const Icon(Icons.cancel, color: kPrimaryBlue),
                          onPressed: () {},
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
