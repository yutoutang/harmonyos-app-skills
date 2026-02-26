# Line HarmonyOS 6.0 开发 Skill

## 概述

Line 是一个线条组件,用于绘制直线。与 Divider 不同,Line 可以绘制任意方向和角度的直线,并提供了更灵活的配置选项。

## 重要说明

- Line 绘制的是从起点到终点的直线
- 必须指定起点 (x1, y1) 和终点 (x2, y2)
- 支持设置线条宽度、颜色、样式
- 可以创建虚线、点线等效果

## 模块信息

- **组件名称**: Line
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **更新日期**: 2026-02-24
- **官方文档**: https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-drawing-components-line-0000001478341181-V3

## 一、组件基础

### 1.1 导入方式

```typescript
// Line 是 ArkUI 内置组件,无需导入
```

### 1.2 基础用法

```typescript
// 水平线
Line({ x1: 0, y1: 0, x2: 200, y2: 0 })
  .stroke('#007DFF')
  .strokeWidth(2)

// 垂直线
Line({ x1: 0, y1: 0, x2: 0, y2: 200 })
  .stroke('#28A745')
  .strokeWidth(2)

// 对角线
Line({ x1: 0, y1: 0, x2: 200, y2: 200 })
  .stroke('#FFC107')
  .strokeWidth(2)
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| x1 | number | 是 | - | 起点 x 坐标 |
| y1 | number | 是 | - | 起点 y 坐标 |
| x2 | number | 是 | - | 终点 x 坐标 |
| y2 | number | 是 | - | 终点 y 坐标 |

### 2.2 属性方法

| 方法 | 参数类型 | 返回值 | 描述 |
|------|----------|--------|------|
| stroke | ResourceColor | Line | 设置线条颜色 |
| strokeWidth | Length | Line | 设置线条宽度 |
| strokeDashArray | number[] | Line | 设置虚线模式 [实线长度, 空白长度] |
| strokeDashOffset | number | Line | 设置虚线偏移量 |
| strokeOpacity | number | Line | 设置线条透明度 (0-1) |

### 2.3 事件回调

Line 支持通用事件:
- `onClick`: 点击事件
- `onAppear`: 出现事件
- `onDisappear`: 消失事件

## 三、使用示例

### 3.1 基础线条

```typescript
@ComponentV2
struct BasicLineExample {
  build() {
    Column({ space: 30 }) {
      Text('基础线条示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      // 水平线
      Line({ x1: 0, y1: 0, x2: 300, y2: 0 })
        .stroke('#007DFF')
        .strokeWidth(3)

      // 垂直线
      Line({ x1: 150, y1: 0, x2: 150, y2: 100 })
        .stroke('#28A745')
        .strokeWidth(3)

      // 对角线
      Line({ x1: 0, y1: 0, x2: 300, y2: 100 })
        .stroke('#FFC107')
        .strokeWidth(3)
    }
    .width('100%')
    .padding(20)
  }
}
```

### 3.2 不同宽度的线条

```typescript
@ComponentV2
struct LineWidthExample {
  build() {
    Column({ space: 25 }) {
      Text('不同宽度的线条')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Line({ x1: 0, y1: 0, x2: 300, y2: 0 })
        .stroke('#007DFF')
        .strokeWidth(1)

      Line({ x1: 0, y1: 0, x2: 300, y2: 0 })
        .stroke('#007DFF')
        .strokeWidth(3)

      Line({ x1: 0, y1: 0, x2: 300, y2: 0 })
        .stroke('#007DFF')
        .strokeWidth(6)

      Line({ x1: 0, y1: 0, x2: 300, y2: 0 })
        .stroke('#007DFF')
        .strokeWidth(10)
    }
    .width('100%')
    .padding(20)
  }
}
```

### 3.3 虚线效果

```typescript
@ComponentV2
struct DashedLineExample {
  build() {
    Column({ space: 25 }) {
      Text('虚线效果')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      // 短虚线
      Line({ x1: 0, y1: 0, x2: 300, y2: 0 })
        .stroke('#007DFF')
        .strokeWidth(2)
        .strokeDashArray([5, 5])

      // 长虚线
      Line({ x1: 0, y1: 0, x2: 300, y2: 0 })
        .stroke('#28A745')
        .strokeWidth(2)
        .strokeDashArray([15, 10])

      // 点线
      Line({ x1: 0, y1: 0, x2: 300, y2: 0 })
        .stroke('#FFC107')
        .strokeWidth(2)
        .strokeDashArray([2, 8])

      // 点划线
      Line({ x1: 0, y1: 0, x2: 300, y2: 0 })
        .stroke('#F44336')
        .strokeWidth(2)
        .strokeDashArray([15, 5, 3, 5])
    }
    .width('100%')
    .padding(20)
  }
}
```

### 3.4 透明度线条

```typescript
@ComponentV2
struct LineOpacityExample {
  build() {
    Column({ space: 25 }) {
      Text('透明度线条')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Line({ x1: 0, y1: 0, x2: 300, y2: 0 })
        .stroke('#007DFF')
        .strokeWidth(4)
        .strokeOpacity(1.0)

      Line({ x1: 0, y1: 0, x2: 300, y2: 0 })
        .stroke('#007DFF')
        .strokeWidth(4)
        .strokeOpacity(0.75)

      Line({ x1: 0, y1: 0, x2: 300, y2: 0 })
        .stroke('#007DFF')
        .strokeWidth(4)
        .strokeOpacity(0.5)

      Line({ x1: 0, y1: 0, x2: 300, y2: 0 })
        .stroke('#007DFF')
        .strokeWidth(4)
        .strokeOpacity(0.25)
    }
    .width('100%')
    .padding(20)
  }
}
```

### 3.5 角度线条

```typescript
@ComponentV2
struct AngledLineExample {
  build() {
    Stack() {
      Text('角度线条示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20 })

      // 45度线
      Line({ x1: 50, y1: 150, x2: 250, y2: 50 })
        .stroke('#007DFF')
        .strokeWidth(3)

      // -45度线
      Line({ x1: 50, y1: 50, x2: 250, y2: 150 })
        .stroke('#28A745')
        .strokeWidth(3)

      // 水平线
      Line({ x1: 50, y1: 100, x2: 250, y2: 100 })
        .stroke('#FFC107')
        .strokeWidth(3)
    }
    .width('100%')
    .height(200)
  }
}
```

### 3.6 图表轴

```typescript
@ComponentV2
struct ChartAxisExample {
  build() {
    Column({ space: 20 }) {
      Text('图表轴示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Stack() {
        // X轴
        Line({ x1: 40, y1: 160, x2: 300, y2: 160 })
          .stroke('#333333')
          .strokeWidth(2)

        // Y轴
        Line({ x1: 40, y1: 20, x2: 40, y2: 160 })
          .stroke('#333333')
          .strokeWidth(2)

        // 网格线(水平)
        Line({ x1: 40, y1: 120, x2: 300, y2: 120 })
          .stroke('#E0E0E0')
          .strokeWidth(1)
          .strokeDashArray([5, 5])

        Line({ x1: 40, y1: 80, x2: 300, y2: 80 })
          .stroke('#E0E0E0')
          .strokeWidth(1)
          .strokeDashArray([5, 5])

        Line({ x1: 40, y1: 40, x2: 300, y2: 40 })
          .stroke('#E0E0E0')
          .strokeWidth(1)
          .strokeDashArray([5, 5])
      }
      .width(320)
      .height(180)
    }
    .width('100%')
    .padding(20)
  }
}
```

### 3.7 箭头线

```typescript
@ComponentV2
struct ArrowLineExample {
  build() {
    Stack() {
      // 主线
      Line({ x1: 50, y1: 150, x2: 250, y2: 50 })
        .stroke('#007DFF')
        .strokeWidth(3)

      // 箭头(用两条短线模拟)
      Line({ x1: 250, y1: 50, x2: 235, y2: 65 })
        .stroke('#007DFF')
        .strokeWidth(3)

      Line({ x1: 250, y1: 50, x2: 235, y2: 35 })
        .stroke('#007DFF')
        .strokeWidth(3)

      Text('箭头线')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .position({ x: 120, y: 180 })
    }
    .width('100%')
    .height(220)
  }
}
```

## 四、最佳实践

### 4.1 使用场景

1. **图表轴**: 绘制坐标轴、网格线
2. **装饰线**: 装饰性线条、分隔线
3. **图形绘制**: 绘制几何图形
4. **箭头指示**: 方向指示线

### 4.2 设计建议

1. **线条宽度**: 常用 1-4px
2. **颜色选择**: 使用灰色表示辅助线,主色表示主要线条
3. **虚线模式**: 保持虚线模式的一致性
4. **坐标系统**: 注意坐标原点在左上角

### 4.3 Line vs Divider

| 特性 | Line | Divider |
|------|------|---------|
| 方向 | 任意角度 | 仅水平/垂直 |
| 配置 | 需要指定坐标 | 自动填充空间 |
| 使用场景 | 图表、绘图 | 内容分隔 |

## 五、常见问题

### Q1: 如何创建带箭头的线?

A: 在终点添加两条短线作为箭头:

```typescript
Stack() {
  // 主线
  Line({ x1: 0, y1: 0, x2: 200, y2: 0 })
    .stroke('#007DFF')
    .strokeWidth(2)

  // 箭头
  Line({ x1: 200, y1: 0, x2: 190, y2: -8 })
    .stroke('#007DFF')
    .strokeWidth(2)

  Line({ x1: 200, y1: 0, x2: 190, y2: 8 })
    .stroke('#007DFF')
    .strokeWidth(2)
}
```

### Q2: 如何创建带动画的虚线?

A: 使用 animateTo 改变 strokeDashOffset:

```typescript
@Local dashOffset: number = 0

Line({ x1: 0, y1: 0, x2: 300, y2: 0 })
  .stroke('#007DFF')
  .strokeWidth(3)
  .strokeDashArray([15, 10])
  .strokeDashOffset(this.dashOffset)
  .onClick(() => {
    animateTo({ duration: 1000, iterations: -1 }, () => {
      this.dashOffset = 50
    })
  })
```

### Q3: Line 和 Divider 如何选择?

A:
- 需要内容分隔 → 使用 Divider
- 需要图表、绘图 → 使用 Line

### Q4: 如何绘制平滑曲线?

A: Line 只能绘制直线。如需曲线,使用 Path 或 PolyBezier 组件。

## 六、参考资源

- [HarmonyOS Line 官方文档](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-drawing-components-line-0000001478341181-V3)
- [Path 组件](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-drawing-components-path-0000001478341181-V3)
- [Divider 组件](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-basic-components-divider-0000001427744872-V3)
