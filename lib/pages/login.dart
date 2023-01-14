import 'package:capstone_app/pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final unameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 150,
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 120,
                width: 120,
                child: DecoratedBox(
                  decoration: new BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 140,
            ),
            SizedBox(
                child: Text(
                  'Enter your email id',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
                )),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 50,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.yellow[50],
              ),
              child: TextFormField(
                controller: unameController,
                cursorColor: Colors.black54,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black54),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54),
                  ),
                ),
                textInputAction: TextInputAction.done,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (uname) =>
                uname != null && !EmailValidator.validate(uname)
                    ? 'Enter a valid email'
                    : null,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton.icon(
              onPressed: () async {
                if(EmailValidator.validate(unameController.text)) {
                  SharedPreferences pref = await SharedPreferences
                      .getInstance();
                  pref.setString('userName', unameController.text);
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) {
                    return HomePage();
                  }));
                } else{
                  print('email not valid');
                }
              },
              icon: Icon(Icons.login),
              label: Text(
                'Continue',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
