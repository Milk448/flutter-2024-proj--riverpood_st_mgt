import 'package:flutter_test/flutter_test.dart';
import 'package:mind_twist/presentation/widgets/score_display.dart';
import 'package:flutter/material.dart';

void main() {
  group('Score Screen Widget Tests', () {
    testWidgets('Score Screen renders correctly', (WidgetTester tester) async {
      // Build the Score Screen
      await tester.pumpWidget(const MaterialApp(
        home: ScoreScreen(
          score: 5,
          totalQuestions: 10,
        ),
      ));

      // Verify the score text
      expect(find.text('Your Score'), findsOneWidget);
      expect(find.text('5 / 10'), findsOneWidget);

      // Verify the tap to return message
      expect(find.text('Tap to return to the Teaser Screen'), findsOneWidget);
    });
  });
}
