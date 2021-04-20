import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

// Rounded Button at Home Screen
class RoundedButton extends StatelessWidget {
  RoundedButton({@required this.label, this.onPressed});
  final String label;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6.0,
      color: Color(0xff2196f3),
      borderRadius: BorderRadius.all(Radius.circular(22.0)),
//      shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.all(Radius.circular(22.0))),
      child: FlatButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
            ),
          ),
        ),
        //Color: Blue500
//        color: Color(0xff2196f3),
//        shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.all(Radius.circular(22.0))),
      ),
    );
  }
}

//Text + QR Image Card Widget
class ScreenTextQrImageCardWidget extends StatelessWidget {
  ScreenTextQrImageCardWidget(
      {@required this.textLabel,
      this.textSize = 18.75,
      @required this.cardQrImage,
      this.cardImageSize = 30.0});
  final String textLabel;
  final QrImage cardQrImage;
  final double textSize;
  final double cardImageSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ScreenTextStyle(
          label: textLabel,
          size: textSize,
        ),
        Card(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                child: cardQrImage,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Text + Text Card Widget
class ScreenTextCardWidget extends StatelessWidget {
  ScreenTextCardWidget(
      {@required this.textLabel,
      this.textSize = 18.75,
      @required this.cardLabel,
      this.cardLabelSize = 30.0});
  final String textLabel;
  final String cardLabel;
  final double textSize;
  final double cardLabelSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ScreenTextStyle(
          label: textLabel,
          size: textSize,
        ),
        Card(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                child: ScreenTextStyle(
                  label: cardLabel,
                  size: cardLabelSize,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//Text Style Widget
class ScreenTextStyle extends StatelessWidget {
  ScreenTextStyle({@required this.label, this.size = 18.75});
  final String label;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontFamily: 'ShareTechMono',
        fontSize: size,
      ),
    );
  }
}
