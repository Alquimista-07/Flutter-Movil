import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ButtonsScreen extends StatelessWidget {
  // NOTA: Agreamos una propiedad estática constante para asignar el nombre que luego vamos a usar en el go_router
  //       adicionalmente recordemos que usamos el static para evitar crear instancias de la clase para solo tener
  //       acceso a la propiedad
  static const String name = 'buttons_screen';

  const ButtonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buttons Screen'),
      ),
      body: const _ButtonsView(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () {
          // NOTA: Regresar a la pantalla anterior, en este caso como tenemos go_router podemos hacer el pop(), pero también podemos usar el
          //       Navigator.of(context).pop() y sería lo mismo que usar solo el pop()
          context.pop();
        },
      ),
    );
  }
}

class _ButtonsView extends StatelessWidget {
  const _ButtonsView();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      // NOTA: A La propiedad width del SizedBox with le asignamos double.infinty el cual especifica que llegue o tome hasta lo
      //       que pueda el padding
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        // NOTA: El widget wrap lo que hace es como si tuvieramos una grilla e ir acomodando los elementos automáticamente debajo cuando no
        //       hay espacio disponible en la pantalla
        child: Wrap(
          // NOTA: El spacing es una propiedad del wrap que agrega un espaciado entre los botones en este caso
          spacing: 10,
          alignment: WrapAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('Elevated'),
            ),
            // NOTA: Para colocar un botón deshabilitado simplemente en el onPressed en vez de mandar una
            //       función mandamos null
            const ElevatedButton(
              onPressed: null,
              child: Text('Elevated Disabled'),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.access_alarm_rounded),
              label: const Text('Elevated Icon'),
            ),
            FilledButton(
              onPressed: () {},
              child: const Text('Filled'),
            ),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.accessibility_new),
              label: const Text('Filled Icon'),
            ),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Outline'),
            ),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.terminal),
              label: const Text('Outline Icon'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Text'),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.account_box_outlined),
              label: const Text('Text Icon'),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.app_registration_rounded),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.app_registration_rounded),
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    colors.primary,
                  ),
                  iconColor: const MaterialStatePropertyAll(
                    Colors.white,
                  )),
            ),

            const CustomButton()
          ],
        ),
      ),
    );
  }
}

// NOTA: Creamos nustrso propio botón personalizado desde cero, al cual le podemos asignar colores, gradientes, bordes redondeados, acciones
//       asignar un color cuando la función que ejecuta la acción sea null, y otras cosas más que se nos ocurra.
class CustomButton extends StatelessWidget {
  const CustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    // NOTA: EL widget ClipRRect permite redondear los bordes del botón.
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      // NOTA: El widget Material es algo especial en el cual nosotros vamos a poder definir incluso el splash screen, que aplique el
      //       aspecto de Material Design, entre otras cosas. Adicionalmente este es el punto inicial par anuestro botón.
      child: Material(
        color: colors.primary,
        // NOTA: EL InkWell es similar al GestureDetector que usamos en la app de los videos toktik, pero este va a reaccionar con el método
        //       al Splash Screen
        child: InkWell(
          onTap: () {},
          child: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Text(
              'Hola Mundo',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
