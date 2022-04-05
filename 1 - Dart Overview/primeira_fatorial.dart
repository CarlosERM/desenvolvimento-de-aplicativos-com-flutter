import 'dart:io';

void main() {
  print("-------------------------------------");
  print("               FATORIAL              ");
  print("-------------------------------------");
  print("Digite um número: ");
  String? input = stdin.readLineSync();

  int? value = int.tryParse(input!);
  if (value != null) {
    int fatorial = 1;
    for (int z = value; z >= 1; z--) {
      fatorial = fatorial * z;
    }
    print("O fatorial de ${value} é: ${fatorial}");
  } else {
    print("DIGITE UM VALOR VÁLIDO.");
  }
}
