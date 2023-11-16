import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Usuario'),
      ),
      body: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    // NOTA: Ojo hay que considerar la ubicación de los campos de texto, adicionalmente podemos trabajar con el SafeArea
    //       para asegurarnos de mostrar el widget basdo en el notch, controles de movimiento, etc. Pero este safeArea no
    //       soluciona todo, por lo tanto tenemos que tener mucho cuidado ya que puede llegar a darse overflow y causar
    //       problemas al visualizar los widgets, y por lo tanto se recomienda envolver en algún widget que permita hacer
    //       scroll como un listview, un singlechildscrollview, etc.
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const FlutterLogo(size: 100),
              // NOTA: Este widget nos permite colocar los campos de texto, que luego se le agregara sus validaciones y demás
              //       cosas que tiene que tener un formulario.
              TextFormField(),
              TextFormField(),
              TextFormField(),
              TextFormField(),

              const SizedBox(height: 20),

              FilledButton.tonalIcon(
                onPressed: () {},
                icon: const Icon(Icons.save),
                label: const Text('Crear Usuario'),
              ),

              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
