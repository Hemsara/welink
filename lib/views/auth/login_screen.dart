// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:we_link_app/models/others/response.dart';
import 'package:we_link_app/providers/auth_provider.dart';
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
  List? errors;

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
                onTap: () async {
                  NavigatorState state = Navigator.of(context);
                  if (_formKey.currentState!.validate()) {
                    Response rs = await context
                        .read<AuthProvider>()
                        .login(_usernameCtrl.text, _passwordCtrl.text);
                    if (rs.status == ResponseStatus.success) {
                      state.pushReplacementNamed('/home');
                    } else {
                      setState(() {
                        errors = rs.errors!;
                      });
                    }
                  }
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: !context.watch<AuthProvider>().isLoading
                        ? Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          )
                        : SpinKitThreeBounce(
                            color: Colors.white,
                            size: 13,
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
              SizedBox(height: 20),
              SizedBox(
                child: errors != null
                    ? Text(
                        errors![0],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13, color: Colors.redAccent),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
