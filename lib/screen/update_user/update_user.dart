import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_crud/screen/homepage/homepage.dart';

import '../../controller/user_controller.dart';
import '../../model/user_model.dart';
import '../../repository/user_repository.dart';

// ignore: must_be_immutable
class UserUpdateScreen extends ConsumerStatefulWidget {
  User user;

  UserUpdateScreen({
    super.key,
    required this.user,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserUpdateScreenState();
}

class _UserUpdateScreenState extends ConsumerState<UserUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //get user by id
    final user = ref.watch(GetUserProvider(widget.user.id));
    //get all user

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //get user by id
              user.when(
                data: (data) => Text('Name: ${data?.name ?? ''}'),
                loading: () => const CircularProgressIndicator(),
                error: (error, stackTrace) => Text('Error: $error'),
              ),
              //update user
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _updateUser,
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateUser() async {
    final userRepository = ref.read(usersRepositoryProvider);

    if (_formKey.currentState!.validate()) {
      final user = User(
        id: widget.user.id,
        name: _nameController.text,
        email: _emailController.text,
      );

      try {
        await userRepository.updateUser(user);

        Navigator.pop(context);
      } catch (e) {
        if (kDebugMode) {
          print('Error updating user: $e');
        }
        // Show error message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error updating user. Please try again.'),
          ),
        );
      }
    }
  }
}
