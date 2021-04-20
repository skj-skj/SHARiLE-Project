import 'package:flutter/material.dart';
import 'package:sharile_v2/components/next_screen_widget.dart';
import 'package:sharile_v2/brain/server_brain.dart';

class ReceiveScreen extends StatelessWidget {
  static const String id = 'Receive_screen';
  static final receiveServer = ServerBrain();

  @override
  Widget build(BuildContext context) {
    receiveServer.uploadFile();
    return NextScreen(server: receiveServer);
  }
}
