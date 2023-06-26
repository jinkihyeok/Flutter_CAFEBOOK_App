import 'package:caffe_app/constants/gaps.dart';
import 'package:caffe_app/constants/sizes.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: const SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v80,
            Text(
              'SENECA',
              style: TextStyle(
                fontSize: Sizes.size32,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            Gaps.v20,
            Text('느낌있는 멘트가',
                style: TextStyle(
                  fontSize: Sizes.size28,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                )),
            Text('들어갈 자리',
                style: TextStyle(
                  fontSize: Sizes.size28,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                )),
          ],
        )),
      ),
    );
  }
}
