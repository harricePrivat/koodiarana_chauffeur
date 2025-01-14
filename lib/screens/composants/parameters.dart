import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Parameters extends StatelessWidget {
  Icon icon;
  String descri;
  GestureTapCallback? onTap;
  Parameters({super.key, required this.icon, this.onTap,required this.descri});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(255, 128, 127, 127),
        ),
        padding: const EdgeInsets.all(12.00),
        width: 100,
        height: 90,
        child: Center(
          child: Column(
            children: [
              icon,
              const SizedBox(
                height: 10.00,
              ),
              Expanded(
                  child: Text(
                descri,
                style: textTheme.titleMedium,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
