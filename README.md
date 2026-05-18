# Flutter 布局类组件演示

基于 [《Flutter 实战·第二版》](https://book.flutterchina.club/) 第四章「布局类组件」的学习项目，将每个小节的示例代码独立拆分，支持**单文件运行**和**统一导航**两种方式。

## 环境

- Flutter 3.41.4 · Dart 3.11.1
- 支持 Android / Windows / Web

## 快速开始

```bash
# 1. 克隆项目
git clone https://github.com/connonfisher/Flutter_Learning_Chapter_4.git
cd Flutter_Learning_Chapter_4

# 2. 安装依赖
flutter pub get

# 3. 运行总目录（可导航到所有小节）
flutter run

# 4. 或单独运行某一小节（以 4.1 为例）
flutter run lib/section4_1_intro.dart
```

## 项目结构

```
lib/
├── main.dart                         # 入口：章节总目录
├── section4_1_intro.dart             # 4.1 布局类组件简介
├── section4_2_constraints.dart       # 4.2 布局原理与约束
├── section4_3_row_and_column.dart    # 4.3 线性布局（Row/Column）
├── section4_4_flex.dart              # 4.4 弹性布局（Flex）
├── section4_5_wrap_and_flow.dart     # 4.5 流式布局（Wrap/Flow）
├── section4_6_stack.dart             # 4.6 层叠布局（Stack/Positioned）
├── section4_7_alignment.dart         # 4.7 对齐与相对定位（Align）
└── section4_8_layoutbuilder.dart     # 4.8 LayoutBuilder / AfterLayout
```

> 每个小节文件末尾都包含独立的 `main()` 入口，可脱离主目录单独运行。

## main.dart —— 章节总目录

`main.dart` 是项目的主入口，将所有 8 个小节整合为一个卡片式导航页面，点击任意卡片即可跳转到对应小节演示。

```dart
import 'section4_1_intro.dart';
import 'section4_2_constraints.dart';
// ... 其余小节

MaterialApp(
  home: Scaffold(
    body: ListView(
      children: [
        _buildSectionCard(context, '4.1 布局类组件简介', ..., const IntroPage()),
        _buildSectionCard(context, '4.2 布局原理与约束', ..., const ConstraintsPage()),
        // ... 共 8 张卡片
      ],
    ),
  ),
)
```

---

# 4.1 布局类组件简介

> 原文地址：[4.1 布局类组件简介](https://book.flutterchina.club/chapter4/intro.html)

## 功能介绍

演示 Flutter 中三类 `RenderObjectWidget` 基类的用途与区别：

| 知识点 | 说明 |
|--------|------|
| `LeafRenderObjectWidget` | 非容器类组件基类，无子节点（如 `Image`、`Text`） |
| `SingleChildRenderObjectWidget` | 单子组件基类（如 `ConstrainedBox`、`DecoratedBox`） |
| `MultiChildRenderObjectWidget` | 多子组件基类，通过 `children` 接收子组件数组（如 `Row`、`Column`、`Stack`） |

> 继承关系：`Widget → RenderObjectWidget → (Leaf / SingleChild / MultiChild) RenderObjectWidget`

## 演示效果

| 代码 | 运行效果 |
|:---:|:---:|
| ![代码截图](演示截图/4.1%20布局类组件简介-代码.png) | ![运行效果](演示截图/4.1%20布局类组件简介-运行效果.png) |

## 核心代码示例

### LeafRenderObjectWidget — 叶子节点

```dart
Image.network(
  'https://picsum.photos/200/100',
  width: 200,
  height: 100,
)
```

### SingleChildRenderObjectWidget — 单子组件

```dart
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
)
```

### MultiChildRenderObjectWidget — 多子组件

```dart
Row(
  children: [
    Container(width: 60, height: 60, color: Colors.red,
      child: const Center(child: Text('1', style: TextStyle(color: Colors.white)))),
    const SizedBox(width: 8),
    Container(width: 60, height: 60, color: Colors.green,
      child: const Center(child: Text('2', style: TextStyle(color: Colors.white)))),
    const SizedBox(width: 8),
    Container(width: 60, height: 60, color: Colors.blue,
      child: const Center(child: Text('3', style: TextStyle(color: Colors.white)))),
  ],
)
```

## 独立运行

```bash
flutter run lib/section4_1_intro.dart
```

或直接在 IDE 中打开该文件，运行文件内的 `main()` 即可。

---

# 4.2 布局原理与约束

> 原文地址：[4.2 布局原理与约束](https://book.flutterchina.club/chapter4/constraints.html)

## 功能介绍

演示 Flutter 布局的核心原理——约束（Constraints），涵盖以下核心概念：

| 知识点 | 说明 |
|--------|------|
| `BoxConstraints` | 盒约束，包含 `minWidth` / `maxWidth` / `minHeight` / `maxHeight` 四个属性 |
| `ConstrainedBox` | 为子组件施加额外约束，父约束与子约束取交集 |
| `SizedBox` | 固定宽高的语法糖，内部等价于 `ConstrainedBox(BoxConstraints.tightFor(...))` |
| 多重限制 | 多个 `ConstrainedBox` 嵌套时，最终约束为所有约束的交集 |
| `UnconstrainedBox` | 去除父级约束，让子组件按自身大小自由布局 |

> Flutter 布局规则：**约束向下传递，尺寸向上传递，父节点最终决定子节点位置。**

## 演示效果

| 代码 | 运行效果 |
|:---:|:---:|
| ![代码截图](演示截图/4.2%20布局原理与约束-代码.png) | ![运行效果](演示截图/4.2%20布局原理与约束-运行效果.png) |

## 核心代码示例

### ConstrainedBox — 施加最小高度约束

```dart
ConstrainedBox(
  constraints: const BoxConstraints(minHeight: 50.0),
  child: Container(
    height: 5.0,
    child: const DecoratedBox(
      decoration: BoxDecoration(color: Colors.red),
    ),
  ),
)
```

### SizedBox — 固定宽高

```dart
const SizedBox(
  width: 80.0,
  height: 80.0,
  child: DecoratedBox(
    decoration: BoxDecoration(color: Colors.red),
  ),
)
```

### 多重限制 — 父约束与子约束取交集

```dart
ConstrainedBox(
  constraints: const BoxConstraints(minWidth: 60.0, minHeight: 60.0), // 父
  child: ConstrainedBox(
    constraints: const BoxConstraints(minWidth: 90.0, minHeight: 20.0), // 子
    child: redBox, // 最终: 90×60
  ),
)
```

### UnconstrainedBox — 去除父级限制

```dart
ConstrainedBox(
  constraints: const BoxConstraints(minWidth: 60.0, minHeight: 100.0), // 父
  child: UnconstrainedBox(
    child: ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 90.0, minHeight: 20.0), // 子
      child: redBox,
    ),
  ),
)
```

### AppBar actions 中使用 UnconstrainedBox

```dart
AppBar(
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
  ],
)
```

## 独立运行

```bash
flutter run lib/section4_2_constraints.dart
```

或直接在 IDE 中打开该文件，运行文件内的 `main()` 即可。

---

# 4.3 线性布局（Row 和 Column）

> 原文地址：[4.3 线性布局](https://book.flutterchina.club/chapter4/row_and_column.html)

## 功能介绍

演示 Flutter 线性布局的核心属性与用法：

| 知识点 | 说明 |
|--------|------|
| `Row` / `Column` | 水平/垂直线性布局，继承自 `Flex` |
| `mainAxisAlignment` | 主轴对齐方式：`start`、`center`、`end`、`spaceBetween` 等 |
| `crossAxisAlignment` | 交叉轴对齐方式：`start`、`center`、`end`、`stretch` 等 |
| `mainAxisSize` | 主轴尺寸模式：`max`（填满）/ `min`（包裹子组件） |
| `textDirection` / `verticalDirection` | 文本方向 / 垂直方向，影响子组件排列顺序 |
| 嵌套 Column + Expanded | 内层 `Column` 通过 `Expanded` 填充外层 `Column` 的剩余空间 |

## 演示效果

| 代码 | 运行效果 |
|:---:|:---:|
| ![代码截图](演示截图/4.3%20线性布局（Row和Column）-代码.png) | ![运行效果](演示截图/4.3%20线性布局（Row和Column）-运行效果.png) |

## 核心代码示例

### Row 对齐方式

```dart
// mainAxisAlignment: center
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: const [
    Text(' hello world '),
    Text(' I am Jack '),
  ],
)

// mainAxisSize: min + mainAxisAlignment: center
Row(
  mainAxisSize: MainAxisSize.min,
  mainAxisAlignment: MainAxisAlignment.center,
  children: const [
    Text(' hello world '),
    Text(' I am Jack '),
  ],
)

// mainAxisAlignment: end + textDirection: rtl
Row(
  mainAxisAlignment: MainAxisAlignment.end,
  textDirection: TextDirection.rtl,
  children: const [
    Text(' hello world '),
    Text(' I am Jack '),
  ],
)

// crossAxisAlignment: start + verticalDirection: up
Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  verticalDirection: VerticalDirection.up,
  children: const [
    Text(' hello world ', style: TextStyle(fontSize: 30.0)),
    Text(' I am Jack '),
  ],
)
```

### 嵌套 Column + Expanded

```dart
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
)
```

## 独立运行

```bash
flutter run lib/section4_3_row_and_column.dart
```

或直接在 IDE 中打开该文件，运行文件内的 `main()` 即可。

---

# 4.4 弹性布局（Flex）

> 原文地址：[4.4 弹性布局](https://book.flutterchina.club/chapter4/flex.html)

## 功能介绍

演示 Flutter 弹性布局的核心用法，`Row` 和 `Column` 均继承自 `Flex`：

| 知识点 | 说明 |
|--------|------|
| `Flex` | 弹性布局基类，通过 `direction` 指定水平或垂直方向 |
| `Expanded` | 按 `flex` 比例分配父容器剩余空间 |
| `Spacer` | `Expanded` + `SizedBox.shrink` 的语法糖，用于创建可伸缩的空白间隔 |

## 演示效果

| 代码 | 运行效果 |
|:---:|:---:|
| ![代码截图](演示截图/4.4%20弹性布局（Flex）-代码.png) | ![运行效果](演示截图/4.4%20弹性布局（Flex）-运行效果.png) |

## 核心代码示例

### Flex 水平方向（1:2 比例）

```dart
Flex(
  direction: Axis.horizontal,
  children: [
    Expanded(
      flex: 1,
      child: Container(height: 30.0, color: Colors.red),
    ),
    Expanded(
      flex: 2,
      child: Container(height: 30.0, color: Colors.green),
    ),
  ],
)
```

### Flex 垂直方向（2:1:1 + Spacer）

```dart
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
)
```

## 独立运行

```bash
flutter run lib/section4_4_flex.dart
```

或直接在 IDE 中打开该文件，运行文件内的 `main()` 即可。

---

# 4.5 流式布局（Wrap 和 Flow）

> 原文地址：[4.5 流式布局](https://book.flutterchina.club/chapter4/wrap_and_flow.html)

## 功能介绍

演示 Flutter 流式布局的两种实现方式：

| 知识点 | 说明 |
|--------|------|
| `Wrap` | 自动换行的流式布局，`spacing`（主轴间距）/ `runSpacing`（纵轴间距）/ `alignment` |
| `Flow` | 更底层的流式布局，通过 `FlowDelegate` 完全自定义子组件位置和绘制 |
| Row 溢出问题 | `Row` 不自动换行，子组件超出屏幕宽度时产生溢出警告 |

> `Wrap` 开箱即用，适合多数场景；`Flow` 需自定义 `FlowDelegate`，性能更优但更复杂。

## 演示效果

| 代码 | 运行效果 |
|:---:|:---:|
| ![代码截图](演示截图/4.5%20流式布局（Wrap和Flow）-代码.png) | ![运行效果](演示截图/4.5%20流式布局（Wrap和Flow）-运行效果.png) |

## 核心代码示例

### Wrap 自动换行

```dart
Wrap(
  spacing: 8.0,
  runSpacing: 4.0,
  alignment: WrapAlignment.center,
  children: const [
    Chip(
      avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('A')),
      label: Text('Hamilton'),
    ),
    Chip(
      avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('M')),
      label: Text('Lafayette'),
    ),
    Chip(
      avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('H')),
      label: Text('Mulligan'),
    ),
    Chip(
      avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('J')),
      label: Text('Laurens'),
    ),
  ],
)
```

### Flow 自定义流式布局

```dart
SizedBox(
  height: 200,
  child: Flow(
    delegate: TestFlowDelegate(margin: const EdgeInsets.all(10.0)),
    children: [
      Container(width: 80.0, height: 80.0, color: Colors.red),
      Container(width: 80.0, height: 80.0, color: Colors.green),
      Container(width: 80.0, height: 80.0, color: Colors.blue),
      Container(width: 80.0, height: 80.0, color: Colors.yellow),
      Container(width: 80.0, height: 80.0, color: Colors.brown),
      Container(width: 80.0, height: 80.0, color: Colors.purple),
    ],
  ),
)
```

### FlowDelegate 自定义绘制

```dart
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
        context.paintChild(i,
          transform: Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i)!.height + margin.top + margin.bottom;
        context.paintChild(i,
          transform: Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i)!.width + margin.left + margin.right;
      }
    }
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) => oldDelegate != this;
}
```

## 独立运行

```bash
flutter run lib/section4_5_wrap_and_flow.dart
```

或直接在 IDE 中打开该文件，运行文件内的 `main()` 即可。

---

# 4.6 层叠布局（Stack 和 Positioned）

> 原文地址：[4.6 层叠布局](https://book.flutterchina.club/chapter4/stack.html)

## 功能介绍

演示 Flutter 层叠布局的两种模式与精确定位：

| 知识点 | 说明 |
|--------|------|
| `Stack` | 层叠布局容器，子组件按添加顺序从底到顶堆叠 |
| `StackFit.loose` | 默认模式，未定位子组件根据 `alignment` 定位，大小由自身决定 |
| `StackFit.expand` | 扩展模式，未定位子组件会填满整个 `Stack` 空间 |
| `Positioned` | 通过 `left` / `top` / `right` / `bottom` 对子组件精确定位 |
| `alignment` | 控制未定位子组件的对齐方式，默认 `AlignmentDirectional.topStart` |

> `Positioned` 组件始终按设置的坐标精确定位，不受 `StackFit` 和 `alignment` 影响。

## 演示效果

| 代码 | 运行效果 |
|:---:|:---:|
| ![代码截图](演示截图/4.6%20层叠布局（Stack和Positioned）-代码.png) | ![运行效果](演示截图/4.6%20层叠布局（Stack和Positioned）-运行效果.png) |

## 核心代码示例

### Stack fit=loose（默认）+ alignment: center

```dart
ConstrainedBox(
  constraints: const BoxConstraints.expand(height: 200),
  child: Stack(
    alignment: Alignment.center,
    children: [
      Container(
        color: Colors.red,
        child: const Text('Hello world', style: TextStyle(color: Colors.white)),
      ),
      const Positioned(left: 18.0, child: Text('I am Jack')),
      const Positioned(top: 18.0, child: Text('Your friend')),
    ],
  ),
)
```

### Stack fit=expand + alignment: center

```dart
ConstrainedBox(
  constraints: const BoxConstraints.expand(height: 200),
  child: Stack(
    alignment: Alignment.center,
    fit: StackFit.expand,
    children: [
      const Positioned(left: 18.0, child: Text('I am Jack')),
      Container(
        color: Colors.red,
        child: const Text('Hello world', style: TextStyle(color: Colors.white)),
      ),
      const Positioned(top: 18.0, child: Text('Your friend')),
    ],
  ),
)
```

## 独立运行

```bash
flutter run lib/section4_6_stack.dart
```

或直接在 IDE 中打开该文件，运行文件内的 `main()` 即可。

---

# 4.7 对齐与相对定位（Align）

> 原文地址：[4.7 对齐与相对定位](https://book.flutterchina.club/chapter4/alignment.html)

## 功能介绍

演示 Flutter 中对齐与相对定位的核心组件：

| 知识点 | 说明 |
|--------|------|
| `Align` | 通过 `alignment` 参数（`Alignment` 或 `FractionalOffset`）定位子组件 |
| `widthFactor` / `heightFactor` | 控制 `Align` 自身尺寸 = 子组件尺寸 × factor |
| `Alignment` 坐标系 | 原点中心，`(-1,-1)` = 左上，`(1,1)` = 右下，`(0,0)` = 中心 |
| `FractionalOffset` 坐标系 | 原点左上，`(0,0)` = 左上，`(1,1)` = 右下 |
| `Center` | `Align` 的子类，`alignment: Alignment.center`，可选 `widthFactor` / `heightFactor` |

## 核心代码示例

### Align 基本定位

```dart
Container(
  height: 120.0,
  width: 120.0,
  color: Colors.blue.shade50,
  child: const Align(
    alignment: Alignment.topRight,
    child: FlutterLogo(size: 60),
  ),
)
```

### Align + widthFactor / heightFactor

```dart
Container(
  color: Colors.blue.shade50,
  child: const Align(
    widthFactor: 2,
    heightFactor: 2,
    alignment: Alignment.topRight,
    child: FlutterLogo(size: 60),
  ),
)
```

### Align + 自定义 Alignment(2, 0)

```dart
Container(
  color: Colors.blue.shade50,
  child: const Align(
    widthFactor: 2,
    heightFactor: 2,
    alignment: Alignment(2, 0.0),
    child: FlutterLogo(size: 60),
  ),
)
```

### FractionalOffset 坐标系

```dart
Container(
  height: 120.0,
  width: 120.0,
  color: Colors.blue.shade50,
  child: const Align(
    alignment: FractionalOffset(0.2, 0.6),
    child: FlutterLogo(size: 60),
  ),
)
```

### Center（Align 子类）对比

```dart
Row(
  children: [
    // Center 不带 factor → 填满父级
    DecoratedBox(
      decoration: const BoxDecoration(color: Colors.red),
      child: Center(
        child: Container(color: Colors.white, child: const Text('xxx')),
      ),
    ),
    // Center 带 factor=1 → 紧贴子组件大小
    DecoratedBox(
      decoration: const BoxDecoration(color: Colors.red),
      child: const Center(
        widthFactor: 1,
        heightFactor: 1,
        child: Text('xxx'),
      ),
    ),
  ],
)
```

## 独立运行

```bash
flutter run lib/section4_7_alignment.dart
```

或直接在 IDE 中打开该文件，运行文件内的 `main()` 即可。

---

# 4.8 LayoutBuilder 和 AfterLayout

> 原文地址：[4.8 LayoutBuilder 和 AfterLayout](https://book.flutterchina.club/chapter4/layoutbuilder.html)

## 功能介绍

演示布局构建器和布局完成后的回调机制：

| 知识点 | 说明 |
|--------|------|
| `LayoutBuilder` | 在布局阶段获取父组件传递的 `BoxConstraints`，实现响应式布局 |
| `Builder` | 获取 `context.size`，在回调中访问当前组件的渲染尺寸 |
| `AfterLayout` | 自定义 `SingleChildRenderObjectWidget`，在 `performLayout` 后回调，获取尺寸和偏移量 |
| `localToGlobal` | 将局部坐标转换为相对祖先组件的全局坐标 |

## 核心代码示例

### LayoutBuilder 响应式布局

```dart
class ResponsiveColumn extends StatelessWidget {
  const ResponsiveColumn({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 200) {
          return Column(children: children, mainAxisSize: MainAxisSize.min);
        } else {
          // 宽度 ≥200 时，每行显示 2 个子组件
          final rows = <Widget>[];
          for (var i = 0; i < children.length; i += 2) {
            if (i + 1 < children.length) {
              rows.add(Row(
                children: [children[i], children[i + 1]],
                mainAxisSize: MainAxisSize.min,
              ));
            } else {
              rows.add(children[i]);
            }
          }
          return Column(children: rows, mainAxisSize: MainAxisSize.min);
        }
      },
    );
  }
}
```

### Builder 获取 context.size

```dart
Builder(
  builder: (context) {
    return GestureDetector(
      child: const Text('flutter@wendux（点我）',
        style: TextStyle(color: Colors.blue)),
      onTap: () {
        final size = context.size;
        debugPrint('Text size: $size');
      },
    );
  },
)
```

### AfterLayout 获取尺寸和坐标

```dart
AfterLayout(
  callback: (RenderAfterLayout ral) {
    debugPrint('AfterLayout: size=${ral.size}, offset=${ral.offset}');
  },
  child: const Text('flutter@wendux',
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
)
```

### localToGlobal 相对坐标转换

```dart
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
          debugPrint('A 在 Container 中占用的空间范围为：${offset & ral.size}');
        },
        child: const Text('A'),
      ),
    );
  },
)
```

## 独立运行

```bash
flutter run lib/section4_8_layoutbuilder.dart
```

或直接在 IDE 中打开该文件，运行文件内的 `main()` 即可。

---

> 📖 以上为《Flutter 实战·第二版》第四章全部 8 小节。主入口 `flutter run` 可导航到所有小节。
