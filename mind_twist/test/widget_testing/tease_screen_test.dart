import 'package:flutter_test/flutter_test.dart';
import 'package:mind_twist/presentation/screens/teaser/tease_screen.dart';
import 'package:flutter/material.dart';

void main() {
  group('Tease Screen Widget Tests', () {
    testWidgets('Tease Screen renders correctly', (WidgetTester tester) async {
      // Build the Tease Screen (with dummy data)
      await tester.pumpWidget(const MaterialApp(
        home: TeaseScreen(
          categoryName: 'General Knowledge',
          questions: [
            {
              'question': 'What is the capital of France?',
              'options': ['Berlin', 'Paris', 'Rome', 'Madrid'],
              'correctAnswer': 1,
            },
          ],
          currentQuestionIndex: 0,
        ),
      ));

      // Verify the category name
      expect(find.text('General Knowledge'), findsOneWidget);

      // Verify the question
      expect(find.text('What is the capital of France?'), findsOneWidget);

      // Verify the answer options
      expect(find.text('Berlin'), findsOneWidget);
      expect(find.text('Paris'), findsOneWidget);
      expect(find.text('Rome'), findsOneWidget);
      expect(find.text('Madrid'), findsOneWidget);
    });
  });
}
