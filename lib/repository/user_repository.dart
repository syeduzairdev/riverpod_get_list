import 'package:riverpod_crud/dummy_json/dummy_json.dart';

import '../model/user_model.dart';
//UsersRepository class, this will handle getting the data from the API:
//defines a method to get a list of users from the API
//we parse the response body into a list of User

class UsersRepository {
  // final String _baseUrl = 'https://jsonplaceholder.typicode.com';

  // Future<List<User>> getUsers() async {
  //   final response = await http.get(Uri.parse('$_baseUrl/users'));
  //   if (response.statusCode == 200) {
  //     final jsonList = json.decode(response.body) as List<dynamic>;
  //     return jsonList.map((json) => User.fromJson(json)).toList();
  //   } else {
  //     throw Exception('Failed to load users');
  //   }
  // }
  List<User> getUser() {
    return UsersJson.map((json) => User.fromJson(json)).toList();
  }
}
