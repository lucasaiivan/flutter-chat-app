import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat/models/usuario.dart';
import 'package:chat/models/login_response.dart';
import 'package:chat/global/environment.dart'; 

class AuthService with ChangeNotifier {

  late Usuario usuario;
  // var : estado de autenticación
  bool _authenticando = false;
  bool get autenticando => _authenticando;
  set autenticando(bool valor){
    _authenticando = valor;
    notifyListeners();
  }
  // var static : token
  static Future<String> getToken() async{
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token as String;
  }
  static Future<void> deleteToken() async{
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token'); 
  }

  // Create storage
  final _storage = const FlutterSecureStorage();

  Future register(String nombre,String email, String password) async {
    // procces create user
    autenticando = true ;

    final Map data = {'nombre':nombre,'email': email,'password': email };
    final resp = await http.post(Uri.parse('${Environment.apiUrl}/login/new'),body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    autenticando = false ;  

     // corroborar el exito de la petición
    if (resp.statusCode == 200) { 
      // obtenemos la repuesta de la autentificación
      final response = loginResponseFromJson(resp.body);
      // obtenemos los datos del usuario
      usuario = response.usuario; 
      // guardamos el token
      await _guardarToken(response.token);
      
      return true;
    }else{ 
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    } 
  }

  Future<bool> login(String email, String password) async {
    // procces auth
    autenticando = true ;

    final Map data = {'email': email,'password': password };
    final resp = await http.post(Uri.parse('${Environment.apiUrl}/login'),body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    autenticando = false ;

    // corroborar el exito de la petición
    if (resp.statusCode == 200) {   
      // obtenemos la repuesta de la autentificación
      final loginResponse = loginResponseFromJson(resp.body);
      // obtenemos los datos del usuario
      usuario = loginResponse.usuario; 
      // guardamos el token
      await _guardarToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    // comprobramos si existe un usuario autenticado
    final String? token = await _storage.read(key: 'token'); 

    if (token == null) {
      return false;
    } 
    // endpoint
    final resp = await http.get(Uri.parse('${Environment.apiUrl}/login/renew'), headers: {'Content-Type': 'application/json','x-token':token});
    autenticando = false; 
    // corroborar el exito de la petición
    if (resp.statusCode == 200) {   
      // obtenemos la repuesta de la autentificación
      final loginResponse = loginResponseFromJson(resp.body);
      // obtenemos los datos del usuario
      usuario = loginResponse.usuario; 
      // guardamos el token
      await _guardarToken(loginResponse.token);
      return true;
    } else {
      logout();
      return false;
    }
  }

  Future _guardarToken(String token) async{ 
    return await _storage.write(key: 'token', value: token);
  }
  Future logout() async{
    await _storage.deleteAll();
  }

}
