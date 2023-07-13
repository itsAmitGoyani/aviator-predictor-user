
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:predictor_user_app/screens/login_screen.dart';
import 'package:predictor_user_app/screens/select_game.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> navigate(BuildContext context) async {
    if(FirebaseAuth.instance.currentUser != null){
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (BuildContext context) => const SelectGame(),
        ),
      );
    }else {
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (BuildContext context) => const LoginScreen(),
        ),
      );
    }


  }
  @override
  void initState() {
    navigate(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(toolbarHeight: 0.0),
      body: const Center(
        child: Text(
          "Predictor User App",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 34.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
