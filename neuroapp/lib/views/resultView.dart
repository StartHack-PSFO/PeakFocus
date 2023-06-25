import 'package:flutter/material.dart';
import 'package:neuroapp/views/data_controller.dart';
import 'package:neuroapp/views/timerView.dart';

class ResultView extends StatefulWidget {
  ResultView({Key? key}) : super(key: key);

  @override
  _ResultViewState createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  var progress = DataController.to.sum / DataController.to.counter;
  var seconds = 20;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Set up a listener to update the progress value when animation value changes
    _animationController.addListener(() {
      setState(() {
        progress = _animationController.value;
      });
    });

    // Start the animation with the desired value
    _animationController.animateTo(progress);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Hero(
                tag: 'mainLogo',
                child: Image(
                  image: AssetImage('assets/Logo.png'),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Results',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                )),
            const SizedBox(
              width: 60.0,
              height: 2.0,
              child: const DecoratedBox(
                decoration: const BoxDecoration(color: Colors.white),
              ),
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
                        strokeWidth: 4,
                      ),
                    ),
                    Text('Avg:\n',
                        style: TextStyle(
                            fontSize: 22,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w300)),
                    Text('\n${(progress * 100).toStringAsFixed(0)}%',
                        style: TextStyle(
                            fontSize: 32,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w300)),
                  ],
                ),
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Text(
            //           'Focus:',
            //           style:
            //               TextStyle(fontSize: 22, fontWeight: FontWeight.w200),
            //         ),
            //         Text(
            //           'Timer:',
            //           style:
            //               TextStyle(fontSize: 22, fontWeight: FontWeight.w200),
            //         ),
            //       ],
            //     ),
            //     Padding(
            //         padding: EdgeInsets.all(32),
            //         child: Column(
            //           children: [
            //             Text(
            //               '${(progress * 100).toStringAsFixed(0)}%',
            //               style: TextStyle(
            //                   fontSize: 22, fontWeight: FontWeight.w200),
            //             ),
            //             Text(
            //               '$seconds s',
            //               style: TextStyle(
            //                   fontSize: 22, fontWeight: FontWeight.w200),
            //             ),
            //           ],
            //         ))
            //   ],
            // ),
            Padding(
              padding: EdgeInsets.all(33.0),
              child: ElevatedButton(
                onPressed: () {
                  DataController.to.sum = 0;
                  DataController.to.counter = 0;
                  Navigator.pop(context);
                },
                child: Text('Go Again', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
