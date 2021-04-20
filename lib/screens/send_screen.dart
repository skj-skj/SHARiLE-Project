import 'package:flutter/material.dart';
import 'package:sharile_v2/components/next_screen_widget.dart';
import 'package:sharile_v2/brain/server_brain.dart';

class SendScreen extends StatelessWidget {
  static const String id = 'Send_screen';
  static final sendServer = ServerBrain();
  final Map<String,String> selectedFileResult;

  SendScreen({this.selectedFileResult});
  @override
  Widget build(BuildContext context) {
//    sendServer.sendFilePick();
print("In Send Screen");
    sendServer.sendFile(selectedFileResult: selectedFileResult);
    return NextScreen(server: sendServer);
  }
}
