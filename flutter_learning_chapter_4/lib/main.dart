// 第四章：布局类组件 — 综合展示
// 参考网站: https://book.flutterchina.club/chapter4/intro.html
//
// 本文件是第四章所有小节的可导航主页，点击每个卡片可进入对应小节的独立演示页面。
// 每个小节文件均包含自己的 main() 函数，可以独立运行。
//
// 小节列表:
// 4.1 布局类组件简介          → section4_1_intro.dart
// 4.2 布局原理与约束           → section4_2_constraints.dart
// 4.3 线性布局（Row和Column）  → section4_3_row_and_column.dart
// 4.4 弹性布局（Flex）         → section4_4_flex.dart
// 4.5 流式布局（Wrap、Flow）   → section4_5_wrap_and_flow.dart
// 4.6 层叠布局（Stack、Positioned）→ section4_6_stack.dart
// 4.7 对齐与相对定位（Align）   → section4_7_alignment.dart
// 4.8 LayoutBuilder、AfterLayout → section4_8_layoutbuilder.dart

import 'package:flutter/material.dart';

import 'section4_1_intro.dart';
import 'section4_2_constraints.dart';
import 'section4_3_row_and_column.dart';
import 'section4_4_flex.dart';
import 'section4_5_wrap_and_flow.dart';
import 'section4_6_stack.dart';
import 'section4_7_alignment.dart';
import 'section4_8_layoutbuilder.dart';

void main() => runApp(const Chapter4App());

class Chapter4App extends StatelessWidget {
  const Chapter4App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter第四章 - 布局类组件',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const Chapter4Home(),
    );
  }
}

class Chapter4Home extends StatelessWidget {
  const Chapter4Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('第四章：布局类组件'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 12.0),
            child: Text(
              '参考: https://book.flutterchina.club/chapter4/intro.html',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ),
          _buildSectionCard(
            context,
            title: '4.1 布局类组件简介',
            subtitle: 'LeafRenderObjectWidget / SingleChildRenderObjectWidget / MultiChildRenderObjectWidget',
            icon: Icons.info_outline,
            color: Colors.teal,
            page: const IntroPage(),
          ),
          _buildSectionCard(
            context,
            title: '4.2 布局原理与约束',
            subtitle: 'BoxConstraints / ConstrainedBox / SizedBox / UnconstrainedBox',
            icon: Icons.aspect_ratio,
            color: Colors.indigo,
            page: const ConstraintsPage(),
          ),
          _buildSectionCard(
            context,
            title: '4.3 线性布局（Row和Column）',
            subtitle: 'mainAxisAlignment / crossAxisAlignment / mainAxisSize',
            icon: Icons.view_agenda,
            color: Colors.orange,
            page: const RowAndColumnPage(),
          ),
          _buildSectionCard(
            context,
            title: '4.4 弹性布局（Flex）',
            subtitle: 'Flex / Expanded / Spacer',
            icon: Icons.space_bar,
            color: Colors.pink,
            page: const FlexPage(),
          ),
          _buildSectionCard(
            context,
            title: '4.5 流式布局（Wrap和Flow）',
            subtitle: 'Wrap自动换行 / Flow自定义流式布局',
            icon: Icons.wrap_text,
            color: Colors.purple,
            page: const WrapAndFlowPage(),
          ),
          _buildSectionCard(
            context,
            title: '4.6 层叠布局（Stack和Positioned）',
            subtitle: 'Stack / StackFit / Positioned精确定位',
            icon: Icons.layers,
            color: Colors.deepOrange,
            page: const StackPage(),
          ),
          _buildSectionCard(
            context,
            title: '4.7 对齐与相对定位（Align）',
            subtitle: 'Align / Alignment / FractionalOffset / Center',
            icon: Icons.align_horizontal_center,
            color: Colors.blueGrey,
            page: const AlignPage(),
          ),
          _buildSectionCard(
            context,
            title: '4.8 LayoutBuilder和AfterLayout',
            subtitle: 'LayoutBuilder响应式布局 / AfterLayout获取尺寸坐标',
            icon: Icons.build,
            color: Colors.green,
            page: const LayoutBuilderPage(),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Widget page,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10.0),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: color,
          radius: 22,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(subtitle),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
        },
      ),
    );
  }
}
