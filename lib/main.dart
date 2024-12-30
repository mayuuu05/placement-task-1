import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:placement_task1/screens/home_screen.dart';

void main() {
  runApp(TodosApp());
}

class TodosApp extends StatelessWidget {
  const TodosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
        getPages:[
          GetPage(
            name: '/',
            page: () =>  HomeScreen(),
          ),
        ],


    );
  }
}
