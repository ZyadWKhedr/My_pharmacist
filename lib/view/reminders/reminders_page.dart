import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio/core/const.dart';
import 'package:healio/core/widgets/custom_button.dart';
import 'package:healio/core/database/database_helper_class.dart';
import 'package:healio/model/medicine_model.dart';
import 'package:healio/core/notifications/notifications.dart';

class RemindersPage extends StatefulWidget {
  const RemindersPage({super.key});

  @override
  _RemindersPageState createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  late Future<List<Medicine>> _reminders;

  @override
  void initState() {
    super.initState();
    _reminders = _fetchReminders();
  }

  Future<List<Medicine>> _fetchReminders() async {
    return await DatabaseHelper.getReminders();
  }

  // Open Time Picker to select time for reminder
  void _setReminder(Medicine medicine) async {
    TimeOfDay? selectedTime = await _selectTime(context);

    if (selectedTime != null) {
      // Get the current date and combine it with the selected time
      DateTime now = DateTime.now();
      DateTime selectedDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      // Schedule the reminder
      _scheduleReminder(medicine, selectedDateTime);
    }
  }

  // Show a Time Picker dialog to select time
  Future<TimeOfDay?> _selectTime(BuildContext context) async {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }

  // Schedule the reminder notification using NotificationService
  void _scheduleReminder(Medicine medicine, DateTime selectedDate) {
    NotificationService.scheduleNotification(
      0,
      'Reminder for Medication',
      'It\'s time for your ${medicine.commercialName} reminder.',
      selectedDate,
    );

    // show an instant notification as confirmation
    NotificationService.showInstantNotification('Reminder Set',
        'Your reminder for ${medicine.commercialName} has been set.');

    print('Reminder set for: $selectedDate');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reminders',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: lightBlue,
      ),
      body: FutureBuilder<List<Medicine>>(
        future: _reminders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No reminders available'));
          } else {
            final reminders = snapshot.data!;

            return ListView.builder(
              itemCount: reminders.length,
              itemBuilder: (context, index) {
                final reminder = reminders[index];

                return Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      border: Border.all(color: lightBlue),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      color: backgroungColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reminder.commercialName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: lightBlue,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        reminder.category,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Set Reminder button for each item
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomButton(
                            widthFactor: 0.35,
                            label: "Set Reminder",
                            color: lightBlue,
                            textColor: Colors.white,
                            onPressed: () {
                              _setReminder(reminder);
                            },
                          ),
                          CustomButton(
                            widthFactor: 0.3,
                            label: "Delete",
                            borderColor: orange,
                            color: Colors.transparent,
                            textColor: orange,
                            onPressed: () async {
                              // Remove from database
                              await DatabaseHelper.deleteReminder(reminder.id!);
                              Get.snackbar(
                                'Deleted Successfully',
                                '${reminder.commercialName} ',
                                snackPosition: SnackPosition.TOP,
                                duration: const Duration(milliseconds: 1020),
                                backgroundColor:
                                    const Color.fromARGB(255, 155, 3, 3),
                                colorText: Colors.white,
                              );

                              setState(() {
                                _reminders = DatabaseHelper.getReminders();
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
