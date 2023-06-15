import 'dart:convert';

import 'package:sofiacare/models/patient.dart';
import 'package:http/http.dart' as http;

class ApiPatient {
  Future<List<Patient>> fetchPatients() async {
    final response = await http.get(Uri.parse(''));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      List<Patient> patients = [];
      for (var item in jsonData) {
        patients.add(Patient.fromJson(item));
      }

      return patients;
    } else {
      throw Exception(
          'Failed to fetch patients. Status code: ${response.statusCode}');
    }
  }
}
