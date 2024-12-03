import 'package:flutter/material.dart';
import 'package:quizapp/userpage.dart';
// import 'package:quizapp2/userpage.dart';
// import 'package:quiz/screens/home/userhome.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Define your sample questions list
    final List<Map<String, String>> questions = [];

    return Scaffold(
      backgroundColor: Colors.white, // Background color
      appBar: AppBar(
          // title: Text("Welcome"),
          // backgroundColor: Colors.blue, // App bar color
          ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image at the top
            Image.asset(
              'assets/welcome.jpg', // Replace with the actual path of your image
              width: 200, // Adjust the width as needed
              height: 200, // Adjust the height as needed
            ),
            SizedBox(height: 20), // Space between image and text
            Text(
              "Welcome to the Quiz",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue[600],
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                // Navigate to UserDashboard and pass the questions list
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserDashboard(questions: questions),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                iconColor: Colors.blue, // Button color
              ),
              child: Text(
                "Let's Start",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue, // Text color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
