import 'package:flutter/material.dart';
import 'package:myapp/pages/login_page.dart';
import 'package:myapp/pages/main_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/bloc/user_bloc.dart';
import 'package:myapp/pages/options_page.dart';
import 'package:myapp/pages/settings.dart';

void main() {
  runApp(
    const MainApp(),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

 void goToLogin() {
    setState(() {
      _selectedIndex = 0;
    });
  }

 void goToMainPage() {
    setState(() {
      _selectedIndex = 1;
    });
  }

    @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

        ),
        home: Scaffold(
          body: IndexedStack(
            index: _selectedIndex,
            children:     [LoginPage(onSubmit: goToMainPage), 
      MainPage(goToLogin: goToLogin,),
      OptionsPage(goToLogin: goToLogin),
      const SettingsPage()],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Login',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.visibility),
              label: 'Main',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Options',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_applications),
              label: 'Settings',
            ),
          ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}