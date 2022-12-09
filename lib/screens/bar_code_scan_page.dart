import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../util/colors.dart';
import '../util/drawer.dart';
import '../util/homeBottomNav.dart';

class BarCodeScanPage extends StatefulWidget {
  const BarCodeScanPage({Key? key}) : super(key: key);

  @override
  State<BarCodeScanPage> createState() => _BarCodeScanPageState();
}

class _BarCodeScanPageState extends State<BarCodeScanPage> {
  GlobalKey<ScaffoldState> key = GlobalKey();
  final GlobalKey qrKey =
      GlobalKey(debugLabel: 'QR'); ///////// this package is for QR Scanar

  Barcode? result;
  QRViewController? controller;

  String tokenMsg = 'Remaining Token';
  String tokenCount = '20';
  IconData icon = Icons.check;
  Color tokenMsgColor = kBlack;
  Color iconColor = kGreen;
  bool isFlash = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: key,
        endDrawer: const DrawerScreen(),
        bottomNavigationBar: bottomNav(context, 0),
        backgroundColor: kWhite,
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    'assets/scan_page_logo.png',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.029,
                        horizontal: MediaQuery.of(context).size.width * 0.074),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //const SizedBox(width: 20),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: kWhite,
                            size: 18,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // Scaffold.of(context).openDrawer();
                            key.currentState!.openEndDrawer();
                          },
                          child: const Icon(
                            Icons.menu,
                            color: Color(0xff967c1d),
                          ),
                        ),
                        //   const SizedBox(width: 20),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.25),
                  Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.025,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Ride : Roller Coaster',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 18,
                            color: kBlack,
                            fontWeight: FontWeight.w600),
                      )),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.3),
                  Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.03,
                      ),
                      //   alignment: Alignment.centerLeft,
                      child: Text(
                        'Token : 3',
                        style: TextStyle(
                            fontSize: 18,
                            color: kBlack,
                            fontWeight: FontWeight.w600),
                      )),
                ],
              ),
              const SizedBox(height: 25),
              Text(
                result == null
                    ? 'Please scan the code'
                    : 'Scanned: ${result!.code}\nScan Format: ${result!.format}',
                style: const TextStyle(fontSize: 16),
              ),
              Container(
                // width: double.infinity,
                //height: MediaQuery.of(context).size.height * 0.4,
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.07),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: kColor,
                ),
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.03,
                  left: MediaQuery.of(context).size.width * 0.07,
                  right: MediaQuery.of(context).size.width * 0.07,
                  bottom: MediaQuery.of(context).size.width * 0.03,
                ),
                child: /*ElevatedButton(onPressed: (){
                  qrCode();
                }, child: const Text('Scan QR Code'))*/
                    Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        controller!.toggleFlash();
                        setState(() {
                          isFlash = !isFlash;
                        });
                      },
                      child: Icon(isFlash ? Icons.flash_on : Icons.flash_off),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      padding: const EdgeInsets.all(15),
                      color: kWhite,
                      child: QRView(
                        key: qrKey,
                        cameraFacing: CameraFacing.back,
                        onQRViewCreated: _onQRViewCreated,
                        overlay: QrScannerOverlayShape(
                            borderColor: Colors.red,
                            borderRadius: 10,
                            borderLength: 10,
                            borderWidth: 6,
                            cutOutSize:
                                MediaQuery.of(context).size.width * 0.6),
                        onPermissionSet: (ctrl, p) =>
                            _onPermissionSet(context, ctrl, p),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {
                              controller!.resumeCamera();
                            },
                            child: const CircleAvatar(
                                radius: 16,
                                backgroundColor: Color(0xffc2b27a),
                                child: Icon(
                                  Icons.play_arrow,
                                  color: Colors.red,
                                ))),
                        const SizedBox(width: 10),
                        InkWell(
                            onTap: () {
                              controller!.pauseCamera();
                              Timer(const Duration(milliseconds: 1300), () {
                                showDetailedDialog();
                                setState(() {
                                  result = null;
                                });
                              });
                            },
                            child: const CircleAvatar(
                                radius: 16,
                                backgroundColor: Color(0xffc2b27a),
                                child: Icon(
                                  Icons.stop,
                                  color: Colors.red,
                                ))),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /* qrCode()async{

    try{
      var code = await FlutterBarcodeScanner.getBarcodeStreamReceiver('#ff6666', 'cancel', true, ScanMode.QR);
      if(!mounted)return;

      print('Scanned code ==== $code');

    }catch(e){
      print(e);
      print('Error while scanning qr code');
    }

  }*/

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      Timer(const Duration(seconds: 3), () {
        setState(() {
          result = scanData;
          if (result != null) {
            controller.pauseCamera();
          }
        });
        print('Result:     ${result!.code}');
        //showMessage(context, "${result!.code}", kGreen);
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    print('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  showDetailedDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, StateSetter setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: const Color(0xFFdbcc9a),
            contentPadding: const EdgeInsets.all(20),
            content: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color(0xFFebdabc),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                      radius: 30,
                      backgroundColor: iconColor,
                      child: Icon(
                        icon,
                        size: 35,
                        color: kWhite,
                      )),
                  Text(
                    'Permission Granted',
                    style: TextStyle(
                        fontSize: 20,
                        color: kBlack,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.16,
                    child: Stack(
                      alignment: Alignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Positioned(
                            top: 13,
                            child: Image.asset(
                              'assets/alert_dialog.png',
                              width: MediaQuery.of(context).size.width * 0.4,
                            )),
                        Positioned(
                          //bottom: ,
                          left: MediaQuery.of(context).size.width * 0.4,
                          top: 0,
                          child: CircleAvatar(
                            radius: 32,
                            backgroundColor: const Color(0xFFbcac54),
                            child: CircleAvatar(
                              radius: 22,
                              backgroundColor: const Color(0xFFebdabc),
                              child: Text(
                                tokenCount,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: kBlack,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Text(
                            tokenMsg,
                            style:
                                TextStyle(fontSize: 18, color: tokenMsgColor),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    //margin: EdgeInsets.symmetric(horizontal: 25),
                    height: 15,
                    decoration: const BoxDecoration(
                      color: Color(0xFFbcac54),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        if (tokenCount == '20') {
                          setState(() {
                            tokenCount = '1';
                            tokenMsg = 'Insufficient Tokens';
                            icon = Icons.close;
                            tokenMsgColor = kRed;
                            iconColor = kRed;
                          });
                        } else {
                          Navigator.pop(context);
                          setState(() {
                            tokenCount = '20';
                            tokenMsg = 'Remaining Token';
                            icon = Icons.check;
                            tokenMsgColor = kBlack;
                            iconColor = kGreen;
                          });
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 2,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                            color: const Color(0xFFac8b4b),
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          'CLOSE',
                          style: TextStyle(
                              fontSize: 16,
                              color: kWhite,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
