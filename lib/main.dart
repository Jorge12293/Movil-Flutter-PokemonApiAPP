import 'package:flutter/material.dart';
import 'package:pokemon/src/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: 'home',
      routes:appRoutes,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
