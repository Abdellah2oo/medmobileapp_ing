import 'package:flutter/material.dart';
import 'package:medmobileapp_ing/screens/Doctors/shedule_screen.dart';
import '../../models/doctor.dart';

class DoctorInfoScreen extends StatelessWidget {
  final Doctor doctor;

  const DoctorInfoScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Info'),
      ),
      body: Center(
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
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color:
                    Theme.of(context).textTheme.bodyLarge?.color, // <-- updated
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // التخصص
            Text(
              doctor.specialty,
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.color
                        ?.withOpacity(0.7) ??
                    Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // التقييم وعدد المراجعات
            Text(
              '⭐ ${doctor.rating} (${doctor.reviews} Reviews)',
              style: TextStyle(
                fontSize: 16,
                color:
                    Theme.of(context).textTheme.bodyLarge?.color, // <-- updated
              ),
            ),
            const SizedBox(height: 24),

            // الخبرة
            Text(
              'Experience: ${doctor.experience}',
              style: TextStyle(
                fontSize: 16,
                color:
                    Theme.of(context).textTheme.bodyLarge?.color, // <-- updated
              ),
            ),
            const SizedBox(height: 24),

            // المواعيد
            Text(
              'Schedule: ${doctor.schedule}',
              style: TextStyle(
                fontSize: 16,
                color:
                    Theme.of(context).textTheme.bodyLarge?.color, // <-- updated
              ),
            ),
            const SizedBox(height: 32),

            // زر جدولة موعد
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ScheduleAppointmentWidget(doctor: doctor,)),
                );
                // هنا ممكن تفتح صفحة جدولة موعد لاحقاً
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Schedule Appointment Clicked')),
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
    );
  }
}
