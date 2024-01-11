import 'package:intl/intl.dart';

class FormatCurrency {
  static String stringToCurrency(String amout) {
    late int cur;
    amout.isEmpty ? cur = 0 : cur = int.parse(amout);
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    return currencyFormat.format(cur);
  }
}
