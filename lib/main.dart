import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  String get channelName => "com.meuapp.todo-list";
  String get methodGetName => "getTodoList";
  String get methodSetName => "setTodo";
  String get methodDeleteName => "deleteTodo";
  late MethodChannel nativeChannel;
  final TextEditingController textEditingController = TextEditingController();
  List<String> todoList = [];

  @override
  void initState() {
    super.initState();
    this.nativeChannel = MethodChannel(this.channelName);
    this.listenGetTodoList();
  }

  Future<void> listenGetTodoList() async {
    try {
      this.nativeChannel.setMethodCallHandler((call) async {
        if (call.method == this.methodGetName) {
          final List<dynamic> arguments = call.arguments;
          this.todoList = arguments.cast<String>();
          setState(() {
            this.resetTextField();
          });
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> sendTodo() async {
    try {
      final todo = this.textEditingController.text;
      await this.nativeChannel.invokeMethod(this.methodSetName, todo);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteTodo({required String todo}) async {
    try {
      await this.nativeChannel.invokeMethod(this.methodDeleteName, todo);
    } catch (e) {
      print(e.toString());
    }
  }

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
          listenGetTodoList: () {
            this.listenGetTodoList();
          },
          sendTodo: () {
            this.sendTodo();
          },
          deleteTodo: (todo) {
            this.deleteTodo(todo: todo);
          },
        ),
      ),
    );
  }
}
