import 'package:dio/dio.dart';
import 'package:flutter_labour9/ept/user.dart';
import 'package:retrofit/http.dart';

part 'api.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/users")
  Future<List<User>> getUsers();
}
