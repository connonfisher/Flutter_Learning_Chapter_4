// 对应网站小节: https://book.flutterchina.club/chapter4/layoutbuilder.html
// 功能说明: 演示LayoutBuilder和AfterLayout的使用，包括通过LayoutBuilder获取父组件约束
// 实现响应式布局（根据宽度切换单列/双列）、Builder获取上下文中的渲染对象大小，
// 以及AfterLayout在布局完成后获取子组件的尺寸和偏移量。

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(const Section4_8App());

class Section4_8App extends StatelessWidget {
  const Section4_8App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '4.8 LayoutBuilder和AfterLayout',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LayoutBuilderPage(),
    );
  }
}

class LayoutBuilderPage extends StatelessWidget {
  const LayoutBuilderPage({super.key});

  @override
  Widget build(BuildContext context) {
    const children = [
      Text('A'),
      Text('B'),
      Text('C'),
      Text('D'),
      Text('E'),
      Text('F'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('4.8 LayoutBuilder和AfterLayout'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '1. ResponsiveColumn（LayoutBuilder响应式布局）',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('宽度<200时显示单列，否则显示双列：'),
            const SizedBox(height: 4),
            const SizedBox(
              width: 190,
              child: ResponsiveColumn(children: children),
            ),
            const Divider(),
            const ResponsiveColumn(children: children),
            const SizedBox(height: 16),
            // Builder 获取 context.size
            const Text(
              '2. Builder获取Text组件尺寸（点击查看控制台输出）',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Builder(
              builder: (context) {
                return GestureDetector(
                  child: const Text(
                    'flutter@wendux（点我）',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: () {
                    final size = context.size;
                    debugPrint('Text size: $size');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Text size: $size')),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            // AfterLayout 示例
            const Text(
              '3. AfterLayout（布局完成后获取尺寸和坐标）',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            AfterLayout(
              callback: (RenderAfterLayout ral) {
                debugPrint('AfterLayout: size=${ral.size}, offset=${ral.offset}');
              },
              child: const Text(
                'flutter@wendux',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '检查控制台输出查看布局完成后的尺寸和坐标信息。',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            // AfterLayout + localToGlobal 示例
            const SizedBox(height: 16),
            const Text(
              '4. AfterLayout + localToGlobal（相对父级坐标）',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Builder(
              builder: (context) {
                return Container(
                  color: Colors.grey.shade200,
                  alignment: Alignment.center,
                  width: 100,
                  height: 100,
                  child: AfterLayout(
                    callback: (RenderAfterLayout ral) {
                      final offset = ral.localToGlobal(
                        Offset.zero,
                        ancestor: context.findRenderObject(),
                      );
                      debugPrint(
                        'A 在 Container 中占用的空间范围为：${offset & ral.size}',
                      );
                    },
                    child: const Text('A'),
                  ),
                );
              },
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// ---- ResponsiveColumn ----

class ResponsiveColumn extends StatelessWidget {
  const ResponsiveColumn({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 200) {
          return Column(
            children: children,
            mainAxisSize: MainAxisSize.min,
          );
        } else {
          final rows = <Widget>[];
          for (var i = 0; i < children.length; i += 2) {
            if (i + 1 < children.length) {
              rows.add(
                Row(
                  children: [children[i], children[i + 1]],
                  mainAxisSize: MainAxisSize.min,
                ),
              );
            } else {
              rows.add(children[i]);
            }
          }
          return Column(
            children: rows,
            mainAxisSize: MainAxisSize.min,
          );
        }
      },
    );
  }
}

// ---- AfterLayout ----

class AfterLayout extends SingleChildRenderObjectWidget {
  const AfterLayout({
    super.key,
    required this.callback,
    super.child,
  });

  final ValueSetter<RenderAfterLayout> callback;

  @override
  RenderAfterLayout createRenderObject(BuildContext context) {
    return RenderAfterLayout(callback);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderAfterLayout renderObject,
  ) {
    renderObject.callback = callback;
  }
}

class RenderAfterLayout extends RenderProxyBox {
  RenderAfterLayout(this.callback);

  ValueSetter<RenderAfterLayout> callback;

  /// 当前RenderObject在父级中的偏移量
  Offset get offset => (parentData as BoxParentData).offset;

  @override
  void performLayout() {
    super.performLayout();
    // 布局完成后回调，此时可以安全地获取子组件的size和offset
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback(this);
    });
  }
}
