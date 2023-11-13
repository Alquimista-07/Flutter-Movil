// NOTA: Vamos a usar un paquete que usamos en la aplicación toktik y que sirve para hacer los números
//       legibles, esto con el fin colocarlo para mostrar las calificaciones de las películas.
//       La documentación la encontramos en: https://pub.dev/packages/intl
import 'package:intl/intl.dart';

class HumanFormats {
  static String number(double number, [int decimals = 0]) {
    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: decimals,
      symbol: '',
      locale: 'en',
    ).format(number);

    return formattedNumber;
  }

  // Método para dar formato a la fecha
  static String shortDate(DateTime date) {
    final format = DateFormat.yMMMEd('es');
    return format.format(date);
  }
}
