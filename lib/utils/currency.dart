import 'package:intl/intl.dart';

class CurrencyFormat {
  static String convertToIdr(String nominal, int decimalDigit) {
    var nominalInNumber = int.tryParse(nominal);

    if (nominalInNumber == null) return "Rp. 0";
    

    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(nominalInNumber);
  }
}
