import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neuroapp/views/delayView.dart';
import 'package:neuroapp/views/routineView.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedDelay = 0;
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomeView()
  ]; // Replace Container() with other views

  void _selectDelay() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        Duration selectedDuration = Duration(seconds: _selectedDelay);

        return GestureDetector(
          onTap: () {
            Navigator.pop(context, selectedDuration);
          },
          child: Container(
            height: 216, // Adjust the height as needed
            child: CupertinoTimerPicker(
              mode: CupertinoTimerPickerMode.ms,
              initialTimerDuration: selectedDuration,
              onTimerDurationChanged: (Duration duration) {
                setState(() {
                  selectedDuration = duration;
                });
              },
            ),
          ),
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {
          _selectedDelay = value.inSeconds;
        });
      }
    });
  }

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: const Text(
            "Neuro Routine Trainer",
          ),
        ),
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
                  child: const Text(
                    'Ready to start working on your routine?',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                GestureDetector(
                  onTap: _selectDelay,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: maxWidth * 0.05),
                    // Responsive horizontal margin
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: maxWidth * 0.02),
                          // Responsive right margin
                          child: const Text(
                            'Delay recording:',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Text(
                          '$_selectedDelay seconds',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(maxWidth * 0.05), // Responsive margin
                  child: ElevatedButton(
                    onPressed: () {
                      if (_selectedDelay > 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DelayView(delay: _selectedDelay),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RoutineView(),
                          ),
                        );
                      }
                    },
                    child: const Text('Start Routine Training'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      drawer: Drawer(
        child: drawerItems,
      ),
    );
  }
}
