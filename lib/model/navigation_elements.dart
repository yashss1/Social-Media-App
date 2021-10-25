import 'package:flutter/material.dart';

class NavigationElement extends StatelessWidget {
  const NavigationElement(
      {Key? key, required this.name, required this.icon, required this.color1})
      : super(key: key);

  final String name;
  final icon;
  final Color color1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(height: 40),
        Icon(
          icon,
          size: 25,
          color: color1,
        ),
        const SizedBox(width: 10),
        Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: color1,
              fontFamily: 'Lato',
              fontSize: 18,
              letterSpacing:
                  0 /*percentages not used in flutter. defaulting to zero*/,
              fontWeight: FontWeight.normal,
              height: 1),
        ),
      ],
    );
  }
}
