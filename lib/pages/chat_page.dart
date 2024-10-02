import 'package:chat/models/mensajes_response.dart';
import 'package:flutter/material.dart'; 
import 'package:provider/provider.dart';

import 'package:chat/services/auth_service.dart';
import 'package:chat/services/socket_service.dart';
import 'package:chat/services/chat_service.dart';

import 'package:chat/models/usuario.dart';
import '../widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  // provider
  late ChatService chatService;
  late SocketService socketService;
  late AuthService authService;


  // var 
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    
    chatService = Provider.of<ChatService>(context,listen: false);
    socketService = Provider.of<SocketService>(context,listen: false);
    authService = Provider.of<AuthService>(context,listen: false);

    socketService.socket.on('mensaje-personal',escucharMensajes);

    // cargar historial de mensajes
    _cargarHistorial(this.chatService.usuarioPara.uid);
  }

  void _cargarHistorial(String usuarioId) async{

    List<Mensaje> chat = await chatService.getChat(usuarioId);

    final history = chat.map((e) => ChatMessage(texto: e.mensaje, uid: e.de));
    _messages.insertAll(0, history);
    setState(() {});
  }

  void escucharMensajes( dynamic data){

    ChatMessage message = ChatMessage(texto: data['mensaje'], uid: data['de']);
    _messages.insert(0,message);
    setState(() {});
    
  }

  @override
  Widget build(BuildContext context) {

 
    // var 
    final Usuario user = chatService.usuarioPara;

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
    final String text = _textController.text;
    _textController.clear();
    _messages.insert(0,ChatMessage(texto: text, uid: authService.usuario.uid ));
    _focusNode.requestFocus(); 
    setState(() {});

    socketService.socket.emit('mensaje-personal',{
      'de':authService.usuario.uid,
      'para':chatService.usuarioPara.uid,
      'mensaje':text,
    });

  }

  @override
  void dispose() {
    // TODO: off socket
    socketService.socket.off('mensaje-personal');
    super.dispose();
  }
}