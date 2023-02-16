import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/user_model.dart';
import '../repository/user_repository.dart';

//Finally, we'll define the Riverpod provider that we'll use in our app:
//The usersRepositoryProvider provider creates a new instance of the UsersRepository class.
//The usersProvider provider is a FutureProvider that uses the usersRepositoryProvider to get a list of users from the API.
final usersRepositoryProvider = Provider<UsersRepository>((ref) {
  return UsersRepository();
});
//We're using the watch method to get an instance of the UsersRepository class and calling the getUsers method to get the data.

//You can then use the usersProvider provider in your widgets to display the data from the API.
//get all user
final usersProvider = FutureProvider<List<User>>((ref) async {
  final repository = ref.watch(usersRepositoryProvider);
  return repository.getUser();
});
//get user by user id
final GetUserProvider = FutureProvider.family<User?, int>((ref, id) async {
  final repository = ref.watch(usersRepositoryProvider);
  return repository.getUserById(id);
});
//update user
final updateUserProvider =
    FutureProvider.family<User?, User>((ref, user) async {
  final repository = ref.watch(usersRepositoryProvider);
  return repository.updateUser(user);
});
//delete user
final deleteUserProvider =
    FutureProvider.family<User?, User>((ref, user) async {
  final repository = ref.watch(usersRepositoryProvider);
  return repository.deleteUser(user);
});
//create user
final createUserProvider =
    FutureProvider.family<User?, User>((ref, user) async {
  final repository = ref.watch(usersRepositoryProvider);
  return repository.createUser(user);
});
