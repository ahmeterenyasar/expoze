import 'package:expoze/data/services/local_db_service.dart';
import 'package:expoze/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Onboarding screen renders focus step', (WidgetTester tester) async {
    final dbService = LocalDbService();
    await dbService.init();

    await tester.pumpWidget(MyApp(dbService: dbService));
    await tester.pumpAndSettle();

    expect(find.text('Step 1 of 3'), findsOneWidget);
    expect(find.text('What would you like\nto work on today?'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
  });
}
