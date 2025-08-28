import 'package:flutter/material.dart';
import 'package:frontend/const/size.dart';

class Width extends StatelessWidget {
  double width;
  Width({required this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenUtil.screenWidth * width,
    );
  }
}
