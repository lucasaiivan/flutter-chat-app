
import 'package:flutter/material.dart'; 

mostrarAlerta(BuildContext context ,{required String title,required String subtitle}){
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(subtitle),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: const Text('Ok'),
        )
      ],
    ),
    
  );
}