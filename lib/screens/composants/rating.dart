import 'package:flutter/material.dart';

class Rating extends StatefulWidget {
  const Rating({super.key});

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.00),
      height: 35,
      width: 63,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.00),
        color: const Color.fromARGB(255, 129, 126, 126),
      ),
      child: const Row(
        spacing: 4,
        children: [
          Icon(
            Icons.work,
            size: 20,
          ),
          Text('5.0'),
        ],
      ),
    );
  }
}
