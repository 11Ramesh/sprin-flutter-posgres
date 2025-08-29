import 'package:flutter/material.dart';
import 'package:frontend/const/color.dart';
import 'package:frontend/const/constant.dart';
import 'package:frontend/const/size.dart';
import 'package:frontend/logic/service.dart';
import 'package:frontend/widgets/button.dart';
import 'package:frontend/widgets/height.dart';
import 'package:frontend/widgets/textInpuField.dart';
import 'package:frontend/widgets/textShow.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  //username validate
  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  //password validate
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  void login(BuildContext context) async {
    String response = await ApiService.loginUser(
        usernameController.text, passwordController.text);
    if (response == "sucsess") {
      Navigator.pushNamed(context, "/home");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: TextShow(
          text: response,
          alignment: TextAlign.center,
        ),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red[300],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text("Login"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Container(
        height: ScreenUtil.screenHeight,
        decoration: BoxDecoration(gradient: bgGredient),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Height(height: 0.05),
                TextInPutField(
                  text: "Username",
                  controller: usernameController,
                  radius: 10,
                  validator: _validateUsername,
                  width: inputBoxWidth,
                  prefixIcon: Icons.person,
                ),
                Height(height: 0.02),
                TextInPutField(
                  text: "Password",
                  controller: passwordController,
                  radius: 10,
                  validator: _validatePassword,
                  width: inputBoxWidth,
                  prefixIcon: Icons.lock,
                ),
                Height(height: 0.02),
                Button(
                  foregroundColor: Colors.white,
                  backgroundColor: Color.fromARGB(255, 64, 0, 255),
                  text: "Login",
                  radius: 10,
                  onclick: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      login(context);
                    }
                  },
                ),
                Height(height: 0.05),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  TextShow(text: "Don't have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/register");
                      },
                      child: TextShow(
                        text: "Register",
                        color: Color.fromARGB(255, 64, 0, 255),
                      ))
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
