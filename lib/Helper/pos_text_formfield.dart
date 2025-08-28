import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class PosTextFormfield extends StatefulWidget {
  const PosTextFormfield({super.key});

  @override
  State<PosTextFormfield> createState() => _PosTextFormfieldState();
}

class _PosTextFormfieldState extends State<PosTextFormfield> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscurePassword,
      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        filled: true,
        fillColor: HexColor('#F5F9FE'),
        hintText: 'Password',
        hintStyle: GoogleFonts.poppins(
          fontSize: 16,
          color: HexColor('#61677D'),
        ),
        prefixIcon: Icon(Icons.lock, color: HexColor('#61677D')),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: HexColor('#61677D'),
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: HexColor('#3461FD')),
        ),
      ),
    );
  }
}
