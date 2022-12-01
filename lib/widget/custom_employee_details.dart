import 'package:flutter/material.dart';

class EmployeeDetail extends StatelessWidget {
  String value;
  String hintText;

  EmployeeDetail({Key? key, required this.value, required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
            TextFormField(
              enabled: false,
              decoration: InputDecoration(
                disabledBorder: InputBorder.none,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: value,
                labelText: hintText,
                labelStyle: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
                hintStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

            ),
        ],
      ),
    );
  }
}
