<!-- omit in toc -->
# Flutter 学习 — 第四章：布局类组件

基于 [《Flutter实战·第二版》](https://book.flutterchina.club/chapter4/intro.html) 第四章的完整代码复现，涵盖 Flutter 布局系统的核心组件。

<!-- omit in toc -->
## 目录

- [项目简介](#项目简介)
- [项目结构](#项目结构)
- [4.1 布局类组件简介](#41-布局类组件简介)
  - [功能介绍](#功能介绍-41)
  - [演示截图](#演示截图-41)
  - [核心代码](#核心代码-41)
  - [关键要点](#关键要点-41)
- [4.2 布局原理与约束](#42-布局原理与约束)
  - [功能介绍](#功能介绍-42)
  - [演示截图](#演示截图-42)
  - [核心代码](#核心代码-42)
  - [关键要点](#关键要点-42)

---

## 项目简介

本项目完整覆盖了《Flutter实战·第二版》第四章「布局类组件」的全部 8 个小节，每小节对应一个独立的 Dart 文件，可单独运行。`main.dart` 提供统一导航，方便浏览所有小节。

**参考链接：** [https://book.flutterchina.club/chapter4/intro.html](https://book.flutterchina.club/chapter4/intro.html)

| 小节 | 内容 | 文件 |
|------|------|------|
| 4.1 | 布局类组件简介 | [section4_1_intro.dart](lib/section4_1_intro.dart) |
| 4.2 | 布局原理与约束 | [section4_2_constraints.dart](lib/section4_2_constraints.dart) |
| 4.3 | 线性布局（Row/Column）| [section4_3_row_and_column.dart](lib/section4_3_row_and_column.dart) |
| 4.4 | 弹性布局（Flex）| [section4_4_flex.dart](lib/section4_4_flex.dart) |
| 4.5 | 流式布局（Wrap/Flow）| [section4_5_wrap_and_flow.dart](lib/section4_5_wrap_and_flow.dart) |
| 4.6 | 层叠布局（Stack/Positioned）| [section4_6_stack.dart](lib/section4_6_stack.dart) |
| 4.7 | 对齐与相对定位（Align）| [section4_7_alignment.dart](lib/section4_7_alignment.dart) |
| 4.8 | LayoutBuilder / AfterLayout | [section4_8_layoutbuilder.dart](lib/section4_8_layoutbuilder.dart) |

### 项目结构

```
lib/
├── main.dart                          ← 综合导航主页
├── section4_1_intro.dart              ← 各小节独立文件
├── section4_2_constraints.dart
├── section4_3_row_and_column.dart
├── section4_4_flex.dart
├── section4_5_wrap_and_flow.dart
├── section4_6_stack.dart
├── section4_7_alignment.dart
└── section4_8_layoutbuilder.dart
演示截图/                               ← 各小节演示截图
├── 4.1 布局类组件简介-代码.png
├── 4.1 布局类组件简介-运行效果.png
├── 4.2 布局原理与约束-代码.png
└── 4.2 布局原理与约束-运行效果.png
```

---

## 4.1 布局类组件简介

> 参考链接：[https://book.flutterchina.club/chapter4/intro.html](https://book.flutterchina.club/chapter4/intro.html)

### 功能介绍 {#功能介绍-41}

本小节演示了 Flutter 中三类 `RenderObjectWidget` 基类的用途与区别：

- **LeafRenderObjectWidget** — 非容器类组件基类，无子节点（如 `Image`、`Text`）
- **SingleChildRenderObjectWidget** — 单子组件基类（如 `ConstrainedBox`、`DecoratedBox`）
- **MultiChildRenderObjectWidget** — 多子组件基类，通过 `children` 接收子组件数组（如 `Row`、`Column`、`Stack`）

继承关系：**Widget → RenderObjectWidget → (Leaf / SingleChild / MultiChild) RenderObjectWidget**

### 演示截图 {#演示截图-41}

| 代码截图 | 运行效果 |
|----------|----------|
| ![4.1代码](演示截图/4.1%20布局类组件简介-代码.png) | ![4.1运行](演示截图/4.1%20布局类组件简介-运行效果.png) |

### 核心代码 {#核心代码-41}

```dart
// 1. LeafRenderObjectWidget — 无子节点，如 Image
Image.network(
  'https://picsum.photos/200/100',
  width: 200,
  height: 100,
);

// 2. SingleChildRenderObjectWidget — 单子组件，如 ConstrainedBox + DecoratedBox
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
);

// 3. MultiChildRenderObjectWidget — 多子组件，如 Row
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
);
```

### 关键要点 {#关键要点-41}

1. Flutter 中所有布局类组件都直接或间接继承自 `RenderObjectWidget`
2. `LeafRenderObjectWidget` 是叶子节点，不能包含子组件（如 `Image`）
3. `SingleChildRenderObjectWidget` 只能包含一个子组件（如 `Padding`、`Align`）
4. `MultiChildRenderObjectWidget` 可包含多个子组件（如 `Row`、`Column`、`Stack`）
5. 布局算法的具体实现位于对应的 `RenderObject` 对象中（如 `RenderFlex`、`RenderStack`）

---

## 4.2 布局原理与约束

> 参考链接：[https://book.flutterchina.club/chapter4/constraints.html](https://book.flutterchina.club/chapter4/constraints.html)

### 功能介绍 {#功能介绍-42}

本小节演示了 Flutter 布局的核心原理——约束（Constraints），涵盖以下核心概念：

- **BoxConstraints** — 盒约束，包含 minWidth / maxWidth / minHeight / maxHeight 四个属性
- **ConstrainedBox** — 为子组件施加额外约束，父约束与子约束取交集
- **SizedBox** — 固定宽高的语法糖，内部等价于 `ConstrainedBox(BoxConstraints.tightFor(...))`
- **多重限制** — 多个 ConstrainedBox 嵌套时，最终约束为所有约束的交集
- **UnconstrainedBox** — 去除父级约束，让子组件按自身大小自由布局

Flutter 布局规则：**约束向下传递，尺寸向上传递，父节点最终决定子节点位置**。

### 演示截图 {#演示截图-42}

| 代码截图 | 运行效果 |
|----------|----------|
| ![4.2代码](演示截图/4.2%20布局原理与约束-代码.png) | ![4.2运行](演示截图/4.2%20布局原理与约束-运行效果.png) |

### 核心代码 {#核心代码-42}

```dart
// 1. ConstrainedBox — 施加最小高度约束
ConstrainedBox(
  constraints: const BoxConstraints(minHeight: 50.0),
  child: Container(
    height: 5.0,
    child: const DecoratedBox(
      decoration: BoxDecoration(color: Colors.red),
    ),
  ),
);

// 2. SizedBox — 固定宽高（等价于 ConstrainedBox + BoxConstraints.tightFor）
const SizedBox(
  width: 80.0,
  height: 80.0,
  child: DecoratedBox(
    decoration: BoxDecoration(color: Colors.red),
  ),
);

// 3. 多重限制 — 父约束与子约束取交集（最终: 90x60）
ConstrainedBox(
  constraints: const BoxConstraints(minWidth: 60.0, minHeight: 60.0), // 父
  child: ConstrainedBox(
    constraints: const BoxConstraints(minWidth: 90.0, minHeight: 20.0), // 子
    child: redBox,
  ),
);

// 4. UnconstrainedBox — 去除父级限制
ConstrainedBox(
  constraints: const BoxConstraints(minWidth: 60.0, minHeight: 100.0), // 父
  child: UnconstrainedBox(
    child: ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 90.0, minHeight: 20.0), // 子
      child: redBox,
    ),
  ),
);

// 5. AppBar actions 中使用 UnconstrainedBox 去除父级约束
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
);
```

### 关键要点 {#关键要点-42}

1. 父组件通过 `BoxConstraints` 向子组件传递约束，子组件根据约束确定自身尺寸
2. 多个 `ConstrainedBox` 嵌套时，最终约束 = 所有约束的**交集**（取最严格的值）
3. `SizedBox` 本质是 `ConstrainedBox` + `BoxConstraints.tightFor` 的语法糖
4. `UnconstrainedBox` 可"去除"父级约束，让子组件自由布局，但可能导致溢出
5. AppBar 等系统组件内部会对 actions 施加限制，需要 `UnconstrainedBox` 解除
