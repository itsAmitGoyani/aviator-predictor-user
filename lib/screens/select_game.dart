import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:predictor_user_app/screens/aviator_screen.dart';
import 'package:predictor_user_app/screens/custom_checkbox.dart';
import 'package:predictor_user_app/screens/lacky_jet_screen.dart';

class SelectGame extends StatefulWidget {
  const SelectGame({Key? key}) : super(key: key);

  @override
  State<SelectGame> createState() => _SelectGameState();
}

class _SelectGameState extends State<SelectGame> {
  String name = "Lucky Jet";
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Select",
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(child: SizedBox(),),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF67DF65),
                  // backgroundColor:
                  //     buttonColor ?? ThemeColor.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (BuildContext context) => const LackyJetScreen(),
                    ),
                  );
                },
                child: const Center(
                  child: Text(
                    "Lucky Jet",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF67DF65),
                  // backgroundColor:
                  //     buttonColor ?? ThemeColor.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (BuildContext context) =>  const AviatorScreen(),
                    ),
                  );
                },
                child: const Center(
                  child: Text(
                    "Aviator",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(child: SizedBox(),),
            ],
          ),
        ),
      ),
    );
  }
}
