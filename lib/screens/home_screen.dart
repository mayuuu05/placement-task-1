import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placement_task1/screens/save_screen.dart';

import '../controller/todoController.dart';
import '../model/todo_model.dart';

class HomeScreen extends StatelessWidget {
  final TodoController todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {

    return Obx(() {
      final isDarkTheme = todoController.isDarkTheme.value;
      return Scaffold(
        backgroundColor: isDarkTheme ? Colors.black38: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: isDarkTheme ? Colors.black : Colors.purple[900],
          leading: Icon(Icons.menu, color: Colors.white),
          title: Text(
            'TODO App',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: [

            PopupMenuButton<int>(
              icon: Icon(Icons.more_vert, color: Colors.white),
              onSelected: (value) {
                if (value == 0) {
                  todoController.toggleTheme();
                } else if (value == 1) {
                  todoController.toggleGridView();
                } else if (value == 2) {
                  Get.to(SavedTodosScreen());
                }
              },
              itemBuilder: (BuildContext context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: Row(
                    children: [
                      Icon(
                        isDarkTheme ? Icons.nightlight_round : Icons.sunny,
                        color: Colors.black,
                      ),
                      SizedBox(width: 8),
                      Text(isDarkTheme ? "Switch to Light Mode" : "Switch to Dark Mode")
                    ],
                  ),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(
                        todoController.isGridView.value ? Icons.grid_view : Icons.list,
                        color: Colors.black,
                      ),
                      SizedBox(width: 8),
                      Text(todoController.isGridView.value ? "Switch to List View" : "Switch to Grid View")
                    ],
                  ),
                ),
                PopupMenuItem<int>(
                  value: 2,
                  child: Row(
                    children: [
                      Icon(Icons.bookmark, color: Colors.black),
                      SizedBox(width: 8),
                      Text("Saved Todos")
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),

        body: FutureBuilder(
          future: todoController.fetchApiData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Failed to load data'));
            } else if (snapshot.hasData) {
              final todoList = snapshot.data as List<Todo>;
              return Obx(
                    () => todoController.isGridView.value
                    ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: todoList.length,
                    itemBuilder: (context, index) {
                      final todo = todoList[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: isDarkTheme
                              ? Colors.grey[800]
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ID: ${todo.id}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isDarkTheme
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              SizedBox(height: 8.0),
                              SizedBox(
                                height: 50,
                               child:  Flexible(
                                  child: Text(
                                    todo.title,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: isDarkTheme
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    todo.completed
                                        ? 'Completed'
                                        : 'Pending',
                                    style: TextStyle(
                                      color: todo.completed
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                  Icon(
                                    todo.completed
                                        ? Icons.check_circle
                                        : Icons.error,
                                    color: todo.completed
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                          Obx(() => IconButton(
                            icon: Icon(
                              todoController.savedTodos.any((item) => item.id == todo.id)
                                  ? Icons.bookmark
                                  : Icons.bookmark_outline_outlined,
                              color: isDarkTheme? Colors.white:Colors.purple[900],
                            ),
                            onPressed: () {
                              todoController.toggleBookmark(todo);
                            },
                          ))



                          ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
                    : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: todoList.length,
                    itemBuilder: (context, index) {
                      final todo = todoList[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 8.0),
                        decoration: BoxDecoration(
                          color: isDarkTheme
                              ? Colors.grey[800]
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ListTile(
                          title: Text(
                            todo.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isDarkTheme
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                todo.completed ? 'Completed  ' : 'Pending  ',
                                style: TextStyle(
                                  color: todo.completed
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                              Icon(
                                todo.completed
                                    ? Icons.check_circle
                                    : Icons.error,
                                color: todo.completed
                                    ? Colors.green
                                    : Colors.red,size: 13,
                              ),
                            ],
                          ),
                          trailing:

                          Obx(() => IconButton(
                            icon: Icon(
                              todoController.savedTodos.any((item) => item.id == todo.id)
                                  ? Icons.bookmark
                                  : Icons.bookmark_outline_outlined,
                              color :isDarkTheme? Colors.white:Colors.purple[900],                            ),
                            onPressed: () {
                              todoController.toggleBookmark(todo);
                            },
                          ))


                        ),
                      );
                    },
                  ),
                ),
              );
            } else {
              return Center(child: Text('No data available'));
            }
          },
        ),
      );
    });
  }
}
