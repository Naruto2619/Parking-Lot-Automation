import 'package:flutter/material.dart';
import 'package:upi_india/upi_india.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  UpiIndia _upiIndia = UpiIndia();
  UpiApp app = UpiApp.googlePay;
  @override
  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: "manjulapt7869@oksbi",
      receiverName: 'Manjula',
      transactionRefId: 'TestingUpiIndiaPlugin',
      transactionNote: 'testing app',
      amount: 1.00,
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black),
      body: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(120),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: const Text("Just a min"),
            ),
            FutureBuilder(
                future: initiateTransaction(app),
                builder: ((context, snapshot) {
                  if (snapshot.hasError) {
                    switch (snapshot.error.runtimeType) {
                      case UpiIndiaAppNotInstalledException:
                        print("Requested app not installed on device");
                        break;
                      case UpiIndiaUserCancelledException:
                        print("You cancelled the transaction");
                        break;
                      case UpiIndiaNullResponseException:
                        print("Requested app didn't return any response");
                        break;
                      case UpiIndiaInvalidParametersException:
                        print("Requested app cannot handle the transaction");
                        break;
                      default:
                        print("An Unknown error has occurred");
                        break;
                    }
                    return Text("Error has Occured");
                  } else {
                    if (snapshot.hasData) {
                      print(snapshot.data);
                    }
                  }
                  return Container();
                }))
          ],
        ),
      ),
    );
  }
}
