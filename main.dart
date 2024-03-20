import 'package:flutter/material.dart';
import 'pages/TaskPage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> TaskData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TaskPage(),
      ),
    );
  }
}

