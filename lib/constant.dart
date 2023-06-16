import 'package:flutter/material.dart';

//STINGS--------------
const baseURL = 'http://10.0.2.2:8000/api';
//const baseURL = 'http://192.168.200.124:8000/api';
const loginURL = baseURL + '/auth/login';
const registerURL = baseURL + '/auth/register';
const logoutURL = baseURL + '/auth/logout';
const sendEmailUrl = baseURL + '/auth/verify';
const valideCodeUrl = baseURL + '/auth/verify_pass';
const updatePassUrl = baseURL + '/auth/update_pass';
const userURL = baseURL + '/users';
const postsURL = baseURL + '/post';
const updatePostsURL = baseURL + '/post/{id}';
const deletePostURL = baseURL + '/post/{id}';
//Commentaire
const commentURL = baseURL + '/comment';
const updateCommentURL = baseURL + '/comment/{id}';
const deleteCommentURL = baseURL + '/comment/{id}';
const likeURL = baseURL + '/like';

//Question
const questionURL = baseURL + '/question';
const updateQuestionURL = baseURL + '/question/{id}';
const deleteQuestionURL = baseURL + '/question/{id}';
//reponse
const responseURL = baseURL + '/response';
const updateResponseURL = baseURL + '/response/{id}';
const deleteResponseURL = baseURL + '/response/{id}';

const searchURL = baseURL + '/patient/user/{user_id}';
const patientURL = baseURL + '/patient';
const patienSearchtURL = baseURL + '/patient/search';
const specialityURL = baseURL + '/specialite';
const specialitySearchURL = baseURL + '/specialite/search';
const searchMedicURL = baseURL + '/medic/user/{user_id}';
const medictURL = baseURL + '/medic';
const medicSearchtURL = baseURL + '/medic/search';
const rendezVousURL = baseURL + '/rendvous';
const rendezVousSearchURL = baseURL + '/rendevous/search';
const dossierURL = baseURL + '/dossier';
const dossierSearchURL = baseURL + '/dossier/search';

//ERRORS-----------
const serverError = 'Server error';
const unauthorized = 'unauthorized';
const somethingWentWrong = 'Something Went Wrong, try again';

//---Input decoration
InputDecoration kInputDecoration(String label) {
  return InputDecoration(
      labelText: label,
      contentPadding: EdgeInsets.all(10),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 1, color: Colors.green)));
}

//---Button

TextButton kTextButton(
    String label, Function onPressed, Null Function() param2) {
  return TextButton(
    onPressed: () => onPressed(),
    child: Text(
      label,
      style: TextStyle(color: Colors.white),
    ),
    style: ButtonStyle(
      backgroundColor:
          MaterialStateColor.resolveWith((states) => Color(0xFF013871)),
      padding: MaterialStateProperty.resolveWith(
        (states) => EdgeInsets.symmetric(vertical: 10),
      ),
    ),
  );
}

//Login Inscription
Row kLoginRegisterHint(String text, String label, Function onTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(text),
      GestureDetector(
        child: Text(
          label,
          style:
              TextStyle(color: Color(0xFF013871), fontWeight: FontWeight.bold),
        ),
        onTap: () => onTap(),
      ),
    ],
  );
}
