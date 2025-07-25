import 'package:flutter/material.dart';
import 'package:todo_app/constans/colors.dart';
import 'package:todo_app/model/todo.dart';

class Todoitems extends StatelessWidget {
  final Todo todo;
  final onToDochanged;
  final onDeleteItem;
  const Todoitems({
    super.key,
    required this.todo,
    required this.onToDochanged,
    required this.onDeleteItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: ListTile(
        onTap: () {
          // print('clicke me');
          onToDochanged(todo);
        },
        contentPadding: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        tileColor: tdWhite,
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: tdBlue,
          size: 30,
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: tdBlack,
            decoration: todo.isDone
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        trailing: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            onPressed: () {
              onDeleteItem(todo.id);
            },
            icon: Icon(Icons.delete, color: tdWhite, size: 20),
          ),
        ),
      ),
    );
  }
}
