class Todo {
  String? id;
  String? todoText;
  bool isDone;

  Todo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<Todo> todoList() {
    return [
      Todo(id: '01', todoText: 'Learn Flutter', isDone: false),
      Todo(id: '02', todoText: 'for practice Flutter', isDone: true),
      Todo(id: '03', todoText: 'Nurnajiha', isDone: false),
      Todo(id: '04', todoText: 'Developed by', ),
      Todo(id: '05', todoText: 'this todo app', isDone: true),
    ];
  }
}