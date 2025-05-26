import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medmobileapp_ing/screens/Doctors/doctors.dart';
import 'package:medmobileapp_ing/screens/home_screen.dart';
import '../../models/doctor.dart';

// Providers for selected states
final selectedDateProvider = StateProvider<int>((ref) => 2);
final selectedTimeProvider = StateProvider<int>((ref) => 4);
final selectedPersonProvider = StateProvider<int>((ref) => 1);
final genderProvider = StateProvider<String>((ref) => 'Female');

// Form controllers as providers
final nameControllerProvider =
    Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController(text: "Jane Doe");
  ref.onDispose(() => controller.dispose());
  return controller;
});
final ageControllerProvider =
    Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController(text: "30");
  ref.onDispose(() => controller.dispose());
  return controller;
});
final problemControllerProvider =
    Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() => controller.dispose());
  return controller;
});
class ScheduleAppointmentWidget extends ConsumerWidget {
final Doctor doctor;
  ScheduleAppointmentWidget({super.key, required this.doctor});

  final List<String> dates = [
    '22\nMON',
    '23\nTUE',
    '24\nWED',
    '25\nTHU',
    '26\nFRI',
    '27\nSAT'
  ];
  final List<String> times = [
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '11:30 AM',
    '12:00 PM',
    '1:00 PM',
    '1:30 PM',
    '2:00 PM',
    '2:30 PM',
    '3:00 PM',
    '3:30 PM',
    '4:00 PM',
    '7:30 PM',
    '8:00 PM'
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final selectedTime = ref.watch(selectedTimeProvider);
    final selectedPerson = ref.watch(selectedPersonProvider);
    final gender = ref.watch(genderProvider);

    final nameController = ref.watch(nameControllerProvider);
    final ageController = ref.watch(ageControllerProvider);
    final problemController = ref.watch(problemControllerProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                doctor.name,
                style: TextStyle(
                    color: Colors.blue.shade700, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Month and Date Selection
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Month', style: TextStyle(fontWeight: FontWeight.bold)),
                  Icon(Icons.keyboard_arrow_down),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 60,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: dates.length,
                  separatorBuilder: (_, __) => SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    bool isSelected = index == selectedDate;
                    return GestureDetector(
                      onTap: () =>
                          ref.read(selectedDateProvider.notifier).state = index,
                      child: Container(
                        width: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.blue.shade700
                              : const Color.fromARGB(94, 245, 245, 245),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Text(
                          dates[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 18),
              // Available Time
              Text('Available Time',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(
                  times.length,
                  (index) => ChoiceChip(
                    label: Text(times[index]),
                    selected: selectedTime == index,
                    onSelected: (_) =>
                        ref.read(selectedTimeProvider.notifier).state = index,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Patient Details
              Text('Patient Details',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue)),
              Row(
                children: [
                  ChoiceChip(
                    label: Text('Yourself'),
                    selected: selectedPerson == 0,
                    onSelected: (_) =>
                        ref.read(selectedPersonProvider.notifier).state = 0,
                  ),
                  SizedBox(width: 10),
                  ChoiceChip(
                    label: Text('Another Person'),
                    selected: selectedPerson == 1,
                    onSelected: (_) =>
                        ref.read(selectedPersonProvider.notifier).state = 1,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Full Name
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Full Name",
                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 10),
              // Age
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Age",
                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 10),
              // Gender
              Row(
                children: [
                  ChoiceChip(
                    label: Text('Male'),
                    selected: gender == 'Male',
                    onSelected: (_) =>
                        ref.read(genderProvider.notifier).state = 'Male',
                  ),
                  SizedBox(width: 8),
                  ChoiceChip(
                    label: Text('Female'),
                    selected: gender == 'Female',
                    onSelected: (_) =>
                        ref.read(genderProvider.notifier).state = 'Female',
                  ),
                ],
              ),
              const SizedBox(height: 18),
              // Describe Problem
              Text("Describe your problem"),
              const SizedBox(height: 8),
              TextField(
                controller: problemController,
                minLines: 4,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Enter Your Problem Here...",
                  fillColor: Theme.of(context).scaffoldBackgroundColor,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
