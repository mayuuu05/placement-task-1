import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  Future<List<Map<String, dynamic>>> fetchData() async {
    String todoApi = 'https://jsonplaceholder.typicode.com/todos';
    Uri uri = Uri.parse(todoApi);
    Response response = await http.get(uri);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
