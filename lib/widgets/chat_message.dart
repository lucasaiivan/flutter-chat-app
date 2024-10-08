

import 'package:flutter/material.dart';
import 'package:chat/services/auth_service.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget { 

  final String texto;
  final String uid;

  const ChatMessage({super.key, required this.texto, required this.uid});

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context,listen: false);

    return uid==authService.usuario.uid?_myMessage():_message();
  }

  Widget _myMessage(){
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4,horizontal: 6),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color:  Colors.blue.withOpacity(0.4),borderRadius: BorderRadius.circular(12)),
        child: Text(texto),
      ),
    );
  }
  Widget _message(){
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4,horizontal: 6),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.grey.withOpacity(0.3),borderRadius: BorderRadius.circular(12)),
        child: Text(texto),
      ),
    );
  }
}