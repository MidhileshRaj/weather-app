import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
    const IconButtonWidget({super.key,required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return  CircleAvatar(
      backgroundColor: Colors.black.withOpacity(.6),
      radius: 25,
      child:Icon(icon,color: Colors.white,)
    );
  }
}
