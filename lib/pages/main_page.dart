import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/bloc/user_bloc.dart';

class MainPage extends StatelessWidget {
  final VoidCallback goToLogin;

  const MainPage({super.key, required this.goToLogin});

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserAuthenticated) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Hello', style: TextStyle(fontSize: 24, color: Colors.black)),
                  Text(state.email, style: const TextStyle(fontSize: 20, color: Colors.black)),
                ],
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