import 'package:flutter/material.dart';

class RoutineView extends StatelessWidget {

  const RoutineView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Routine View'),
      ),
      body: Center(
        child: Text(
          'hello',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
