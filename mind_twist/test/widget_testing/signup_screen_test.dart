// mind_twist\test\widget_test\sign_up_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mind_twist/presentation/screens/welcome/signUp.dart';
import 'package:flutter/material.dart';

void main() {
  group('Sign Up Screen Widget Tests', () {
    testWidgets('Sign Up Screen renders correctly',
        (WidgetTester tester) async {
      // Build the Sign Up Screen
      await tester.pumpWidget(MaterialApp(
        home: SignUpScreen(),
      ));

      // Verify that the screen has the expected title
      expect(find.text('Sign Up'), findsOneWidget);

      // Verify that the username and password input fields exist
      expect(find.byType(TextFormField).at(0), findsOneWidget);
      expect(find.byType(TextFormField).at(1), findsOneWidget);

      // Verify that the sign up button exists
      expect(find.text('SIGN UP'), findsOneWidget);
    });

    testWidgets('Sign Up Form validates input', (WidgetTester tester) async {
      // Build the Sign Up Screen
      await tester.pumpWidget(MaterialApp(
        home: SignUpScreen(),
      ));

      // Find the username and password input fields
      final usernameField = find.byType(TextFormField).at(0);
      final passwordField = find.byType(TextFormField).at(1);

      // Test empty username input
      await tester.enterText(usernameField, '');
      await tester.tap(find.text('SIGN UP'));
      await tester.pumpAndSettle();
      expect(find.text('Please enter your username'), findsOneWidget);

      // Test empty password input
      await tester.enterText(usernameField, 'testuser');
      await tester.enterText(passwordField, '');
      await tester.tap(find.text('SIGN UP'));
      await tester.pumpAndSettle();
      expect(find.text('Please enter your password'), findsOneWidget);
    });
  });
}
