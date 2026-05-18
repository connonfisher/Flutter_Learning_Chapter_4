// 对应网站小节: https://book.flutterchina.club/chapter4/alignment.html
// 功能说明: 演示Flutter对齐与相对定位（Align），包括Align通过alignment参数定位子组件、
// widthFactor/heightFactor的使用、Alignment与FractionalOffset两种坐标系，
// 以及Center组件（Align的子类）的用法。

import 'package:flutter/material.dart';

void main() => runApp(const Section4_7App());

class Section4_7App extends StatelessWidget {
  const Section4_7App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '4.7 对齐与相对定位',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AlignPage(),
    );
  }
}

class AlignPage extends StatelessWidget {
  const AlignPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('4.7 对齐与相对定位（Align）')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Align 基本示例
            const Text(
              '1. Align: alignment: topRight',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              height: 120.0,
              width: 120.0,
              color: Colors.blue.shade50,
              child: const Align(
                alignment: Alignment.topRight,
                child: FlutterLogo(size: 60),
              ),
            ),
            const SizedBox(height: 16),
            // Align + widthFactor/heightFactor
            const Text(
              '2. Align: widthFactor=2, heightFactor=2, alignment: topRight',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Text('(Align自身宽高 = 子组件宽高 × factor)'),
            const SizedBox(height: 8),
            Container(
              color: Colors.blue.shade50,
              child: const Align(
                widthFactor: 2,
                heightFactor: 2,
                alignment: Alignment.topRight,
                child: FlutterLogo(size: 60),
              ),
            ),
            const SizedBox(height: 16),
            // Align + 自定义Alignment(2, 0)
            const Text(
              '3. Align: alignment: Alignment(2, 0)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              color: Colors.blue.shade50,
              child: const Align(
                widthFactor: 2,
                heightFactor: 2,
                alignment: Alignment(2, 0.0),
                child: FlutterLogo(size: 60),
              ),
            ),
            const SizedBox(height: 16),
            // FractionalOffset 示例
            const Text(
              '4. Align + FractionalOffset(0.2, 0.6)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Text(
              '(FractionalOffset: (0,0)=左上, (1,1)=右下)',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Container(
              height: 120.0,
              width: 120.0,
              color: Colors.blue.shade50,
              child: const Align(
                alignment: FractionalOffset(0.2, 0.6),
                child: FlutterLogo(size: 60),
              ),
            ),
            const SizedBox(height: 16),
            // Center 与 Center(widthFactor: 1) 对比
            const Text(
              '5. Center（Align子类）对比',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                DecoratedBox(
                  decoration: const BoxDecoration(color: Colors.red),
                  child: Center(
                    child: Container(
                      color: Colors.white,
                      child: const Text('xxx'),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                DecoratedBox(
                  decoration: const BoxDecoration(color: Colors.red),
                  child: const Center(
                    widthFactor: 1,
                    heightFactor: 1,
                    child: Text('xxx'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              '左侧: Center不带factor → 填满父级（红色铺满）\n'
              '右侧: Center带factor=1 → 紧贴子组件大小',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
