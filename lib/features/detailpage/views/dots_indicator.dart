import 'package:flutter/material.dart';

class DotsIndicator extends StatelessWidget {
  final int position;
  final int numberOfDot;

  const DotsIndicator({super.key, required this.position, required this.numberOfDot});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(numberOfDot, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 2.0),
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == position ? Colors.white : Colors.grey,
          ),
        );
      }),
    );
  }
}