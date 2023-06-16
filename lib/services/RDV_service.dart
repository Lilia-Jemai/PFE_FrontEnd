import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sofiacare/constant.dart';

import '../models/api_response.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

Future<ApiResponse> rendezVous(
    String time, String date, int patientId, int medicId) async {
  ApiResponse apiResponse = ApiResponse();

  final response = await http.post(Uri.parse(rendezVousURL), headers: {
    'Accept': 'application/json'
  }, body: {
    'time': time,
    'date': date,
    'patient_id': patientId,
    'medic_id': medicId,
  });
  if (response.statusCode == 200) {
    print("success-> " + response.statusCode.toString());
    print(response.body);
    apiResponse.data = User.fromJson(jsonDecode(response.body));
    var data = json.decode(response.body);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setInt('patientId', data['data']['id']);
    await _prefs.setInt('medicId', data['data']['id']);
    await _prefs.setString('description', data['data']);
  } else if (response.statusCode == 422) {
    print("failure -> " + response.statusCode.toString());
    final errors = jsonDecode(response.body)['errors'];
    apiResponse.error = errors[errors.keys.elementAt(0)][0];
  } else {
    print("else -> " + response.statusCode.toString());
    apiResponse.error = somethingWentWrong;
  }
  print("status code -> " + response.statusCode.toString());
  return apiResponse;
}
