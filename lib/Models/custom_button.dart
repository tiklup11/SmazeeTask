import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {required this.dimColor, required this.btnText, required this.isLoading});
  final bool isLoading;
  final String btnText;
  final bool dimColor;

  @override
  Widget build(BuildContext context) {
    var scrWidth = MediaQuery.of(context).size.width;
    var scrHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      width: scrWidth * 0.85,
      height: 75,
      decoration: BoxDecoration(
        color: dimColor ? Colors.black38 : const Color(0xff0962ff),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: isLoading
            ? const CircularProgressIndicator(
                color: Colors.white70,
                strokeWidth: 6,
              )
            : Text(
                btnText,
                style: const TextStyle(
                  fontFamily: 'ProductSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              ),
      ),
    );
  }
}
