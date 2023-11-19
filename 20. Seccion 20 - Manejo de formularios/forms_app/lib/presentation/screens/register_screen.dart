import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/register/register_cubit.dart';
import 'package:forms_app/presentation/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Usuario'),
      ),

      // NOTA: Envolvemos el widget en nuestro Cubit para que todos los widget ramificados a partir de este, en este caso nuestro view, tengan acceso
      //       al state del Cubit
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: const _RegisterView(),
      ),
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

class _RegisterForm extends StatelessWidget {
  const _RegisterForm();

  @override
  Widget build(BuildContext context) {
    // NOTA: Referencia al Cubit
    final registerCubit = context.watch<RegisterCubit>();

    final username = registerCubit.state.username;
    final password = registerCubit.state.password;

    return Form(
        child: Column(
      children: [
        // NOTA: Acá vamos a usar nuestro widget personalizado
        CustomTextFormField(
          label: 'Nombre De Usuario',
          // NOTA: Cambiamos el onChanged para manejarlo ahora con Cubit
          onChanged: registerCubit.usernameChanged,
          errorMessage:
              username.isPure || username.isValid ? null : 'Usuario no válido',
        ),

        const SizedBox(height: 10),

        CustomTextFormField(
          label: 'Correo Electrónico',
          // NOTA: Cambiamos el onChanged para manejarlo ahora con Cubit
          onChanged: (value) {
            registerCubit.emailChanged(value);
          },
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
          // NOTA: Cambiamos el onChanged para manejarlo ahora con Cubit
          onChanged: (value) {
            registerCubit.passwordChanged(value);
          },
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
            // NOTA: Llamamos el método de subit que creamos en el Cubit
            registerCubit.onSubmit();
          },
          icon: const Icon(Icons.save),
          label: const Text('Crear Usuario'),
        ),
      ],
    ));
  }
}
