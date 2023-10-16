import 'package:intl/intl.dart';

class HumanFormats {
  // NOTA: La reazón de colocarlo static es que no necesito crear una intancia para hacer referencia a los métodos y propiedades de este
  static String humanReadbleNumber(double number) {
    // NOTA: Para dar el formato a los número usamos un nuevo paquete llamado intl
    final formatterNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
    ).format(number);

    return formatterNumber;
  }
}
