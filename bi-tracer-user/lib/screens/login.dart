import 'package:bi_tracker_user/firebase/auth.dart';
import 'package:bi_tracker_user/screens/reset_pass.dart';
import 'package:bi_tracker_user/shared/auth_button.dart';
import 'package:bi_tracker_user/shared/constants.dart';
import 'package:bi_tracker_user/shared/navigator.dart';
import 'package:bi_tracker_user/shared/textfield.dart';
import 'package:bi_tracker_user/shared/validation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  late TextEditingController emailController;
  late TextEditingController passController;

  //get mainColor => null;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    child: Image.asset('images/logo.png'),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              LoginTextField(
                keyboardType: TextInputType.emailAddress,
                label: 'Enter Email',
                controller: emailController,
                suffixIcon: Icon(
                  Icons.email,
                  color: Colors.black,
                ),
                validate: Validation().emailValidation,
              ),
              SizedBox(
                height: 15,
              ),
              LoginTextField(
                keyboardType: TextInputType.visiblePassword,
                label: 'Enter Password',
                controller: passController,
                validate: Validation().passwordValidation,
              ),
              SizedBox(
                height: 15,
              ),
              MaterialButtonDesign(
                  pressed: () async {
                    Auth().login(
                        emailController.text, passController.text, context);
                  },
                  minWidth: 250,
                  color: mainColor,
                  label: 'Login'),
              SizedBox(
                height: 15,
              ),
              MaterialButtonText(
                  pressed: () {
                    navigate(context: context, route: ResetPassword());
                  },
                  label: 'Forget password')
            ],
          ),
        ),
      ),
    );
  }
}
