import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/todoController.dart';

class SavedTodosScreen extends StatelessWidget {
  final TodoController todoController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: todoController.isDarkTheme.value ? Colors.black38: Colors.white,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back,color:todoController.isDarkTheme.value
              ? Colors.white
              : Colors.white ,),
        ),
        title: Text('Saved Todos',style: TextStyle( color: todoController.isDarkTheme.value
            ? Colors.white
            : Colors.white,),),

        backgroundColor: todoController.isDarkTheme.value ? Colors.black : Colors.purple[900],
      ),
      body: Obx(() {
        final savedTodos = todoController.savedTodos;
        return savedTodos.isEmpty
            ? Center(
          child: Text(
            'No saved todos',
            style: TextStyle(
              color: todoController.isDarkTheme.value
                  ? Colors.white
                  : Colors.black, // Theme-based text color
            ),
          ),
        )
            : ListView.builder(
          itemCount: savedTodos.length,
          itemBuilder: (context, index) {
            final todo = savedTodos[index];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                color: todoController.isDarkTheme.value
                    ? Colors.grey[850] // Dark theme background color for cards
                    : Colors.white, // Light theme background color for cards
                child: ListTile(
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      color: todoController.isDarkTheme.value
                          ? Colors.white
                          : Colors.black, // Theme-based title text color
                    ),
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
                            : Colors.red,
                        size: 13,
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: todoController.isDarkTheme.value
                          ? Colors.white // Dark theme icon color
                          : Colors.red, // Light theme icon color
                    ),
                    onPressed: () {
                      todoController.toggleBookmark(todo);
                    },
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
