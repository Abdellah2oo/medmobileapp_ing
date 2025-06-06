import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/doctor.dart'; // Adjusted import path

// --- State Providers ---

// Provider for the index of the selected date in the dates list
final selectedDateProvider = StateProvider<int>((ref) => 2); // Default to 3rd item (index 2)

// Provider for the index of the selected time in the times list
final selectedTimeProvider = StateProvider<int?>((ref) => null); // Default to null (no selection)

// Provider for who the appointment is for (0: Yourself, 1: Another Person)
final selectedPersonProvider = StateProvider<int>((ref) => 0); // Default to Yourself

// Provider for the selected gender
final genderProvider = StateProvider<String?>((ref) => null); // Default to null

// --- Controller Providers ---

// Using StateProvider for controllers to allow external modification if needed,
// but typically TextEditingControllers are managed within the widget's state or via a Form.
// Consider using a Form widget with FormKeys for better validation and state management.

final nameControllerProvider = Provider.autoDispose<TextEditingController>((ref) {
  // TODO: Initialize with actual user data if available and 'Yourself' is selected
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});

final ageControllerProvider = Provider.autoDispose<TextEditingController>((ref) {
  // TODO: Initialize with actual user data if available and 'Yourself' is selected
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});

final problemControllerProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});

// --- Schedule Screen Widget ---

class ScheduleScreen extends ConsumerWidget {
  final Doctor doctor;

  // Use const constructor
  const ScheduleScreen({super.key, required this.doctor});

  // Static data for dates and times - consider making this dynamic or configurable
  static const List<String> _dates = [
    '22\nMON', '23\nTUE', '24\nWED', '25\nTHU', '26\nFRI', '27\nSAT'
  ];
  static const List<String> _times = [
    '9:00 AM', '10:00 AM', '11:00 AM', '11:30 AM', '12:00 PM', '1:00 PM',
    '1:30 PM', '2:00 PM', '2:30 PM', '3:00 PM', '3:30 PM', '4:00 PM',
    '7:30 PM', '8:00 PM'
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    // Watch state providers
    final selectedDateIndex = ref.watch(selectedDateProvider);
    final selectedTimeIndex = ref.watch(selectedTimeProvider);
    final selectedPersonIndex = ref.watch(selectedPersonProvider);
    final selectedGender = ref.watch(genderProvider);

    // Watch controller providers
    final nameController = ref.watch(nameControllerProvider);
    final ageController = ref.watch(ageControllerProvider);
    final problemController = ref.watch(problemControllerProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        // Theme handles background and elevation
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18, // Slightly smaller radius
              backgroundImage: AssetImage(doctor.imageUrl), // Use doctor's image
              // Add fallback icon
              onBackgroundImageError: (_, __) => const Icon(Icons.person),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                doctor.name,
                style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        // Removed toolbarHeight, let AppBar calculate its size
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Select Date', textTheme, colorScheme),
            const SizedBox(height: 8),
            _buildDateSelector(ref, selectedDateIndex, theme),
            const SizedBox(height: 18),
            _buildSectionTitle('Available Time', textTheme, colorScheme),
            const SizedBox(height: 8),
            _buildTimeSelector(ref, selectedTimeIndex, theme),
            const SizedBox(height: 24),
            _buildSectionTitle('Patient Details', textTheme, colorScheme),
            const SizedBox(height: 8),
            _buildPatientTypeSelector(ref, selectedPersonIndex, theme),
            const SizedBox(height: 16),
            _buildTextField(nameController, 'Full Name', theme),
            const SizedBox(height: 10),
            _buildTextField(ageController, 'Age', theme, keyboardType: TextInputType.number),
            const SizedBox(height: 10),
            _buildGenderSelector(ref, selectedGender, theme),
            const SizedBox(height: 18),
            _buildSectionTitle('Describe Your Problem', textTheme, colorScheme),
            const SizedBox(height: 8),
            _buildTextField(
              problemController,
              'Enter Your Problem Here...',
              theme,
              isHint: true,
              minLines: 4,
              maxLines: 5,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _bookAppointment(context, ref);
                },
                style: theme.elevatedButtonTheme.style?.copyWith(
                  padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 16)),
                ),
                child: const Text('Book Appointment', style: TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildSectionTitle(String title, TextTheme textTheme, ColorScheme colorScheme) {
    return Text(
      title,
      style: textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: colorScheme.primary, // Use primary color for section titles
      ),
    );
  }

  Widget _buildDateSelector(WidgetRef ref, int selectedIndex, ThemeData theme) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _dates.length,
        itemBuilder: (context, index) {
          final bool isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => ref.read(selectedDateProvider.notifier).state = index,
            child: Container(
              width: 55, // Slightly wider
              margin: const EdgeInsets.symmetric(horizontal: 4),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? theme.colorScheme.primary : theme.colorScheme.surfaceContainerHighest, // Use theme colors
                borderRadius: BorderRadius.circular(16), // Consistent rounding
              ),
              child: Text(
                _dates[index],
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isSelected ? theme.colorScheme.onPrimary : theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimeSelector(WidgetRef ref, int? selectedIndex, ThemeData theme) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(
        _times.length,
        (index) => ChoiceChip(
          label: Text(_times[index]),
          selected: selectedIndex == index,
          onSelected: (isSelected) {
            ref.read(selectedTimeProvider.notifier).state = isSelected ? index : null;
          },
          // ChipTheme will style this from main.dart
        ),
      ),
    );
  }

  Widget _buildPatientTypeSelector(WidgetRef ref, int selectedIndex, ThemeData theme) {
    return Row(
      children: [
        ChoiceChip(
          label: const Text('Yourself'),
          selected: selectedIndex == 0,
          onSelected: (isSelected) {
            if (isSelected) ref.read(selectedPersonProvider.notifier).state = 0;
            // TODO: Optionally pre-fill fields if 'Yourself' is selected
          },
        ),
        const SizedBox(width: 10),
        ChoiceChip(
          label: const Text('Another Person'),
          selected: selectedIndex == 1,
          onSelected: (isSelected) {
             if (isSelected) ref.read(selectedPersonProvider.notifier).state = 1;
             // TODO: Optionally clear fields if 'Another Person' is selected
          },
        ),
      ],
    );
  }

  Widget _buildGenderSelector(WidgetRef ref, String? selectedGender, ThemeData theme) {
    return Row(
      children: [
        ChoiceChip(
          label: const Text('Male'),
          selected: selectedGender == 'Male',
          onSelected: (isSelected) {
            ref.read(genderProvider.notifier).state = isSelected ? 'Male' : null;
          },
        ),
        const SizedBox(width: 8),
        ChoiceChip(
          label: const Text('Female'),
          selected: selectedGender == 'Female',
          onSelected: (isSelected) {
            ref.read(genderProvider.notifier).state = isSelected ? 'Female' : null;
          },
        ),
         const SizedBox(width: 8),
        ChoiceChip(
          label: const Text('Other'),
          selected: selectedGender == 'Other',
          onSelected: (isSelected) {
            ref.read(genderProvider.notifier).state = isSelected ? 'Other' : null;
          },
        ),
      ],
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String labelOrHint,
    ThemeData theme,
    {
      bool isHint = false,
      TextInputType? keyboardType,
      int minLines = 1,
      int maxLines = 1,
    }
  ) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
        // Uses InputDecorationTheme from main.dart
        labelText: isHint ? null : labelOrHint,
        hintText: isHint ? labelOrHint : null,
        // Ensure border settings are consistent with theme
      ),
      style: theme.textTheme.bodyLarge,
    );
  }

  // --- Booking Logic ---

  void _bookAppointment(BuildContext context, WidgetRef ref) {
    // Read final values from providers
    final selectedDateIndex = ref.read(selectedDateProvider);
    final selectedTimeIndex = ref.read(selectedTimeProvider);
    final selectedPersonIndex = ref.read(selectedPersonProvider);
    final selectedGender = ref.read(genderProvider);
    final name = ref.read(nameControllerProvider).text.trim();
    final age = ref.read(ageControllerProvider).text.trim();
    final problem = ref.read(problemControllerProvider).text.trim();

    // --- Basic Validation ---
    if (selectedTimeIndex == null) {
      _showErrorSnackbar(context, 'Please select an available time.');
      return;
    }
    if (name.isEmpty) {
      _showErrorSnackbar(context, 'Please enter the patient\'s full name.');
      return;
    }
    if (age.isEmpty) {
      _showErrorSnackbar(context, 'Please enter the patient\'s age.');
      return;
    }
     if (selectedGender == null) {
      _showErrorSnackbar(context, 'Please select the patient\'s gender.');
      return;
    }
    if (problem.isEmpty) {
      _showErrorSnackbar(context, 'Please describe the problem.');
      return;
    }
    // --- End Validation ---

    final selectedDateStr = _dates[selectedDateIndex].replaceAll('\n', ' ');
    final selectedTimeStr = _times[selectedTimeIndex];
    final patientType = selectedPersonIndex == 0 ? 'Yourself' : 'Another Person';

    // TODO: Implement actual booking logic (API call, update state, etc.)
    print('--- Booking Appointment ---');
    print('Doctor: ${doctor.name}');
    print('Date: $selectedDateStr');
    print('Time: $selectedTimeStr');
    print('Patient Type: $patientType');
    print('Name: $name');
    print('Age: $age');
    print('Gender: $selectedGender');
    print('Problem: $problem');
    print('-------------------------');

    // Show success message and navigate back or to confirmation screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Appointment booked successfully (Placeholder)!')),
    );
    Navigator.of(context).pop(); // Go back after booking
  }

  void _showErrorSnackbar(BuildContext context, String message) {
     ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
      );
  }
}

