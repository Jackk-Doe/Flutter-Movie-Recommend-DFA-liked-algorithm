import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final String buttonMessage;
  final Color buttonColor;
  final Icon buttonIcon;
  final Function() buttonFnc;

  const CustomIconButton({
    required this.buttonMessage,
    required this.buttonColor,
    required this.buttonIcon,
    required this.buttonFnc,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: buttonFnc,
        icon: buttonIcon,
        label: Text(buttonMessage),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(buttonColor),
        ),
      ),
    );
  }
}
