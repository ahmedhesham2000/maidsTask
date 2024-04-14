import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFormfieldWidget extends StatefulWidget {
  TextFormfieldWidget(
      {super.key,
      required this.hintText,
      this.isPassword = false,
      required this.controller,
      this.validator,
      this.onTap,
      this.obscureText = false});
  String hintText;
  bool isPassword;
  bool obscureText;
  var validator;
  TextEditingController controller;
  var onTap;
  @override
  State<TextFormfieldWidget> createState() => _TextFormfieldWidgetState();
}

class _TextFormfieldWidgetState extends State<TextFormfieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 10),
        hintText: widget.hintText,
        fillColor: Colors.white,
        filled: true,
        suffixIcon: widget.isPassword
            ? InkWell(
                onTap: () {
                  setState(() {
                    widget.obscureText = !widget.obscureText;
                  });
                },
                child: Icon(widget.obscureText
                    ? Icons.visibility_off
                    : Icons.visibility),
              )
            : null,
        hintStyle: const TextStyle(
          color: Color(0xff988F8C),
          fontSize: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(22),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(22),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(22),
        ),
      ),
    );
  }
}
