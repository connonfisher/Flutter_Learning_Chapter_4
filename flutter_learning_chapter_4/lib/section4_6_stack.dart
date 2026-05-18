// 对应网站小节: https://book.flutterchina.club/chapter4/stack.html
// 功能说明: 演示Flutter层叠布局（Stack和Positioned），包括Stack的alignment对齐、
// StackFit.loose与StackFit.expand的区别，以及Positioned通过left/top/right/bottom
// 对子组件进行精确定位。

import 'package:flutter/material.dart';

void main() => runApp(const Section4_6App());

class Section4_6App extends StatelessWidget {
  const Section4_6App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '4.6 层叠布局',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const StackPage(),
    );
  }
}

class StackPage extends StatelessWidget {
  const StackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('4.6 层叠布局（Stack和Positioned）')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '1. Stack fit=loose（默认），alignment: center',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints.expand(height: 200),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    color: Colors.red,
                    child: const Text(
                      'Hello world',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const Positioned(
                    left: 18.0,
                    child: Text('I am Jack'),
                  ),
                  const Positioned(
                    top: 18.0,
                    child: Text('Your friend'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '2. Stack fit=expand + alignment: center',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints.expand(height: 200),
              child: Stack(
                alignment: Alignment.center,
                fit: StackFit.expand,
                children: [
                  const Positioned(
                    left: 18.0,
                    child: Text('I am Jack'),
                  ),
                  Container(
                    color: Colors.red,
                    child: const Text(
                      'Hello world',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const Positioned(
                    top: 18.0,
                    child: Text('Your friend'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '区别说明：fit=loose时未定位子组件根据alignment定位，'
                'fit=expand时未定位子组件会填满整个Stack空间。'
                'Positioned组件始终按设置的left/top/right/bottom精确定位。',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
