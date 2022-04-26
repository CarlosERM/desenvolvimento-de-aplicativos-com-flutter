import 'dart:math';

import 'package:anuncios/anuncio.dart';
import 'package:anuncios/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Random random = new Random();
  List<String> frases = [
    "Eu sou uma vaca bonita.",
    "Eu sou a mais bela e estilosa de todas.",
    "Eu adoro bacon.",
    "O maldito do fazendeiro sempre rouba o meu leite.",
    "As vezes eu acho que vivo numa prisão.",
    "Eu ouvi dizer que a grama é verde.",
    "Por que as porteiras existem?",
  ];
  final List<Anuncio> _fazenda = List<Anuncio>.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SvgPicture.asset(
          "assets/ivaca_logo_1.svg",
        ),
        leadingWidth: 70,
        title: SvgPicture.asset(
          "assets/ivaca_logo_2.svg",
          height: 70,
          fit: BoxFit.scaleDown,
        ),
        backgroundColor: Colors.green,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _fazenda.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          Anuncio vaca = _fazenda.elementAt(index);

          return ListTile(
            key: Key(vaca.nome),
            leading:
                Image.asset("assets/cow_${index % 2 == 0 ? "1" : "2"}.png"),
            title: Text(
              vaca.nome,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green[600],
              ),
            ),
            subtitle: Text(
              frases[random.nextInt(6)],
            ),
            trailing: Text(
              "R\$ ${vaca.preco}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
            hoverColor: Colors.green[100],
            onLongPress: () async {
              Anuncio? vacaEditada = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterScreen(anuncio: vaca),
                ),
              );
              if (vacaEditada != null) {
                setState(
                  () {
                    _fazenda.remove(vaca);
                    _fazenda.insert(index, vacaEditada);
                  },
                );
              } else {
                setState(
                  () {
                    _fazenda.remove(vaca);
                  },
                );
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            Anuncio? vacaNova = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => RegisterScreen()));

            if (vacaNova != null) {
              print(_fazenda);
              setState(() {
                _fazenda.add(vacaNova);
              });
            }
          } catch (e) {
            print(e.toString());
          }
        },
        tooltip: 'Cadastrar Vacas',
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
