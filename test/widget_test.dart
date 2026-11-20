import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:wastewhistle_mobile/main.dart';
import 'package:wastewhistle_mobile/screens/rewards.dart';

void main() {
  testWidgets(
    'Tab membuka modul yang sesuai dan Reporting kembali ke tab asal',
    (tester) async {
      await tester.pumpWidget(const MyApp());
      expect(find.text('Selamat datang di Waste Whistle!'), findsOneWidget);

      await tester.tap(find.text('Bank Sampah'));
      await tester.pumpAndSettle();
      expect(find.text('Direktori Bank Sampah'), findsOneWidget);

      await tester.tap(find.text('Lapor Sampah'));
      await tester.pumpAndSettle();
      expect(find.text('Lapor Timbunan Sampah'), findsOneWidget);
      await tester.tap(find.text('Kembali'));
      await tester.pumpAndSettle();
      expect(find.text('Direktori Bank Sampah'), findsOneWidget);

      await tester.tap(find.text('Lapor Sampah'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Edukasi').last);
      await tester.pumpAndSettle();
      expect(find.text('Edukasi Sampah'), findsOneWidget);
      await tester.tap(find.text('Hadiah').last);
      await tester.pumpAndSettle();
      expect(find.byType(RewardsPage), findsOneWidget);
    },
  );

  testWidgets('Formulir muat di ponsel dan Batal kembali ke beranda', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Lapor Sampah'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    await tester.enterText(find.byType(TextField).first, 'Sampah di halte');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();
    await tester.dragUntilVisible(
      find.text('Batal').hitTestable(),
      find.byType(ListView),
      const Offset(0, -260),
    );
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<FilledButton>(
            find.byWidgetPredicate((widget) => widget is FilledButton),
          )
          .onPressed,
      isNull,
    );
    await tester.tap(find.text('Batal'));
    await tester.pumpAndSettle();
    expect(find.text('Selamat datang di Waste Whistle!'), findsOneWidget);
  });
}
