import 'package:chat/global/environment.dart';
import 'package:chat/models/usuarios_response.dart';
import 'package:chat/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:chat/models/usuario.dart';

class UsuariosService {

  Future<List<Usuario>> getUsuarios() async {

    try{

      // piticion http
      final resp = await http.get(Uri.parse('${Environment.apiUrl}/usuarios'),
        headers: {
          'Content-Type':'Application/json',
          'x-token': await  AuthService.getToken(),
        });
      final usuariosResponse = usuariosResponseFromJson(resp.body);

      return usuariosResponse.usuarios;

    }catch(err){
      return [];
    }

  }

}