import 'dart:async';
import 'package:caffe_app/constants/gaps.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../constants/sizes.dart';
import '../../home/views/home_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool isEmailVerified = false;
  Timer? timer;
  int remainingTime = 60;

  @override
  void initState() {
    super.initState();
    auth.currentUser?.sendEmailVerification();
    timer =
        Timer.periodic(const Duration(seconds: 1), (_) => checkEmailVerified());
  }

  checkEmailVerified() async {
    await auth.currentUser?.reload();

    setState(() {
      remainingTime -= 1;
    });

    if (remainingTime <= 0) {
      timer?.cancel();

      try {
        await firestore.collection('users').doc(auth.currentUser?.uid).delete();
        await auth.currentUser?.delete();
        Navigator.pop(context);
      } catch (e) {
        print('Error deleting user: $e');
      }

      return;
    }

    setState(() {
      isEmailVerified = auth.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      print(isEmailVerified);

      timer?.cancel();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ));
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v40,
              const Text(
                '이메일 인증',
                style: TextStyle(
                  fontSize: Sizes.size28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '${auth.currentUser?.email}로\n전송된 이메일을 확인해주세요.',
                style: const TextStyle(
                  fontSize: Sizes.size16,
                  color: Colors.black54,
                ),
              ),
              Gaps.v60,
              Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Gaps.v60,
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        '인증이 완료되면 화면이 자동으로 이동합니다.',
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Gaps.v8,
                    Center(
                      child: Text(
                        '남은 시간 : $remainingTime',
                        style: const TextStyle(
                          fontSize: Sizes.size16,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
