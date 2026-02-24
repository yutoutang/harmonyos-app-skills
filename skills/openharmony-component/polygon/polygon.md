# Polygon HarmonyOS 6.0 开发 Skill

## 概述

Polygon 是一个多边形形状组件,用于绘制闭合的多边形图形。它通过指定一系列顶点坐标来创建自定义的多边形形状。

## 重要说明

- Polygon 绘制的是闭合多边形,起点和终点会自动连接
- 至少需要3个顶点才能构成多边形
- 支持填充颜色、边框、阴影等样式
- 常用于创建三角形、五边形、六边形等自定义形状
- 顶点坐标相对于组件自身的坐标系

## 模块信息

- **组件名称**: Polygon
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **更新日期**: 2026-02-24
- **官方文档**: https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-drawing-components-polygon-0000001478341181-V3

## 一、组件基础

### 1.1 导入方式

```typescript
// Polygon 是 ArkUI 内置组件,无需导入
```

### 1.2 基础用法

```typescript
// 三角形
Polygon()
  .points([[50, 0], [0, 100], [100, 100]])
  .fill('#007DFF')

// 五边形
Polygon()
  .points([[50, 0], [100, 38], [81, 100], [19, 100], [0, 38]])
  .fill('#28A745')
```

## 二、API 参数

### 2.1 构造参数

Polygon 组件无必需的构造参数,通过属性方法设置点集。

### 2.2 属性方法

| 方法 | 参数类型 | 返回值 | 描述 |
|------|----------|--------|------|
| points | Array<[number, number]> | Polygon | 设置多边形顶点坐标数组 |
| fill | ResourceColor \| LinearGradient | Polygon | 设置填充颜色或渐变 |
| stroke | ResourceColor | Polygon | 设置边框颜色 |
| strokeWidth | Length | Polygon | 设置边框宽度 |
| width | Length | Polygon | 设置组件宽度 |
| height | Length | Polygon | 设置组件高度 |

**points 参数说明**:
- 数组中每个元素是一个包含两个数字的元组 [x, y]
- x 和 y 坐标相对于组件自身的左上角 (0, 0)
- 至少需要3个点才能构成多边形

### 2.3 事件回调

Polygon 支持通用事件:
- `onClick`: 点击事件
- `onAppear`: 出现事件
- `onDisappear`: 消失事件

## 三、使用示例

### 3.1 基础三角形

```typescript
@ComponentV2
struct TriangleExample {
  build() {
    Column({ space: 20 }) {
      Text('基础三角形')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        Polygon()
          .width(100)
          .height(100)
          .points([[50, 0], [0, 100], [100, 100]])
          .fill('#007DFF')

        Polygon()
          .width(100)
          .height(100)
          .points([[50, 0], [0, 100], [100, 100]])
          .fill('#28A745')

        Polygon()
          .width(100)
          .height(100)
          .points([[50, 0], [0, 100], [100, 100]])
          .fill('#FFC107')
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.2 等边三角形

```typescript
@ComponentV2
struct EquilateralTriangleExample {
  build() {
    Column({ space: 20 }) {
      Text('等边三角形')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Polygon()
        .width(120)
        .height(104)
        .points([[60, 0], [0, 104], [120, 104]])
        .fill('#007DFF')
        .stroke('#0056B3')
        .strokeWidth(2)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.3 五边形

```typescript
@ComponentV2
struct PentagonExample {
  build() {
    Column({ space: 20 }) {
      Text('五边形')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        // 正五边形
        Polygon()
          .width(100)
          .height(100)
          .points([[50, 0], [100, 38], [81, 100], [19, 100], [0, 38]])
          .fill('#FF6B6B')

        // 填充五边形
        Polygon()
          .width(100)
          .height(100)
          .points([[50, 0], [100, 38], [81, 100], [19, 100], [0, 38]])
          .fill('#4ECDC4')
          .stroke('#2C7A7B')
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

### 3.4 六边形

```typescript
@ComponentV2
struct HexagonExample {
  build() {
    Column({ space: 20 }) {
      Text('六边形')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        // 正六边形
        Polygon()
          .width(100)
          .height(100)
          .points([[50, 0], [100, 25], [100, 75], [50, 100], [0, 75], [0, 25]])
          .fill('#95E1D3')

        // 描边六边形
        Polygon()
          .width(100)
          .height(100)
          .points([[50, 0], [100, 25], [100, 75], [50, 100], [0, 75], [0, 25]])
          .fill('#FCE38A')
          .stroke('#F38181')
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

### 3.5 星形

```typescript
@ComponentV2
struct StarExample {
  build() {
    Column({ space: 20 }) {
      Text('星形')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        // 五角星
        Polygon()
          .width(100)
          .height(100)
          .points([
            [50, 0], [61, 38], [100, 38], [68, 59],
            [79, 100], [50, 75], [21, 100], [32, 59],
            [0, 38], [39, 38]
          ])
          .fill('#FFD93D')

        // 渐变星形
        Polygon()
          .width(100)
          .height(100)
          .points([
            [50, 0], [61, 38], [100, 38], [68, 59],
            [79, 100], [50, 75], [21, 100], [32, 59],
            [0, 38], [39, 38]
          ])
          .fill(new LinearGradient({
            angle: 135,
            colors: [['#FF6B6B', 0.0], ['#FFD93D', 1.0]]
          }))
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.6 菱形

```typescript
@ComponentV2
struct DiamondExample {
  build() {
    Column({ space: 20 }) {
      Text('菱形')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        Polygon()
          .width(80)
          .height(80)
          .points([[40, 0], [80, 40], [40, 80], [0, 40]])
          .fill('#A8E6CF')

        Polygon()
          .width(80)
          .height(80)
          .points([[40, 0], [80, 40], [40, 80], [0, 40]])
          .fill('#FFD3B6')
          .stroke('#FFAAA5')
          .strokeWidth(2)

        Polygon()
          .width(80)
          .height(80)
          .points([[40, 0], [80, 40], [40, 80], [0, 40]])
          .fill(new LinearGradient({
            angle: 45,
            colors: [['#667EEA', 0.0], ['#764BA2', 1.0]]
          }))
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.7 箭头

```typescript
@ComponentV2
struct ArrowExample {
  build() {
    Column({ space: 20 }) {
      Text('箭头')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        // 向上箭头
        Polygon()
          .width(60)
          .height(60)
          .points([[30, 0], [60, 40], [45, 40], [45, 60], [15, 60], [15, 40], [0, 40]])
          .fill('#007DFF')

        // 向右箭头
        Polygon()
          .width(60)
          .height(60)
          .points([[0, 15], [40, 15], [40, 0], [60, 30], [40, 60], [40, 45], [0, 45]])
          .fill('#28A745')

        // 向下箭头
        Polygon()
          .width(60)
          .height(60)
          .points([[15, 0], [45, 0], [45, 20], [60, 20], [30, 60], [0, 20], [15, 20]])
          .fill('#FFC107')
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.8 自定义多边形

```typescript
@ComponentV2
struct CustomPolygonExample {
  build() {
    Column({ space: 20 }) {
      Text('自定义多边形')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        // 梯形
        Polygon()
          .width(100)
          .height(80)
          .points([[20, 0], [80, 0], [100, 80], [0, 80]])
          .fill('#6C5CE7')

        // 八边形
        Polygon()
          .width(100)
          .height(100)
          .points([
            [30, 0], [70, 0], [100, 30], [100, 70],
            [70, 100], [30, 100], [0, 70], [0, 30]
          ])
          .fill('#00B894')
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(16)
  }
}
```

## 四、最佳实践

### 4.1 使用场景

1. **图标**: 创建自定义形状图标
2. **装饰**: 页面装饰性元素
3. **指示器**: 方向指示箭头
4. **图形**: 数据可视化中的自定义图形

### 4.2 设计建议

1. **坐标计算**: 使用图形工具或计算器获取精确坐标
2. **尺寸比例**: 保持多边形在容器中的适当比例
3. **颜色选择**: 遵循品牌色和设计规范
4. **对称性**: 正多边形的顶点应该对称分布

### 4.3 性能优化

- Polygon 是轻量级组件,性能开销小
- 避免创建顶点过多(>20个)的多边形
- 大量使用时考虑复用组件

### 4.4 坐标计算技巧

计算正多边形顶点公式:
```typescript
// 计算正 n 边形的顶点
function calculateRegularPolygon(n: number, radius: number, centerX: number, centerY: number): Array<[number, number]> {
  const points: Array<[number, number]> = []
  const angleStep = (2 * Math.PI) / n

  for (let i = 0; i < n; i++) {
    const angle = i * angleStep - Math.PI / 2 // 从顶部开始
    const x = centerX + radius * Math.cos(angle)
    const y = centerY + radius * Math.sin(angle)
    points.push([x, y])
  }

  return points
}
```

## 五、常见问题

### Q1: 如何绘制空心多边形?

A: 只设置 stroke,不设置 fill:

```typescript
Polygon()
  .points([[50, 0], [0, 100], [100, 100]])
  .stroke('#007DFF')
  .strokeWidth(3)
```

### Q2: Polygon 和 Path 有什么区别?

A:
- Polygon 专门用于绘制多边形,自动闭合路径
- Path 可以绘制任意路径,包括曲线、不闭合路径等
- Polygon 使用更简单,Path 功能更强大

### Q3: 如何创建动态多边形?

A: 使用状态变量存储点集:

```typescript
@ComponentV2
struct DynamicPolygonExample {
  @Local points: Array<[number, number]> = [[50, 0], [0, 100], [100, 100]]

  build() {
    Polygon()
      .points(this.points)
      .fill('#007DFF')
  }
}
```

### Q4: 如何计算多边形中心点?

A: 取所有顶点坐标的平均值:

```typescript
function calculateCenter(points: Array<[number, number]>): [number, number] {
  const sumX = points.reduce((sum, p) => sum + p[0], 0)
  const sumY = points.reduce((sum, p) => sum + p[1], 0)
  return [sumX / points.length, sumY / points.length]
}
```

## 六、参考资源

- [HarmonyOS Polygon 官方文档](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-drawing-components-polygon-0000001478341181-V3)
- [Path 组件文档](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-drawing-components-path-0000001478341181-V3)
