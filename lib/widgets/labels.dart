
import 'package:flutter/material.dart';

class Labels extends StatelessWidget { 

  final String descriptionText;
  final String buttonText;
  final String rute;

  const Labels({super.key, required this.rute,required this.descriptionText, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top:30,bottom: 30),
      child: Column(
        children: [
          Text(descriptionText),
          TextButton(onPressed: (){
            Navigator.pushReplacementNamed(context,rute);
          }, child: Text(buttonText)),
          const SizedBox(height:20),
          TextButton(onPressed: (){ 
            // ... 
          }, child: const Text('Términos y condiciones de uso',style: TextStyle(fontSize: 12,color: Colors.blueGrey),))
        ],
      ),
    );
  }
}