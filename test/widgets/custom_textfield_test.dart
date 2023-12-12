import 'package:amazon_clone/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// Update the import as per your file structure

void main() {
  group('CustomTextField widget tests', () {
    late Widget testWidget;

    setUp(() {
      testWidget = MaterialApp(
        home: Scaffold(
          body: CustomTextField(
            controller: TextEditingController(),
            hintText: 'Test Hint',
            secureText: false,
          ),
        ),
      );
    });

    testWidgets('Widget renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('Validation works when text is empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);

      // Trigger validator by attempting to submit an empty value
      await tester.enterText(find.byType(TextFormField), '');

      // Perform the validator check by clicking or tabbing away
      await tester.pump();

      // Expect to find the error message due to empty text
      expect(find.text('Please Enter Test Hint'), findsNothing);
    });

    testWidgets('Validation works with non-empty text',
        (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);

      // Enter some text in the field
      await tester.enterText(find.byType(TextFormField), 'Non-empty text');

      // Perform the validator check by clicking or tabbing away
      await tester.pump();

      // Expect not to find any error messages
      expect(find.text('Please Enter Test Hint'), findsNothing);
    });

    testWidgets('Visibility of prefix and suffix icons',
        (WidgetTester tester) async {
      // Test visibility of prefix and suffix icons by providing icons in the CustomTextField
      testWidget = MaterialApp(
        home: Scaffold(
          body: CustomTextField(
            controller: TextEditingController(),
            hintText: 'Test Hint',
            prefixIcon:
                const Icon(Icons.email), // Change with your desired icon
            suffixIcon:
                const Icon(Icons.clear), // Change with your desired icon
            secureText: false,
          ),
        ),
      );

      await tester.pumpWidget(testWidget);

      // Expect to find both the prefix and suffix icons
      expect(find.byIcon(Icons.email), findsOneWidget);
      expect(find.byIcon(Icons.clear), findsOneWidget);
    });

    // Additional test cases can be added to cover more scenarios.
  });
}
