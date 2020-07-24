import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:date_time_picker/date_time_picker.dart';

void main() {
  testWidgets('Testing instantiate DateTimePicker',
      (WidgetTester tester) async {
    var myWidget = MyWidget();
    await tester.pumpWidget(myWidget);

    expect(
      find.text('Jul 23, 2020'),
      findsOneWidget,
      reason: 'DateTimePicker initial display date not found!',
    );

    var dateTimePicker = find.byType(DateTimePicker);
    expect(
      dateTimePicker,
      findsOneWidget,
      reason: 'DateTimePicker not found!',
    );

    await tester.tap(dateTimePicker);
    await tester.pumpWidget(myWidget);

    var day = find.text('25');
    expect(
      day,
      findsOneWidget,
      reason: 'DateTimePicker day 25 not found!',
    );
    var okBtn = find.text('OK');
    expect(
      okBtn,
      findsOneWidget,
      reason: 'DateTimePicker OK button not found!',
    );

    await tester.tap(day);
    await tester.tap(okBtn);

    expect(
      find.text('Jul 25, 2020'),
      findsOneWidget,
      reason: 'DateTimePicker new date selected not found on text field!',
    );

    await tester.pumpWidget(myWidget);
    expect(
      find.text('2020-07-25'),
      findsOneWidget,
      reason: 'DateTimePicker new date value not found!',
    );
  });
}

class MyWidget extends StatefulWidget {
  MyWidget({Key key}) : super(key: key);

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String _value = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            DateTimePicker(
              initialValue: '2020-07-23',
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              onChanged: (val) => setState(() => _value = val),
            ),
            Text(_value),
          ],
        ),
      ),
    );
  }
}
