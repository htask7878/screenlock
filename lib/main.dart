import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';

import 'first.dart';

void main() {
  runApp(const MaterialApp(
    home: home(),
  ));
}

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  bool config = true;
  String str = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenLock(
        digits: 4,
        correctString: str,
        confirmation: config,
        confirmTitle: Text("Repeat your password"),
        didConfirmed: (matchedText) {
          print(matchedText);
          setState(() {
            config = false;
            str = matchedText;
          });
        },
        secretsConfig: SecretsConfig(secretConfig: SecretConfig(
          borderColor: Colors.black12,
            build: (context, {required config, required enabled}) {
              return SizedBox(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: enabled
                        ? config.enabledColor
                        : config.disabledColor,
                    border: Border.all(
                      width: config.borderSize,
                      color: config.borderColor,
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                  width: config.width,
                  height: config.height,
                ),
                width: config.width,
                height: config.height,
              );
            },
          enabledColor: Colors.green,
          disabledColor: Colors.black12
        )),
        keyPadConfig: KeyPadConfig(
            buttonConfig: StyledInputConfig(
                buttonStyle: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.grey[400]),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent)))),
        title: config ? Text("set your password") : Text("Enter your password"),
        didUnlocked: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return first();
            },
          ));
        },
      ),
    );
  }
}
