import 'package:flutter/material.dart';
import 'package:neuroapp/views/resultView.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'hello',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResultView()),
                );
              },
              child: Text('Go to Result View'),
            ),
          ],
        ),
      ),
    );
  }
}
