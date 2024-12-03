import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final TextEditingController _questionController = TextEditingController();
  final List<TextEditingController> _optionControllers = List.generate(
      4, (_) => TextEditingController()); // Four options by default.
  int _correctAnswerIndex = 0;
  List<Question> _questions = [];

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? questionsJson = prefs.getString('questions');
    if (questionsJson != null) {
      setState(() {
        _questions = (json.decode(questionsJson) as List)
            .map((q) => Question.fromJson(q))
            .toList();
      });
    }
  }

  Future<void> _saveQuestions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String questionsJson =
        json.encode(_questions.map((q) => q.toJson()).toList());
    await prefs.setString('questions', questionsJson);
  }

  void _addQuestion() {
    if (_questionController.text.isNotEmpty &&
        _optionControllers.every((controller) => controller.text.isNotEmpty)) {
      setState(() {
        _questions.add(Question(
          question: _questionController.text,
          options:
              _optionControllers.map((controller) => controller.text).toList(),
          correctAnswerIndex: _correctAnswerIndex,
        ));
      });
      _saveQuestions();
      _clearInputs();
    }
  }

  void _deleteQuestion(int index) {
    setState(() {
      _questions.removeAt(index);
    });
    _saveQuestions();
  }

  void _clearInputs() {
    _questionController.clear();
    for (var controller in _optionControllers) {
      controller.clear();
    }
    _correctAnswerIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _questionController,
              decoration: InputDecoration(labelText: "Question"),
            ),
            for (int i = 0; i < 4; i++)
              TextField(
                controller: _optionControllers[i],
                decoration: InputDecoration(labelText: "Option ${i + 1}"),
              ),
            DropdownButton<int>(
              value: _correctAnswerIndex,
              items: List.generate(
                4,
                (index) => DropdownMenuItem(
                  value: index,
                  child: Text("Correct Option: ${index + 1}"),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _correctAnswerIndex = value!;
                });
              },
            ),
            ElevatedButton(
              onPressed: _addQuestion,
              child: Text("Add Question"),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _questions.length,
                itemBuilder: (context, index) {
                  final question = _questions[index];
                  return ListTile(
                    title: Text(question.question),
                    subtitle: Text("Options: ${question.options.join(', ')}"),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteQuestion(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Question {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'],
      options: List<String>.from(json['options']),
      correctAnswerIndex: json['correctAnswerIndex'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'options': options,
      'correctAnswerIndex': correctAnswerIndex,
    };
  }
}
