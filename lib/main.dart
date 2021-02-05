import 'dart:developer';

import 'package:flutter/material.dart';
import 'bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final counterbloc = CounterBloc();
  // starttimer() {
  //   // _timer = Timer.periodic(Duration(seconds: 1), (timer) {
  //   //   setState(() {
  //   //     if (remainingtime > 0) {
  //   //       remainingtime--;
  //   //     } else {
  //   //       _timer.cancel();
  //   //     }
  //   //   });
  //   // });
  // }
  @override
  void dispose() {
    counterbloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("widget formed");
    return Scaffold(
      body: Center(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.schedule, size: 100.0, color: Colors.blue),
                SizedBox(height: 10),
                StreamBuilder(
                  stream: counterbloc.counterStream,
                  initialData: 60,
                  builder: (context, snapshot) {
                    return Text(
                      " ${counterbloc.counter}",
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.w500),
                    );
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                MaterialButton(
                    child: Text("Start"),
                    onPressed: () {
                      counterbloc.eventSink.add(CounterAction.Start);
                    }),
                MaterialButton(
                    child: Text("Reset"),
                    onPressed: () {
                      counterbloc.eventSink.add(CounterAction.Reset);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
