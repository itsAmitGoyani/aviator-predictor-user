import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:predictor_user_app/models/sequence.dart';
import 'package:predictor_user_app/models/user_lacky_jet_model.dart';
import 'package:predictor_user_app/screens/login_screen.dart';
import 'package:predictor_user_app/services/toast_service.dart';

class LackyJetScreen extends StatefulWidget {
  const LackyJetScreen({Key? key,}) : super(key: key);

  @override
  State<LackyJetScreen> createState() => _LackyJetScreenState();
}

class _LackyJetScreenState extends State<LackyJetScreen> {
  CollectionReference luckyJet =
      FirebaseFirestore.instance.collection('lucky-jet');
  CollectionReference userLuckyJet =
      FirebaseFirestore.instance.collection('user-luckyjet');
  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (BuildContext context) => const LoginScreen(),
        ),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lacky Jet",
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: FirebaseAuth.instance.currentUser != null
          ? StreamBuilder<QuerySnapshot<Object?>>(
              //Fetching data from the documentId specified of th e student
              stream: luckyJet.orderBy('timestamp').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                //Error Handling conditions
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      snapshot.error.toString(),
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                          fontWeight: FontWeight.w500),
                    ),
                  );
                } else if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }else  {
                  final seqDataList = snapshot.data!.docs
                      .map((e) => Sequence(
                          id: e.id,
                          seq: SequenceData.fromJson(
                                  e.data() as Map<String, dynamic>)
                              .seq))
                      .toList();
                  if(seqDataList.isEmpty){
                    return Center(
                      child: Text(
                        "Data Not Found.",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.w500),
                      ),
                    );
                  } else {
                    return StreamBuilder<QuerySnapshot<Object?>>(
                      //Fetching data from the documentId specified of the student
                      stream:  userLuckyJet.snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot<Object?>> userData) {
                        if (userData.hasError) {
                          return Center(
                            child: Text(
                              userData.error.toString(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500),
                            ),
                          );
                        } else if(!userData.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else  {
                          final List<UserLackyJetModel> userList = userData
                              .data!.docs
                              .map((e) => UserLackyJetModel(
                            sequenceId: UserLackyJetDataModel.fromJson(
                                e.data() as Map<String, dynamic>)
                                .sequenceId,
                            userId: UserLackyJetDataModel.fromJson(
                                e.data() as Map<String, dynamic>)
                                .userId,
                            id: e.id,
                          ))
                              .toList();
                          if(userList.any((element) => element.userId == FirebaseAuth.instance.currentUser?.uid)){
                            final userModel = userList.firstWhere((element) => element.userId == FirebaseAuth.instance.currentUser?.uid);
                            final seqModel = seqDataList.firstWhere((element) => element.id == userModel.sequenceId,orElse: () => Sequence(seq: seqDataList[0].seq,id: seqDataList[0].id),);
                            print("abc");
                            return PredictWidget(
                              userModel: userModel,
                              seqDataList: seqDataList,
                              seqModel: seqModel,
                            );
                          } else {
                            userLuckyJet
                                .add({
                              'sequence_id': seqDataList[0].id,
                              'user_id': FirebaseAuth.instance.currentUser?.uid,
                            })
                                .then((value) {
                              final userModel = userList.firstWhere((element) => element.userId == FirebaseAuth.instance.currentUser?.uid);
                              final seqModel = seqDataList.firstWhere((element) => element.id == userModel.sequenceId,orElse: () => Sequence(seq: seqDataList[0].seq,id: seqDataList[0].id),);
                              return PredictWidget(
                                userModel: userModel,
                                seqDataList: seqDataList,
                                seqModel: seqModel,
                              );
                            },)
                                .catchError(
                                    (error) {
                                  return Center(
                                    child: Text(
                                      userData.error.toString(),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.red,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  );
                                });
                            return SizedBox();


                          }
                        }
                      },
                    );
                  }

                }
              },
            )
          : Center(
              child: Text(
                "Session Expired!",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.w500),
              ),
            ),
    );
  }
}

class PredictWidget extends StatefulWidget {
  final Sequence seqModel;
  final UserLackyJetModel userModel;
  final List<Sequence> seqDataList;
  const PredictWidget(
      {Key? key,
      required this.seqModel,
      required this.userModel,
      required this.seqDataList})
      : super(key: key);

  @override
  State<PredictWidget> createState() => _PredictWidgetState();
}

class _PredictWidgetState extends State<PredictWidget> {
  String? seqValue;
  bool showButton = false;
  CollectionReference userLuckyJet =
      FirebaseFirestore.instance.collection('user-luckyjet');
  Future<void> setTime () async {
    Future.delayed(const Duration(seconds: 10)).then((value) async {
      setState(() {
        showButton = true;
      });
    });
  }
  @override
  void initState() {
    seqValue = widget.seqModel.seq.toString();
    setTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(child: SizedBox(),),
        Center(
          child: Container(
            height: 260,
            width: 260,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border.all(
                  color: Colors.white,
                  width: 1.8,
                )),
            padding: EdgeInsets.all(18),
            child: Container(
              height: 240,
              width: 240,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  border: Border.all(
                    color: Colors.white,
                    width: 1.8,
                  )),
              child: Center(
                child: showButton ? Text(
                  seqValue ?? widget.seqModel.seq.toString(),
                  style: TextStyle(
                      fontSize: 36,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ) : const Center(child: CircularProgressIndicator(),),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Expanded(child: SizedBox()),
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

                setState(() {
                  final index = widget.seqDataList.indexWhere(
                        (element) =>
                    element.seq ==
                        double.parse(
                          seqValue.toString(),
                        ),
                  );
                  seqValue = widget.seqDataList[index == (widget.seqDataList.length -1) ? 0 : index + 1].seq.toString();
                  showButton = false;
                  setTime();
                });
                final updatedIndex = widget.seqDataList.indexWhere(
                      (element) =>
                  element.seq ==
                      double.parse(
                        seqValue.toString(),
                      ),
                );
                userLuckyJet
                    .doc(widget.userModel.id)
                    .update({
                  'sequence_id': widget.seqDataList[updatedIndex].id,
                  'user_id': widget.userModel.userId,
                })
                    .catchError(
                      (error) {
                    print("error api ${error.toString()}");
                    showErrorToast(
                      context,
                      text: error.toString(),
                    );
                  },
                );
              },
              child: Center(
                child: Text(
                  "Next".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(child: SizedBox()),
          ],
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }
}
