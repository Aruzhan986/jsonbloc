import 'package:dio/dio.dart';
import 'package:flutter_labour9/api.dart';
import 'package:flutter_labour9/ept/user.dart';

class UserRepository {
  final ApiService apiService;

  UserRepository(Dio dio)
      : apiService =
            ApiService(dio, baseUrl: 'https://jsonplaceholder.typicode.com');

  Future<List<User>> fetchUsers() async {
    return await apiService.getUsers();
  }
}

final dio = Dio();
final userRepository = UserRepository(dio);
