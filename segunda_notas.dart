import 'dart:io';

void main() {
  int nota50 = 0;
  int nota10 = 0;
  int nota5 = 0;

  print("------------------------------------------------");
  print("                 CAIXA ELETRÔNICO               ");
  print("------------------------------------------------");
  print("Digite um valor: ");
  String? input = stdin.readLineSync();

  int? value = int.tryParse(input!);

  if (value != null) {
    if (value >= 50) {
      nota50 = (value / 50).floor();
      value = value % 50;
    }

    if (value >= 10) {
      nota10 = (value / 10).floor();
      value = value % 10;
    }
    
    if (value >= 5) {
      nota5 = (value / 5).floor();
      value = value % 5;
    }

    print("Notas de 50: ${nota50}\nNotas de 10: ${nota10}\nNotas de 5: ${nota5}\nNotas de 1: ${value}");
  }
}
