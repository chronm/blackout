import 'package:Blackout/main.dart';
import 'package:Blackout/models/home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

typedef void QRViewCallback(Home home);

class QRViewWidget extends StatefulWidget {
  final QRViewCallback callback;

  QRViewWidget({Key key, this.callback}) : super(key: key);

  @override
  _QRViewWidgetState createState() => _QRViewWidgetState();
}

class _QRViewWidgetState extends State<QRViewWidget> {
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      widget.callback(Home.fromJson(scanData));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isEmulator) {
      return FlatButton(
        child: Text("Click here to emulate captured qr code"),
        onPressed: () => widget.callback(Home.fromJson("{\"id\": \"testHomeId\", \"name\": \"MyHome\"}")),
      );
    } else {
      return QRView(
        onQRViewCreated: _onQRViewCreated,
        key: qrKey,
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

}