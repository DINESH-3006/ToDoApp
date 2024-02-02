class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone=false,
  });

  static List<ToDo> toDoList(){
      return[
        ToDo(id: '01',todoText: 'GFG POTD',isDone: false),
        ToDo(id: '02', todoText: 'Leet Code'),
        ToDo(id: '04', todoText: 'Submit Assignment'),
        ToDo(id: '03', todoText: 'Codechef contest',isDone: true),
      ];
  }
}