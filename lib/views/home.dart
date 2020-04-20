import 'package:flutter/material.dart';
import 'package:todo_flutter/models/tarefa.dart';
import 'package:todo_flutter/views/nova_tarefa.dart';

class Home extends StatefulWidget {
  List<Tarefa> tarefas = new List<Tarefa>();

  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo'),
      ),
      body: Container(
        child: widget.tarefas.length == 0
            ? Center(
                child: Text('Não possui tarefas, que tal adicionar algumas?'),
              )
            : ListView.builder(
                itemCount: widget.tarefas.length,
                itemBuilder: (BuildContext context, int index) {
                  final Tarefa tarefa = widget.tarefas[index];
                  return CheckboxListTile(
                    title: Text(tarefa.nome),
                    subtitle: Text(tarefa.descricao),
                    onChanged: (bool value) {
                      setState(() => tarefa.pronta = value);
                    },
                    value: tarefa.pronta,
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addTarefa(),
        child: Icon(Icons.add),
      ),
    );
  }

  addTarefa() async {
    final Tarefa result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NovaTarefa(),
        ));

    if (result != null) {
      var tarefa = new Tarefa(
        nome: result.nome,
        descricao: result.descricao,
        pronta: false,
      );
      setState(() {
        widget.tarefas.add(tarefa);
      });
    }
  }
}
