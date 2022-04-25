import 'package:aula_task/cadastro_screen.dart';
import 'package:aula_task/task.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> _lista = List<Task>.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task App"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.separated(
        itemCount: _lista.length,
        separatorBuilder: (context, position) => const Divider(),
        itemBuilder: (context, position) {
          Task item = _lista.elementAt(position);
          return Dismissible(
            key: Key(item.descricao),
            secondaryBackground: Container(
                alignment: const Alignment(0.95, 0.0),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                color: Colors.red),
            background: Container(
                alignment: const Alignment(-0.95, 0.0),
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                color: Colors.green),
            onDismissed: (direction) => {
              if (direction == DismissDirection.endToStart)
                {
                  setState(() {
                    _lista.remove(item);
                  })
                }
            },
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                Task? editedTask = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CadastroScreen(task: item),
                  ),
                );
                if (editedTask != null) {
                  setState(
                    () {
                      _lista.remove(item);
                      _lista.insert(position, editedTask);
                    },
                  );
                }
                return false;
              } else {
                return true;
              }
            },
            child: ListTile(
              title: Text(
                item.descricao,
                style: TextStyle(
                  color: item.done ? Colors.grey : Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  decoration: item.done
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              trailing: Icon(Icons.check,
                  size: 30, color: item.done ? Colors.green : Colors.grey),
              onTap: () => {
                setState(() {
                  item.changeState();
                })
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            Task? task = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => CadastroScreen()));
            // Navigator.pushNamed(context, "/cadastro");

            if (task != null) {
              print(_lista);
              setState(() {
                _lista.add(task);
              });
            }
          } catch (e) {
            print(e.toString());
          }
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
    );
  }
}
