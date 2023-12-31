import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neuroapp/views/delayView.dart';
import 'package:neuroapp/views/routineView.dart';

class TimerView extends StatefulWidget {
  const TimerView({Key? key}) : super(key: key);

  @override
  _TimerViewState createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> {
  int _selectedDelay = 0;

  @override
  Widget build(BuildContext context) {
    const drawerHeader = UserAccountsDrawerHeader(
      accountName: Text(
        "Tiger Woods",
      ),
      accountEmail: Text(
        "tiger@woods.com",
      ),
      currentAccountPicture: CircleAvatar(
          child: Image(
        image: AssetImage("assets/Logo.png"),
      )),
    );
    final drawerItems = ListView(
      children: [
        drawerHeader,
        ListTile(
          title: const Text(
            "Train Routines",
          ),
          leading: const Icon(Icons.flash_on),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text(
            "Statistics",
          ),
          leading: const Icon(Icons.stacked_bar_chart),
          onTap: () {},
        ),
        ListTile(
          title: const Text(
            "Settings",
          ),
          leading: const Icon(Icons.settings),
          onTap: () {},
        ),
      ],
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      // transparent appbar with drawer as action
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        forceMaterialTransparency: true,
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Hero(
                    tag: 'mainLogo',
                    child: Image(
                      image: AssetImage('assets/Logo@4.png'),
                      width: maxWidth * 0.6,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(maxWidth * 0.1),
                  child: const Text(
                    'Select Countdown',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ),
                CupertinoTimerPicker(
                  mode: CupertinoTimerPickerMode.ms,
                  initialTimerDuration: Duration(seconds: _selectedDelay),
                  onTimerDurationChanged: (Duration duration) {
                    setState(() {
                      _selectedDelay = duration.inSeconds;
                    });
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(maxWidth * 0.1),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_selectedDelay > 0) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DelayView(delay: _selectedDelay),
                          ),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RoutineView(),
                          ),
                        );
                      }
                    },
                    child: const Text('Start Routine',
                        style: TextStyle(fontSize: 20)),
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
