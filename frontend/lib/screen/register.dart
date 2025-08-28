import 'package:flutter/material.dart';
import 'package:frontend/widgets/button.dart';
import 'package:frontend/widgets/height.dart';
import 'package:frontend/widgets/textInpuField.dart';
import 'package:frontend/widgets/textShow.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController conformPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    if (value.length < 6) {
      return 'Username must be at least 6 characters';
    }
    return null;
  }

  //password validate
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateConformPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    if (value != passwordController.text) {
      return 'Password not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
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
              TextInPutField(
                text: "Conform Password",
                controller: conformPasswordController,
                radius: 10,
                validator: _validateConformPassword,
              ),
              Height(height: 0.05),
              Button(
                text: "Register",
                radius: 10,
                onclick: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                  }
                },
              ),
              Height(height: 0.05),
              Row(children: [
                TextShow(text: "you want to login?"),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/login");
                    },
                    child: TextShow(text: "Login"))
              ])
            ],
          ),
        ),
      ),
    );
  }
}
