import '../constants/color.dart';
import '../widgets/todo_item.dart';
import '../model/todo.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final todoList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _appBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                _searchBox(),
                Expanded(
                  child: _listView(),
                ),
              ],
            ),
          ),
          _addNewItem(),
        ],
      ),
    );
  }

  Align _addNewItem() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                bottom: 20,
                right: 20,
                left: 20,
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 10.0,
                    spreadRadius: 0.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _todoController,
                decoration: InputDecoration(
                  hintText: 'Add New Todo Item',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: 20,
              right: 20,
            ),
            child: ElevatedButton(
              child: Text(
                '+',
                style: TextStyle(fontSize: 30),
              ),
              onPressed: () {
                _AddToDoItem(_todoController.text);
              },
              style: ElevatedButton.styleFrom(
                  primary: tdBlue, minimumSize: Size(60, 60), elevation: 10),
            ),
          ),
        ],
      ),
    );
  }

  ListView _listView() {
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 50,
            bottom: 20,
          ),
          child: Text(
            'All ToDos',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        for (ToDo todo in _foundToDo.reversed)
          ToDoItem(
            todo: todo,
            onToDoChanged: _handleTodoChanged,
            onDeleteItem: _DeleteItem,
          ),
      ],
    );
  }

  void _handleTodoChanged(ToDo todo) {
    setState(() {
      // Toggle the 'isDone' property of the todo
      todo.isDone = !todo.isDone;
    });
  }

  void _DeleteItem(String id) {
    setState(() {
      // Toggle the 'isDone' property of the todo
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void _AddToDoItem(String toDo) {
    setState(() {
      // Toggle the 'isDone' property of the todo
      todoList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo,
      ));
    });
    _todoController.clear();
  }

  void _RunFilter(String enteredKeyword) {
    // Toggle the 'isDone' property of the todo
    List<ToDo> result = [];
    if (enteredKeyword.isEmpty) {
      result = todoList;
    } else {
      result = todoList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = result;
    });
  }

  Container _searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => _RunFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/avatars.jpg'),
            ),
          ),
        ],
      ),
    );
  }
}
