import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:healio/model/medicine_model.dart';
import 'package:http/http.dart' as http;

class MedicineViewModel extends ChangeNotifier {
  final String baseUrl = 'http://192.168.1.7:3000/api/content/medicines';
  List<Medicine> medicines = [];

  Future<void> fetchMedicines() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        medicines = data.map((json) => Medicine.fromJson(json)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load medicines');
      }
    } catch (error) {
      print(error);
    }
  }
}
