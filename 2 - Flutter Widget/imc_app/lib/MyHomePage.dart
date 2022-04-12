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
  late String image = "images/default_image.jpeg";
  double value = 0;

  void calculate(double value) {
    if (value <= 18.5) {
      classification = "Abaixo do Peso";
      image = "images/abaixo_do_peso.jpg";
    } else if (value >= 18.6 && value <= 24.9) {
      classification = "Peso ideal (parabéns)";
      image = "images/peso_ideal.jpeg";
    } else if (value >= 25.0 && value <= 29.9) {
      classification = "Levemente acima do peso";
      image = "images/ligeiramente_acima_do_peso.png";
    } else if (value >= 30.0 && value <= 34.9) {
      classification = "Obesidade grau I";
      image = "images/obesidade_grau_1.jpeg";
    } else if (value >= 35.0 && value <= 39.9) {
      classification = "Obesidade grau II (severa)";
      image = "images/obesidade_grau_2.jpg";
    } else if (value >= 40) {
      classification = "Obesidade grau III (mórbida)";
      image = "images/obesidade_grau_3.jpg";
    }
    resultado = value.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: const Center(child: const Icon(Icons.house)),
        actions: [
          IconButton(
            icon: const Icon(Icons.replay_outlined),
            onPressed: () {
              setState(() {
                resultado = "";
                _controller_altura.text = "";
                _controller_peso.text = "";
                image = "images/default_image.jpeg";
              });
            },
          )
        ],
      ),
      body: ListView(
        children: [
          Center(
            child: Container(
              width: 300,
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  Image.asset(
                    image,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text("Altura"),
                      hintText: "Digite a altura em Metros.",
                    ),
                    controller: _controller_altura,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text("Peso"),
                      hintText: "Digite o peso em KG.",
                    ),
                    controller: _controller_peso,
                  ),
                  const SizedBox(height: 30.0),
                  TextButton(
                    child: const Text("Clica em mim"),
                    onPressed: () {
                      double altura = double.parse(_controller_altura.text);
                      double peso = double.parse(_controller_peso.text);
                      if (peso > 0 && altura > 0) {
                        value = (peso / (altura * altura));
                        setState(() {
                          calculate(value);
                        });
                      }
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
          ),
        ],
      ),
    );
  }
}
