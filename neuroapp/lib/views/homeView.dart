import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neuroapp/views/routineView.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.title});
  final String title;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedDelay = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Ready to start working on your routine?',
              style: TextStyle(fontSize: 18),
            ),
            const Text(
              'Do you need a delay before we start recording?',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              width: 200,
              child: CupertinoTextField(
                keyboardType: TextInputType.number,
                placeholder: 'Enter delay in seconds',
                onChanged: (value) {
                  setState(() {
                    _selectedDelay = int.tryParse(value) ?? 0;
                  });
                },
              ),
            ),
            Text(
              'Selected Delay: $_selectedDelay seconds',
              style: TextStyle(fontSize: 18),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RoutineView(),
                  ),
                );
              },
              child: Text('Start Routine Training'),
            ),
          ],
        ),
      ),
    );
  }
}
