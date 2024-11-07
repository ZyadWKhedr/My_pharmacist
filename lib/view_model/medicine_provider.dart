import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:healio/model/medicine_model.dart';
import 'package:http/http.dart' as http;

class MedicineViewModel extends ChangeNotifier {
  final String baseUrl = 'http://192.168.1.7:3000/medicines';
  List<Medicine> medicines = [];
  List<String> categories = [];

  bool isLoading = false;

  // Map of predefined categories with image URLs
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

  // Fetch medicines from API
  Future<void> fetchMedicines() async {
    try {
      isLoading = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });

      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        medicines = data.map((json) => Medicine.fromJson(json)).toList();

        categories =
            medicines.map((medicine) => medicine.category).toSet().toList();
        print("Categories : $categories");
      } else {
        throw Exception('Failed to load medicines');
      }
    } catch (error) {
      print(error);
    } finally {
      isLoading = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  String getCategoryImageUrl(String category) {
    // Convert the category to lowercase and trim any extra spaces
    String normalizedCategory = category.toLowerCase().trim();

    // Find the image URL based on normalized category
    return categoryImageUrls.entries
        .firstWhere(
          (entry) => entry.key.toLowerCase().trim() == normalizedCategory,
          orElse: () => MapEntry('',
              'https://buzzrx.s3.amazonaws.com/f8e7be31-2f60-4de0-8bd1-5bea5fe83ce4/CoughMedicine.png'),
        )
        .value;
  }
}
