extension MaskedPhoneNumber on String {
 String get toMaskedPhone {
   return "${substring(0, 7)} *** ** ${substring(11)}";
  }
}

extension PhoneNumberFormatter on String {
  String get toFormattedPhone {
    return   replaceAll(RegExp(r'[^\d+]'), '');
  }
}