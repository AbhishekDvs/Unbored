// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../Constants/UniversalParams.dart';

class BoredPage extends StatefulWidget {
  const BoredPage({super.key, required this.title});

  final String title;

  @override
  State<BoredPage> createState() => BoredPageState();
}

class BoredPageState extends State<BoredPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
              onPressed: () {
                UniversalParams.GetSomeActivity();
              },
              child: const Text('Get a random activity to do!')),
          Column(
            children: [
              Text('Activity name:${UniversalParams.activity}'),
              Text('No. of Participants:${UniversalParams.participants}'),
              Text('Activity Type:${UniversalParams.type}'),
              Text('Follow:${UniversalParams.link}'),
            ],
          )
        ],
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
