import 'package:flutter/material.dart';
import 'package:medmobileapp_ing/app_colors.dart';
import 'package:medmobileapp_ing/models/doctor.dart';
import 'package:medmobileapp_ing/screens/Doctors/doctor_info_screen.dart';
import 'package:medmobileapp_ing/screens/Doctors/shedule_screen.dart';
import 'package:medmobileapp_ing/screens/home_screen.dart';
import 'package:medmobileapp_ing/screens/Profile&Settings/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../appointments_screen.dart';

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  String sortBy = 'A-Z';
  String? selectedFilter; // يمكن أن تكون 'fav', 'male', 'female'
  Set<String> favoriteDoctorNames = {};

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteDoctorNames =
          prefs.getStringList('favoriteDoctors')?.toSet() ?? {};
    });
  }

  Future<void> _toggleFavorite(String doctorName) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (favoriteDoctorNames.contains(doctorName)) {
        favoriteDoctorNames.remove(doctorName);
      } else {
        favoriteDoctorNames.add(doctorName);
      }
      prefs.setStringList('favoriteDoctors', favoriteDoctorNames.toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    // تطبيق الفلاتر
    List<Doctor> filteredDoctors = doctors.where((doctor) {
      if (selectedFilter == null) return true;
      if (selectedFilter == 'male') return doctor.sex == 'M';
      if (selectedFilter == 'female') return doctor.sex == 'F';
      if (selectedFilter == 'fav')
        return favoriteDoctorNames.contains(doctor.name);
      return true;
    }).toList();

    // تطبيق الترتيب
    if (sortBy == 'A-Z') {
      filteredDoctors.sort((a, b) => a.name.compareTo(b.name));
    } else if (sortBy == 'Z-A') {
      filteredDoctors.sort((a, b) => b.name.compareTo(a.name));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Doctors")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Text('Sort By',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(width: 8),
                ToggleButtons(
                  isSelected: [sortBy == 'A-Z', sortBy == 'Z-A'],
                  onPressed: (index) {
                    setState(() {
                      sortBy = index == 0 ? 'A-Z' : 'Z-A';
                    });
                  },
                  borderRadius: BorderRadius.circular(8),
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('A-Z'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('Z-A'),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: Icon(Icons.favorite,
                      color: selectedFilter == 'fav'
                          ? kPrimaryBlue
                          : kUnselectedGrey),
                  tooltip: 'Favorites',
                  onPressed: () {
                    setState(() {
                      selectedFilter = selectedFilter == 'fav' ? null : 'fav';
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.male,
                      color: selectedFilter == 'male'
                          ? kPrimaryBlue
                          : kUnselectedGrey),
                  tooltip: 'Male',
                  onPressed: () {
                    setState(() {
                      selectedFilter = selectedFilter == 'male' ? null : 'male';
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.female,
                      color: selectedFilter == 'female'
                          ? kPrimaryBlue
                          : kUnselectedGrey),
                  tooltip: 'Female',
                  onPressed: () {
                    setState(() {
                      selectedFilter =
                          selectedFilter == 'female' ? null : 'female';
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredDoctors.length,
              itemBuilder: (context, index) {
                final doctor = filteredDoctors[index];
                final isFavorite = favoriteDoctorNames.contains(doctor.name);
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Card(
                    elevation: 2,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? kDarkCard
                        : kLightScaffold, // أبيض أو رمادي فاتح جداً
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 38,
                            backgroundImage: AssetImage(doctor.imageUrl),
                          ),
                          const SizedBox(width: 18),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  doctor.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.color,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  doctor.specialty,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.color
                                            ?.withOpacity(0.7) ??
                                        Colors.grey,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    IconButton(
                                      icon: const Icon(Icons.calendar_month,
                                          color: kPrimaryBlue),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  ScheduleAppointmentWidget(
                                                    doctor: doctor,
                                                  )),
                                        );
                                      },
                                      tooltip: 'Book',
                                    ),
                                    const SizedBox(width: 10),
                                    IconButton(
                                      icon: const Icon(Icons.info_outline,
                                          color: kPrimaryBlue),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DoctorInfoScreen(
                                                    doctor: doctor),
                                          ),
                                        );
                                      },
                                      tooltip: 'Details',
                                    ),
                                    const SizedBox(width: 10),
                                    // زر المفضلة
                                    IconButton(
                                      icon: Icon(
                                        isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: isFavorite
                                            ? Colors.red
                                            : kUnselectedGrey,
                                      ),
                                      tooltip: isFavorite
                                          ? 'Remove from favorites'
                                          : 'Add to favorites',
                                      onPressed: () {
                                        _toggleFavorite(doctor.name);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_search_rounded), label: "Doctors"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: "Appointment"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: 1, // Appointment tab selected
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AppointmentsScreen()),
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
