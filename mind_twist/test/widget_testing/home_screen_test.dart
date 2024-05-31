import 'package:flutter_test/flutter_test.dart';
import 'package:mind_twist/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  group('Home Screen Widget Tests', () {
    testWidgets('Home Screen renders correctly', (WidgetTester tester) async {
      // Build the Home Screen
      await tester.pumpWidget(MaterialApp(
        home: HomeScreen(),
      ));

      // Verify the welcome text
      expect(find.text('Welcome to Brain Teaser'), findsOneWidget);

      // Verify the "Daily Twist" button
      expect(find.text('Daily Twist'), findsOneWidget);

      // Verify the slogan
      expect(find.text('Unleash Your Mind Every Day!'), findsOneWidget);
    });
  });
}
