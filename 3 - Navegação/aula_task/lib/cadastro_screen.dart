import 'dart:io';

import 'package:aula_task/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CadastroScreen extends StatefulWidget {
  Task? task;
  CadastroScreen({Key? key, this.task}) : super(key: key);

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _formalKey = GlobalKey<FormState>();
  File _image = File("");

  late TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      setState(() {
        _textController.text = widget.task!.descricao;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? "Cadastro" : "Editar"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Form(
          key: _formalKey,
          child: Column(
            children: [
              GestureDetector(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 20.0,
                    ),
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border:
                          Border.all(width: 1, color: const Color(0xFFBDBDBD)),
                      shape: BoxShape.circle,
                    ),
                    child: _image == null
                        ? Icon(
                            Icons.add_a_photo,
                            size: 30,
                          )
                        : ClipOval(
                            child: Image.file(_image),
                          ),
                  ),
                  onTap: () async {
                    final ImagePicker _picker = ImagePicker();
                    final XFile? pickedFile =
                        await _picker.pickImage(source: ImageSource.camera);
                    if (pickedFile != null) {
                      setState(
                        () {
                          _image = File(pickedFile.path);
                        },
                      );
                    }
                  }),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: TextFormField(
                    controller: _textController,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "Preenchimento obrigatório";
                      }
                      if (value.toString().length < 3) {
                        return "Mínimo de 3 caracteres";
                      }
                    },
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                      labelText: "Título",
                      labelStyle: TextStyle(
                        fontSize: 20,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide:
                              BorderSide(color: Colors.purple, width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide:
                              BorderSide(color: Colors.purple, width: 2)),
                    ),
                  )),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formalKey.currentState!.validate()) {
                          String texto = _textController.text.toString();
                          Task newTask = Task(texto);
                          Navigator.pop(context, newTask);
                        }
                      },
                      child: const Text(
                        "Cadastrar",
                        style: TextStyle(fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                    ),
                  )),
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        "Cancelar",
                        style: TextStyle(fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                    ),
                  ))
                ],
              )
            ],
          )),
    );
  }
}
