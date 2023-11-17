import 'package:flutter/material.dart';
import 'package:forms_app/presentation/widgets/widgets.dart';

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
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FlutterLogo(size: 100),

              // NOTA: Este widget nos permite colocar los campos de texto, que luego se le agregara sus validaciones y demás
              //       cosas que tiene que tener un formulario.
              // NOTA: Ahora en este caso ese sería un input básico pero nosotros queremos personalizarlo y darle algunos estilos
              //       por lo tanto no lo vamos a usar y vamos a crear nuestro propio widget y usarlo en nuestro form personalizado
              //TextFormField(),

              // NOTA: Widget en el cual vamos a trabajar nuestro formulario personalizado
              _RegisterForm(),

              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  // NOTA: Vamos a crear el globalkey que me permite enlazar el key con el formkey
  //       y que me va a permitir tener el control del formulario basado en ese key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String username = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            // NOTA: Acá vamos a usar nuestro widget personalizado
            CustomTextFormField(
              label: 'Nombre De Usuario',
              // NOTA: Recordemos que cada uno de nuestro CustomTextFormField tiene el onChange que nos pemite captuar el valor de ese input
              onChanged: (value) => username = value,
              // NOTA: Recordemnos que ocupamos hacer las validaciones
              validator: (value) {
                if (value == null || value.isEmpty) return 'Campo requerido';
                // Recordemos que el trim quita espacios adelante y atrás
                if (value.trim().isEmpty) return 'Campo requerido';
                if (value.length < 6) return 'Más de 6 letras';
                return null;
              },
            ),

            const SizedBox(height: 10),

            CustomTextFormField(
              label: 'Correo Electrónico',
              // NOTA: Recordemos que cada uno de nuestro CustomTextFormField tiene el onChange que nos pemite captuar el valor de ese input
              onChanged: (value) => email = value,
              // NOTA: Recordemnos que ocupamos hacer las validaciones
              validator: (value) {
                if (value == null || value.isEmpty) return 'Campo requerido';
                // Recordemos que el trim quita espacios adelante y atrás
                if (value.trim().isEmpty) return 'Campo requerido';

                // NOTA: Validamos con una expresión regular para verificar si tiene formato de correo
                final emailRegExp = RegExp(
                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                );
                if (!emailRegExp.hasMatch(value)) {
                  return 'No tiene formato de correo';
                }

                return null;
              },
            ),

            const SizedBox(height: 10),

            CustomTextFormField(
              label: 'Contraseña',
              obscureText: true,
              // NOTA: Recordemos que cada uno de nuestro CustomTextFormField tiene el onChange que nos pemite captuar el valor de ese input
              onChanged: (value) => password = value,
              // NOTA: Recordemnos que ocupamos hacer las validaciones
              validator: (value) {
                if (value == null || value.isEmpty) return 'Campo requerido';
                // Recordemos que el trim quita espacios adelante y atrás
                if (value.trim().isEmpty) return 'Campo requerido';
                if (value.length < 6) return 'Más de 6 letras';
                return null;
              },
            ),

            const SizedBox(height: 20),
            FilledButton.tonalIcon(
              onPressed: () {
                // NOTA: Ahora para que se apliquen las validaciones a nuestros campos podríamos tomar la referencia a cada campo y hacer la referencia al validator,
                //       pero sale más fácil hacer referencia directamnete al formulario usando el formKey
                final isValid = _formKey.currentState!.validate();
                if (!isValid) return;

                // NOTA: Cuando haga click en el botón imprimo los valores de los campos
                print('{$username, $email, $password}');
              },
              icon: const Icon(Icons.save),
              label: const Text('Crear Usuario'),
            ),
          ],
        ));
  }
}
