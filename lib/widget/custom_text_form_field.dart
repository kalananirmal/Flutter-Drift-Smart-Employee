import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final TextInputType? inputType;
  final String label;
  final String prefix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLength;
  final int minLength;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final VoidCallback? voidCallback;
  final String? hintText;

  const CustomTextFormField({
    Key? key,
    this.onChanged,
    this.inputType,
    required this.label,
    this.prefix = '',
    this.prefixIcon,
    this.suffixIcon,
    this.maxLength,
    this.minLength = 3,
    this.focusNode,
    this.controller,
    this.voidCallback,
    this.hintText,



  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        cursorColor: Colors.teal,
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          focusColor: Colors.teal,
          labelText: label,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.teal,fontSize: 25,fontWeight: FontWeight.bold ),
          labelStyle: const TextStyle(color: Colors.teal,fontSize: 22, ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixText: prefix,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal, width: 1.5),
            borderRadius: BorderRadius.all(
              Radius.circular(16.0),
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent, width: 1.5),
          ),
          errorStyle: const TextStyle(
            color: Colors.deepOrange,
            letterSpacing: 1.0,
          ),
        ),
        maxLength: maxLength,
        onTap: voidCallback,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label ${"field_required"}';
          }

          if (value.length < minLength) {
            return '$label ${"field_length_small"}';
          }

          if (value.length > maxLength!) {
            return '$label ${"field_length_to_long"}';
          }

          return null;
        },
        keyboardType: inputType ?? TextInputType.text,
      ),
    );
  }
}
