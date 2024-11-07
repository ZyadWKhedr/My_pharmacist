import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healio/model/medicine_model.dart';
import 'package:http/http.dart' as http;

class MedicineViewModel extends ChangeNotifier {
  final String baseUrl = 'http://192.168.1.7:3000/medicines';
  List<Medicine> medicines = [];
  List<String> categories = [];
  List<Medicine> filteredMedicines = [];
  bool isLoading = false;
  String errorMessage = '';

  final Map<String, String> categoryImageUrls = {
    'Pain Relievers':
        'https://evolvept.com/wp-content/uploads/2024/04/AdobeStock_752836158-1024x574.jpeg',
    'Flu Medications':
        'https://img.freepik.com/free-vector/medical-infographic-cold-flu-symptoms_1308-47909.jpg',
    'Mental Health Medications':
        'https://www.sapphire-essentials.com/wp-content/uploads/2020/09/2020-11-02-Commonly-Prescribed-Psychiatric-Medications.jpg',
    'Headache Medications':
        'https://d35oenyzp35321.cloudfront.net/max_banner_size_2_77984af80e.jpg',
    'Cough Medications':
        'https://bpac.org.nz/2023/img/cough-medicines-main.jpg',
  };

  Future<void> fetchMedicines() async {
    try {
      isLoading = true; // Start loading
      errorMessage = ''; // Clear any previous error messages

      // Fetch the data from the API
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        // If the data is fetched successfully, process it
        List data = json.decode(response.body);
        medicines = data.map((json) => Medicine.fromJson(json)).toList();

        // Extract categories from the medicines
        categories =
            medicines.map((medicine) => medicine.category).toSet().toList();
      } else {
        // If the response is not successful, show an error message
        errorMessage = 'Failed to load medicines';
      }
    } catch (error) {
      // If there's any error during the fetch, show an error message
      errorMessage = 'Error fetching medicines: $error';
    } finally {
      isLoading = false;

      // Notify listeners after fetching and processing the data
      notifyListeners();
    }
  }

  Future<void> fetchMedicinesByCategory(String selectedCategory) async {
    print("Fetching medicines for category: $selectedCategory");
    try {
      isLoading = true; // Start loading
      errorMessage = '';
      medicines = []; // Clear existing data before fetching new data
      notifyListeners(); // Notify listeners immediately

      final response = await http.get(Uri.parse(baseUrl));
      print("Response status: ${response.statusCode}");

      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        print("Fetched medicines: ${data.length}");

        // Filter medicines by category
        medicines = data
            .map((json) => Medicine.fromJson(json))
            .where((medicine) =>
                medicine.category.toLowerCase().trim() ==
                selectedCategory.toLowerCase().trim())
            .toList();

        print(
            "Medicines fetched for category $selectedCategory: ${medicines.length}");
      } else {
        errorMessage = 'Failed to load medicines';
        print("Error: Failed to load medicines");
      }
    } catch (error) {
      errorMessage = 'Error fetching medicines: $error';
      print("Error: $error");
    } finally {
      isLoading = false; // Ensure we stop loading

      // Notify listeners after fetching and filtering
      notifyListeners(); // This triggers a rebuild with the updated data
    }
  }

  void searchMedicines(String query) {
    if (query.isEmpty) {
      filteredMedicines = medicines; // If query is empty, show all medicines
    } else {
      filteredMedicines = medicines
          .where((medicine) =>
              medicine.commercialName
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              medicine.category.toLowerCase().contains(query.toLowerCase()))
          .toList(); // Filter by name or category
    }
    notifyListeners(); // Notify listeners to update the UI
  }

  String getCategoryImageUrl(String category) {
    String normalizedCategory = category.toLowerCase().trim();
    return categoryImageUrls.entries
        .firstWhere(
          (entry) => entry.key.toLowerCase().trim() == normalizedCategory,
          orElse: () => MapEntry('',
              'https://buzzrx.s3.amazonaws.com/f8e7be31-2f60-4de0-8bd1-5bea5fe83ce4/CoughMedicine.png'),
        )
        .value;
  }
}
