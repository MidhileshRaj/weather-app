import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TempWidget extends StatelessWidget {
   const TempWidget({super.key, required this.url, required this.temperature, required this.time});
  final String url;
  final String temperature;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(style: const TextStyle(color: Colors.white),time),
          Lottie.asset(height: 50,url),
          Text(style: const TextStyle(color: Colors.white),'$temperature°')
        ],
      ),
    );
  }
}
