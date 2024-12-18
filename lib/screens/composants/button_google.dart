import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// ignore: must_be_immutable
class ButtonGoogle extends StatelessWidget {
  GestureTapCallback onPressed;
   ButtonGoogle({super.key,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ShadButton(
      shadows: const [
        BoxShadow(blurRadius: 16.00, color: Color.fromARGB(255, 120, 119, 119)),
      ],
      onPressed: onPressed,
      width: 250,
      height: 50,
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/google.png',
              width: 25,
              height: 25,
            ),
            const Text('Se connecter avec Google')
          ],
        ),
      ),
    );
  }
}
