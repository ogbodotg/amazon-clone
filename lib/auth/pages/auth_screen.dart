import 'package:amazon_clone/auth/services/auth_services.dart';
import 'package:amazon_clone/common/widgets/common_services.dart';
import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/text-field.dart';
import 'package:amazon_clone/constants/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

enum Auth {
  login,
  register,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.login;
  final _loginKey = GlobalKey<FormState>();
  final _registerKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _visible = false;
  final AuthServices authServices = AuthServices();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void registerUser() {
    authServices.registerUser(
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      context: context,
    );
  }

  void loginUser() {
    authServices.loginUser(
      email: _emailController.text,
      password: _passwordController.text,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    CommonServices _commonServices = CommonServices();
    return Scaffold(
      backgroundColor: Globals.greyBgColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            ListTile(
              tileColor:
                  _auth == Auth.login ? Globals.bgColor : Globals.greyBgColor,
              title: const Text(
                'Login',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Radio(
                value: Auth.login,
                activeColor: Globals.secondaryColor,
                groupValue: _auth,
                onChanged: (Auth? value) {
                  setState(() {
                    _auth = value!;
                  });
                },
              ),
            ),
            if (_auth == Auth.login)
              Container(
                padding: const EdgeInsets.all(8),
                color: Globals.bgColor,
                child: Form(
                  key: _loginKey,
                  child: Column(children: [
                    TextFieldWidget(
                      controller: _emailController,
                      icon: Icons.email_outlined,
                      hintText: "Email",
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      onTap: null,
                    ),
                    _commonServices.sizedBox(h: 8),
                    TextFieldWidget(
                      keyboardType: TextInputType.text,
                      controller: _passwordController,
                      obscureText: !_visible,
                      icon: Icons.key_sharp,
                      suffixIcon: _visible
                          ? Icons.remove_red_eye_outlined
                          : Icons.visibility_off,
                      hintText: "Password",
                      onTap: () {
                        setState(() {
                          _visible = !_visible;
                        });
                      },
                    ),
                    _commonServices.sizedBox(h: 10),
                    CustomFlatButton(
                      label: "Login",
                      labelStyle: const TextStyle(fontSize: 20),
                      onPressed: () {
                        if (_loginKey.currentState!.validate()) {
                          loginUser();
                        } else {}
                      },
                      borderRadius: 30,
                    ),
                  ]),
                ),
              ),
            _commonServices.sizedBox(h: 10),
            ListTile(
              tileColor:
                  _auth == Auth.login ? Globals.bgColor : Globals.greyBgColor,
              title: const Text(
                'Register',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Radio(
                value: Auth.register,
                activeColor: Globals.secondaryColor,
                groupValue: _auth,
                onChanged: (Auth? value) {
                  setState(() {
                    _auth = value!;
                  });
                },
              ),
            ),
            if (_auth == Auth.register)
              Container(
                padding: const EdgeInsets.all(8),
                color: Globals.bgColor,
                child: Form(
                  key: _registerKey,
                  child: Column(children: [
                    TextFieldWidget(
                      controller: _nameController,
                      icon: Icons.person,
                      hintText: "Full Name",
                      obscureText: false,
                      keyboardType: TextInputType.name,
                      onTap: null,
                    ),
                    _commonServices.sizedBox(h: 8),
                    TextFieldWidget(
                      controller: _emailController,
                      icon: Icons.email_outlined,
                      hintText: "Email",
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      onTap: null,
                    ),
                    _commonServices.sizedBox(h: 8),
                    TextFieldWidget(
                      keyboardType: TextInputType.text,
                      controller: _passwordController,
                      obscureText: !_visible,
                      icon: Icons.key_sharp,
                      suffixIcon: _visible
                          ? Icons.remove_red_eye_outlined
                          : Icons.visibility_off,
                      hintText: "Password",
                      onTap: () {
                        setState(() {
                          _visible = !_visible;
                        });
                      },
                    ),
                    _commonServices.sizedBox(h: 10),
                    CustomFlatButton(
                      label: "Register",
                      labelStyle: const TextStyle(fontSize: 20),
                      onPressed: () {
                        if (_registerKey.currentState!.validate()) {
                          registerUser();
                        } else {}
                      },
                      borderRadius: 30,
                    ),
                  ]),
                ),
              ),
          ],
        ),
      )),
    );
  }
}
