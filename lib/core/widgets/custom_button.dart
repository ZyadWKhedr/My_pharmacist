import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final double? widthFactor;
  final double? heightFactor;
  final double borderRadius;
  final List<BoxShadow>? shadow;

  const CustomButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.color = Colors.lightBlue,
    this.textColor = Colors.white,
    this.borderColor = Colors.blue,
    this.widthFactor = 0.8,
    this.heightFactor = 0.055,
    this.borderRadius = 50.0,
    this.shadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: widthFactor != null ? screenWidth * widthFactor! : null,
      height: heightFactor != null ? screenHeight * heightFactor! : null,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(color: borderColor),
          ),
          shadowColor:
              shadow != null ? shadow!.first.color : Colors.transparent,
          elevation: shadow != null ? shadow!.first.blurRadius : 0,
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
