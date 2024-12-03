import 'package:flutter/material.dart';

class UserDashboard extends StatefulWidget {
  final List<Map<String, String>> questions;

  UserDashboard({required this.questions});

  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  int _currentQuestionIndex = 0;
  String? _selectedAnswer;
  List<String?> _userAnswers = [];
  bool _isSubmitted = false;
  bool _quizStarted = false; // Flag to track if quiz has started

  // Move to the next question
  void _nextQuestion() {
    if (_currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        if (_userAnswers.length <= _currentQuestionIndex) {
          _userAnswers.add(_selectedAnswer);
        } else {
          _userAnswers[_currentQuestionIndex] = _selectedAnswer;
        }

        _currentQuestionIndex++;
        _selectedAnswer = _userAnswers.isNotEmpty &&
                _userAnswers.length > _currentQuestionIndex
            ? _userAnswers[_currentQuestionIndex]
            : null;
      });
    }
  }

  // Move to the previous question
  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        if (_userAnswers.length <= _currentQuestionIndex) {
          _userAnswers.add(_selectedAnswer);
        } else {
          _userAnswers[_currentQuestionIndex] = _selectedAnswer;
        }

        _currentQuestionIndex--;
        _selectedAnswer = _userAnswers[_currentQuestionIndex];
      });
    }
  }

  // Submit the exam and navigate to the ResultPage
  void _submitExam() {
    setState(() {
      _isSubmitted = true;
    });

    // Navigate to the result page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
          score: _calculateScore(),
          totalQuestions: widget.questions.length,
          userAnswers: _userAnswers,
          questions: widget.questions,
        ),
      ),
    );
  }

  // Calculate the score based on correct answers
  int _calculateScore() {
    int score = 0;
    for (int i = 0; i < widget.questions.length; i++) {
      if (_userAnswers[i] == widget.questions[i]['correctAnswer']) {
        score++;
      }
    }
    return score;
  }

  // Start the quiz
  void _startQuiz() {
    setState(() {
      _quizStarted = true; // Set quiz started flag to true
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_quizStarted) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Welcome to the quiz',
            style: TextStyle(color: Colors.blue),
          ),
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image from assets displayed before the button
              Image.asset(
                'assets/logo.png', // Path to your image
                height: 200, // Adjust the height as needed
                width: 200, // Adjust the width as needed
                fit: BoxFit.cover, // Optional: to scale the image properly
              ),
              SizedBox(height: 40), // Space between image and button

              // "Let's Start" Button
              ElevatedButton(
                onPressed: _startQuiz,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                  iconColor: Colors.white,
                  disabledIconColor: Colors.white, // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text("Let's Start",
                    style: TextStyle(fontSize: 18, color: Colors.blue)),
              ),
            ],
          ),
        ),
      );
    }

    final question = widget.questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Quiz: ${_currentQuestionIndex + 1} / ${widget.questions.length}'),
        // backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the current question
            Text(
              question['question'] ?? 'No question provided',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Display the answer options
            ...['A', 'B', 'C', 'D'].map((option) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedAnswer = option;
                    if (_userAnswers.length <= _currentQuestionIndex) {
                      _userAnswers.add(option);
                    } else {
                      _userAnswers[_currentQuestionIndex] = option;
                    }
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                    color: _selectedAnswer == option
                        ? Colors.blueAccent
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blueAccent),
                  ),
                  child: Text(
                    '${option}: ${question['option$option']}',
                    style: TextStyle(
                      fontSize: 18,
                      color: _selectedAnswer == option
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              );
            }).toList(),
            SizedBox(height: 20),
            // Navigation Buttons: Previous, Next, or Submit
            if (!_isSubmitted)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _currentQuestionIndex > 0
                        ? () {
                            _previousQuestion();
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      iconColor: Colors.grey,
                    ),
                    child: Text('Previous'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_currentQuestionIndex ==
                          widget.questions.length - 1) {
                        _submitExam(); // Submit when the last question is reached
                      } else {
                        _nextQuestion(); // Move to the next question
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      iconColor: Colors.blueAccent,
                    ),
                    child: Text(
                        _currentQuestionIndex == widget.questions.length - 1
                            ? 'Submit'
                            : 'Next Question'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final List<String?> userAnswers;
  final List<Map<String, String>> questions;

  ResultPage({
    required this.score,
    required this.totalQuestions,
    required this.userAnswers,
    required this.questions,
  });

  // Helper method to get the answer text based on the selected option
  String getAnswerText(Map<String, String> question, String option) {
    switch (option) {
      case 'A':
        return question['optionA'] ?? 'No answer';
      case 'B':
        return question['optionB'] ?? 'No answer';
      case 'C':
        return question['optionC'] ?? 'No answer';
      case 'D':
        return question['optionD'] ?? 'No answer';
      default:
        return 'Invalid option';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Results'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Score: $score/$totalQuestions',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),
            SizedBox(height: 20),
            Text(
              'Correct Answers:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            for (int i = 0; i < totalQuestions; i++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Q${i + 1}: Correct answer: ${getAnswerText(questions[i], questions[i]['correctAnswer']!)} '
                  '(Your answer: ${userAnswers[i] == null ? 'Not answered' : getAnswerText(questions[i], userAnswers[i]!)} )',
                  style: TextStyle(
                    fontSize: 18,
                    color: userAnswers[i] == questions[i]['correctAnswer']
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to the user dashboard
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                iconColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
