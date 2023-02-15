// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:we_link_app/res/colors.dart';
import 'package:we_link_app/res/ui.dart';
import 'package:we_link_app/views/components/textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _usernameCtrl;
  late TextEditingController _passwordCtrl;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _usernameCtrl = TextEditingController();
    _passwordCtrl = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Padding(
        padding: EdgeInsets.all(AppUi.scaffoldPadding),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('login_image.png'),
              ),
              Text(
                "Welcome back",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              Text(
                "You have been missed!",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      TextInput(
                        controller: _usernameCtrl,
                        label: "Username",
                        obscured: false,
                      ),
                      TextInput(
                        controller: _passwordCtrl,
                        label: "Password",
                        obscured: true,
                      ),
                    ],
                  )),
              SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () => Navigator.pushReplacementNamed(context, '/signup'),
                child: Text(
                  "Don't have an account? Create a one",
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
