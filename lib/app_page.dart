import 'package:flutter/material.dart';

class AppPage extends StatefulWidget {
  final Function listenGetTodoList;
  final Function sendTodo;
  final Function(String) deleteTodo;
  final List<String> todoList;
  final TextEditingController textEditingController;

  const AppPage({
    super.key,
    required this.listenGetTodoList,
    required this.sendTodo,
    required this.deleteTodo,
    required this.todoList,
    required this.textEditingController,
  });

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 10,
            child: SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.todoList.length,
                itemBuilder: (contenxt, index) => Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          widget.todoList[index],
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                        ),
                        onPressed: () {
                          widget.deleteTodo(widget.todoList[index]);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 10,
                child: TextFormField(
                  controller: widget.textEditingController,
                  decoration: InputDecoration(
                      hintText: 'Nova Tarefa',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey))),
                ),
              ),
              Spacer(),
              Expanded(
                flex: 2,
                child: ClipRRect(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.blueGrey)),
                    onPressed: () {
                      widget.sendTodo();
                    },
                    child: FittedBox(
                        child: Icon(
                      Icons.send,
                    )),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
