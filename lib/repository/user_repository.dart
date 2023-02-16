import 'package:riverpod_crud/dummy_json/dummy_json.dart';

import '../model/user_model.dart';
//UsersRepository class, this will handle getting the data from the API:
//defines a method to get a list of users from the API
//we parse the response body into a list of User

class UsersRepository {
  //get all user
  List<User> getUser() {
    return UsersJson.map((json) => User.fromJson(json)).toList();
  }

  //get user by user id
  getUserById(int id) {
    return UsersJson.map((json) => User.fromJson(json))
        .toList()
        .firstWhere((element) => element.id == id);
  }

//update user
  updateUser(User user) {
    return UsersJson.map((json) => User.fromJson(json))
        .toList()
        .firstWhere((element) => element.id == user.id);
  }

  //create user
  createUser(User user) {
    return UsersJson.map((json) => User.fromJson(json))
        .toList()
        .firstWhere((element) => element.id == user.id);
  }

  //delete user
  deleteUser(User user) {
    return UsersJson.map((json) => User.fromJson(json))
        .toList()
        .firstWhere((element) => element.id == user.id);
  }
}
