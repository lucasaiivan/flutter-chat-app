import 'package:flutter/material.dart'; 

import 'package:chat/models/usuario.dart';
import '../widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // var 
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  final List<ChatMessage> _messages = [
    const ChatMessage(texto: 'tanto tiempo', uid: '111'),
    const ChatMessage(texto: 'Hola, bien y tu ?', uid: '111'),
    const ChatMessage(texto: 'Como estas?', uid: '123'),
    const ChatMessage(texto: 'Hola!!', uid: '123'),
  ];

  @override
  Widget build(BuildContext context) {

    // var 
    final Usuario user = Usuario(online: true, nombre: 'Fernando', email: 'fer2019@gmail.com', uid:'34325tgergerdh');

    return Scaffold(
      appBar: AppBar(title: Row(
        children: [
          CircleAvatar(child: Text(user.nombre.substring(0,2))),
          const SizedBox(width: 6),
          Text(user.nombre),
        ],
      )),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder: (context, index) => ChatMessage(texto: _messages[index].texto, uid: _messages[index].uid),
              reverse: true,
            ),
          ),
          inputChat(),
        ],
      ),
    );
  }

  Widget inputChat(){
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Flexible(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12,),
              child: TextField(
                controller: _textController,
                focusNode: _focusNode,
                decoration: const InputDecoration(hintText: 'Escriba un mensaje',border: OutlineInputBorder(),),
                onSubmitted: _handleSubmit,
                keyboardType: TextInputType.text,
                onChanged: (text) {
                  // ...
                  setState(() {
                    
                  });
                },
              ),
            )),
            IconButton(onPressed: _textController.text==''?null: (){
              if(_textController.text==''){return;}
              _handleSubmit(_textController.text);
            }, icon: const Icon(Icons.send_outlined)),
            const SizedBox(width: 8)
          ],
        ),
      ),
    );
  }

  void _handleSubmit( String text){
    _messages.insert(0,ChatMessage(texto: _textController.text, uid: '123'));
    _textController.clear();
    _focusNode.requestFocus(); 
    setState(() {
      
    }); 
  }

  @override
  void dispose() {
    // TODO: off socket
    super.dispose();
  }
}