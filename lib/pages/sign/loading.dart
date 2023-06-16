import 'package:sofiacare/constant.dart';
import 'package:sofiacare/models/api_response.dart';
import 'package:flutter/material.dart';
import 'package:sofiacare/pages/patient/search/page_search_screen.dart';
import 'package:sofiacare/utils/shared_pref.dart';

import '../../services/user_service.dart';
import 'login.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void _loadingUserInfo() async {
    String? token = await SharedPreferencesHelper.getString('token');
    if (token == '') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Login()), (route) => false);
    } else {
      final  response = await UserService.getUserDetail();
      if (response == null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => SearchScreen()), (route) => false);
      } else if (response.isEmpty) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Login()), (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Probleme survenue'),
        ));
      }
    }
  }

  @override
  void initState() {
    _loadingUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
