import 'package:example/views/first/first_veto_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Veto',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const FirstVetoView(),
    );
  }
}
