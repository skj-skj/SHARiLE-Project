import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharile_v2/components/route_animation.dart';
import 'package:sharile_v2/components/widgets.dart';
import 'package:sharile_v2/filePicker/sharile_file_picker.dart';
import 'package:sharile_v2/screens/receive_screen.dart';
import 'package:sharile_v2/screens/send_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.view_headline),
          title: Text('SHARiLE'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RoundedButton(
                label: 'Send Files',
                onPressed: () async {
                  SendScreen.sendServer.startServer(port: 7777);
                  print('server Started');
                  Map<String, String> result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SharileFilePicker(),
                    ),
                  );

                  Navigator.of(context).push(
                    screenRoute(
                      screen: SendScreen(
                        selectedFileResult: result,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 100.0,
                width: double.infinity,
              ),
              RoundedButton(
                label: 'Receive File',
                onPressed: () {
                  ReceiveScreen.receiveServer.startServer(port: 9999);
                  print('server Started');
                  Navigator.of(context)
                      .push(screenRoute(screen: ReceiveScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Route _sendScreenRoute() {
//  return PageRouteBuilder(
//    pageBuilder: (context, animation, secondaryAnimation) => SendScreen(),
//    transitionsBuilder: (context, animation, secondaryAnimation, child) {
//      Animation<double> opacityAnimation =
//          Tween(begin: 0.5, end: 1.0).animate(animation);
//      return FadeTransition(
//        opacity: opacityAnimation,
//        child: child,
//      );
//    },
//  );
//}
