// 对应网站小节: https://book.flutterchina.club/chapter4/wrap_and_flow.html
// 功能说明: 演示Flutter流式布局（Wrap和Flow），包括Wrap的自动换行、spacing与runSpacing设置、
// alignment对齐，以及Flow组件通过FlowDelegate自定义子组件布局的实现方式。

import 'package:flutter/material.dart';

void main() => runApp(const Section4_5App());

class Section4_5App extends StatelessWidget {
  const Section4_5App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '4.5 流式布局',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const WrapAndFlowPage(),
    );
  }
}

class WrapAndFlowPage extends StatelessWidget {
  const WrapAndFlowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('4.5 流式布局（Wrap和Flow）')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row 溢出演示
            const Text(
              '1. Row溢出问题（xxx重复100次 → 溢出警告）',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: const [
                  Text(
                    'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
                    'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Wrap 基本使用
            const Text(
              '2. Wrap 自动换行（Chip列表，spacing:8, runSpacing:4）',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              alignment: WrapAlignment.center,
              children: const [
                Chip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text('A'),
                  ),
                  label: Text('Hamilton'),
                ),
                Chip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text('M'),
                  ),
                  label: Text('Lafayette'),
                ),
                Chip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text('H'),
                  ),
                  label: Text('Mulligan'),
                ),
                Chip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text('J'),
                  ),
                  label: Text('Laurens'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Flow 自定义布局
            const Text(
              '3. Flow 自定义流式布局',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: Flow(
                delegate: TestFlowDelegate(margin: const EdgeInsets.all(10.0)),
                children: [
                  Container(
                    width: 80.0,
                    height: 80.0,
                    color: Colors.red,
                  ),
                  Container(
                    width: 80.0,
                    height: 80.0,
                    color: Colors.green,
                  ),
                  Container(
                    width: 80.0,
                    height: 80.0,
                    color: Colors.blue,
                  ),
                  Container(
                    width: 80.0,
                    height: 80.0,
                    color: Colors.yellow,
                  ),
                  Container(
                    width: 80.0,
                    height: 80.0,
                    color: Colors.brown,
                  ),
                  Container(
                    width: 80.0,
                    height: 80.0,
                    color: Colors.purple,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TestFlowDelegate extends FlowDelegate {
  TestFlowDelegate({this.margin = EdgeInsets.zero});
  final EdgeInsets margin;

  @override
  void paintChildren(FlowPaintingContext context) {
    double x = margin.left;
    double y = margin.top;
    for (int i = 0; i < context.childCount; i++) {
      final w = context.getChildSize(i)!.width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(
          i,
          transform: Matrix4.translationValues(x, y, 0.0),
        );
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i)!.height + margin.top + margin.bottom;
        context.paintChild(
          i,
          transform: Matrix4.translationValues(x, y, 0.0),
        );
        x += context.getChildSize(i)!.width + margin.left + margin.right;
      }
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return const Size(double.infinity, 200.0);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
