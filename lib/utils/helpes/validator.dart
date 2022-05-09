class Validator {
  static bool validPhoneNumber(String phoneNumber, {bool? isSearchOrder}) {
    return isSearchOrder == true
        ? RegExp(r'^(0|\+84)[0-9]{9,10}$').hasMatch(phoneNumber)
        : RegExp(r'^([0-9])[0-9]{9}$').hasMatch(phoneNumber);
  }

  static bool validEmail(String _email) {
    return RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(_email);
  }

  static bool validCMNDNumber(String number) {
    return RegExp(r'^([0-9]){9,12}\b').hasMatch(number);
  }

  static bool validBankNumber(String number) {
    return RegExp(r'^[A-Za-z0-9_.]+$').hasMatch(number);
  }
}
