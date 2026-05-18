// 对应网站小节: https://book.flutterchina.club/chapter4/row_and_column.html
// 功能说明: 演示Flutter线性布局（Row和Column），包括mainAxisAlignment、crossAxisAlignment、
// mainAxisSize、textDirection、verticalDirection等对齐方式的用法，以及嵌套Column中Expanded的作用。

import 'package:flutter/material.dart';

void main() => runApp(const Section4_3App());

class Section4_3App extends StatelessWidget {
  const Section4_3App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '4.3 线性布局',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const RowAndColumnPage(),
    );
  }
}

class RowAndColumnPage extends StatelessWidget {
  const RowAndColumnPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('4.3 线性布局（Row和Column）')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row 对齐方式演示
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '1. Row mainAxisAlignment 对齐方式',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(),
            const Text('  mainAxisAlignment: center'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(' hello world '),
                Text(' I am Jack '),
              ],
            ),
            const Divider(),
            const Text('  mainAxisSize: min + mainAxisAlignment: center'),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(' hello world '),
                Text(' I am Jack '),
              ],
            ),
            const Divider(),
            const Text('  mainAxisAlignment: end + textDirection: rtl'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              textDirection: TextDirection.rtl,
              children: const [
                Text(' hello world '),
                Text(' I am Jack '),
              ],
            ),
            const Divider(),
            const Text('  crossAxisAlignment: start + verticalDirection: up'),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              verticalDirection: VerticalDirection.up,
              children: const [
                Text(
                  ' hello world ',
                  style: TextStyle(fontSize: 30.0),
                ),
                Text(' I am Jack '),
              ],
            ),
            const Divider(),
            // Column 对齐方式演示
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '2. Column crossAxisAlignment',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: double.infinity),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text('hi'),
                  Text('world'),
                ],
              ),
            ),
            const Divider(),
            // 嵌套 Column 演示
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '3. 嵌套Column（Expanded让内层Column填满空间）',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 200,
              child: Container(
                color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.red,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('hello world '),
                              Text('I am Jack '),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
