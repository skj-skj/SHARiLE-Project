// Next Screens are Send & Receive Screen both have dame layout

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sharile_v2/brain/server_brain.dart';
import 'package:sharile_v2/components/widgets.dart';

class NextScreen extends StatelessWidget {
  const NextScreen({@required this.server});

  final ServerBrain server;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print('Pressed Back');
        server.stopServer();
        print('Server Stop');
        print('Temp File Cleared');
        Navigator.of(context).pop();
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('SHARiLE'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                ),
                ScreenTextCardWidget(
                  textLabel: 'Type:',
                  cardLabel: server.getIpAddress(),
                ),
                ScreenTextStyle(
                  label: 'OR',
                ),
                ScreenTextQrImageCardWidget(
                  textLabel: 'Scan:',
                  cardQrImage: QrImage(
                    data: server.getIpAddress(),
                    version: QrVersions.auto,
                    size: 256.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
