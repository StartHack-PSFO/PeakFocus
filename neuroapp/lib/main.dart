import 'package:flutter/material.dart';
import 'package:neuroapp/views/homeView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NavDrawerDemo(), // Use NavDrawerDemo as the home widget
    );
  }
}

class NavDrawerDemo extends StatefulWidget {
  const NavDrawerDemo({Key? key}) : super(key: key);

  @override
  _NavDrawerDemoState createState() => _NavDrawerDemoState();
}

class _NavDrawerDemoState extends State<NavDrawerDemo> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [HomeView(), Container()]; // Replace Container() with other views

  @override
  Widget build(BuildContext context) {
    final drawerHeader = UserAccountsDrawerHeader(
      accountName: Text(
        "Tiger Woods",
      ),
      accountEmail: Text(
        "tiger@woods.com",
      ),
      currentAccountPicture: const CircleAvatar(
        child: FlutterLogo(size: 42.0),
      ),
    );
    final drawerItems = ListView(
      children: [
        drawerHeader,
        ListTile(
          title: Text(
            "Train Routines",
          ),
          leading: const Icon(Icons.favorite),
          onTap: () {
            setState(() {
              _selectedIndex = 0;
            });
            Navigator.pop(context);
          },
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Neuro Routine Trainer",
        ),
      ),
      body: Semantics(
        container: true,
        child: Center(
          child: _pages[_selectedIndex],
        ),
      ),
      drawer: Drawer(
        child: drawerItems,
      ),
    );
  }
}
