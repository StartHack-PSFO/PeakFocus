import 'package:flutter/material.dart';
import 'package:neuroapp/views/homeView.dart';

class ResultView extends StatelessWidget {
  ResultView({Key? key}) : super(key: key);
  var progress = 0.65;
  var seconds = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: const Text(
            "Neuro Routine Trainer",
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Results',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 20),
            Container(
              width: 220,
              height: 350,
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.scale(
                        scale: 5,
                        child: CircularProgressIndicator(
                          value: progress,
                          strokeWidth: 5,
                        )),
                    Text(
                      '${(progress * 100)}%',
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              'Duration: ${seconds} sec',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200),
            ),
            Padding(
              padding: EdgeInsets.all(33.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeView()),
                  );
                },
                child: Text('Focus again'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
