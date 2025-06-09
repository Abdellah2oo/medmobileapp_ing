import 'package:flutter/material.dart';
import 'package:medmobileapp_ing/app_colors.dart';
import 'package:medmobileapp_ing/models/doctor.dart';
import 'package:medmobileapp_ing/screens/Doctors/doctor_info_screen.dart';
import 'package:medmobileapp_ing/screens/Doctors/doctors.dart';
import 'package:medmobileapp_ing/screens/Profile&Settings/profile.dart';
import 'package:medmobileapp_ing/screens/chatbot_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'appointments_screen.dart';
import 'Profile&Settings/settings_screen.dart';

// ——— بيانات الأطباء ———
final List<Doctor> doctors = [
  Doctor(
    name: "Dr. Alexander Bennett, Ph.D.",
    sex: 'M',
    specialty: "Dermato-Genetics",
    rating: 5,
    reviews: 40,
    imageUrl: "assets/images/doctor1.png",
    experience: "15 years",
    schedule: "Mon-Sat / 9:00AM - 5:00PM",
  ),
  Doctor(
    name: "Dr. Michael Davidson, M.D.",
    sex: 'M',
    specialty: "Solar Dermatology",
    rating: 4.8,
    reviews: 30,
    imageUrl: "assets/images/doctor2.png",
    experience: "12 years",
    schedule: "Mon-Fri / 8:00AM - 4:00PM",
  ),
  Doctor(
    name: "Dr. Olivia Turner, M.D.",
    sex: 'F',
    specialty: "Dermato-Endocrinology",
    rating: 5,
    reviews: 60,
    imageUrl: "assets/images/doctor3.png",
    experience: "10 years",
    schedule: "Tue-Sat / 10:00AM - 5:00PM",
  ),
  Doctor(
    name: "Dr. Sophia Martinez, Ph.D.",
    sex: 'F',
    specialty: "Cosmetic Bioengineering",
    rating: 5,
    reviews: 150,
    imageUrl: "assets/images/doctor4.png",
    experience: "8 years",
    schedule: "Mon-Fri / 11:00AM - 7:00PM",
  ),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Set<String> favoriteDoctorNames = {};
  String? selectedFilter;

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
    // فلترة الأطباء إذا كان الفلتر مفعّل
    List<Doctor> filteredDoctors = doctors.where((doctor) {
      if (selectedFilter == 'fav') {
        return favoriteDoctorNames.contains(doctor.name);
      }
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: kPrimaryBlue,
        unselectedItemColor: kUnselectedGrey,
        currentIndex: 0,
        onTap: (index) {
          setState(() {});
          // Navigation logic for each tab
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DoctorsScreen()),
            );
          } else if (index == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => AppointmentsScreen()));
          } else if (index == 3) {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => ProfileScreen()));
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_search_rounded), label: "Doctors"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: "Appointment"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  // ✅ زر البروفايل
                  InkWell(
                    onTap: () {
                      //print("فتح صفحة البروفايل");
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => ProfileScreen()));
                    },
                    child: const CircleAvatar(
                      radius: 24,
                      backgroundImage: AssetImage("assets/images/profile.png"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hi, WelcomeBack",
                          style: TextStyle(color: Colors.grey)),
                      Text("Abdellah Djadour",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Spacer(),

                  // ✅ زر الإشعارات
                  IconButton(
                    icon: const Icon(Icons.bubble_chart_sharp),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChatbotScreen()),
                      );
                    },
                  ),

                  // ✅ زر الإعدادات
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => SettingsScreen()));
                    },
                  ),
                ],
              ),
            ),

            // Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  const Spacer(),

                  // ✅ زر المفضلة
                  IconButton(
                    icon: Icon(
                      selectedFilter == 'fav'
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: selectedFilter == 'fav'
                          ? Colors.red
                          : Theme.of(context).iconTheme.color,
                    ),
                    onPressed: () {
                      setState(() {
                        selectedFilter = selectedFilter == 'fav' ? null : 'fav';
                      });
                    },
                  ),

                  // ✅ زر الفلتر
                  IconButton(
                    icon: const Icon(Icons.filter_alt_outlined),
                    onPressed: () {
                      //print("فتح الفلترة");
                      // Navigator.push(context, MaterialPageRoute(builder: (_) => FilterScreen()));
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Days row
            SizedBox(
              height: 70,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: List.generate(6, (index) {
                  final dates = [
                    "9\nMON",
                    "10\nTUE",
                    "11\nWED",
                    "12\nTHU",
                    "13\nFRI",
                    "14\nSAT"
                  ];
                  final isSelected = index == 2; // يوم 11 هو المحدد
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? kPrimaryBlue
                          : Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: kPrimaryBlue.withOpacity(0.2)),
                    ),
                    child: Text(
                      dates[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isSelected
                            ? Theme.of(context).scaffoldBackgroundColor
                            : Theme.of(context).textTheme.bodyLarge?.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 16),

            // موعد محجوز
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? kDarkCard
                      : kLightCard,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "10 AM",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Dr. Olivia Turner, M.D.",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Treatment and prevention of skin and photodermatitis.",
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white70
                            : Colors.black54,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        Icons.close,
                        size: 20,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // قائمة الأطباء
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: filteredDoctors
                    .map((doctor) => doctorCard(context, doctor))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

// 📦 عنصر واجهة لعرض بطاقة دكتور
  Widget doctorCard(BuildContext context, Doctor doctor) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isFavorite = favoriteDoctorNames.contains(doctor.name);
    return InkWell(
      onTap: () {
        // الانتقال إلى صفحة تفاصيل الدكتور
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorInfoScreen(doctor: doctor),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? kDarkCard : kLightCard,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // صورة الدكتور
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(doctor.imageUrl),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // اسم الدكتور
                  Text(
                    doctor.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // التخصص
                  Text(
                    doctor.specialty,
                    style: TextStyle(
                      color: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.color
                              ?.withOpacity(0.7) ??
                          Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // تقييم وعدد المراجعات
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        "${doctor.rating}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.people, color: Colors.grey, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        "${doctor.reviews}",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite
                              ? Colors.red
                              : Theme.of(context).iconTheme.color,
                        ),
                        tooltip: isFavorite
                            ? 'Remove from favorites'
                            : 'Add to favorites',
                        onPressed: () {
                          _toggleFavorite(doctor.name);
                        },
                      ),
                      const SizedBox(width: 6),
                      Icon(Icons.help_outline,
                          color: Theme.of(context).iconTheme.color),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
