import 'package:flutter_test/flutter_test.dart';
import 'package:nuget_packages/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const NuGetPackagesApp());
    expect(find.byType(NuGetPackagesApp), findsOneWidget);
  });
}
