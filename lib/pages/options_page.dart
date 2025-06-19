import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/bloc/user_bloc.dart';

class OptionsPage extends StatelessWidget {
  final VoidCallback goToLogin;

  const OptionsPage({super.key, required this.goToLogin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserAuthenticated) {
              return ElevatedButton(
                onPressed: () {
                  context.read<UserBloc>().add(LogoutEvent());
                },
                child: const Text('Logout'),
              );
            } else {
              return ElevatedButton(
                onPressed: goToLogin,
                child: const Text('Go to Login'),
              );
            }
          },
        ),
      ),
    );
  }
}