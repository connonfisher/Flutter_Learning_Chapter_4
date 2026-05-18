// 对应网站小节: https://book.flutterchina.club/chapter4/constraints.html
// 功能说明: 演示Flutter布局原理与约束（constraints），包括BoxConstraints、ConstrainedBox、
// SizedBox、多重限制（父约束与子约束的叠加）、UnconstrainedBox的使用及AppBar中去除限制的实例。

import 'package:flutter/material.dart';

void main() => runApp(const Section4_2App());

class Section4_2App extends StatelessWidget {
  const Section4_2App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '4.2 布局原理与约束',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ConstraintsPage(),
    );
  }
}

class ConstraintsPage extends StatelessWidget {
  const ConstraintsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const redBox = DecoratedBox(
      decoration: BoxDecoration(color: Colors.red),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('4.2 布局原理与约束'),
        actions: [
          UnconstrainedBox(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation(Colors.white70),
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ConstrainedBox 示例
            const Text(
              '1. ConstrainedBox（最小高度50）',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 50.0),
              child: Container(height: 5.0, child: redBox),
            ),
            const SizedBox(height: 16),
            // SizedBox 示例
            const Text(
              '2. SizedBox（固定宽高80x80）',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const SizedBox(width: 80.0, height: 80.0, child: redBox),
            const SizedBox(height: 16),
            // 多重限制 示例一：父约束不小于60x60，子约束不小于90x20
            const Text(
              '3. 多重限制（父60x60，子90x20，取交集 → 90x60）',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 60.0,
                minHeight: 60.0,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 90.0,
                  minHeight: 20.0,
                ),
                child: redBox,
              ),
            ),
            const SizedBox(height: 16),
            // 多重限制 示例二：父约束不小于90x20，子约束不小于60x60
            const Text(
              '4. 多重限制（父90x20，子60x60，取交集 → 90x60）',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 90.0,
                minHeight: 20.0,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 60.0,
                  minHeight: 60.0,
                ),
                child: redBox,
              ),
            ),
            const SizedBox(height: 16),
            // UnconstrainedBox 示例
            const Text(
              '5. UnconstrainedBox（去除父级限制，子90x20自由生效）',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 60.0,
                minHeight: 100.0,
              ),
              child: UnconstrainedBox(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 90.0,
                    minHeight: 20.0,
                  ),
                  child: redBox,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '提示：AppBar右上角有一个UnconstrainedBox包裹的CircularProgressIndicator，'
              '说明AppBar默认会对actions施加限制，需要通过UnconstrainedBox去除。',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
