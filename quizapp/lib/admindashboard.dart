import 'package:flutter/material.dart';
import 'package:quizapp/userpage.dart';
// import 'package:prroject/userpage.dart';

// Admin Dashboard Page
class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final List<Map<String, String>> questions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Implement logout logic here
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to Add Question page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddQuestionPage(
                      onQuestionAdded: (question, optionA, optionB, optionC,
                          optionD, correctAnswer) {
                        setState(() {
                          questions.add({
                            'question': question,
                            'optionA': optionA,
                            'optionB': optionB,
                            'optionC': optionC,
                            'optionD': optionD,
                            'correctAnswer': correctAnswer,
                          });
                        });
                      },
                    ),
                  ),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 8),
                  Text('Add Question'),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to View Questions page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ViewQuestionPage(questions: questions),
                  ),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.list),
                  SizedBox(width: 8),
                  Text('View Questions'),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Quiz Settings page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizSettingsPage()),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.settings),
                  SizedBox(width: 8),
                  Text('Quiz Settings'),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to User Dashboard page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserDashboard(questions: questions),
                  ),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.dashboard),
                  SizedBox(width: 8),
                  Text('User Dashboard'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Add Question Page
class AddQuestionPage extends StatefulWidget {
  final Function(String, String, String, String, String, String)
      onQuestionAdded;

  AddQuestionPage({required this.onQuestionAdded});

  @override
  _AddQuestionPageState createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _optionAController = TextEditingController();
  final TextEditingController _optionBController = TextEditingController();
  final TextEditingController _optionCController = TextEditingController();
  final TextEditingController _optionDController = TextEditingController();

  String _correctAnswer = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.onQuestionAdded(
        _questionController.text,
        _optionAController.text,
        _optionBController.text,
        _optionCController.text,
        _optionDController.text,
        _correctAnswer,
      );

      _questionController.clear();
      _optionAController.clear();
      _optionBController.clear();
      _optionCController.clear();
      _optionDController.clear();
      setState(() {
        _correctAnswer = '';
      });

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Question')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _questionController,
                decoration: InputDecoration(labelText: 'Enter Question'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a question';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _optionAController,
                decoration: InputDecoration(labelText: 'Option A'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Option A';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _optionBController,
                decoration: InputDecoration(labelText: 'Option B'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Option B';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _optionCController,
                decoration: InputDecoration(labelText: 'Option C'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Option C';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _optionDController,
                decoration: InputDecoration(labelText: 'Option D'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Option D';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _correctAnswer.isEmpty ? null : _correctAnswer,
                decoration: InputDecoration(labelText: 'Select Correct Answer'),
                items: [
                  DropdownMenuItem(value: 'A', child: Text('A')),
                  DropdownMenuItem(value: 'B', child: Text('B')),
                  DropdownMenuItem(value: 'C', child: Text('C')),
                  DropdownMenuItem(value: 'D', child: Text('D')),
                ],
                onChanged: (value) {
                  setState(() {
                    _correctAnswer = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select the correct answer';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit Question'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ViewQuestionPage extends StatefulWidget {
  final List<Map<String, String>> questions;

  ViewQuestionPage({required this.questions});

  @override
  _ViewQuestionPageState createState() => _ViewQuestionPageState();
}

class _ViewQuestionPageState extends State<ViewQuestionPage> {
  void _deleteQuestion(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Question'),
          content: Text('Are you sure you want to delete this question?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  widget.questions.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _editQuestion(
      BuildContext context, Map<String, String> question, int index) async {
    final updatedQuestion = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditQuestionPage(question: question),
      ),
    );
    if (updatedQuestion != null) {
      setState(() {
        widget.questions[index] = updatedQuestion;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Questions'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to Add Question page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddQuestionPage(
                    onQuestionAdded: (question, optionA, optionB, optionC,
                        optionD, correctAnswer) {
                      setState(() {
                        widget.questions.add({
                          'question': question,
                          'optionA': optionA,
                          'optionB': optionB,
                          'optionC': optionC,
                          'optionD': optionD,
                          'correctAnswer': correctAnswer,
                        });
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.questions.length,
        itemBuilder: (context, index) {
          final question = widget.questions[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(question['question']!),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'A: ${question['optionA']}, B: ${question['optionB']}, C: ${question['optionC']}, D: ${question['optionD']}'),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.all(8),
                    color: Colors.green[100], // light green background
                    child: Text(
                      'Correct Answer: ${question['correctAnswer']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _editQuestion(context, question, index),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteQuestion(index), // Delete button
                  ),
                ],
              ),
              onLongPress: () => _deleteQuestion(index),
            ),
          );
        },
      ),
    );
  }
}

class EditQuestionPage extends StatefulWidget {
  final Map<String, String> question;

  EditQuestionPage({required this.question});

  @override
  _EditQuestionPageState createState() => _EditQuestionPageState();
}

class _EditQuestionPageState extends State<EditQuestionPage> {
  late TextEditingController _questionController;
  late TextEditingController _optionAController;
  late TextEditingController _optionBController;
  late TextEditingController _optionCController;
  late TextEditingController _optionDController;
  late String _correctAnswer;

  @override
  void initState() {
    super.initState();
    _questionController =
        TextEditingController(text: widget.question['question']);
    _optionAController =
        TextEditingController(text: widget.question['optionA']);
    _optionBController =
        TextEditingController(text: widget.question['optionB']);
    _optionCController =
        TextEditingController(text: widget.question['optionC']);
    _optionDController =
        TextEditingController(text: widget.question['optionD']);
    _correctAnswer = widget.question['correctAnswer']!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Question'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _questionController,
              decoration: InputDecoration(labelText: 'Enter Question'),
            ),
            TextField(
              controller: _optionAController,
              decoration: InputDecoration(labelText: 'Option A'),
            ),
            TextField(
              controller: _optionBController,
              decoration: InputDecoration(labelText: 'Option B'),
            ),
            TextField(
              controller: _optionCController,
              decoration: InputDecoration(labelText: 'Option C'),
            ),
            TextField(
              controller: _optionDController,
              decoration: InputDecoration(labelText: 'Option D'),
            ),
            DropdownButton<String>(
              value: _correctAnswer,
              onChanged: (newValue) {
                setState(() {
                  _correctAnswer = newValue!;
                });
              },
              items: [
                DropdownMenuItem(value: 'A', child: Text('A')),
                DropdownMenuItem(value: 'B', child: Text('B')),
                DropdownMenuItem(value: 'C', child: Text('C')),
                DropdownMenuItem(value: 'D', child: Text('D')),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.question['question'] = _questionController.text;
                  widget.question['optionA'] = _optionAController.text;
                  widget.question['optionB'] = _optionBController.text;
                  widget.question['optionC'] = _optionCController.text;
                  widget.question['optionD'] = _optionDController.text;
                  widget.question['correctAnswer'] = _correctAnswer;
                });
                Navigator.pop(context, widget.question);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz Settings')),
      body: Center(child: Text('Quiz Settings Page')),
    );
  }
}
