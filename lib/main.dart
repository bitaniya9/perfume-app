import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const MyHomePage(title: 'Flutter Demo Home Page'));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      drawer: Drawer(child: Center(child: Text("Menu"))),
      body: Builder(
        builder: (context) => Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 100, // Height including status bar
                color: const Color.fromARGB(
                  255,
                  244,
                  241,
                  242,
                ), // A slightly darker pink than the body
              ),
            ),

            Positioned(
              top: 40, // Adjust for status bar padding
              left: 10,
              child: IconButton(
                icon: Icon(Icons.menu, size: 30),
                onPressed: () => {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
