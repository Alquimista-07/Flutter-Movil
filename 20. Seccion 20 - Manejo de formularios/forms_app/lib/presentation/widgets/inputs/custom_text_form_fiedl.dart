import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      // borderSide: BorderSide(color: colors.primary),
    );

    return TextFormField(
      // NOTA: Obtener el valor del input
      onChanged: (value) {
        print('value: ${value}');
      },
      // NOTA: Como su nombre lo indica esto me permite validar el campo
      validator: (value) {
        if (value == null) return 'El campo es requerido';
        if (value.isEmpty) return 'El campo es requerido';
        // NOTA: El trim elimina los espacios adelante y atrás del texto
        if (value.trim().isEmpty) return 'El campo es requerido';

        return null;
      },
      // NOTA: La propiedad decoration me permite cambiar la apariencia física del input
      decoration: InputDecoration(
        // NOTA: La propiedad enabledBorder se aplica cuando el input es habilitado
        enabledBorder: border,
        // NOTA: Cuando tenemos foco sobre el input y usamos un copywith para mantener el color del tema
        focusedBorder:
            border.copyWith(borderSide: BorderSide(color: colors.primary)),
      ),
    );
  }
}
