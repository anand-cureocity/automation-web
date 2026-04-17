// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:semantic_test/main.dart';

void main() {
  testWidgets('First screen renders key controls', (WidgetTester tester) async {
    await tester.pumpWidget(const SemanticTestApp());

    expect(find.text('QA Semantic Controls'), findsOneWidget);
    expect(find.byKey(const Key('textfield_name')), findsOneWidget);
    expect(find.byKey(const Key('textfield_email')), findsOneWidget);
    expect(find.byKey(const Key('checkbox_agree')), findsOneWidget);
    expect(find.byKey(const Key('radio_option_a')), findsOneWidget);

    await tester.scrollUntilVisible(
      find.byKey(const Key('button_go_second')),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.byKey(const Key('button_go_second')), findsOneWidget);
  });
}
