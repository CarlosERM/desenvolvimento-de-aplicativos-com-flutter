import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Hello World",
           style: TextStyle(fontSize: 18, color: Colors.blue,),
           ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
        child: Text("Hello World de novo mano"),
      )
    );
  }
}
