// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'app_page.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final TextEditingController textEditingController = TextEditingController();
  List<String> todoList = [];

  void resetTextField() {
    this.textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Swift Todo List'),
          backgroundColor: Colors.blueGrey,
        ),
        body: AppPage(
          todoList: this.todoList,
          textEditingController: this.textEditingController,
          listenGetTodoList: () {},
          sendTodo: () {},
          deleteTodo: (todo) {},
        ),
      ),
    );
  }
}
