// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_link_app/models/others/response.dart';
import 'package:we_link_app/providers/auth_provider.dart';
import 'package:we_link_app/providers/links_provider.dart';
import 'package:we_link_app/res/constants.dart';
import 'package:we_link_app/services/network_service.dart';
import 'package:we_link_app/views/app/links/screens/add_link.dart';
import 'package:we_link_app/views/auth/create_account_screen.dart';
import 'package:we_link_app/views/auth/login_screen.dart';
import 'package:we_link_app/views/app/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool auth = await checkAuthenticated();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LinkProvider(),
        ),
      ],
      child: WeLinkApp(auth: auth),
    ),
  );
}

class WeLinkApp extends StatelessWidget {
  final bool auth;
  const WeLinkApp({super.key, required this.auth});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home': (context) => Home(),
        '/login': (context) => LoginScreen(),
        '/add': (context) => AddLinkScreen(),
        '/signup': (context) => CreateAccountScreen(),
      },
      debugShowCheckedModeBanner: false,
      initialRoute: auth ? '/home' : '/login',
    );
  }
}

Future<bool> checkAuthenticated() async {
  try {
    NetworkService api = NetworkService(baseURL: '${AppConstants.host}/api');
    Response rs = await api.get(mustAuthenticated: true, endpoint: '/auth');
    if (rs.status == ResponseStatus.success) {
      return true;
    }
    return false;
  } catch (e) {
    return false;
  }
}
