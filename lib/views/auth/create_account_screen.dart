import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:we_link_app/models/others/response.dart';
import 'package:we_link_app/providers/auth_provider.dart';
import 'package:we_link_app/res/colors.dart';
import 'package:we_link_app/res/ui.dart';
import 'package:we_link_app/views/components/textfield.dart';
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  late TextEditingController _usernameCtrl;
  late TextEditingController _passwordCtrl;
  late TextEditingController _passwordRepeatCtrl;
  late TextEditingController _emailCtrl;
  List? errors;

  @override
  void initState() {
    super.initState();
    _usernameCtrl = TextEditingController();
    _passwordCtrl = TextEditingController();
    _passwordRepeatCtrl = TextEditingController();
    _emailCtrl = TextEditingController();
  }

  final _formKey = GlobalKey<FormState>();

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
                image: AssetImage('signup_image.png'),
              ),
              Form(
                  key: _formKey,
                  child: Column(children: [
                    Text(
                      "Welcome to WeLink",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "You have been missed!",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    SizedBox(height: 20),
                    TextInput(
                      controller: _emailCtrl,
                      label: "E-mail address",
                      obscured: false,
                    ),
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
                    TextInput(
                      hasMatchingTextField: true,
                      matchText: _passwordCtrl.text,
                      controller: _passwordRepeatCtrl,
                      label: "Confirm password",
                      obscured: true,
                    ),
                  ])),
              SizedBox(height: 40),
              GestureDetector(
                onTap: () async {
                  var state = Navigator.of(context);
                  if (_formKey.currentState!.validate()) {
                    Response res = await context
                        .read<AuthProvider>()
                        .createUser(
                            username: _usernameCtrl.value.text,
                            password: _passwordCtrl.value.text,
                            email: _emailCtrl.value.text);
                    if (res.status == ResponseStatus.success) {
                      state.pushReplacementNamed('/login');
                      return;
                    } else {
                      setState(() {
                        errors = res.errors!;
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
                            "Create my account",
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
                onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                child: Text(
                  "Already have an account? Login",
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
