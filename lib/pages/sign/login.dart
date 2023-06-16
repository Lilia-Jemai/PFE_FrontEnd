import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sofiacare/pages/patient/search/page_search_screen.dart';
import 'package:sofiacare/pages/sign/reset_pas/mdp_oubli%C3%A9.dart';

import '../../models/api_response.dart';
import '../../models/user.dart';
import '../../services/user_service.dart';
import '../doctor/home/page_doc_home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _txtEmail = TextEditingController();
  TextEditingController _txtPassword = TextEditingController();
  bool _loading = false;

  void _login() async {
    ApiResponse response = await login(_txtEmail.text, _txtPassword.text);
    print("\n $response \n");
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as User);
    } else {
      setState(() {
        if (mounted) _loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${response.error}')),
      );
    }
  }

  void _saveAndRedirectToHome(User user) async {
    print(".......... $user");
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);

    if (user.role == 'patient') {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => SearchScreen()),
        (route) => false,
      );
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => DoctorHome()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(32),
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _txtEmail,
              validator: (val) => val!.isEmpty ? 'Invalid email address' : null,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                labelText: 'Email',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 1, color: Colors.green),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              obscureText: true,
              controller: _txtPassword,
              validator: (val) =>
                  val!.length < 6 ? 'Minimum 6 characters' : null,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_outline),
                labelText: 'Password',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 1, color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 5),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MdpOublie()),
                  );
                },
                child: Text(
                  'Mot de passe oublié',
                  style: TextStyle(
                    color: Color(0xFF013871),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            _loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _loading = true;
                          _login();
                        });
                      }
                    },
                    child: Text(
                      'Valider',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Color(0xFF013871),
                      ),
                      padding: MaterialStateProperty.resolveWith(
                        (states) => EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
