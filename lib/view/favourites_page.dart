import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healio/core/const.dart';
import 'package:healio/core/widgets/custom_button.dart';
import 'package:healio/database/database_helper_class.dart';
import 'package:healio/model/medicine_model.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late Future<List<Medicine>> _medicinesFuture;

  @override
  void initState() {
    super.initState();
    _medicinesFuture = DatabaseHelper.getMedicines();
  }

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightBlue,
        centerTitle: true,
        title: const Text(
          'Favorites',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: FutureBuilder<List<Medicine>>(
        future: _medicinesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No favorite medicines added.'));
          }

          final medicines = snapshot.data!;
          return ListView.builder(
            itemCount: medicines.length,
            itemBuilder: (context, index) {
              final medicine = medicines[index];
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
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                        'assets/images/placeholder.jpg');
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
                            _buildInfoColumn(
                                'Side Effects', medicine.sideEffects),
                          ],
                        ),
                      ),
                      // Delete Button
                      CustomButton(
                        label: "Delete",
                        color: Colors.transparent,
                        textColor: orange,
                        borderColor: orange,
                        onPressed: () async {
                          // Remove from database
                          await DatabaseHelper.deleteMedicine(medicine.id);
                          Get.snackbar(
                            'Deleted Successfully',
                            '${medicine.commercialName} ',
                            snackPosition: SnackPosition.TOP,
                            duration: const Duration(milliseconds: 1020),
                            backgroundColor:
                                const Color.fromARGB(255, 155, 3, 3),
                            colorText: Colors.white,
                          );

                          // Refresh the list by calling setState
                          setState(() {
                            _medicinesFuture = DatabaseHelper.getMedicines();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
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
