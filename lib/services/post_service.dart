import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constant.dart';
import '../models/api_response.dart';
import '../models/post.dart';
import '../models/user.dart';

class ApiPosts {
  Future<List<Post>> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse(postsURL));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List<dynamic> data = jsonData['data'];

        return data.map((item) => Post.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch posts');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<ApiResponse> post(String description, int userId) async {
    ApiResponse apiResponse = ApiResponse();

    final response = await http.post(Uri.parse(postsURL),
        headers: {'Accept': 'application/json'},
        body: {'description': post, 'user_id': User});
    if (response.statusCode == 200) {
      print("success-> " + response.statusCode.toString());
      print(response.body);

      apiResponse.data = Post.fromJson(jsonDecode(response.body));
      var data = json.decode(response.body);
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      await _prefs.setInt('userId', data['data']['id']);
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

//UpdatePost

  Future<ApiResponse> Updatepost(String description, int userId) async {
    ApiResponse apiResponse = ApiResponse();

    final response = await http.put(Uri.parse(updatePostsURL),
        headers: {'Accept': 'application/json'},
        body: {'description': post, 'post_id': Post});
    if (response.statusCode == 200) {
      print("success-> " + response.statusCode.toString());
      print(response.body);

      apiResponse.data = Post.fromJson(jsonDecode(response.body));
      var data = json.decode(response.body);
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      await _prefs.setInt('post_d', data['data']['id']);
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

//DeletePost

  Future<ApiResponse> Deletepost(String description, int postId) async {
    ApiResponse apiResponse = ApiResponse();

    final response = await http.delete(Uri.parse(deletePostURL),
        headers: {'Accept': 'application/json'},
        body: {'description': post, 'post_id': Post});
    if (response.statusCode == 200) {
      print("success-> " + response.statusCode.toString());
      print(response.body);

      apiResponse.data = Post.fromJson(jsonDecode(response.body));
      var data = json.decode(response.body);
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      await _prefs.setInt('post_id', data['data']['id']);
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
}
