import 'package:flutter/material.dart';
import 'package:healio/model/medicine_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MedicineProvider with ChangeNotifier {
  List<Medicine> _medicines = [];

  List<Medicine> get medicines => _medicines;

  // Fetch medicines from the API
  Future<void> fetchMedicines() async {
    final url = Uri.parse(
        'https://medicationsapi-production.up.railway.app/api/medicines'); // Replace with your API endpoint
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _medicines = data.map((item) => Medicine.fromJson(item)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load medicines');
      }
    } catch (error) {
      print('Error fetching medicines: $error');
    }
  }
}
