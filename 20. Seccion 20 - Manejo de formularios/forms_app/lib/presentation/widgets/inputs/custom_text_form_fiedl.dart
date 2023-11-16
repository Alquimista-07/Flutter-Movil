import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? errorMessage;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool obscureText;

  const CustomTextFormField({
    super.key,
    this.label,
    this.hint,
    this.errorMessage,
    this.onChanged,
    this.validator,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      // borderSide: BorderSide(color: colors.primary),
    );

    return TextFormField(
      // NOTA: Obtener el valor del input
      /*
      onChanged: (value) {
        print('value: ${value}');
      },
      */
      onChanged: onChanged,

      // NOTA: Como su nombre lo indica esto me permite validar el campo.
      //       Otra cosa es que este validator puede ser opcional ya que a la larga nosotros delegaríamos esto a un gestor
      //       de estado para que valide cuando el input tiene un error y cuando no y determinar el mensaje que se debe mandar
      /*
      validator: (value) {
        if (value == null) return 'El campo es requerido';
        if (value.isEmpty) return 'El campo es requerido';
        // NOTA: El trim elimina los espacios adelante y atrás del texto
        if (value.trim().isEmpty) return 'El campo es requerido';

        return null;
      },
      */
      validator: validator,

      // NOTA: La propiedad decoration me permite cambiar la apariencia física del input
      decoration: InputDecoration(
        // NOTA: La propiedad enabledBorder se aplica cuando el input es habilitado
        enabledBorder: border,

        // NOTA: Cuando tenemos foco sobre el input y usamos un copywith para mantener el color del tema
        focusedBorder:
            border.copyWith(borderSide: BorderSide(color: colors.primary)),

        // NOTA: La propiedad isDense hace el input un poco más compacto y pequeño
        isDense: true,

        label: label != null ? Text(label!) : null,

        // NOTA: La propiedad hintText nos permite agregar pistas o ayudas al usuario de que tiene que diligenciar en el input, similar a un placeholder
        hintText: hint,

        // NOTA: El focusColor sirve para dar el color al cursor cuando se hace foco en el input
        focusColor: colors.primary,

        /*
        // NOTA: La propiedad prefixIcon como su nombre lo indica permite colocar un icono al input al inicio
        prefixIcon: Icon(
          Icons.supervised_user_circle_outlined,
          color: colors.primary,
        ),
        // NOTA: La propiedad suffixIcon coloca el icono al final del input
        suffixIcon: Icon(
          Icons.supervised_user_circle_outlined,
          color: colors.primary,
        ),
        // NORA: La propiedad icon coloca el icono fuera del input
        icon: Icon(
          Icons.supervised_user_circle_outlined,
          color: colors.primary,
        ),
        */

        // NOTA: La propiedad errorText muestra los mensajes de error pero al agregar esto vamos a perder el diseño
        //       redondeado por lo tanto es necesario agregar la propiedad errorBorder y focusedErrorBorder.
        //       Adicionalmente podemos mandarle un null al errorText y no se va a mostrar y esto nos siver para mostrar
        //       dependiendo si el formulario es válido o no.
        //       Otra cosa bonita que tiene es que cuando hay un error el dispositivo va a vibrar y se va a hacer la animación
        //       mostrando el error porque sabe cuando esta cambiando el estado del input y hay un error.
        errorText: errorMessage,

        errorBorder:
            border.copyWith(borderSide: BorderSide(color: Colors.red.shade800)),

        focusedErrorBorder:
            border.copyWith(borderSide: BorderSide(color: Colors.red.shade800)),
      ),

      //NOTA: La propiedad obscureText la usamos para cuando queremos ocultar lo que se escribe en un campo de texto por ejemplo
      //      el campo para una contraseña.
      obscureText: obscureText,
    );
  }
}
