import 'package:flutter/material.dart';
import 'package:wavy_bottom_sheet/buttom_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo', // Title
      debugShowCheckedModeBanner: false, // Remove Debug Banner
      theme: ThemeData(
        useMaterial3: true, // Use Material 3
        // primarySwatch: Colors.blue,
      ),
      home: const WavyButtomBar(),
    );
  }
}
