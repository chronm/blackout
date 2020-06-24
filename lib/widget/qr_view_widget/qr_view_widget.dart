import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../main.dart';
import '../../models/home.dart';

typedef QRViewCallback = void Function(Home home);

class QRViewWidget extends StatefulWidget {
  final QRViewCallback callback;

  const QRViewWidget({
    Key key,
    @required this.callback,
  }) : super(key: key);

  @override
  _QRViewWidgetState createState() => _QRViewWidgetState();
}

class _QRViewWidgetState extends State<QRViewWidget> {
  QRViewController _controller;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');

  void _onQRViewCreated(QRViewController controller) {
    _controller = controller;
    controller.scannedDataStream.listen((scanData) {
      widget.callback(Home.fromJson(scanData));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (emulator) {
      return FlatButton(
        child: const Text("Click here to emulate captured qr code"),
        onPressed: () => widget.callback(Home.fromJson("{\"id\": \"testHomeId\", \"name\": \"MyHome\"}")),
      );
    } else {
      return QRView(
        onQRViewCreated: _onQRViewCreated,
        key: _qrKey,
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
