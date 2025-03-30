class Validators {
  static String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Telefon raqamini kiriting!";
    }

    RegExp phoneRegExp = RegExp(r'^\+998-\d{2}-\d{3}-\d{2}-\d{2}$');
    if (!phoneRegExp.hasMatch(value)) {
      return "Telefon raqam formati: +998-XX-XXX-XX-XX";
    }

    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Parolni kiriting!";
    }
    if (value.length < 4) {
      return "Parol kamida 4 ta belgidan iborat bo‘lishi kerak!";
    }
    return null;
  }
}