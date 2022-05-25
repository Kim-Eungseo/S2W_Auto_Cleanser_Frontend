import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../responsive.dart';

class FlowButton extends StatelessWidget{

  FlowButton({
    required this.onPressed,
    required this.icon,
    required this.label
  });

  final VoidCallback? onPressed;
  final Icon? icon;
  final Text? label;
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: defaultPadding * 1.5,
          vertical:
          defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
        ),
      ),
      onPressed: onPressed!,
      icon: icon!, label: label!,
    );
  }
  
}