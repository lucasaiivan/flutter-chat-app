import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/services/socket_service.dart';
import '../helpers/mostrar_alerta.dart';
import '../services/auth_service.dart';
import '../widgets/custom_imput.dart';
import '../widgets/labels.dart'; 

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController nameTextEditingController = TextEditingController();
  final TextEditingController emailTextEditingController = TextEditingController();
  final TextEditingController passTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    // provider
    final socketServices = Provider.of<SocketService>(context);
    final authService = Provider.of<AuthService>(context);

    return Scaffold( 
      appBar: AppBar( 
        title: const Text('Registro'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomInput(
                icon: const Icon(Icons.person_outline_outlined),
                placeHolder: 'Nombre',
                textEditingController: nameTextEditingController, 
              ), 
              CustomInput(
                icon: const Icon(Icons.email_outlined),
                placeHolder: 'Correo Electrònico',
                textEditingController: emailTextEditingController,
                keyboardInputType: TextInputType.emailAddress,
              ), 
              CustomInput(
                icon: const Icon(Icons.lock),
                placeHolder: 'Contraseña',
                textEditingController: passTextEditingController,
                keyboardInputType: TextInputType.visiblePassword,
                isPassword: true,
              ),
              const SizedBox(height:50),
              OutlinedButton(
                onPressed: authService.autenticando?  null  : () async {

                  if(nameTextEditingController.text.isEmpty || nameTextEditingController.text.isEmpty || nameTextEditingController.text.isEmpty ){
                    mostrarAlerta(context, title:'No se pudo crear el usuario',subtitle: 'Debe completar el formulario');
                    return;
                  }

                  final registerOk = await authService.register(nameTextEditingController.text.trim(),emailTextEditingController.text.trim(), passTextEditingController.text.trim());

                  if(registerOk == true ){
                    socketServices.connect();
                    Navigator.pushReplacementNamed(context,'usuarios');
                  }else{
                    mostrarAlerta(context, title:'No se pudo crear el usuario', subtitle:registerOk);
                  }

                },
                child: const Text('Crear cuenta'),
              ),
              const Labels(
                  descriptionText: '¿ya tienes una cuenta?',
                  buttonText: 'Ingresar ahora',
                  rute: 'login',
                ),
            ],
          ),
        ),
      ),
    );
  }
 
}