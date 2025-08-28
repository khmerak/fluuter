import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SocialButton extends StatelessWidget {
  final String? icon;
  final String? label;
  final void Function()? onPressed;
  const SocialButton({
    super.key,
    required this.onPressed,
    this.icon,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        padding: WidgetStatePropertyAll(EdgeInsets.all(16)),
        backgroundColor: WidgetStatePropertyAll(HexColor('#F5F9FE')),
      ),
      
      child: 
     
      Row(
        children: [
          icon == null
              ? SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Image.asset(icon!, width: 25),
                ),
          Text(
            label ?? '',
            style: TextStyle(fontSize: 16, color: HexColor('#61677D')),
          ),
        ],
      ),
      
    );
  }
}
