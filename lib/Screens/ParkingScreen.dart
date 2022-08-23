import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Providers/user_provider.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

class ParkingScreen extends StatefulWidget {
  const ParkingScreen({Key? key}) : super(key: key);

  @override
  State<ParkingScreen> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen> {
  UserOptions user = new UserOptions();
  List lst = [];
  late Map args;
  @override
  void didChangeDependencies() async {
    args = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{})
        as Map;
    super.didChangeDependencies();
    lst = await user.getSlots();
    setState(() {
      lst;
    });

    // print(args);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        backgroundColor: Colors.black87,
        title: Text("Slot"),
      ),
      body: Container(
          width: double.infinity,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  "Slot No : " + args['slot'],
                  style:
                      GoogleFonts.bebasNeue(color: Colors.white, fontSize: 40),
                ),
              ),
              Container(
                height: 500,
                width: 280,
                child: lst.isEmpty
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : GridView.builder(
                        itemCount: 24,
                        itemBuilder: (context, index) {
                          if (lst[index] == 1) {
                            return Container(
                              child: Image.asset('images/cer.png'),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white)),
                            );
                          } else {
                            return Container(
                              child: Image.asset('images/free.png'),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white)),
                            );
                          }
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 3.4,
                          crossAxisCount: 2,
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ConfirmationSlider(
                    text: "Slide To Exit",
                    height: 54,
                    width: 300,
                    foregroundColor: Colors.black,
                    iconColor: Colors.white,
                    onConfirmation: (() => {
                          Navigator.of(context).pushNamed('payment',
                              arguments: {...args, 'what': 'exit'})
                        })),
              ),
            ],
          )),
    );
  }
}
