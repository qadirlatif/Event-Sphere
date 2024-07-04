import 'dart:ui';

import 'package:eventsphere/BottomBar.dart';
import 'package:eventsphere/Choice.dart';
import 'package:eventsphere/EventDetail.dart';
import 'package:eventsphere/EventList.dart';
import 'package:eventsphere/Login.dart';
import 'package:eventsphere/addEvent.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Choice()
      ),
      routes: {

        '/BottomBar' :(context) => const BottomBar(),
        '/login' :(context) => const Login(),
        '/EventDetail' :(context) => EventDetail(),
        '/Eventlist' :  (context) => const ExploreEvents()
      },
    );
  }
}
