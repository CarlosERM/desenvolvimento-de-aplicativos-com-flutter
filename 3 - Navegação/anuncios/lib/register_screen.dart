import 'package:anuncios/anuncio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key, this.anuncio}) : super(key: key);
  Anuncio? anuncio;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formalKey = GlobalKey<FormState>();

  late final TextEditingController _vacaController = TextEditingController();

  late final TextEditingController _precoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.anuncio != null) {
      setState(() {
        _vacaController.text = widget.anuncio!.nome;
        _precoController.text = widget.anuncio!.preco;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cadastro de Vacas",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: Form(
        key: _formalKey,
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const SizedBox(height: 40),
              SvgPicture.asset("assets/ivaca_logo_1.svg",
                  color: Colors.green, height: 100),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Nome da Vaca",
                ),
                style: TextStyle(
                  color: Colors.green[800],
                  fontSize: 18,
                ),
                controller: _vacaController,
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return "Preenchimento obrigatório";
                  }
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Preço da Vaca",
                ),
                style: TextStyle(
                  color: Colors.green[800],
                  fontSize: 18,
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[0-9]+[,.]{0,1}[0-9]*'),
                  ),
                  TextInputFormatter.withFunction(
                    (oldValue, newValue) => newValue.copyWith(
                      text: newValue.text.replaceAll('.', ','),
                    ),
                  ),
                ],
                controller: _precoController,
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return "Preenchimento obrigatório";
                  }
                },
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.anuncio != null)
                    ElevatedButton(
                      child: const Text(
                        "Deletar",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        if (_formalKey.currentState!.validate()) {
                          Navigator.pop(context, null);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 20,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  const SizedBox(
                    width: 30.0,
                  ),
                  ElevatedButton(
                    child: Text(
                      widget.anuncio != null ? "Editar" : "Cadastrar",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      if (_formalKey.currentState!.validate()) {
                        String nome = _vacaController.text.toString();
                        String preco = _precoController.text.toString();
                        Anuncio novoAnuncio = Anuncio(nome, preco);
                        Navigator.pop(context, novoAnuncio);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 20,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
