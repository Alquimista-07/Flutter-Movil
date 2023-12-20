import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    // NOTA: Recordemos que el .expand es para que tome todo el espacio posible disponible del widget padre.
    // NOTA: Los widget que tienen el .adaptative se adaptan al sistema operativo, por ejemplo el CircularProgressIndicator.adaptive()
    return const SizedBox.expand(
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
    );
  }
}
