import 'dart:convert';
import 'package:http/http.dart' as http;

class UserRepository {
  final String baseUrl;

  UserRepository({required this.baseUrl});

  Future<List<dynamic>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load users.');
    }
  }
}
