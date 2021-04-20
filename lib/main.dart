import 'package:flutter/material.dart';
import 'package:sharile_v2/filePicker/sharile_file_picker.dart';
import 'package:sharile_v2/screens/home_screen.dart';
import 'package:sharile_v2/screens/receive_screen.dart';
import 'package:sharile_v2/screens/send_screen.dart';

void main() => runApp(SharileApp());

class SharileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        SendScreen.id: (context) => SendScreen(),
        ReceiveScreen.id: (context) => ReceiveScreen(),
        SharileFilePicker.id:(context) => SharileFilePicker(),
      },
    );
  }
}
