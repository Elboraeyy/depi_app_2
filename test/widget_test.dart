import 'package:flutter_test/flutter_test.dart';
import 'package:depi_app_2/main.dart';

void main() {
  testWidgets('shows splash screen', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('NIGHT 360°'), findsOneWidget);
  });
}
