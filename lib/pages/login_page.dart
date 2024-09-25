import 'package:flutter/material.dart';

import '../widgets/custom_imput.dart';
import '../widgets/labels.dart'; 

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(  
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _Logo(),
              const _Form(),
              const Labels(
                descriptionText: '¿No tienes cuenta?',
                buttonText: 'Crear una cuenta',
                rute: 'register',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class _Logo extends StatelessWidget {

  @override
  Widget build(BuildContext context) { 

    return SafeArea(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(Icons.messenger_outline_sharp,size: 100),
            Text('Messeger',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24)),
          ],
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form();

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {

  // controllers
  TextEditingController email_textEditingController = TextEditingController();
  TextEditingController pass_textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [ 
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:35),
          child: Column(
            children: [
              CustomInput(
                icon: const Icon(Icons.email_outlined),
                placeHolder: 'Correo Electrònico',
                textEditingController: email_textEditingController,
                keyboardInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height:20),
              CustomInput(
                icon: const Icon(Icons.lock_outline_sharp),
                placeHolder: 'Contraseña',
                textEditingController: pass_textEditingController,
                keyboardInputType: TextInputType.visiblePassword,
                isPassword: true,
              ),
            ],
          ),
        ),
        const SizedBox(height:20),
        OutlinedButton(
          onPressed: (){
            // ... 
          },
          child: const Text('Ingresar'),
        )
      ],
    );
  }
}

