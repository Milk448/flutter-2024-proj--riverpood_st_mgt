import 'package:flutter_test/flutter_test.dart';
import 'package:mind_twist/presentation/screens/profile/profile.dart';
import 'package:flutter/material.dart';

void main() {
  group('Profile Page Widget Tests', () {
    testWidgets('Profile Page renders correctly', (WidgetTester tester) async {
      // Build the Profile Page
      await tester.pumpWidget(MaterialApp(
        home: ProfilePage(),
      ));

      // Verify the title
      expect(find.text('Profile'), findsOneWidget);

      // Verify the "Update" and "Logout" buttons
      expect(find.text('Update'), findsOneWidget);
      expect(find.text('Logout'), findsOneWidget);
    });
  });
}
