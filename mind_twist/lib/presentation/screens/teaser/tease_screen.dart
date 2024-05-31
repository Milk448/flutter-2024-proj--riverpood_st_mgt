// mind_twist/lib/presentation/screens/teaser/tease_screen.dart

import 'package:flutter/material.dart';
import 'package:mind_twist/presentation/widgets/score_display.dart';
import 'package:mind_twist/presentation/widgets/tease_options.dart';
import 'package:go_router/go_router.dart';

class TeaseScreen extends StatefulWidget {
  final String categoryName;
  final List<Map<String, dynamic>> questions;
  final int currentQuestionIndex;

  const TeaseScreen({
    Key? key,
    required this.categoryName,
    required this.questions,
    required this.currentQuestionIndex,
  }) : super(key: key);

  @override
  _TeaseScreenState createState() => _TeaseScreenState();
}

class _TeaseScreenState extends State<TeaseScreen> {
  int _currentQuestionIndex = 0;
  int _selectedOptionIndex = -1;
  int _score = 0;
  List<Map<String, dynamic>> _questions = [];

  @override
  void initState() {
    super.initState();
    _questions = widget.questions;
    _currentQuestionIndex = widget.currentQuestionIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Check if _questions is not empty and _currentQuestionIndex is within bounds
            if (_questions.isNotEmpty &&
                _currentQuestionIndex < _questions.length)
              Text(
                _questions[_currentQuestionIndex]['question'] as String,
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              )
            else
              const Text("No more questions in this category"),
            const SizedBox(height: 20.0),
            // Check if _questions is not empty and _currentQuestionIndex is within bounds
            if (_questions.isNotEmpty &&
                _currentQuestionIndex < _questions.length)
              ...(_questions[_currentQuestionIndex]['options'] as List<dynamic>)
                  .asMap()
                  .entries
                  .map(
                    (entry) => Option(
                      optionText: entry.value as String,
                      isSelected: _selectedOptionIndex == entry.key,
                      onPressed: () => _handleOptionSelected(entry.key),
                    ),
                  )
                  .toList()
            else
              const SizedBox.shrink(), // Or any other placeholder
          ],
        ),
      ),
    );
  }

  void _handleOptionSelected(int optionIndex) {
    setState(() {
      _selectedOptionIndex = optionIndex;

      // Correctly handle 'correctAnswer' as int
      int correctAnswer = _questions[_currentQuestionIndex]['correctAnswer'];

      if (optionIndex == correctAnswer) {
        _score++;
      }

      // Move to the next question or display the score
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        _selectedOptionIndex = -1; // Reset selected option
      } else {
        // Navigate to ScoreScreen
        context.push(
          '/score_screen',
          extra: {'score': _score, 'totalQuestions': _questions.length},
        );
      }
    });
  }
}
