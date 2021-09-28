class Validators {
  static String? requiredField(String? input) {
    if (input!.isEmpty) {
      return 'Campo obrigatório!';
    }
  }
}
