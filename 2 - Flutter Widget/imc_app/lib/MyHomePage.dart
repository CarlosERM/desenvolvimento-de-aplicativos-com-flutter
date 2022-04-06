import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller_altura = TextEditingController();
  final TextEditingController _controller_peso = TextEditingController();
  late String resultado = "";
  late String classification = "";
  double value = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: const Center(child: const Icon(Icons.house)),
          actions: [
            IconButton(
              icon: const Icon(Icons.replay_outlined),
              onPressed: () {},
            )
          ],
        ),
        body: Center(
          child: Container(
            width: 300,
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text("Altura"),
                  ),
                  controller: _controller_altura,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text("Peso"),
                  ),
                  controller: _controller_peso,
                ),
                const SizedBox(height: 30.0),
                TextButton(
                  child: const Text("Clica em mim"),
                  onPressed: () {
                    double altura = double.parse(_controller_altura.text);
                    double peso = double.parse(_controller_peso.text);
                    value = (peso / (altura * altura));

                    setState(() {
                      if (value <= 18.5) {
                        classification = "Abaixo do Peso";
                      } else if (value >= 18.6 && value <= 24.9) {
                        classification = "Peso ideal (parabéns)";
                      } else if (value >= 25.0 && value <= 29.9) {
                        classification = "Levemente acima do peso";
                      } else if (value >= 30.0 && value <= 34.9) {
                        classification = "Obesidade grau I";
                      } else if (value >= 35.0 && value <= 39.9) {
                        classification = "Obesidade grau II (severa)";
                      } else if (value >= 40) {
                        classification = "Obesidade grau III (mórbida)";
                      }
                      resultado = value.toStringAsFixed(2);
                    });
                  },
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.deepOrange),
                ),
                Container(
                  height: 200,
                  width: 300,
                  margin: const EdgeInsets.only(top: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          resultado != ""
                              ? "Seu IMC é $resultado. \nSua classificação é:\n$classification"
                              : "",
                          style: const TextStyle(
                            color: Colors.white,
                            backgroundColor: Colors.deepOrange,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
