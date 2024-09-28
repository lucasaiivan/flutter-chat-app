import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart'; 

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat/models/usuario.dart';

// ignore: must_be_immutable
class UsuariosPage extends StatefulWidget {
   const UsuariosPage({super.key});

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  // controllers
  late RefreshController _refreshController;

  // var
  final usuarios = [
    Usuario(online: true, nombre: 'Lucas', email: 'lucas.ivan@gmail.com', uid: 'sf24gdsgsd'),
    Usuario(online: true, nombre: 'Maria', email: 'maria234@gmail.com', uid: 'sfgdasfafsgsd'),
    Usuario(online: false, nombre: 'Juan', email: 'juan34.3@gmail.com', uid: 'sfgdasfa24sfsgsd'),
    Usuario(online: true, nombre: 'Fernando', email: 'Fer2019@gmail.com', uid: 'sfaa42424sfaf'),
  ];

  @override
  Widget build(BuildContext context) {

    // controllers 
    _refreshController = RefreshController(initialRefresh: false);

    // widgets
    Widget online = const Row(crossAxisAlignment: CrossAxisAlignment.center,children: [Icon(Icons.circle_rounded,size:6,color: Colors.green),SizedBox(width:2),Text('Online',style: TextStyle(color: Colors.green,fontSize: 12,fontWeight: FontWeight.bold))],);
    Widget offline = const Row(crossAxisAlignment: CrossAxisAlignment.center,children: [Icon(Icons.circle_rounded,size:6,color: Colors.red),SizedBox(width:2),Text('Offline',style: TextStyle(color: Colors.red,fontSize: 12,fontWeight: FontWeight.bold))],);


    return Scaffold(
      appBar: AppBar(
        title: const Text('Messager'),
        leading: IconButton(onPressed: (){
          // TODO : desconectar del socket service
          Navigator.pushReplacementNamed(context,'login');
          AuthService.deleteToken();
          //...logout
        }, icon: const Icon(Icons.exit_to_app_outlined)),
        actions: [
          offline,
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
        Navigator.of(context).pushNamed('chat');
      },
    );
  }

  void cargarUsuarios() async{
    await Future.delayed(const Duration(milliseconds: 1000)); 
    _refreshController.refreshCompleted();
    setState(() { });
  } 
}