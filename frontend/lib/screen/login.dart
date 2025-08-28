import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextInPutField(
                text: "Username",
                controller: usernameController,
                radius: 10,
                validator: _validateUsername,
              ),
              Height(height: 0.05),
              TextInPutField(
                text: "Password",
                controller: passwordController,
                radius: 10,
                validator: _validatePassword,
              ),
              Height(height: 0.05),
              Button(
                text: "Login",
                radius: 10,
                onclick: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                  }
                },
              ),
              Row(children: [
                TextShow(text: "you want to register"),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/register");
                    },
                    child: TextShow(text: "Register"))
              ])
            ],
          ),
        ),
      ),
    );
  }
}
