// 对应网站小节: https://book.flutterchina.club/chapter4/flex.html
// 功能说明: 演示Flutter弹性布局（Flex），包括Flex组件的基本使用、Expanded按flex比例分配空间、
// 以及Spacer（Expanded+SizedBox.shrink的语法糖）的实际应用。

import 'package:flutter/material.dart';

void main() => runApp(const Section4_4App());

class Section4_4App extends StatelessWidget {
  const Section4_4App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '4.4 弹性布局',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const FlexPage(),
    );
  }
}

class FlexPage extends StatelessWidget {
  const FlexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('4.4 弹性布局（Flex）')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '1. Flex 水平方向（1:2比例分配）',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 30.0,
                    color: Colors.red,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 30.0,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              '2. Flex 垂直方向（2:1:1 + Spacer）',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Text('(在高度100的SizedBox内按比例分配)'),
            const SizedBox(height: 8),
            SizedBox(
              height: 100.0,
              child: Flex(
                direction: Axis.vertical,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(color: Colors.red),
                  ),
                  const Spacer(flex: 1),
                  Expanded(
                    flex: 1,
                    child: Container(color: Colors.green),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Spacer 本质是 Expanded + SizedBox.shrink，'
              '用于在Flex中创建可伸缩的空白间隔。',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
