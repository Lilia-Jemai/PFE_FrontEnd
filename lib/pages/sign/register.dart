import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sofiacare/pages/doctor/home/page_doc_home.dart';
import 'package:sofiacare/pages/patient/home/page_pat_home.dart';

import '../../models/api_response.dart';
import '../../models/user.dart';
import '../../services/user_service.dart';

enum UserRole { patient, doctor }

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController nomController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneNumberController =
      TextEditingController(text: '+216');
  bool loading = false;
  UserRole? userRole = UserRole.patient;
  bool? _isChecked = false;
  List<String> specialities = [
    'Dentist',
    'Généraliste',
    'Anesthésiologie',
    ' Cardiologie',
    'Dermatologie',
    'Endocrinologie',
    'Gastro-entérologie',
    'Génétique',
    'Gériatrie',
    'Hématologie',
    'Néphrologie',
    'Neurologie',
    'Pédiatrie',
    'Physiatrie',
    'Rhumatologie',
    'Psychiatrie',
    'Pneumologie',
    'Oncologie médicale',
  ];
  String? selectedSpeciality;

  void _register() async {
    ApiResponse response = await register(
      nomController.text,
      emailController.text,
      passwordController.text,
      userRole == UserRole.patient ? 'patient' : 'doctor',
    );
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as User);
    } else {
      setState(() {
        if (mounted) loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${response.error}')),
      );
    }
  }

  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (userRole == UserRole.doctor) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => DoctorHome()),
        (route) => false,
      );
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => PatHome()),
        (route) => false,
      );
    }
  }

  void _showValidationPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Validation'),
          content: Text('Your email has been successfully validated.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: ListView(
          padding: EdgeInsets.all(32),
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: nomController,
              validator: (val) => val!.isEmpty ? 'Invalid username' : null,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: 'UserName',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 1, color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              validator: (val) => val!.isEmpty ? 'Invalid email address' : null,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                labelText: 'Email',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 1, color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              obscureText: true,
              controller: passwordController,
              validator: (val) => val!.isEmpty ? 'Minimum 6 characters' : null,
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
            SizedBox(height: 10),
            TextFormField(
              obscureText: true,
              controller: confirmPasswordController,
              validator: (val) => val != passwordController.text
                  ? 'Confirm password does not match'
                  : null,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_outline),
                labelText: 'Confirm Password',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 1, color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 10),
            Column(
              children: [
                SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text(
                          'Patient',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        leading: Radio<UserRole>(
                          value: UserRole.patient,
                          groupValue: userRole,
                          onChanged: (UserRole? value) {
                            setState(() {
                              userRole = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text(
                          'Docteur',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        leading: Radio<UserRole>(
                          value: UserRole.doctor,
                          groupValue: userRole,
                          onChanged: (UserRole? value) {
                            setState(() {
                              userRole = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                if (userRole == UserRole.doctor) ...[
                  DropdownButtonFormField<String>(
                    value: selectedSpeciality,
                    onChanged: (String? value) {
                      setState(() {
                        selectedSpeciality = value;
                      });
                    },
                    items: specialities.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    decoration: InputDecoration(
                      labelText: 'Spécialité',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(width: 1, color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    validator: (val) =>
                        val!.isEmpty ? 'Adresse required' : null,
                    decoration: InputDecoration(
                      labelText: 'Adresse',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(width: 1, color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: phoneNumberController,
                    validator: (val) =>
                        val!.isEmpty ? 'Numéro de téléphone required' : null,
                    decoration: InputDecoration(
                      labelText: 'Numéro de téléphone',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(width: 1, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value;
                    });
                  },
                ),
                Text('Accepter les conditions d\'utilisation'),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  setState(() {
                    loading = true;
                  });
                  _register();
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: loading
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : Text(
                        'Register',
                        style: TextStyle(fontSize: 16),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
