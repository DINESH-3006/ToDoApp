import 'package:flutter/material.dart';
import 'package:todoapp/toDoItems.dart';
import 'package:uuid/uuid.dart';

class MyHomePage extends StatefulWidget {
   const MyHomePage({Key? key}):super(key:key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<ToDo> array=ToDo.toDoList();
  var newItem='';
  var searchedWord='';
  final TextEditingController _textController=TextEditingController();
  List<ToDo>searchToDoItem=[];

@override
void initState(){
  searchToDoItem=array;
  super.initState();
}
  Widget _buildToDoItem(ToDo todo) {
  return Container(
    margin: const EdgeInsets.all(10),
    child: Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 8,top: 4),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.only(right: 10,bottom: 5),
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: Colors.pinkAccent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: IconButton(
                onPressed: () {
                  _handleToDoChanges(todo);
                },
                icon: Icon(todo.isDone?Icons.check_box:Icons.check_box_outline_blank),
                iconSize: 30,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            onTap: () {
              _handleToDoChanges(todo);
            },
            tileColor: Colors.pink,
            title: Text(
              todo.todoText ?? '',
              style: TextStyle(
                decoration: todo.isDone ? TextDecoration.lineThrough : TextDecoration.none,
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                letterSpacing: 5,
              ),
            ),
            trailing: Container(
              width: 50, // Adjust the width as needed
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.only(left: 8),
                  child: Container(
                    padding: const EdgeInsets.only(right: 5),
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _deleteToDoItem(todo);

                        });
                      },
                      icon: const Icon(Icons.delete),
                      iconSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(25),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appData(),
      body: Stack(
        children: [

          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                margin:
                    const EdgeInsets.only(left: 10, bottom: 10, right: 10, top: 10),
                decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: TextField(
                  onChanged: (val){
                      _searchToDo(val);
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 25,
                    ),
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    for(var item in searchToDoItem.reversed)
                    _buildToDoItem(item),
          
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20,right: 20,left: 20,),
                    padding: const EdgeInsets.only(top: 10,bottom: 20,left: 20,right: 20,),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [BoxShadow(
                        color: Colors.grey,
                        offset: Offset(-5.0, 5.0),
                        blurRadius: 7.0,
                        spreadRadius: 3.0,
                      ),]
                    ),
                    child: TextField(
                      controller: _textController,
                      onChanged: (value){
                        newItem=value;
                      },
                      style: const TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.w400),
                      decoration: const InputDecoration(
                        hintText: 'Add Events Here',
                        hintStyle: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.w400,),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20,right: 20),
                  child: Container(
                    height: 60,
                    width: 60,
                    child: FloatingActionButton(
                      onPressed: (){
                        setState(() {
                          array.add(ToDo(id: Uuid().v4().toString(), todoText: newItem));
                          _textController.clear();
                        });
                      },
                      backgroundColor: Colors.pink,
                      foregroundColor: Colors.white,
                      hoverColor: Colors.pinkAccent,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: const Text('+',style: TextStyle(fontSize: 40),),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  ToDo _handleToDoChanges(ToDo todo){
    setState(() {
      todo.isDone=!todo.isDone;
    });
    return todo;
  }

  ToDo _deleteToDoItem(ToDo todo){
    array.removeWhere((element) => element.id==todo.id);
    return todo;
  }

  void _searchToDo(String searchedWord){
    setState(() {
    List<ToDo>res=[];
    if(searchedWord.isEmpty){
      res=array;
    }
    else{
      res=array.where((element) => element.todoText!.toLowerCase().contains(searchedWord.toLowerCase())).toList();
    }
   
      searchToDoItem=res;
    });
  }
}


AppBar appData() {
  return AppBar(
    backgroundColor: Colors.pinkAccent,
    leading: const Icon(
      Icons.menu,
      color: Colors.white,
      size: 38,
    ),
    actions: const [
      Padding(
        padding: EdgeInsets.only(right: 10),
        child: Icon(
          Icons.account_circle,
          color: Colors.white,
          size: 42,
        ),
      )
    ],
    title: const Text(
      'To Do App',
      style: TextStyle(
          color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
    ),
  );
}

