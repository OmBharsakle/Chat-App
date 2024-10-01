import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField(
      {super.key,
        required this.text,
        required this.controller,
        required this.hintText,
        this.isObscure});

  final String text;
  final String hintText;
  final TextEditingController controller;
  final bool? isObscure;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
          height: 55.h,
          child: TextFormField(
            cursorColor: Color(0xFF00BF6D),
            controller: controller,
            style: GoogleFonts.lato(textStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).colorScheme.onSecondary,
                hintText: hintText,
                hintStyle: GoogleFonts.lato()),
            onTapOutside: (event) =>
                FocusScope.of(context).requestFocus(FocusNode()),
            obscureText: isObscure ?? false,
          ),
        )
      ],
    );
  }
}