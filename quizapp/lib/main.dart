import 'package:flutter/material.dart';
import 'package:quizapp/admindashboard.dart';
import 'package:quizapp/adminpage.dart';
import 'package:quizapp/userpage.dart';
import 'package:quizapp/welcome.dart'; // Make sure this import path is correct

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'), // Add a title to your app bar
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to AdminPage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminPage()),
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add),
              SizedBox(width: 8), // To add some space between the icon and text
              Text('Add Question'),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: AdminDashboard(), //Start with the Main page
    ),
  );
}
