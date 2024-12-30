import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../helper/todo_helper.dart';
import '../model/todo_model.dart';

class TodoController extends GetxController {
  var apiHelper = ApiHelper();
  List<Todo> todos = [];
  RxList<Todo> savedTodos = <Todo>[].obs;
  RxBool isGridView = true.obs;
  RxBool isDarkTheme = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadSavedTodos();
  }

  Future<List<Todo>> fetchApiData() async {
    final data = await apiHelper.fetchData();
    todos = data.map((json) => Todo.fromJson(json)).toList();
    await loadSavedTodos();
    return todos;
  }

  void toggleGridView() {
    isGridView.value = !isGridView.value;
  }

  void toggleTheme() {
    isDarkTheme.value = !isDarkTheme.value;
  }

  Future<void> saveTodoLocally(Todo todo) async {
    final prefs = await SharedPreferences.getInstance();
    if (!savedTodos.any((item) => item.id == todo.id)) {
      savedTodos.add(todo);
    }
    final savedList = savedTodos.map((e) => json.encode(e.toJson())).toList();
    await prefs.setStringList('savedTodos', savedList);
  }

  Future<void> loadSavedTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final savedList = prefs.getStringList('savedTodos') ?? [];
    savedTodos.value = savedList.map((e) => Todo.fromJson(json.decode(e))).toList();
  }

  Future<void> toggleBookmark(Todo todo) async {
    final prefs = await SharedPreferences.getInstance();

    if (savedTodos.any((item) => item.id == todo.id)) {
      savedTodos.removeWhere((item) => item.id == todo.id);
    } else {
      savedTodos.add(todo);
    }

    final savedList = savedTodos.map((e) => json.encode(e.toJson())).toList();
    await prefs.setStringList('savedTodos', savedList);
  }

  Future<void> removeTodoFromSaved(Todo todo) async {
    final prefs = await SharedPreferences.getInstance();
    savedTodos.removeWhere((item) => item.id == todo.id);

    final savedList = savedTodos.map((e) => json.encode(e.toJson())).toList();
    await prefs.setStringList('savedTodos', savedList);
  }
}

