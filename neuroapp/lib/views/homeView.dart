import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neuroapp/views/delayView.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedDelay = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .primary,
        title: Text('Home View'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(maxWidth * 0.05), // Responsive margin
                  child: Text(
                    'Ready to start working on your routine?',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: maxWidth * 0.05),
                  // Responsive horizontal margin
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: maxWidth * 0.02),
                        // Responsive right margin
                        child: Text(
                          'Delay recording:',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        width: maxWidth * 0.3, // Responsive width
                        child: CupertinoTextField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              _selectedDelay = int.tryParse(value) ?? 0;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: maxWidth * 0.02),
                        // Responsive right margin
                        child: Text(
                          's',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(maxWidth * 0.05), // Responsive margin
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DelayView(delay: _selectedDelay),
                        ),
                      );
                    },
                    child: Text('Start Routine Training'),
                  ),),
              ],
            ),
          );
        },
      ),
    );
  }
}
