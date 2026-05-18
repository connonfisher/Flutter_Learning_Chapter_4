// 对应网站小节: https://book.flutterchina.club/chapter4/intro.html
// 功能说明: 第四章布局类组件简介，演示Flutter中三种RenderObjectWidget基类
// (LeafRenderObjectWidget、SingleChildRenderObjectWidget、MultiChildRenderObjectWidget)
// 的使用场景，以及布局组件的基本概念。

import 'package:flutter/material.dart';

void main() => runApp(const Section4_1App());

class Section4_1App extends StatelessWidget {
  const Section4_1App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '4.1 布局类组件简介',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const IntroPage(),
    );
  }
}

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('4.1 布局类组件简介')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Flutter布局组件继承关系:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Widget → RenderObjectWidget → '
              '(LeafRenderObjectWidget | SingleChildRenderObjectWidget | '
              'MultiChildRenderObjectWidget)',
            ),
            const SizedBox(height: 16),
            // LeafRenderObjectWidget: 无子节点的Widget，如Image
            const Text(
              '1. LeafRenderObjectWidget（非容器类）',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Text('代表: Image, Text 等无子节点的Widget'),
            const SizedBox(height: 8),
            Image.network(
              'https://picsum.photos/200/100',
              width: 200,
              height: 100,
            ),
            const SizedBox(height: 16),
            // SingleChildRenderObjectWidget: 单子组件，如ConstrainedBox
            const Text(
              '2. SingleChildRenderObjectWidget（单子组件）',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Text('代表: ConstrainedBox, DecoratedBox, Padding, Align 等'),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: double.infinity,
                minHeight: 50,
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('ConstrainedBox + DecoratedBox（单子组件组合）'),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // MultiChildRenderObjectWidget: 多子组件，如Row, Column
            const Text(
              '3. MultiChildRenderObjectWidget（多子组件）',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Text('代表: Row, Column, Stack, Wrap, Flex 等'),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  color: Colors.red,
                  width: 60,
                  height: 60,
                  child: const Center(
                    child: Text('1', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  color: Colors.green,
                  width: 60,
                  height: 60,
                  child: const Center(
                    child: Text('2', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  color: Colors.blue,
                  width: 60,
                  height: 60,
                  child: const Center(
                    child: Text('3', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
