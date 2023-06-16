import 'dart:convert';
import 'dart:io';
import 'package:sofiacare/constant.dart'
    show
        loginURL,
        registerURL,
        sendEmailUrl,
        serverError,
        somethingWentWrong,
        unauthorized,
        updatePassUrl,
        updateUrl,
        userURL,
        valideCodeUrl;
import 'package:sofiacare/models/api_response.dart';
import 'package:sofiacare/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sofiacare/utils/shared_pref.dart';

class UserService {
//login
//login
  static Future<ApiResponse?> login(String email, String password) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http.post(Uri.parse(loginURL),
          headers: {'Accept': 'application/json'},
          body: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        print("success-> " + response.statusCode.toString());
        print(response.body);

        apiResponse.data = User.fromJson(jsonDecode(response.body));
        //var data = json.decode(response.body);
        // SharedPreferences _prefs = await SharedPreferences.getInstance();
        //await _prefs.setInt('userId', data['data']['id']);
        /*await _prefs.setString('token', data['token']);
    await _prefs.setString('nom', data['data']['name']);
    await _prefs.setString('adresse', data['data']['adresse']);
    await _prefs.setString('role', data['data']['role']);*/
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
    } catch (e) {
      return null;
    }
  }

//Register

  static Future<ApiResponse?> register(
      String name,
      String email,
      String password,
      String? role,
      String? addresse,
      String? numTel,
      int? specID) async {
    ApiResponse apiResponse = ApiResponse();
    Map<String, dynamic> data = {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmtion': password,
      'role': role,
      'spec_id': specID ?? 0,
      'adresse': addresse ?? null,
      'num_tel': numTel ?? null
    };
    print(data);
    try {
      final response = await http.post(Uri.parse(registerURL),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          },
          body: jsonEncode(data));
      if (response.statusCode == 201) {
        print("success-> " + response.statusCode.toString());
        print(response.body);
        apiResponse.data = User.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 422) {
        print("failure -> " + response.statusCode.toString());
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
      } else {
        print(response.body);
        print("else -> " + response.statusCode.toString());
        apiResponse.error = somethingWentWrong;
      }
      print("status code -> " + response.statusCode.toString());
      return apiResponse;
    } catch (e, st) {
      print(e);
      print(st);
      return null;
    }
  }

//user details

  static Future<List<User>?> getUserDetail() async {
    ApiResponse apiResponse = ApiResponse();
    String? token = await SharedPreferencesHelper.getString('token');
    List<User>? users = [];
    try {
      final response = await http.get(Uri.parse(userURL), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
      // if (response.statusCode == 200) {
      //   print("success-> " + response.statusCode.toString());
      //   print(response.body);
      //   apiResponse.data = User.fromJson(jsonDecode(response.body));
      // } else if (response.statusCode == 422) {
      //   print("failure -> " + response.statusCode.toString());
      //   final errors = jsonDecode(response.body)['errors'];
      //   apiResponse.error = errors[errors.keys.elementAt(0)][0];
      // } else {
      //   print("else -> " + response.statusCode.toString());
      //   apiResponse.error = somethingWentWrong;
      // }
      //print("status code -> " + response.statusCode.toString());
      //print(response.body);
      final rawData = jsonDecode(response.body);
     // print("rrrdata => $rawData");

      rawData.forEach((e) {
        print("zeazeza$e");
        return users.add(User.fromJson(e));
      });
      print(users);
      return users;
    } catch (e, st) {
      print(e);
      print(st);
      return null;
    }
  }

//Get Token
  static Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('token') ?? '';
  }

//get user id
  static Future<int> getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt('userId') ?? 0;
  }

//logout
//get user id
  static Future<bool> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.remove('token');
  }

// Get base64 encoded image
  String? getStringImage(File? file) {
    if (file == null) return null;
    return base64Encode(file.readAsBytesSync());
  }

/*static Future<ApiResponse> logout() async {
  ApiResponse apiResponse = ApiResponse();

  final response = await http.post(
    Uri.parse(logoutURL),
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer yourAccessToken'
    },
  );
  if (response.statusCode == 200) {
    print("success-> " + response.statusCode.toString());
    print(response.body);
    apiResponse.data = User.fromJson(jsonDecode(response.body));
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
*/
//email Validate
// ignore: non_constant_identifier_names
  static Future<ApiResponse> SendEmail(String email) async {
    ApiResponse apiResponse = ApiResponse();

    final response = await http.post(Uri.parse(sendEmailUrl),
        headers: {'Accept': 'application/json'}, body: {'email': email});
    if (response.statusCode == 200) {
      print("success-> " + response.statusCode.toString());
      print(response.body);
      apiResponse.data = User.fromJson(jsonDecode(response.body));
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

//ConfirmCode
// ignore: non_constant_identifier_names
  static Future<ApiResponse> VerifCode(String code) async {
    ApiResponse apiResponse = ApiResponse();

    final response = await http.post(Uri.parse(valideCodeUrl), headers: {
      'Accept': 'application/json'
    }, body: {
      'verification_code': code,
    });
    if (response.statusCode == 200) {
      print("success-> " + response.statusCode.toString());
      print(response.body);
      apiResponse.data = User.fromJson(jsonDecode(response.body));
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

//UpdateMot de passe

// ignore: non_constant_identifier_names
  static Future<ApiResponse> ModifierMotDePasse(String password) async {
    ApiResponse apiResponse = ApiResponse();

    final response = await http.post(Uri.parse(updatePassUrl), headers: {
      'Accept': 'application/json'
    }, body: {
      'password': password,
    });
    if (response.statusCode == 200) {
      print("success-> " + response.statusCode.toString());
      print(response.body);
      apiResponse.data = User.fromJson(jsonDecode(response.body));
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
}
