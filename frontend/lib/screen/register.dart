import 'package:flutter/material.dart';
import 'package:frontend/const/color.dart';
import 'package:frontend/const/constant.dart';
import 'package:frontend/const/size.dart';
import 'package:frontend/logic/service.dart';
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

  void register(BuildContext context) async {
    String response = await ApiService.registerUser(
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
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text("Register"),
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
                TextInPutField(
                  text: "Conform Password",
                  controller: conformPasswordController,
                  radius: 10,
                  validator: _validateConformPassword,
                  width: inputBoxWidth,
                  prefixIcon: Icons.lock,
                ),
                Height(height: 0.02),
                Button(
                  foregroundColor: Colors.white,
                  backgroundColor: Color.fromARGB(255, 64, 0, 255),
                  text: "Register",
                  radius: 10,
                  onclick: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      register(context);
                    }
                  },
                ),
                Height(height: 0.05),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  TextShow(text: "Do you want to login?"),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/login");
                      },
                      child: TextShow(
                        text: "Login",
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
