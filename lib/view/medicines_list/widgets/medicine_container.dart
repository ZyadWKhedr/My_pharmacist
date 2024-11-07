import 'package:flutter/material.dart';
import 'package:healio/core/const.dart';
import 'package:healio/core/widgets/custom_button.dart';
import 'package:healio/model/medicine_model.dart';

class MedicineContainer extends StatelessWidget {
  final Medicine medicine;

  const MedicineContainer({Key? key, required this.medicine}) : super(key: key);

  // Helper function to split text into groups of three words
  String splitText(String text) {
    List<String> words = text.split(' ');
    List<String> lines = [];

    for (int i = 0; i < words.length; i += 3) {
      // Create a group of three words or whatever remains
      int end = (i + 3 < words.length) ? i + 3 : words.length;
      lines.add(words.sublist(i, end).join(' '));
    }

    return lines.join('\n'); // Join lines with a line break
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
            // Medical Name
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
                            return Center(child: CircularProgressIndicator());
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

            // Type, Dosage, and Side Effects Row
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

            // Precautions and Interactions Row
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildInfoColumn('Precautions', medicine.precautions),
                  _buildInfoColumn('Interactions', medicine.interactions),
                ],
              ),
            ),

            SizedBox(
              height: 20,
            ),

            // Favorite and Add to Reminder Buttons
            Column(
              children: [
                CustomButton(
                  label: "Add to Reminder",
                  color: lightBlue,
                  onPressed: () {
                    // Add your reminder button action here
                  },
                ),
                const SizedBox(height: 15.0),
                CustomButton(
                  label: "Favourite",
                  color: Colors.transparent,
                  textColor: lightBlue,
                  onPressed: () {
                    // Add your favourite button action here
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build info columns for Type, Dosage, etc.
  Widget _buildInfoColumn(String label, String value) {
    return Column(
      children: [
        Text(
          splitText(value), // Split the value into 3-word chunks
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: lightBlue,
          ),
          textAlign: TextAlign.center,
          maxLines: 3, // Limit to 3 lines
          overflow: TextOverflow.ellipsis, // Handle overflow
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
