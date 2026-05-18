import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_learning_chapter_3/main.dart';

void main() {
  testWidgets('Main app renders section list', (WidgetTester tester) async {
    await tester.pumpWidget(const Chapter4App());

    // 验证主页标题存在
    expect(find.text('第四章：布局类组件'), findsOneWidget);
    // 验证小节入口存在
    expect(find.text('4.1 布局类组件简介'), findsOneWidget);
  });
}
