import 'package:intl/intl.dart';

class Convert {
  static String convertMoney(money) {
    final oCcy = NumberFormat('#,##0', 'en_US');
    if (money is int || money is double) {
      return '${oCcy.format(money)} đ';
    } else if (money is String) {
      return '${oCcy.format(double.tryParse(money) ?? 0)} đ';
    }
    return '0 đ';
  }

  static DateTime stringToDate(String date, {String? pattern}) {
    if (date.isEmpty) return DateTime.now();
    pattern ??= 'dd/MM/yyyy';
    return DateFormat(pattern).parse(date);
  }

  static String stringToDateAnotherPattern(String date,
      {String? patternIn, String? patternOut, String? ifNull, bool? isAtc}) {
    if (date.isEmpty) {
      if (ifNull != null) {
        return ifNull;
      }
      return '';
    }
    patternIn ??= 'yyyy-MM-ddThh:mm:ss';
    patternOut ??= 'dd MM yyyy, hh:mm:ss';
    if (isAtc == null) {
       return DateFormat(patternOut)
          .format(DateFormat(patternIn).parseUTC(date).toUtc());
    } else if (isAtc) {
      var dateTemp =
          DateFormat(patternIn).parse(date).add(const Duration(hours: 7));
      return DateFormat(patternOut).format(dateTemp);
    } else {
      var dateTemp =
          DateFormat(patternIn).parse(date).subtract(const Duration(hours: 7));
      return DateFormat(patternOut).format(dateTemp);
    }
   
  }

  static getPhone(String? phoneNumber) {
    if (phoneNumber == null) return '';
    return phoneNumber.replaceAll('+84', '0');
  }

  static String getDateMonth(int? date) {
    if (date == null || date <= 0) {
      return '';
    }
    if (date < 10) {
      return '0$date';
    } else {
      return date.toString();
    }
  }

  static String dateToString(DateTime? picked, String? patternOut) {
    if (picked == null) return '';
    patternOut ??= 'dd/MM/yyyy';
    return DateFormat(patternOut).format(picked);
  }
}
