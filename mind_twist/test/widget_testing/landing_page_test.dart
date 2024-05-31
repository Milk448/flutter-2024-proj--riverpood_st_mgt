import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mind_twist/presentation/screens/welcome/landing_page.dart';

void main() {
  group('Landing Page Widget Tests', () {
    testWidgets('Landing Page renders correctly', (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(const MaterialApp(home: LandingPage()));

      // Verify that the title is present
      expect(find.text('MIND-TWIST'), findsOneWidget);

      // Verify that the brain image is present
      expect(find.byType(Image), findsOneWidget);

      // Verify that the slogan is present
      expect(find.text('Untangle Your Thoughts'), findsOneWidget);

      // Verify that the Sign Up button is present
      expect(find.text('Sign Up'), findsOneWidget);

      // Verify that the Sign In button is present
      expect(find.text('Sign In'), findsOneWidget);
    });
  });
}
