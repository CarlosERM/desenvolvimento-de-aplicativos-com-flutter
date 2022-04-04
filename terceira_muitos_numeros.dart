import 'dart:io';
import 'dart:math';

void main() {
  int? value = 0;
  List<int> valores = [];
  print("------------------------------------------------");
  print("                      DIGITE                    ");
  print("------------------------------------------------");
  do {
    print("Digite um valor: ");
    String? input = stdin.readLineSync();
    value = int.tryParse(input!);
    if (value != null) {
      valores.add(value);
    } else {
      print("Valor inválido.");
    }
  } while (!valores.contains(-1));
  valores.remove(-1);

  print("Quantidade de números digitados: ${valores.length}");
  print("Maior número digitado: ${valores.reduce(max)}");
  print("Menor número digitado: ${valores.reduce(min)}");
  print(
      "A média número digitado: ${valores.reduce((a, b) => a + b) / valores.length}");
}
