import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:todo_app/constans/colors.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/widgets/todoItems.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = Todo.todoList();
  List<Todo> _foundToDo = [];
  final _todoController = TextEditingController();
  @override
  void initState() {
    _foundToDo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdbgcolor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                SearchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(15),
                        child: Text(
                          'All ToDos',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: tdBlack,
                          ),
                        ),
                      ),
                      for (Todo todoo in _foundToDo.reversed)
                        Todoitems(
                          todo: todoo,
                          onToDochanged: _handleTodochange,
                          onDeleteItem: _deleteTodoItem,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20, right: 10, left: 20),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: tdWhite,
                      boxShadow: const [
                        BoxShadow(
                          color: tdGray,
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: Offset(0.0, 0.0),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Add a new todo',
                        hintStyle: TextStyle(color: tdGray),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: tdBlue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      _addToDoItem(_todoController.text);
                    },
                    child: Icon(Icons.add, color: tdWhite, size: 30),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      shadowColor: Colors.transparent,
                      // minimumSize: Size(50, 50),
                      padding: EdgeInsets.all(10),
                      backgroundColor: tdBlue,
                      elevation: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _runFilter(String enterKeyword) {
    List<Todo> result = [];
    if (enterKeyword.isEmpty) {
      result = todoList;
    } else {
      result = todoList
          .where(
            (item) => item.todoText!.toLowerCase().contains(
              enterKeyword.toLowerCase(),
            ),
          )
          .toList();
    }
    setState(() {
      _foundToDo = result;
    });
  }

  void _handleTodochange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _addToDoItem(String toDo) {
    setState(() {
      todoList.add(
        Todo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDo,
        ),
      );
    });
    _todoController.clear();
  }

  void _deleteTodoItem(String id) {
    setState(() {
      todoList.removeWhere((item) {
        return item.id == id;
      });
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdbgcolor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.menu, color: tdBlack, size: 40),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: tdGray,
              borderRadius: BorderRadius.circular(30),
              // border: Border.all(color: tdBlack, width: 1.5),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                'assets/images/G.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget SearchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.all(15),
      height: 50,
      decoration: BoxDecoration(
        color: tdWhite,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search',
          prefixIcon: Icon(Icons.search, color: tdBlack),
          contentPadding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}
