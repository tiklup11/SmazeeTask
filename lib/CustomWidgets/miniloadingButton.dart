import 'package:flutter/material.dart';

class MiniLoadingButton extends StatelessWidget {
  MiniLoadingButton(
      {required this.isDone, required this.scrHeight, required this.scrWidth});
  final scrWidth;
  final scrHeight;
  final bool isDone;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: miniLoadingButton(),
    );
  }

  Widget miniLoadingButton() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        height: 75,
        decoration: BoxDecoration(
          color: const Color(0xff0962ff),
          borderRadius: BorderRadius.circular(isDone ? 20 : 40),
        ),
        child: Center(
          child: isDone
              ? const Icon(
                  Icons.done,
                  size: 40,
                  color: Colors.white70,
                )
              : const CircularProgressIndicator(
                  color: Colors.white70, strokeWidth: 6),
        ));
  }
}
