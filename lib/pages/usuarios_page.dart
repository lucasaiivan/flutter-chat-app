import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat/services/chat_service.dart';
import 'package:chat/services/usuarios_service.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/socket_service.dart';

import 'package:chat/models/usuario.dart';

// ignore: must_be_immutable
class UsuariosPage extends StatefulWidget {
   const UsuariosPage({super.key});

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {

  // controllers
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  //
  final usuariosService = UsuariosService();


  // var
  List<Usuario> usuarios = [];
  

  @override
  void initState() {
    cargarUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // provider
    final socketServices = Provider.of<SocketService>(context);
 

    // widgets
    Widget online = const Row(crossAxisAlignment: CrossAxisAlignment.center,children: [Icon(Icons.circle_rounded,size:6,color: Colors.green),SizedBox(width:2),Text('Online',style: TextStyle(color: Colors.green,fontSize: 12,fontWeight: FontWeight.bold))],);
    Widget offline = const Row(crossAxisAlignment: CrossAxisAlignment.center,children: [Icon(Icons.circle_rounded,size:6,color: Colors.red),SizedBox(width:2),Text('Offline',style: TextStyle(color: Colors.red,fontSize: 12,fontWeight: FontWeight.bold))],);


    return Scaffold(
      appBar: AppBar(
        title: const Text('Messager'),
        leading: IconButton(onPressed: (){
          socketServices.disconnect();
          Navigator.pushReplacementNamed(context,'login');
          AuthService.deleteToken();
          //...logout
        }, icon: const Icon(Icons.exit_to_app_outlined)),
        actions: [
          socketServices.online?online:offline,
          const SizedBox(width:12),
        ]
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        header: const WaterDropHeader(),
        onRefresh: ()=> cargarUsuarios(),
        child: body,
      ),
    );
  }

  Widget get body{
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder:(context, index) => itemListTile(user: usuarios[index]), 
        separatorBuilder: (context, index) => const Divider(height: 0,), 
        itemCount:usuarios.length,
      );
  }

  Widget itemListTile({required Usuario  user }){
    return ListTile(
      leading: Stack(
        children: [
          CircleAvatar(
            child: Text(user.nombre.substring(0,2)),
          ),
          Positioned(
            top: 3,right: 3,
            child: Icon(Icons.circle,size: 7,color:user.online?Colors.green:Colors.red)),
        ],
      ),
      title:Text(user.nombre),
      subtitle:Text(user.email),
      onTap: (){
        final chatService = Provider.of<ChatService>(context,listen: false);
        chatService.usuarioPara = user;
        Navigator.of(context).pushNamed('chat');
      },
      
    );
  }

  void cargarUsuarios() async { 

    
    usuarios = await usuariosService.getUsuarios();

    _refreshController.refreshCompleted();
    setState(() { });
  } 
}