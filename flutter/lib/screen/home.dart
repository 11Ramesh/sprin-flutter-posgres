import 'package:flutter/material.dart';
import 'package:frontend/const/color.dart';
import 'package:frontend/const/size.dart';
import 'package:frontend/widgets/height.dart';
import 'package:frontend/widgets/textShow.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? accessToken;
  String? refreshToken;

  Future<Map<String, String>> getTokens() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'accessToken': prefs.getString('accessToken') ?? '',
      'refreshToken': prefs.getString('refreshToken') ?? '',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: backgroundColor,
        ),
        body: FutureBuilder<Map<String, String>>(
          future: getTokens(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else {
              final tokens = snapshot.data!;
              return Container(
                height: ScreenUtil.screenHeight,
                decoration: BoxDecoration(gradient: bgGredient),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Height(height: 0.05),
                      Row(
                        children: [
                          TextShow(
                            text: "Your access token is: ",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                              child:
                                  TextShow(text: "${tokens['accessToken']}")),
                        ],
                      ),
                      Height(height: 0.05),
                      Row(
                        children: [
                          TextShow(
                            text: "Your refresh token is: ",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                              child:
                                  TextShow(text: "${tokens['refreshToken']}")),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ));
  }
}
