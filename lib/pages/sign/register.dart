import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sofiacare/pages/doctor/home/page_doc_home.dart';
import 'package:sofiacare/pages/patient/home/page_pat_home.dart';

import '../../models/api_response.dart';
import '../../models/user.dart';
import '../../services/user_service.dart';
import '../../utils/Utils.dart';

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
  TextEditingController _phoneNumberController =
      TextEditingController(text: '+216');
  TextEditingController _addressController = TextEditingController();
  bool _loading = false;
  String? userRole;
  bool? _isChecked = false;
  List<String> specialities = [
    'Dentist',
    'Généraliste',
    'Anesthésiologie',
    'Cardiologie',
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
    ApiResponse? response = await UserService.register(
        nomController.text,
        emailController.text,
        passwordController.text,
        userRole,
        _addressController.text,
        _phoneNumberController.text,
        specialities.indexOf(selectedSpeciality ?? 'Dentist') + 1);
    if (response == null) {
      Utils.showSnack(context, CupertinoIcons.exclamationmark_bubble, false,
          'Oops, Notre service est au maintenance veuillez réessayer plus tard, Merci!');
    }
    if (response!.error == null) {
      _saveAndRedirectToHome(response.data as User);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${response.error}')),
      );
    }
  }

  void _saveAndRedirectToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    if (userRole == 'medecin') {
      print("but i got in ?");
      await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => DoctorHome()),
        (route) => false,
      );
    } else {
      print("but i got in ?2");
      await Navigator.of(context).pushAndRemoveUntil(
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
                        leading: Radio<String>(
                          value: 'patient',
                          groupValue: userRole,
                          onChanged: (String? value) {
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
                        leading: Radio<String>(
                          value: 'medecin',
                          groupValue: userRole,
                          onChanged: (String? value) {
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
                if (userRole == 'medecin') ...[
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
                    controller: _addressController,
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
                    controller: _phoneNumberController,
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
                    _loading = true;
                  });
                  _register();
                  setState(() {
                    _loading = false;
                  });
                }
              },
              child: _loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Text(
                      'Inscrire',
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
