import 'package:flutter/material.dart';
import 'package:riverpod_crud/controller/user_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../update_user/update_user.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  @override
  Widget build(BuildContext context) {
    final usersState = ref.watch(usersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod CRUD'),
      ),
      body: usersState.when(
        data: (users) {
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserUpdateScreen(
                        user: user,
                      ),
                    ),
                  );
                },
                child: ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text(error.toString())),
      ),
    );
  }
}
