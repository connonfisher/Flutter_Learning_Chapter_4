# Flutter 布局类组件演示

Based on Chapter 4 ("布局类组件") of *Flutter 实战·第二版*, this project splits each section's sample code into independently runnable files with unified navigation.

## Environment & Quick Start

- **Flutter 3.41.4 · Dart 3.11.1** — supports Android, Windows, and Web.

```bash
git clone https://github.com/connonfisher/Flutter_Learning_Chapter_4.git
cd Flutter_Learning_Chapter_4
flutter pub get
flutter run                          # main navigation
flutter run lib/section4_1_intro.dart  # single section
```

## Project Structure

```
lib/
├── main.dart                         # Entry: chapter index
├── section4_1_intro.dart             # 4.1 布局类组件简介
├── section4_2_constraints.dart       # 4.2 布局原理与约束
├── section4_3_row_and_column.dart    # 4.3 线性布局（Row/Column）
├── section4_4_flex.dart              # 4.4 弹性布局（Flex）
├── section4_5_wrap_and_flow.dart     # 4.5 流式布局（Wrap/Flow）
├── section4_6_stack.dart             # 4.6 层叠布局（Stack/Positioned）
├── section4_7_alignment.dart         # 4.7 对齐与相对定位（Align）
└── section4_8_layoutbuilder.dart     # 4.8 LayoutBuilder / AfterLayout
演示截图/                               # Demo screenshots
```

Each file includes its own `main()` entry for standalone execution.

## main.dart — Chapter Index

A card-based navigation page using `ListView` and `Navigator.push` to jump among all eight sections.

**Reference:** [https://book.flutterchina.club/chapter4/intro.html](https://book.flutterchina.club/chapter4/intro.html)

---

## 4.1 布局类组件简介

Introduces the three `RenderObjectWidget` base classes that underpin all Flutter layout widgets.

- **LeafRenderObjectWidget** — leaf nodes without children (e.g. `Image`, `Text`)
- **SingleChildRenderObjectWidget** — containers with exactly one child (e.g. `ConstrainedBox`, `DecoratedBox`, `Padding`, `Align`)
- **MultiChildRenderObjectWidget** — containers with a `children` list (e.g. `Row`, `Column`, `Stack`, `Wrap`, `Flex`)

Inheritance chain: **Widget → RenderObjectWidget → (Leaf / SingleChild / MultiChild) RenderObjectWidget**. Each corresponds to a `RenderObject` subclass that implements the actual layout algorithm (e.g. `Row` → `RenderFlex`).

![4.1 运行效果](演示截图/4.1%20布局类组件简介-运行效果.png)

### Key patterns

```dart
// LeafRenderObjectWidget — 无子节点
Image.network(
  'https://picsum.photos/200/100',
  width: 200,
  height: 100,
);

// SingleChildRenderObjectWidget — 单子组件
ConstrainedBox(
  constraints: const BoxConstraints(minWidth: double.infinity, minHeight: 50),
  child: DecoratedBox(
    decoration: BoxDecoration(
      color: Colors.blue.shade100,
      borderRadius: BorderRadius.circular(8),
    ),
    child: const Padding(
      padding: EdgeInsets.all(12.0),
      child: Text('ConstrainedBox + DecoratedBox'),
    ),
  ),
);

// MultiChildRenderObjectWidget — 多子组件
Row(
  children: [
    Container(width: 60, height: 60, color: Colors.red,
      child: const Center(child: Text('1'))),
    const SizedBox(width: 8),
    Container(width: 60, height: 60, color: Colors.green,
      child: const Center(child: Text('2'))),
    const SizedBox(width: 8),
    Container(width: 60, height: 60, color: Colors.blue,
      child: const Center(child: Text('3'))),
  ],
);
```

**Run:** `flutter run lib/section4_1_intro.dart`

---

## 4.2 布局原理与约束

Covers Flutter's constraint system — the core layout rule dictating how parent and child widgets negotiate sizes.

- **BoxConstraints** — a box constraint with `minWidth` / `maxWidth` / `minHeight` / `maxHeight`
- **ConstrainedBox** — imposes additional constraints on its child; multiple nested constraints resolve to their intersection (the strictest)
- **SizedBox** — syntactic sugar for `ConstrainedBox` + `BoxConstraints.tightFor`, forces a fixed size
- **UnconstrainedBox** — removes the parent's constraint, letting the child size itself freely (may overflow)

Flutter layout rule: **constraints go down, sizes go up, the parent decides the position**.

![4.2 运行效果](演示截图/4.2%20布局原理与约束-运行效果.png)

### Key patterns

```dart
// ConstrainedBox — 最小高度50，Container 的 height:5 被覆盖
ConstrainedBox(
  constraints: const BoxConstraints(minHeight: 50.0),
  child: Container(
    height: 5.0,
    child: const DecoratedBox(decoration: BoxDecoration(color: Colors.red)),
  ),
);

// SizedBox — 固定宽高80×80
const SizedBox(
  width: 80.0,
  height: 80.0,
  child: DecoratedBox(decoration: BoxDecoration(color: Colors.red)),
);

// 多重限制 — 父60×60 与 子90×20 取交集 → 最终 90×60
ConstrainedBox(
  constraints: const BoxConstraints(minWidth: 60.0, minHeight: 60.0), // 父
  child: ConstrainedBox(
    constraints: const BoxConstraints(minWidth: 90.0, minHeight: 20.0), // 子
    child: DecoratedBox(decoration: BoxDecoration(color: Colors.red)),
  ),
);

// UnconstrainedBox — 去除父级限制
ConstrainedBox(
  constraints: const BoxConstraints(minWidth: 60.0, minHeight: 100.0), // 父
  child: UnconstrainedBox(
    child: ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 90.0, minHeight: 20.0), // 子
      child: DecoratedBox(decoration: BoxDecoration(color: Colors.red)),
    ),
  ),
);

// AppBar actions 中解除限制
AppBar(
  actions: [
    UnconstrainedBox(
      child: SizedBox(
        width: 20, height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation(Colors.white70),
        ),
      ),
    ),
  ],
);
```

**Run:** `flutter run lib/section4_2_constraints.dart`

---

> All eight sections from Chapter 4 of *Flutter 实战·第二版*. Run `flutter run` at the project root for the unified navigation entry point.