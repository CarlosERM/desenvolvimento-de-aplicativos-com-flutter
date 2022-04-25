import 'dart:io';
import 'package:aula_task/cadastro_screen.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.purple,
    ),
    initialRoute: "/",
    routes: {
      "/": (context) => HomeScreen(),
      "/cadastro": (context) => CadastroScreen()
    },
  ));
}
