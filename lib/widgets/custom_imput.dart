import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget { 
  
  final Icon? icon;
  final String placeHolder;
  final TextEditingController textEditingController;
  final TextInputType keyboardInputType;
  final bool isPassword;

  const CustomInput({super.key, this.icon, required this.placeHolder, required this.textEditingController, this.keyboardInputType= TextInputType.text, this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(hintText:placeHolder,prefixIcon:icon),
      obscureText: isPassword,
      keyboardType: keyboardInputType,
      
    );
  }
}