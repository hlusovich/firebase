import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/bloc/user_bloc.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onSubmit;

  const LoginPage({super.key, required this.onSubmit});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>(); 
  final _emailController = TextEditingController();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Padding(
              padding: const EdgeInsets.all(16.0),              
              child: BlocConsumer<UserBloc, UserState>(
                listener: (context, state) {
                  if (state is UserAuthenticated) {
                    widget.onSubmit();
                  } else if (state is UserError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is UserLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('Welcome Back!'),
                        const SizedBox(height: 16.0),
                        // Email Field
                        TextFormField(
                          controller: _emailController,
                          onChanged: (_) => setState(() {}),
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!value.contains('@') || !value.contains('.')) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        // Login Field
                        TextFormField(
                          controller: _loginController,
                          decoration: const InputDecoration(
                            labelText: 'Login',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 16.0),
                        // Password Field
                        TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                          ),
                          obscureText: true,
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 24.0),
                        ElevatedButton(
                          onPressed: (_emailController.text.isNotEmpty &&
                                      _passwordController.text.isNotEmpty) ||
                                  (_loginController.text.isNotEmpty &&
                                      _passwordController.text.isNotEmpty)
                              ? () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<UserBloc>().add(
                                          LoginEvent(
                                            _emailController.text,
                                            _passwordController.text,
                                          ),
                                        );
                                  }
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          child: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}