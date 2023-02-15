// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final TextEditingController controller;
  final String? matchText;
  final String label;
  final bool obscured;
  final bool hasMatchingTextField;

  const TextInput({
    Key? key,
    this.matchText,
    required this.controller,
    this.hasMatchingTextField = false,
    required this.label,
    required this.obscured,
  }) : super(key: key);

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  late bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = widget.obscured;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: TextFormField(
        controller: widget.controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '*This field is required';
          }
          if (widget.hasMatchingTextField) {
            if (value != widget.matchText) {
              return "*Password doesn't match";
            }
          }

          return null;
        },
        obscureText: _passwordVisible,
        decoration: InputDecoration(
          suffixIcon: widget.obscured
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                  child: Icon(
                    _passwordVisible
                        ? CupertinoIcons.eye
                        : CupertinoIcons.eye_slash,
                    size: 18,
                  ),
                )
              : null,
          hintText: widget.label,
          hintStyle: TextStyle(fontSize: 13),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey, width: 0.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.redAccent, width: 0.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.redAccent, width: 0.0),
          ),
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}
