import 'dart:ui';

import 'package:eventsphere/BottomBar.dart';
import 'package:eventsphere/EventDetail.dart';
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
        body: BottomBar()
      ),
      routes: {
        '/EventDetail' :(context) => const EventDetail()
      },
    );
  }
}
