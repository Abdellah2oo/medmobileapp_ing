import 'package:flutter/material.dart';
import '../models/doctor.dart';

class DoctorInfoScreen extends StatelessWidget {
  final Doctor doctor;

  const DoctorInfoScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Info'),
      ),
      body: Stack(
        children: [
          Container(
          //  margin: EdgeInsets.fromLTRB(50, 20, 20, 50),
          //  color: Color.fromARGB(90, 67, 85, 221),
          decoration: BoxDecoration(
            color: Color.fromARGB(90, 67, 85, 221),
            borderRadius: BorderRadius.circular(21)
          ),
            width: 300,
            height: 500,
          ),
          Center(
            child: Column(
              children: [
                const SizedBox(height: 32),
                // صورة الدكتور
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(doctor.imageUrl),
                ),
                const SizedBox(height: 16),

                // اسم الدكتور
                Text(
                  doctor.name,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // التخصص
                Text(
                  doctor.specialty,
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // التقييم وعدد المراجعات
                Text(
                  '⭐ ${doctor.rating} (${doctor.reviews} Reviews)',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),

                // الخبرة
                Text(
                  'Experience: ${doctor.experience}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),

                // المواعيد
                Text(
                  'Schedule: ${doctor.schedule}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 32),

                // زر جدولة موعد
                ElevatedButton.icon(
                  onPressed: () {
                    // هنا ممكن تفتح صفحة جدولة موعد لاحقاً
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Schedule Appointment Clicked')),
                    );
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: const Text('Schedule Appointment',
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 34, 96, 255),
                    iconColor: Colors.white,
                    minimumSize: const Size(30, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
