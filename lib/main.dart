import 'package:amazon_clone/admin/admin_navbar.dart';
import 'package:amazon_clone/admin/admin_screen.dart';
import 'package:amazon_clone/auth/pages/auth_screen.dart';
import 'package:amazon_clone/pages/home_screen.dart';
import 'package:amazon_clone/auth/services/auth_services.dart';
import 'package:amazon_clone/common/widgets/nav_bar.dart';
import 'package:amazon_clone/constants/globals.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: ((context) => UserProvider()),
    ),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthServices authServices = AuthServices();
  String? token;

  @override
  void initState() {
    super.initState();
    authServices.getUserData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Lato",
        scaffoldBackgroundColor: Globals.bgColor,
        colorScheme: const ColorScheme.light(
          primary: Globals.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black54,
          ),
        ),
      ),
      onGenerateRoute: ((settings) => generateRoute(settings)),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == 'user'
              ? NavBar()
              : AdminNavBar()
          : const AuthScreen(),
    );
  }
}
