# Path HarmonyOS 6.0 开发 Skill

## 概述

Path 是一个路径组件,用于绘制自定义的复杂图形路径。它提供了最灵活的绘图能力,支持直线、曲线、弧线等多种路径命令,可以创建任意复杂的形状。

## 重要说明

- Path 是最强大的绘图组件,支持复杂的路径命令
- 使用 SVG 路径命令语法 (M, L, H, V, C, S, Q, T, A, Z)
- 可以绘制开放路径或闭合路径
- 支持填充、描边、渐变等丰富样式
- 常用于自定义图标、复杂图形、动画路径等场景

## 模块信息

- **组件名称**: Path
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **更新日期**: 2026-02-24
- **官方文档**: https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-drawing-components-path-0000001478341181-V3

## 一、组件基础

### 1.1 导入方式

```typescript
// Path 是 ArkUI 内置组件,无需导入
```

### 1.2 基础用法

```typescript
// 简单路径
Path()
  .width(100)
  .height(100)
  .commands('M 10 10 L 90 10 L 90 90 L 10 90 Z')
  .fill('#007DFF')

// 曲线路径
Path()
  .width(100)
  .height(100)
  .commands('M 10 50 Q 50 10 90 50 T 170 50')
  .stroke('#28A745')
  .strokeWidth(3)
```

## 二、API 参数

### 2.1 构造参数

Path 组件无必需的构造参数,通过属性方法设置路径命令。

### 2.2 属性方法

| 方法 | 参数类型 | 返回值 | 描述 |
|------|----------|--------|------|
| commands | string | Path | 设置 SVG 路径命令字符串 |
| fill | ResourceColor \| LinearGradient | Path | 设置填充颜色或渐变 |
| stroke | ResourceColor | Path | 设置描边颜色 |
| strokeWidth | Length | Path | 设置描边宽度 |
| width | Length | Path | 设置组件宽度 |
| height | Length | Path | 设置组件高度 |

### 2.3 路径命令

| 命令 | 名称 | 参数 | 描述 |
|------|------|------|------|
| M | MoveTo | x y | 移动画笔到指定点 |
| L | LineTo | x y | 画直线到指定点 |
| H | HorizontalLineTo | x | 画水平线到指定 x 坐标 |
| V | VerticalLineTo | y | 画垂直线到指定 y 坐标 |
| C | CubicBezier | c1x c1y c2x c2y x y | 三次贝塞尔曲线 |
| S | SmoothCubicBezier | c2x c2y x y | 平滑三次贝塞尔曲线 |
| Q | QuadraticBezier | cx cy x y | 二次贝塞尔曲线 |
| T | SmoothQuadraticBezier | x y | 平滑二次贝塞尔曲线 |
| A | Arc | rx ry rotation large-arc sweep x y | 椭圆弧 |
| Z | ClosePath | - | 闭合路径 |

**命令大小写区别**:
- 大写字母: 绝对坐标
- 小写字母: 相对坐标

### 2.4 事件回调

Path 支持通用事件:
- `onClick`: 点击事件
- `onAppear`: 出现事件
- `onDisappear`: 消失事件

## 三、使用示例

### 3.1 基础路径

```typescript
@ComponentV2
struct BasicPathExample {
  build() {
    Column({ space: 20 }) {
      Text('基础路径')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        // 矩形路径
        Path()
          .width(80)
          .height(80)
          .commands('M 10 10 L 70 10 L 70 70 L 10 70 Z')
          .fill('#007DFF')

        // 三角形路径
        Path()
          .width(80)
          .height(80)
          .commands('M 40 10 L 70 70 L 10 70 Z')
          .fill('#28A745')

        // 菱形路径
        Path()
          .width(80)
          .height(80)
          .commands('M 40 5 L 75 40 L 40 75 L 5 40 Z')
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

### 3.2 二次贝塞尔曲线

```typescript
@ComponentV2
struct QuadraticCurveExample {
  build() {
    Column({ space: 20 }) {
      Text('二次贝塞尔曲线')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Column({ space: 16 }) {
        // 简单曲线
        Path()
          .width(200)
          .height(80)
          .commands('M 10 70 Q 100 10 190 70')
          .stroke('#007DFF')
          .strokeWidth(3)
          .fill('transparent')

        // 波浪线
        Path()
          .width(200)
          .height(80)
          .commands('M 10 40 Q 50 10 90 40 T 170 40')
          .stroke('#28A745')
          .strokeWidth(3)
          .fill('transparent')

        // 多段曲线
        Path()
          .width(200)
          .height(80)
          .commands('M 10 60 Q 50 10 90 60 T 170 60')
          .stroke('#FF6B6B')
          .strokeWidth(3)
          .fill('transparent')
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

### 3.3 三次贝塞尔曲线

```typescript
@ComponentV2
struct CubicCurveExample {
  build() {
    Column({ space: 20 }) {
      Text('三次贝塞尔曲线')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Column({ space: 16 }) {
        // S 形曲线
        Path()
          .width(200)
          .height(100)
          .commands('M 10 80 C 50 10 150 10 190 80')
          .stroke('#007DFF')
          .strokeWidth(3)
          .fill('transparent')

        // 平滑曲线
        Path()
          .width(200)
          .height(100)
          .commands('M 10 50 C 60 10 140 90 190 50')
          .stroke('#9B59B6')
          .strokeWidth(3)
          .fill('transparent')

        // 多段三次曲线
        Path()
          .width(200)
          .height(100)
          .commands('M 10 80 C 50 10 90 10 130 50 S 190 90 190 20')
          .stroke('#E74C3C')
          .strokeWidth(3)
          .fill('transparent')
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

### 3.4 弧线

```typescript
@ComponentV2
struct ArcPathExample {
  build() {
    Column({ space: 20 }) {
      Text('弧线路径')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        // 开口圆
        Path()
          .width(80)
          .height(80)
          .commands('M 10 40 A 30 30 0 1 1 70 40')
          .stroke('#007DFF')
          .strokeWidth(3)
          .fill('transparent')

        // 半圆
        Path()
          .width(80)
          .height(80)
          .commands('M 10 40 A 30 30 0 0 1 70 40')
          .stroke('#28A745')
          .strokeWidth(3)
          .fill('transparent')

        // 闭合弧形
        Path()
          .width(80)
          .height(80)
          .commands('M 10 40 A 30 30 0 1 1 70 40 Z')
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

### 3.5 心形

```typescript
@ComponentV2
struct HeartPathExample {
  build() {
    Column({ space: 20 }) {
      Text('心形')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        Path()
          .width(100)
          .height(100)
          .commands(`
            M 50 90
            C 20 60 0 30 25 15
            C 40 5 50 25 50 25
            C 50 25 60 5 75 15
            C 100 30 80 60 50 90
            Z
          `)
          .fill('#FF6B6B')

        Path()
          .width(100)
          .height(100)
          .commands(`
            M 50 90
            C 20 60 0 30 25 15
            C 40 5 50 25 50 25
            C 50 25 60 5 75 15
            C 100 30 80 60 50 90
            Z
          `)
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

### 3.6 箭头图标

```typescript
@ComponentV2
struct ArrowPathExample {
  build() {
    Column({ space: 20 }) {
      Text('箭头图标')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        // 向上箭头
        Path()
          .width(60)
          .height(60)
          .commands('M 30 5 L 5 30 L 20 30 L 20 55 L 40 55 L 40 30 L 55 30 Z')
          .fill('#007DFF')

        // 向右箭头
        Path()
          .width(60)
          .height(60)
          .commands('M 55 30 L 30 5 L 30 20 L 5 20 L 5 40 L 30 40 L 30 55 Z')
          .fill('#28A745')

        // 向下箭头
        Path()
          .width(60)
          .height(60)
          .commands('M 30 55 L 55 30 L 40 30 L 40 5 L 20 5 L 20 30 L 5 30 Z')
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

### 3.7 云朵形状

```typescript
@ComponentV2
struct CloudPathExample {
  build() {
    Column({ space: 20 }) {
      Text('云朵形状')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        Path()
          .width(120)
          .height(80)
          .commands(`
            M 20 60
            A 15 15 0 0 1 35 45
            A 20 20 0 0 1 75 45
            A 15 15 0 0 1 90 60
            L 90 70
            L 20 70
            Z
          `)
          .fill('#E3F2FD')
          .stroke('#007DFF')
          .strokeWidth(2)

        Path()
          .width(120)
          .height(80)
          .commands(`
            M 20 60
            A 15 15 0 0 1 35 45
            A 20 20 0 0 1 75 45
            A 15 15 0 0 1 90 60
            L 90 70
            L 20 70
            Z
          `)
          .fill('#FFFFFF')
          .stroke('#90CAF9')
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

### 3.8 星形

```typescript
@ComponentV2
struct StarPathExample {
  build() {
    Column({ space: 20 }) {
      Text('星形路径')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        // 五角星
        Path()
          .width(100)
          .height(100)
          .commands(`
            M 50 5
            L 61 38
            L 98 38
            L 68 59
            L 79 91
            L 50 70
            L 21 91
            L 32 59
            L 2 38
            L 39 38
            Z
          `)
          .fill('#FFD93D')

        // 六角星
        Path()
          .width(100)
          .height(100)
          .commands(`
            M 50 5
            L 58 38
            L 92 38
            L 65 58
            L 75 92
            L 50 72
            L 25 92
            L 35 58
            L 8 38
            L 42 38
            Z
          `)
          .fill('#FF6B6B')
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.9 复杂组合图形

```typescript
@ComponentV2
struct ComplexPathExample {
  build() {
    Column({ space: 20 }) {
      Text('复杂组合图形')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        // 房子
        Path()
          .width(100)
          .height(100)
          .commands(`
            M 10 90
            L 10 50
            L 50 10
            L 90 50
            L 90 90
            Z
            M 35 90
            L 35 60
            L 65 60
            L 65 90
            Z
          `)
          .fill('#007DFF')
          .stroke('#0056B3')
          .strokeWidth(2)

        // 树
        Path()
          .width(100)
          .height(120)
          .commands(`
            M 50 10
            L 70 40
            L 90 40
            L 70 60
            L 80 90
            L 50 70
            L 20 90
            L 30 60
            L 10 40
            L 30 40
            Z
            M 40 90
            L 40 110
            L 60 110
            L 60 90
            Z
          `)
          .fill('#28A745')
          .stroke('#1E7E34')
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

### 3.10 动态路径

```typescript
@ComponentV2
struct DynamicPathExample {
  @Local progress: number = 0

  build() {
    Column({ space: 20 }) {
      Text('动态路径')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      // 动态圆形进度
      Stack() {
        // 背景圆
        Path()
          .width(120)
          .height(120)
          .commands('M 60 60 m -50 0 a 50 50 0 1 0 100 0 a 50 50 0 1 0 -100 0')
          .stroke('#E0E0E0')
          .strokeWidth(8)
          .fill('transparent')

        // 进度圆 (使用 dasharray 实现进度效果)
        Path()
          .width(120)
          .height(120)
          .commands('M 60 60 m -50 0 a 50 50 0 1 0 100 0 a 50 50 0 1 0 -100 0')
          .stroke('#007DFF')
          .strokeWidth(8)
          .fill('transparent')
          .strokeDasharray([314, 314])
          .strokeDashoffset(314 * (1 - this.progress / 100))

        // 进度文字
        Text(`${Math.round(this.progress)}%`)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#007DFF')
      }
      .width(120)
      .height(120)

      Slider({
        value: this.progress,
        min: 0,
        max: 100
      })
        .width('100%')
        .onChange((value: number) => {
          this.progress = Math.round(value)
        })
    }
    .width('100%')
    .padding(16)
  }
}
```

## 四、最佳实践

### 4.1 使用场景

1. **自定义图标**: 创建独特的图标形状
2. **复杂图形**: 绘制无法用简单形状表示的图形
3. **动画路径**: 用于动画运动的路径
4. **数据可视化**: 自定义图表元素

### 4.2 路径命令技巧

1. **使用大写命令**: 使用绝对坐标更容易理解和调试
2. **代码格式化**: 多行书写复杂路径,提高可读性
3. **注释标记**: 为复杂路径添加注释说明
4. **工具辅助**: 使用 SVG 编辑器生成路径命令

### 4.3 性能优化

- Path 性能开销较小,但复杂路径会影响渲染性能
- 避免创建过于复杂的路径(命令数 > 100)
- 大量使用时考虑复用路径定义
- 动画中使用简单路径以保证流畅性

### 4.4 路径编辑工具

推荐使用以下工具创建路径:
- **Figma/Sketch**: 设计软件导出 SVG
- **Adobe Illustrator**: 专业矢量图编辑
- **Inkscape**: 开源 SVG 编辑器
- **在线工具**: SVG Path Editor

## 五、常见问题

### Q1: 如何绘制空心路径?

A: 只设置 stroke,不设置 fill:

```typescript
Path()
  .commands('M 10 10 L 90 10 L 90 90 L 10 90 Z')
  .stroke('#007DFF')
  .strokeWidth(3)
  .fill('transparent')
```

### Q2: Path 和 Polygon/Polyline 有什么区别?

A:
- Path: 最灵活,支持所有路径命令
- Polygon: 专门绘制多边形,自动闭合
- Polyline: 绘制折线,不自动闭合
- Path 功能最强大,但使用复杂度也最高

### Q3: 如何创建平滑曲线?

A: 使用贝塞尔曲线命令 (C, S, Q, T):

```typescript
// 三次贝塞尔曲线 - 最平滑
Path()
  .commands('M 10 50 C 50 10 150 10 190 50')
  .stroke('#007DFF')
  .strokeWidth(3)
  .fill('transparent')
```

### Q4: 如何创建动态路径?

A: 使用状态变量和字符串模板:

```typescript
@ComponentV2
struct DynamicPathExample {
  @Local radius: number = 50

  build() {
    Path()
      .width(120)
      .height(120)
      .commands(`M 60 60 m -${this.radius} 0 a ${this.radius} ${this.radius} 0 1 0 ${this.radius * 2} 0 a ${this.radius} ${this.radius} 0 1 0 -${this.radius * 2} 0`)
      .stroke('#007DFF')
      .strokeWidth(3)
      .fill('transparent')
  }
}
```

### Q5: 如何从 SVG 转换路径?

A: 复制 SVG 的 path d 属性值到 commands:

```xml
<!-- SVG -->
<path d="M 10 10 L 90 10 L 90 90 L 10 90 Z" />
```

```typescript
// ArkTS
Path()
  .commands('M 10 10 L 90 10 L 90 90 L 10 90 Z')
  .fill('#007DFF')
```

## 六、参考资源

- [HarmonyOS Path 官方文档](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-drawing-components-path-0000001478341181-V3)
- [SVG 路径命令参考](https://developer.mozilla.org/en-US/docs/Web/SVG/Tutorial/Paths)
- [MDN SVG Path 文档](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/path)
