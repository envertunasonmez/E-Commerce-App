class Validator {
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return "Email boş olamaz";
    final regex = RegExp(r"^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,}$");
    if (!regex.hasMatch(value)) return "Geçerli bir email girin";
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Parola boş olamaz";
    if (value.length < 8) return "Parola en az 8 karakter olmalı";
    final hasLetter = RegExp(r'[A-Za-z]').hasMatch(value);
    final hasDigit = RegExp(r'\d').hasMatch(value);
    if (!hasLetter || !hasDigit) return "Parola en az 1 harf ve 1 rakam içermeli";
    return null;
  }

  static String? validateConfirmPassword(String? value, String original) {
    if (value == null || value.isEmpty) return "Parola tekrar boş olamaz";
    if (value != original) return "Parolalar eşleşmiyor";
    return null;
  }
}
