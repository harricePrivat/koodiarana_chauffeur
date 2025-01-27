import 'dart:ui';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _Loading();
}

class _Loading extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            color: const Color.fromARGB(90, 153, 152, 152,),
          ),
        ),
        ModalBarrier(
          dismissible: false,
          color: Colors.transparent,
        ),
        Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8,
          children: [
            LoadingAnimationWidget.threeRotatingDots(
                color: theme.primaryColor, size: 40),
            Text(
              "Chargement...",
              style: theme.textTheme.titleMedium,
            )
          ],
        )),
      ],
    );
  }
}
