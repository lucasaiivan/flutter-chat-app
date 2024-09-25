
import 'package:flutter/material.dart';

import '../pages/chat_page.dart';
import '../pages/loading_page.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';
import '../pages/usuarios_page.dart';

final Map<String,Widget Function(BuildContext)> appRoutes = {
  'usuarios': (_)=>  const UsuariosPage(),
  'chat': (_)=>  const ChatPage(),
  'login': (_)=>  const LoginPage(),
  'register': (_)=> RegisterPage(),
  'loading': (_)=>  const LoadingPage(),
};