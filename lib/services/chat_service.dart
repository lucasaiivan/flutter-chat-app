import 'package:chat/models/mensajes_response.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chat/models/usuario.dart';
import 'package:chat/global/environment.dart'; 

class ChatService with ChangeNotifier{

  late Usuario usuarioPara; // usuario de chat (para quien van los mensajes)

  // peticion de servicio
  Future<List<Mensaje>> getChat(String usuarioId) async {
    final resp = await http.get(Uri.parse('${Environment.apiUrl}/mensajes/$usuarioId'),
    headers: {
      'Content-Type':'application/json',
      'x-token': await AuthService.getToken(),
      }
    );
    final mensajeResponse = mensajesResponseFromJson(resp.body);
    return mensajeResponse.mensajes;
  }

}