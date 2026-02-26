# Ellipse HarmonyOS 6.0 开发 Skill

## 概述

Ellipse 是一个椭圆形组件,用于绘制椭圆形状。与 Circle 不同,Ellipse 允许宽度和高度不同,从而创建各种比例的椭圆。

## 重要说明

- Ellipse 可以创建不同宽高比的椭圆
- 当 width 等于 height 时,绘制的是完美圆形
- 支持填充、边框、阴影等样式
- 在 API 12+ 中支持更多样式选项

## 模块信息

- **组件名称**: Ellipse
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **更新日期**: 2026-02-24
- **官方文档**: https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-drawing-components-ellipse-0000001478341181-V3

## 一、组件基础

### 1.1 导入方式

```typescript
// Ellipse 是 ArkUI 内置组件,无需导入
```

### 1.2 基础用法

```typescript
// 宽椭圆
Ellipse({ width: 150, height: 80 })
  .fill('#007DFF')

// 高椭圆
Ellipse({ width: 80, height: 150 })
  .fill('#28A745')

// 正圆(宽高相等)
Ellipse({ width: 100, height: 100 })
  .fill('#FFC107')
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| width | Length | 是 | - | 椭圆宽度 |
| height | Length | 是 | - | 椭圆高度 |

### 2.2 属性方法

| 方法 | 参数类型 | 返回值 | 描述 |
|------|----------|--------|------|
| fill | ResourceColor \| LinearGradient | Ellipse | 设置填充颜色或渐变 |
| stroke | ResourceColor | Ellipse | 设置边框颜色 |
| strokeWidth | Length | Ellipse | 设置边框宽度 |

### 2.3 事件回调

Ellipse 支持通用事件:
- `onClick`: 点击事件
- `onAppear`: 出现事件
- `onDisappear`: 消失事件

## 三、使用示例

### 3.1 不同比例的椭圆

```typescript
@ComponentV2
struct EllipseRatioExample {
  build() {
    Column({ space: 20 }) {
      Text('不同比例的椭圆')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 16 }) {
        Ellipse({ width: 150, height: 60 })
          .fill('#007DFF')

        Ellipse({ width: 120, height: 80 })
          .fill('#28A745')

        Ellipse({ width: 80, height: 120 })
          .fill('#FFC107')
      }
      .width('100%')
      .height(140)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.2 带边框的椭圆

```typescript
@ComponentV2
struct StrokedEllipseExample {
  build() {
    Column({ space: 20 }) {
      Text('带边框的椭圆')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 16 }) {
        Ellipse({ width: 140, height: 70 })
          .fill('#E3F2FD')
          .stroke('#007DFF')
          .strokeWidth(4)

        Ellipse({ width: 100, height: 100 })
          .fill('#E8F5E9')
          .stroke('#28A745')
          .strokeWidth(6)

        Ellipse({ width: 70, height: 140 })
          .fill('#FFF3E0')
          .stroke('#FFC107')
          .strokeWidth(8)
      }
      .width('100%')
      .height(160)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.3 装饰性椭圆

```typescript
@ComponentV2
struct DecorativeEllipseExample {
  build() {
    Column({ space: 20 }) {
      Text('装饰性椭圆')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Stack() {
        // 背景椭圆
        Ellipse({ width: 200, height: 100 })
          .fill('#E3F2FD')
          .opacity(0.5)

        // 中层椭圆
        Ellipse({ width: 150, height: 75 })
          .fill('#007DFF')
          .opacity(0.3)

        // 文字
        Text('装饰效果')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#007DFF')
      }
      .width('100%')
      .height(120)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.4 渐变椭圆

```typescript
@ComponentV2
struct GradientEllipseExample {
  build() {
    Column({ space: 20 }) {
      Text('渐变椭圆')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 16 }) {
        Ellipse({ width: 140, height: 60 })
          .fill(new LinearGradient({
            angle: 90,
            colors: [['#007DFF', 0.0], ['#00BCD4', 1.0]]
          }))

        Ellipse({ width: 120, height: 80 })
          .fill(new LinearGradient({
            angle: 135,
            colors: [['#FF6B6B', 0.0], ['#FFD93D', 1.0]]
          }))

        Ellipse({ width: 80, height: 120 })
          .fill(new LinearGradient({
            angle: 180,
            colors: [['#A8E6CF', 0.0], ['#3D9970', 1.0]]
          }))
      }
      .width('100%')
      .height(140)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.5 椭圆按钮

```typescript
@ComponentV2
struct EllipseButtonExample {
  build() {
    Column({ space: 20 }) {
      Text('椭圆按钮')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        Ellipse({ width: 120, height: 50 })
          .fill('#007DFF')
          .onClick(() => {
            console.log('椭圆按钮点击')
          })

        Ellipse({ width: 120, height: 50 })
          .fill('#28A745')
          .onClick(() => {
            console.log('椭圆按钮点击')
          })

        Ellipse({ width: 120, height: 50 })
          .fill('#FFC107')
          .onClick(() => {
            console.log('椭圆按钮点击')
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.6 卡片装饰

```typescript
@ComponentV2
struct CardEllipseDecoration {
  build() {
    Column({ space: 20 }) {
      Text('卡片装饰')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Column({ space: 16 }) {
        Text('装饰性卡片')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)

        Text('椭圆形状可以作为卡片的装饰元素,增加视觉层次感。')
          .fontSize(14)
          .fontColor('#666666')
          .lineHeight(22)

        Row() {
          // 装饰椭圆
          Ellipse({ width: 60, height: 30 })
            .fill('#E3F2FD')

          Blank()

          Text('了解更多 →')
            .fontSize(14)
            .fontColor('#007DFF')
        }
        .width('100%')
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
      .shadow({ radius: 8, color: 'rgba(0,0,0,0.1)' })
    }
    .width('100%')
    .padding(16)
  }
}
```

## 四、最佳实践

### 4.1 使用场景

1. **装饰元素**: 卡片装饰、背景装饰
2. **特殊按钮**: 椭圆形按钮
3. **图标背景**: 图标的椭圆背景
4. **视觉层次**: 创建层次分明的视觉效果

### 4.2 设计建议

1. **宽高比**: 常用比例为 2:1 或 3:2
2. **颜色选择**: 与整体设计风格协调
3. **透明度**: 使用 opacity 创建层次效果
4. **对称性**: 对称的椭圆更加美观

### 4.3 与 Circle 的选择

- 使用 Circle: 需要完美圆形(头像、圆点)
- 使用 Ellipse: 需要椭圆形状(装饰、特殊按钮)

## 五、常见问题

### Q1: Ellipse 和 Circle 如何选择?

A: 根据形状需求选择:
- 需要正圆 → 使用 Circle
- 需要椭圆 → 使用 Ellipse

### Q2: 如何创建半透明椭圆?

A: 使用 opacity 属性:

```typescript
Ellipse({ width: 100, height: 60 })
  .fill('#007DFF')
  .opacity(0.5)
```

### Q3: 如何创建带阴影的椭圆?

A: 使用 shadow 属性:

```typescript
Ellipse({ width: 120, height: 70 })
  .fill('#007DFF')
  .shadow({
    radius: 8,
    color: 'rgba(0, 125, 255, 0.3)',
    offsetX: 0,
    offsetY: 4
  })
```

### Q4: Ellipse 可以作为容器吗?

A: Ellipse 是形状组件,不是容器。如需在椭圆内放置内容,使用 Stack 布局:

```typescript
Stack() {
  Ellipse({ width: 100, height: 60 })
    .fill('#E3F2FD')

  Text('内容')
    .fontSize(14)
    .fontColor('#007DFF')
}
.width(100)
.height(60)
```

## 六、参考资源

- [HarmonyOS Ellipse 官方文档](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-drawing-components-ellipse-0000001478341181-V3)
- [Circle 组件](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-drawing-components-circle-0000001478341181-V3)
