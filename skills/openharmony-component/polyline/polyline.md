# Polyline HarmonyOS 6.0 开发 Skill

## 概述

Polyline 是一个折线组件,用于绘制连接多个点的折线段。与 Polygon 不同,Polyline 不会自动闭合路径,起点和终点保持开放状态。

## 重要说明

- Polyline 绘制的是非闭合折线,起点和终点不会自动连接
- 至少需要2个点才能构成折线
- 主要用于绘制图表、波形图、路径轨迹等
- 支持自定义线条样式、颜色、宽度等
- 常用于数据可视化、图表绘制、路线指示等场景

## 模块信息

- **组件名称**: Polyline
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **更新日期**: 2026-02-24
- **官方文档**: https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-drawing-components-polyline-0000001478341181-V3

## 一、组件基础

### 1.1 导入方式

```typescript
// Polyline 是 ArkUI 内置组件,无需导入
```

### 1.2 基础用法

```typescript
// 简单折线
Polyline()
  .width(200)
  .height(100)
  .points([[0, 50], [50, 20], [100, 80], [150, 30], [200, 60]])
  .stroke('#007DFF')
  .strokeWidth(2)
```

## 二、API 参数

### 2.1 构造参数

Polyline 组件无必需的构造参数,通过属性方法设置点集和样式。

### 2.2 属性方法

| 方法 | 参数类型 | 返回值 | 描述 |
|------|----------|--------|------|
| points | Array<[number, number]> | Polyline | 设置折线顶点坐标数组 |
| stroke | ResourceColor | Polyline | 设置线条颜色 |
| strokeWidth | Length | Polyline | 设置线条宽度 |
| width | Length | Polyline | 设置组件宽度 |
| height | Length | Polyline | 设置组件高度 |

**points 参数说明**:
- 数组中每个元素是一个包含两个数字的元组 [x, y]
- x 和 y 坐标相对于组件自身的左上角 (0, 0)
- 至少需要2个点才能构成折线
- 点按顺序连接形成折线

### 2.3 事件回调

Polyline 支持通用事件:
- `onClick`: 点击事件
- `onAppear`: 出现事件
- `onDisappear`: 消失事件

## 三、使用示例

### 3.1 基础折线

```typescript
@ComponentV2
struct BasicPolylineExample {
  build() {
    Column({ space: 20 }) {
      Text('基础折线')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        Polyline()
          .width(150)
          .height(100)
          .points([[0, 50], [40, 20], [80, 80], [120, 30], [150, 60]])
          .stroke('#007DFF')
          .strokeWidth(3)

        Polyline()
          .width(150)
          .height(100)
          .points([[0, 30], [40, 70], [80, 20], [120, 80], [150, 40]])
          .stroke('#28A745')
          .strokeWidth(3)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.2 锯齿波

```typescript
@ComponentV2
struct ZigzagPolylineExample {
  build() {
    Column({ space: 20 }) {
      Text('锯齿波')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        // 简单锯齿
        Polyline()
          .width(150)
          .height(80)
          .points([[0, 40], [30, 10], [60, 70], [90, 10], [120, 70], [150, 40]])
          .stroke('#FF6B6B')
          .strokeWidth(3)

        // 密集锯齿
        Polyline()
          .width(150)
          .height(80)
          .points([
            [0, 40], [20, 10], [40, 70], [60, 10],
            [80, 70], [100, 10], [120, 70], [150, 40]
          ])
          .stroke('#4ECDC4')
          .strokeWidth(2)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.3 折线图

```typescript
@ComponentV2
struct LineChartExample {
  build() {
    Column({ space: 20 }) {
      Text('折线图')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      // 图表容器
      Stack({ alignContent: Alignment.BottomStart }) {
        // 网格线
        Column() {
          ForEach([0, 1, 2, 3, 4], (index: number) => {
            Divider()
              .color('#E0E0E0')
              .strokeWidth(1)
          })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        // 折线
        Polyline()
          .width('100%')
          .height(150)
          .points([
            [0, 120], [60, 80], [120, 100], [180, 40],
            [240, 60], [300, 20], [360, 80]
          ])
          .stroke('#007DFF')
          .strokeWidth(3)

        // 数据点
        Row({ space: 60 }) {
          ForEach([0, 1, 2, 3, 4, 5, 6], (index: number) => {
            Circle({ width: 8, height: 8 })
              .fill('#FFFFFF')
              .stroke('#007DFF')
              .strokeWidth(2)
          })
        }
        .width(360)
        .margin({ bottom: 80, left: 0 })
      }
      .width('100%')
      .height(150)
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.4 心电图

```typescript
@ComponentV2
struct ECGPolylineExample {
  build() {
    Column({ space: 20 }) {
      Text('心电图')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Stack({ alignContent: Alignment.Center }) {
        // 背景网格
        Column() {
          ForEach([0, 1, 2, 3, 4], (index: number) => {
            Divider()
              .color('#E0E0E0')
              .strokeWidth(1)
          })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        // 心电图波形
        Polyline()
          .width(350)
          .height(100)
          .points([
            [0, 50], [30, 50], [40, 20], [50, 80], [60, 30],
            [70, 50], [100, 50], [110, 20], [120, 80], [130, 30],
            [140, 50], [170, 50], [180, 20], [190, 80], [200, 30],
            [210, 50], [240, 50], [250, 20], [260, 80], [270, 30],
            [280, 50], [310, 50], [320, 20], [330, 80], [340, 30], [350, 50]
          ])
          .stroke('#FF6B6B')
          .strokeWidth(2)
      }
      .width('100%')
      .height(100)
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.5 阶梯图

```typescript
@ComponentV2
struct StepChartExample {
  build() {
    Column({ space: 20 }) {
      Text('阶梯图')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        // 上升阶梯
        Polyline()
          .width(120)
          .height(120)
          .points([
            [0, 120], [40, 120], [40, 80], [80, 80],
            [80, 40], [120, 40]
          ])
          .stroke('#007DFF')
          .strokeWidth(3)

        // 下降阶梯
        Polyline()
          .width(120)
          .height(120)
          .points([
            [0, 40], [40, 40], [40, 80], [80, 80],
            [80, 120], [120, 120]
          ])
          .stroke('#28A745')
          .strokeWidth(3)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.6 多条折线对比

```typescript
@ComponentV2
struct MultiLineChartExample {
  build() {
    Column({ space: 20 }) {
      Text('多条折线对比')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Stack({ alignContent: Alignment.BottomStart }) {
        // 背景网格
        Column() {
          ForEach([0, 1, 2, 3, 4], (index: number) => {
            Divider()
              .color('#E0E0E0')
              .strokeWidth(1)
          })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        // 第一条线
        Polyline()
          .width('100%')
          .height(150)
          .points([[0, 100], [80, 60], [160, 120], [240, 40], [320, 80]])
          .stroke('#007DFF')
          .strokeWidth(3)

        // 第二条线
        Polyline()
          .width('100%')
          .height(150)
          .points([[0, 80], [80, 120], [160, 60], [240, 100], [320, 40]])
          .stroke('#FF6B6B')
          .strokeWidth(3)
      }
      .width('100%')
      .height(150)
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      // 图例
      Row({ space: 20 }) {
        Row({ space: 8 }) {
          Rect()
            .width(20)
            .height(3)
            .fill('#007DFF')
          Text('数据 A')
            .fontSize(12)
        }

        Row({ space: 8 }) {
          Rect()
            .width(20)
            .height(3)
            .fill('#FF6B6B')
          Text('数据 B')
            .fontSize(12)
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.7 趋势线

```typescript
@ComponentV2
struct TrendLineExample {
  build() {
    Column({ space: 20 }) {
      Text('趋势线')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Column({ space: 16 }) {
        // 上升趋势
        Column({ space: 8 }) {
          Text('上升趋势')
            .fontSize(14)
            .fontColor('#666666')
          Polyline()
            .width(200)
            .height(80)
            .points([[0, 70], [50, 50], [100, 40], [150, 20], [200, 10]])
            .stroke('#28A745')
            .strokeWidth(3)
        }

        // 下降趋势
        Column({ space: 8 }) {
          Text('下降趋势')
            .fontSize(14)
            .fontColor('#666666')
          Polyline()
            .width(200)
            .height(80)
            .points([[0, 10], [50, 30], [100, 50], [150, 60], [200, 70]])
            .stroke('#FF6B6B')
            .strokeWidth(3)
        }

        // 波动趋势
        Column({ space: 8 }) {
          Text('波动趋势')
            .fontSize(14)
            .fontColor('#666666')
          Polyline()
            .width(200)
            .height(80)
            .points([[0, 40], [40, 20], [80, 60], [120, 30], [160, 70], [200, 40]])
            .stroke('#FFC107')
            .strokeWidth(3)
        }
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.8 路径轨迹

```typescript
@ComponentV2
struct PathTraceExample {
  build() {
    Column({ space: 20 }) {
      Text('路径轨迹')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Stack() {
        // 轨迹线
        Polyline()
          .width(300)
          .height(200)
          .points([
            [20, 180], [80, 120], [140, 160], [200, 80],
            [260, 120], [280, 40]
          ])
          .stroke('#007DFF')
          .strokeWidth(3)
          .strokeDasharray([5, 5])

        // 路径点
        ForEach([
          [20, 180], [80, 120], [140, 160], [200, 80], [260, 120], [280, 40]
        ], (point: number[]) => {
          Circle({ width: 12, height: 12 })
            .fill('#FFFFFF')
            .stroke('#007DFF')
            .strokeWidth(2)
            .position({ x: point[0] - 6, y: point[1] - 6 })
        })

        // 起点标记
        Text('起点')
          .fontSize(12)
          .fontColor('#28A745')
          .position({ x: 20, y: 195 })

        // 终点标记
        Text('终点')
          .fontSize(12)
          .fontColor('#FF6B6B')
          .position({ x: 260, y: 25 })
      }
      .width(300)
      .height(200)
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)
    }
    .width('100%')
    .padding(16)
  }
}
```

## 四、最佳实践

### 4.1 使用场景

1. **数据可视化**: 折线图、趋势图、图表
2. **波形显示**: 心电图、音频波形、信号波形
3. **路径指示**: 路线轨迹、导航路径
4. **装饰线条**: 锯齿装饰、分割线

### 4.2 设计建议

1. **线条宽度**: 根据使用场景选择合适的线条宽度
   - 细线 (1-2px): 适合密集数据展示
   - 中线 (2-4px): 适合一般图表
   - 粗线 (4-6px): 适合强调重点

2. **颜色选择**:
   - 使用对比色区分多条线
   - 遵循品牌色和设计规范
   - 考虑色盲友好配色

3. **数据密度**:
   - 避免在一个图表中显示过多数据点
   - 合理设置点间距,避免过于密集

### 4.3 性能优化

- Polyline 性能开销小,适合大量使用
- 避免创建点数过多(>100个)的折线
- 动态更新数据时使用状态变量

### 4.4 与图表库对比

**使用 Polyline 的场景**:
- 简单的折线图
- 自定义波形显示
- 轻量级数据可视化

**使用专业图表库的场景**:
- 复杂的交互式图表
- 需要缩放、平移等功能
- 需要丰富的图表类型

## 五、常见问题

### Q1: 如何绘制虚线?

A: 使用 strokeDasharray 属性:

```typescript
Polyline()
  .points([[0, 50], [50, 20], [100, 80]])
  .stroke('#007DFF')
  .strokeWidth(3)
  .strokeDasharray([5, 5]) // 5px实线,5px空白
```

### Q2: Polyline 和 Polygon 有什么区别?

A:
- Polyline: 不闭合的折线,起点和终点不连接
- Polygon: 自动闭合的多边形,起点和终点会连接

### Q3: 如何创建动态折线?

A: 使用状态变量存储点集:

```typescript
@ComponentV2
struct DynamicPolylineExample {
  @Local points: Array<[number, number]> = [[0, 50], [50, 20], [100, 80]]

  build() {
    Polyline()
      .width(100)
      .height(100)
      .points(this.points)
      .stroke('#007DFF')
      .strokeWidth(3)
  }
}
```

### Q4: 如何在折线上添加数据点标记?

A: 使用 Stack 或 AbsoluteLayout 布局:

```typescript
Stack() {
  Polyline()
    .width(300)
    .height(150)
    .points([[0, 100], [100, 50], [200, 120], [300, 80]])
    .stroke('#007DFF')
    .strokeWidth(3)

  ForEach([[0, 100], [100, 50], [200, 120], [300, 80]], (point: number[]) => {
    Circle({ width: 8, height: 8 })
      .fill('#FFFFFF')
      .stroke('#007DFF')
      .strokeWidth(2)
      .position({ x: point[0] - 4, y: point[1] - 4 })
  })
}
```

## 六、参考资源

- [HarmonyOS Polyline 官方文档](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-drawing-components-polyline-0000001478341181-V3)
- [Path 组件文档](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-drawing-components-path-0000001478341181-V3)
