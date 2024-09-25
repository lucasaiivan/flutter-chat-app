import 'package:flutter/material.dart';
import '../widgets/custom_imput.dart';
import '../widgets/labels.dart'; 

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController nameTextEditingController = TextEditingController();
  final TextEditingController emailTextEditingController = TextEditingController();
  final TextEditingController passTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar( 
        title: const Text('Registro'),
      ),
      body: Container(
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
              onPressed: (){
                // ... 
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
    );
  }
}