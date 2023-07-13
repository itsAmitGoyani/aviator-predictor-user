import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:predictor_user_app/screens/select_game.dart';
import 'package:predictor_user_app/services/toast_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login",style: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.w700),),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    children: [
                      Expanded(child: SizedBox()),
                      Text("Aviator Predictor",style: TextStyle(fontSize: 24,color: Colors.white,fontWeight: FontWeight.w700),),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: emailController,
                        validator: (val){
                          if(val == null){
                            return "Please enter email.";
                          }else if (val.isEmpty){
                            return "Please enter email.";
                          }else {
                            return null;
                          }

                        },
                        decoration: const InputDecoration(
                          labelText: "Email",
                          hintText: "Email",
                          isDense: true,
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(width: 1,color: Colors.white),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.red, width: 1),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(width: 1,color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(width: 1,color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(width: 1,color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24,),
                      TextFormField(
                        controller: passwordController,
                        validator: (val){
                          if(val == null){
                            return "Please enter password.";
                          }else if (val.isEmpty){
                            return "Please enter password.";
                          }else {
                            return null;
                          }

                        },
                        decoration: const InputDecoration(
                          labelText: "Password",
                          hintText: "Password",
                          isDense: true,
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(width: 1,color: Colors.white),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.red, width: 1),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(width: 1,color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(width: 1,color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(width: 1,color: Colors.white),
                          ),
                        ),
                      ),
                      Expanded(child: SizedBox()),

                    ],
                  ),
                ),
              ),
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
                  if (_formKey.currentState!.validate()) {
                    try {
                      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                      );
                      Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                          builder: (BuildContext context) => const SelectGame(),
                        ),
                      );
                      showToast(context, text: "User successfully login.",);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        showErrorToast(context, text: "No user found for that email.",);
                      } else if (e.code == 'wrong-password') {
                        showErrorToast(context, text: "Wrong password provided for that user.",);
                      }else {
                        showErrorToast(context, text: e.message ?? "Something Went Wrong.",);
                      }

                    }

                  }

                },
                child: const Center(
                  child: Text(
                    "CONTINUE",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
