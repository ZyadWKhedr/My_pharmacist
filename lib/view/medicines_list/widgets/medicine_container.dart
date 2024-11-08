import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio/core/const.dart';
import 'package:healio/core/widgets/custom_button.dart';
import 'package:healio/database/database_helper_class.dart';
import 'package:healio/model/medicine_model.dart';

class MedicineContainer extends StatelessWidget {
  final Medicine medicine;

  const MedicineContainer({super.key, required this.medicine});

  // Helper function to split text into groups of three words
  String splitText(String text) {
    List<String> words = text.split(' ');
    List<String> lines = [];

    for (int i = 0; i < words.length; i += 3) {
      int end = (i + 3 < words.length) ? i + 3 : words.length;
      lines.add(words.sublist(i, end).join(' '));
    }

    return lines.join('\n');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 238, 237, 237),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                splitText(medicine.commercialName),
                style: TextStyle(
                  fontSize: 20,
                  color: lightBlue,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // Medicine Image
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: medicine.imageUrl != null &&
                        medicine.imageUrl!.isNotEmpty
                    ? Image.network(
                        medicine.imageUrl!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return const Center(child: CircularProgressIndicator());
                          }
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset('assets/images/placeholder.jpg');
                        },
                      )
                    : const Icon(
                        Icons.image_not_supported,
                        size: 100,
                        color: Colors.grey,
                      ),
              ),
            ),
            // Type, Dosage, and Side Effects
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildInfoColumn('Type', medicine.type),
                  _buildInfoColumn('Dosage', medicine.dosage),
                  _buildInfoColumn('Side Effects', medicine.sideEffects),
                ],
              ),
            ),
            // Favorite and Add to Reminder Buttons
            Column(
              children: [
                CustomButton(
                  label: "Add to Reminder",
                  color: lightBlue,
                  onPressed: () async {
                    bool isMedicineInReminders =
                        await DatabaseHelper.isMedicineInReminders(medicine.id);
                    if (isMedicineInReminders) {
                      // Show Snackbar if already added to reminders
                      Get.snackbar(
                        '${medicine.commercialName} is already added to reminders', // Title of the snackbar
                        'Notice',
                        snackPosition: SnackPosition.TOP,
                        duration: const Duration(milliseconds: 1000),
                        backgroundColor: const Color.fromARGB(255, 0, 158, 82),
                        colorText: Colors.white,
                      );
                    } else {
                      await DatabaseHelper.insertReminder(medicine);
                      // Show Snackbar indicating success
                      Get.snackbar(
                        'Success',
                        '${medicine.commercialName} added to reminders!',
                        snackPosition: SnackPosition.TOP,
                        duration: const Duration(milliseconds: 1020),
                        backgroundColor: const Color.fromARGB(255, 0, 158, 82),
                        colorText: Colors.white,
                      );
                    }
                  },
                ),
                const SizedBox(height: 15.0),
                CustomButton(
                  label: "Favourite",
                  color: Colors.transparent,
                  textColor: lightBlue,
                  onPressed: () async {
                    bool isMedicineSaved =
                        await DatabaseHelper.isMedicineSaved(medicine.id);
                    if (isMedicineSaved) {
                      // Show Snackbar if already saved
                      Get.snackbar(
                        '${medicine.commercialName} is already saved to favourites', // Title of the snackbar
                        'Notice',
                        snackPosition: SnackPosition.TOP,
                        duration: const Duration(milliseconds: 1000),
                        backgroundColor: const Color.fromARGB(255, 0, 158, 82),
                        colorText: Colors.white,
                      );
                    } else {
                      await DatabaseHelper.insertMedicine(medicine);
                      // Show Snackbar indicating success
                      Get.snackbar(
                        'Success',
                        '${medicine.commercialName} added to favorites!',
                        snackPosition: SnackPosition.TOP,
                        duration: const Duration(milliseconds: 1020),
                        backgroundColor: const Color.fromARGB(255, 0, 158, 82),
                        colorText: Colors.white,
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Column(
      children: [
        Text(
          splitText(value),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: lightBlue,
          ),
          textAlign: TextAlign.center,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
