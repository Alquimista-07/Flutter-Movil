import 'package:flutter/material.dart';

class UiControlsScreen extends StatelessWidget {
  static const name = 'ui_controls_screen';

  const UiControlsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UI Controls'),
      ),
      body: const _UiControlsView(),
    );
  }
}

class _UiControlsView extends StatefulWidget {
  const _UiControlsView();

  @override
  State<_UiControlsView> createState() => _UiControlsViewState();
}

// NOTA: Esta eumeración me va a servir a mi para saber cuales son los valores permitido en el RadioButton
enum Transportation { car, plane, boat, submarine }

class _UiControlsViewState extends State<_UiControlsView> {
  bool isDeveloper = true;

  Transportation selectedTransportation = Transportation.car;

  bool wantsBreakfast = false;
  bool wantsLunch = false;
  bool wantsDinner = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      // NOTA: Esta propiedad ClampingScrollPhysics es el opuesto al BouncingScrollPhysics y la cual nos sirve para quitar el efecto de rebote
      //       cuando hacemos el scroll
      physics: const ClampingScrollPhysics(),
      children: [
        // NOTA: La ventaja de usar este tipo de SwitchListTile es que básicamente lo tenemos en una lista y la cual si damos click en la lista y no sobre el switch
        //       este va a cambiar y no tendríamos que dar click directamente sobre el switch
        SwitchListTile(
          value: isDeveloper,
          title: const Text('Developer Mode'),
          subtitle: const Text('Controles adicionales'),
          // NOTA: Cambiamos el estado del switch para que se encienda o se apague
          onChanged: (value) => setState(() {
            // IsDeveloper es igual al valor opuesto de isDeveloper
            isDeveloper = !isDeveloper;
          }),
        ),

        // NOTA: El ExpansionTile es otro widget que nos permite hacer listas desplegables las cuales podemos hacer que esten desplegadas o contraidas por defecto.
        //       Una cosa que tenemos que tener en cuenta es que cuando lo usamos su comportamiento por defecto es estar contraida.
        ExpansionTile(
          title: const Text('Vehículo de transporte'),
          subtitle: Text('$selectedTransportation'),
          children: [
            RadioListTile(
              title: const Text('By Car'),
              subtitle: const Text('Viajar por carro'),
              value: Transportation.car,
              // NOTA: La propiedad groupValue es la que nosotros usamos o vamos a usar para marcar o obtener el valor de cual es la opción seleccionada
              groupValue: selectedTransportation,
              // NOTA: En el onChanged nosotros vamos a actualizar el estado
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.car;
              }),
            ),
            RadioListTile(
              title: const Text('By Boat'),
              subtitle: const Text('Viajar por barco'),
              value: Transportation.boat,
              // NOTA: La propiedad groupValue es la que nosotros usamos o vamos a usar para marcar o obtener el valor de cual es la opción seleccionada
              groupValue: selectedTransportation,
              // NOTA: En el onChanged nosotros vamos a actualizar el estado
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.boat;
              }),
            ),
            RadioListTile(
              title: const Text('By Plane'),
              subtitle: const Text('Viajar por avión'),
              value: Transportation.plane,
              // NOTA: La propiedad groupValue es la que nosotros usamos o vamos a usar para marcar o obtener el valor de cual es la opción seleccionada
              groupValue: selectedTransportation,
              // NOTA: En el onChanged nosotros vamos a actualizar el estado
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.plane;
              }),
            ),
            RadioListTile(
              title: const Text('By Submarine'),
              subtitle: const Text('Viajar por Submarino'),
              value: Transportation.submarine,
              // NOTA: La propiedad groupValue es la que nosotros usamos o vamos a usar para marcar o obtener el valor de cual es la opción seleccionada
              groupValue: selectedTransportation,
              // NOTA: En el onChanged nosotros vamos a actualizar el estado
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.submarine;
              }),
            ),
          ],
        ),

        // TODO: Por aquí inician los checkbox
        CheckboxListTile(
          title: const Text('¿Desayuno?'),
          value: wantsBreakfast,
          onChanged: (value) => setState(() {
            wantsBreakfast = !wantsBreakfast;
          }),
        ),
        CheckboxListTile(
          title: const Text('Almuerzo?'),
          value: wantsLunch,
          onChanged: (value) => setState(() {
            wantsLunch = !wantsLunch;
          }),
        ),
        CheckboxListTile(
          title: const Text('¿Cena?'),
          value: wantsDinner,
          onChanged: (value) => setState(() {
            wantsDinner = !wantsDinner;
          }),
        ),
      ],
    );
  }
}
