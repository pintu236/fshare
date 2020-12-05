import 'package:flutter/material.dart';
import 'package:fshare/utils/colors.dart';
import 'package:fshare/view/ui/homescreen.dart';

void main() => runApp(FShareApp());

class FShareApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FShare',
      theme: ThemeData(
          fontFamily: 'Roboto',
          primaryColor: primaryColor,
          scaffoldBackgroundColor: Colors.white),
      home: HomeScreen(),
    );
  }
}
