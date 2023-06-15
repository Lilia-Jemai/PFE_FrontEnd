import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constant.dart';
import '../models/api_response.dart';
import '../models/medecin.dart';
import '../models/post.dart';
import '../models/user.dart';

Future<ApiResponse> question(String question, int userId, int medicId) async {
  ApiResponse apiResponse = ApiResponse();

  final response = await http.post(Uri.parse(questionURL),
      headers: {'Accept': 'application/json'},
      body: {'question':question, 'user_id': User,'medic_id':Medic});
  if (response.statusCode == 200) {
    print("success-> " + response.statusCode.toString());
    print(response.body);

    apiResponse.data = Post.fromJson(jsonDecode(response.body));
    var data = json.decode(response.body);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setInt('user_id', data['data']['id']);
    await _prefs.setInt('medic_id', data['data']['medic_id']);
    await _prefs.setString('question', data['data']);
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

//UpdateQuestion


Future<ApiResponse> Updatequestion(String question, int userId, int medicId) async {
  ApiResponse apiResponse = ApiResponse();

  final response = await http.put(Uri.parse(UpdatequestionURL),
      headers: {'Accept': 'application/json'},
      body: {'question':question, 'user_id': User,'medic_id':Medic});
  if (response.statusCode == 200) {
    print("success-> " + response.statusCode.toString());
    print(response.body);

    apiResponse.data = Post.fromJson(jsonDecode(response.body));
    var data = json.decode(response.body);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setInt('user_id', data['data']['id']);
    await _prefs.setInt('medic_id', data['data']['medic_id']);
    await _prefs.setString('question', data['data']);
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

//DeleteQuestion


Future<ApiResponse> Deletecomment(String question, int userId, int medicId) async {
  ApiResponse apiResponse = ApiResponse();

  final response = await http.post(Uri.parse(DeletequestionURL),
      headers: {'Accept': 'application/json'},
      body: {'question':question, 'user_id': User,'medic_id':Medic});
  if (response.statusCode == 200) {
    print("success-> " + response.statusCode.toString());
    print(response.body);

    apiResponse.data = Post.fromJson(jsonDecode(response.body));
    var data = json.decode(response.body);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setInt('user_id', data['data']['id']);
    await _prefs.setInt('medic_id', data['data']['medic_id']);
    await _prefs.setString('question', data['data']);
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
}  ApiResponse apiResponse = ApiResponse();

  