# Rect HarmonyOS 6.0 开发 Skill

## 概述

Rect 是一个矩形形状组件,用于绘制矩形或圆角矩形。它是基于 Shape 组件的简化版本,专门用于创建矩形或圆角矩形装饰元素。

## 重要说明

- Rect 绘制的是矩形,可以设置不同的宽高比
- 支持圆角半径设置,可以创建圆角矩形
- 可以设置填充颜色、边框、阴影等样式
- 在 API 12+ 中支持更多动画效果
- 常用于卡片背景、装饰性矩形、按钮背景等场景

## 模块信息

- **组件名称**: Rect
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **更新日期**: 2026-02-24
- **官方文档**: https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-drawing-components-rect-0000001478341181-V3

## 一、组件基础

### 1.1 导入方式

```typescript
// Rect 是 ArkUI 内置组件,无需导入
```

### 1.2 基础用法

```typescript
// 基础矩形
Rect()
  .width(100)
  .height(80)
  .fill('#007DFF')

// 圆角矩形
Rect()
  .width(100)
  .height(80)
  .fill('#28A745')
  .radius(12)
```

## 二、API 参数

### 2.1 构造参数

Rect 组件无必需的构造参数,通过属性方法设置尺寸和样式。

### 2.2 属性方法

| 方法 | 参数类型 | 返回值 | 描述 |
|------|----------|--------|------|
| width | Length | Rect | 设置矩形宽度 |
| height | Length | Rect | 设置矩形高度 |
| radius | Length \| Array\<Length\> | Rect | 设置圆角半径 |
| fill | ResourceColor \| LinearGradient | Rect | 设置填充颜色或渐变 |
| stroke | ResourceColor | Rect | 设置边框颜色 |
| strokeWidth | Length | Rect | 设置边框宽度 |

**radius 参数说明**:
- 单个值: 四个角使用相同圆角半径
- 数组 [topLeft, topRight, bottomRight, bottomLeft]: 分别设置四个角的圆角半径

### 2.3 事件回调

Rect 支持通用事件:
- `onClick`: 点击事件
- `onAppear`: 出现事件
- `onDisappear`: 消失事件

## 三、使用示例

### 3.1 基础矩形

```typescript
@ComponentV2
struct BasicRectExample {
  build() {
    Column({ space: 20 }) {
      Text('基础矩形')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        Rect()
          .width(80)
          .height(80)
          .fill('#007DFF')

        Rect()
          .width(100)
          .height(60)
          .fill('#28A745')

        Rect()
          .width(60)
          .height(100)
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

### 3.2 圆角矩形

```typescript
@ComponentV2
struct RoundedRectExample {
  build() {
    Column({ space: 20 }) {
      Text('圆角矩形')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        // 小圆角
        Rect()
          .width(80)
          .height(80)
          .fill('#E3F2FD')
          .radius(8)

        // 中圆角
        Rect()
          .width(80)
          .height(80)
          .fill('#E8F5E9')
          .radius(16)

        // 大圆角
        Rect()
          .width(80)
          .height(80)
          .fill('#FFF3E0')
          .radius(40)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.3 异形圆角矩形

```typescript
@ComponentV2
struct CustomRadiusRectExample {
  build() {
    Column({ space: 20 }) {
      Text('异形圆角矩形')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        // 左侧圆角
        Rect()
          .width(120)
          .height(60)
          .fill('#007DFF')
          .radius([30, 0, 0, 30])

        // 右侧圆角
        Rect()
          .width(120)
          .height(60)
          .fill('#28A745')
          .radius([0, 30, 30, 0])

        // 顶部圆角
        Rect()
          .width(100)
          .height(80)
          .fill('#FFC107')
          .radius([20, 20, 0, 0])
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.4 带边框的矩形

```typescript
@ComponentV2
struct StrokedRectExample {
  build() {
    Column({ space: 20 }) {
      Text('带边框的矩形')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        Rect()
          .width(80)
          .height(80)
          .fill('#E3F2FD')
          .stroke('#007DFF')
          .strokeWidth(4)
          .radius(8)

        Rect()
          .width(80)
          .height(80)
          .fill('#FFFFFF')
          .stroke('#28A745')
          .strokeWidth(6)
          .radius(16)

        Rect()
          .width(80)
          .height(80)
          .fill('#FFF3E0')
          .stroke('#FFC107')
          .strokeWidth(8)
          .radius(24)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.5 渐变矩形

```typescript
@ComponentV2
struct GradientRectExample {
  build() {
    Column({ space: 20 }) {
      Text('渐变矩形')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        Rect()
          .width(100)
          .height(80)
          .fill(new LinearGradient({
            angle: 135,
            colors: [['#007DFF', 0.0], ['#00BCD4', 1.0]]
          }))
          .radius(12)

        Rect()
          .width(100)
          .height(80)
          .fill(new LinearGradient({
            angle: 90,
            colors: [['#FF6B6B', 0.0], ['#FFD93D', 1.0]]
          }))
          .radius(12)

        Rect()
          .width(100)
          .height(80)
          .fill(new LinearGradient({
            angle: 180,
            colors: [['#A8E6CF', 0.0], ['#3D9970', 1.0]]
          }))
          .radius(12)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.6 卡片背景

```typescript
@ComponentV2
struct CardRectExample {
  build() {
    Column({ space: 20 }) {
      Text('卡片背景')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Column({ space: 12 }) {
        Text('卡片标题')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)

        Text('这是卡片内容,使用 Rect 作为背景')
          .fontSize(14)
          .fontColor('#666666')
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)

      Column({ space: 12 }) {
        Text('阴影卡片')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)

        Text('带阴影效果的卡片')
          .fontSize(14)
          .fontColor('#666666')
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
      .shadow({
        radius: 8,
        color: 'rgba(0, 0, 0, 0.1)',
        offsetX: 0,
        offsetY: 2
      })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.7 按钮背景

```typescript
@ComponentV2
struct ButtonRectExample {
  build() {
    Column({ space: 20 }) {
      Text('按钮背景')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 16 }) {
        Text('主要按钮')
          .fontSize(16)
          .fontColor('#FFFFFF')
          .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          .backgroundColor('#007DFF')
          .borderRadius(8)

        Text('次要按钮')
          .fontSize(16)
          .fontColor('#007DFF')
          .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          .backgroundColor('#E3F2FD')
          .borderRadius(8)
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.8 装饰性矩形

```typescript
@ComponentV2
struct DecorativeRectExample {
  build() {
    Column({ space: 20 }) {
      Text('装饰性矩形')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Stack({ alignContent: Alignment.Center }) {
        // 背景装饰
        Rect()
          .width('100%')
          .height('100%')
          .fill(new LinearGradient({
            angle: 135,
            colors: [['#667EEA', 0.0], ['#764BA2', 1.0]]
          }))
          .radius(16)

        // 内容
        Text('装饰背景')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
      }
      .width('100%')
      .height(120)

      Row({ space: 12 }) {
        Stack({ alignContent: Alignment.Center }) {
          Rect()
            .width(60)
            .height(60)
            .fill('#FF6B6B')
            .radius(12)

          Text('1')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
        }

        Stack({ alignContent: Alignment.Center }) {
          Rect()
            .width(60)
            .height(60)
            .fill('#4ECDC4')
            .radius(12)

          Text('2')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
        }

        Stack({ alignContent: Alignment.Center }) {
          Rect()
            .width(60)
            .height(60)
            .fill('#FFD93D')
            .radius(12)

          Text('3')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
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

### 3.9 状态矩形

```typescript
@ComponentV2
struct StatusRectExample {
  @Local status: string = 'success'

  build() {
    Column({ space: 20 }) {
      Text('状态指示矩形')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 16 }) {
        Column({ space: 8 }) {
          Rect()
            .width(40)
            .height(40)
            .fill('#4CAF50')
            .radius(8)

          Text('成功')
            .fontSize(12)
            .fontColor('#666666')
        }

        Column({ space: 8 }) {
          Rect()
            .width(40)
            .height(40)
            .fill('#FFC107')
            .radius(8)

          Text('警告')
            .fontSize(12)
            .fontColor('#666666')
        }

        Column({ space: 8 }) {
          Rect()
            .width(40)
            .height(40)
            .fill('#F44336')
            .radius(8)

          Text('错误')
            .fontSize(12)
            .fontColor('#666666')
        }

        Column({ space: 8 }) {
          Rect()
            .width(40)
            .height(40)
            .fill('#2196F3')
            .radius(8)

          Text('信息')
            .fontSize(12)
            .fontColor('#666666')
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

### 3.10 进度条背景

```typescript
@ComponentV2
struct ProgressBarRectExample {
  @Local progress: number = 65

  build() {
    Column({ space: 20 }) {
      Text('进度条背景')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Column({ space: 8 }) {
        Row() {
          Text(`${this.progress}%`)
            .fontSize(14)
            .fontColor('#666666')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Stack({ alignContent: Alignment.Start }) {
          // 背景条
          Rect()
            .width('100%')
            .height(8)
            .fill('#E0E0E0')
            .radius(4)

          // 进度条
          Rect()
            .width(`${this.progress}%`)
            .height(8)
            .fill('#007DFF')
            .radius(4)
        }
        .width('100%')
      }
      .width('100%')

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

1. **卡片背景**: 信息卡片、功能卡片
2. **按钮背景**: 自定义按钮样式
3. **装饰元素**: 页面装饰、分隔区域
4. **状态指示**: 状态标签、进度条
5. **容器背景**: 内容区域的背景装饰

### 4.2 设计建议

1. **尺寸规范**: 遵循设计规范的尺寸标准
2. **圆角半径**: 常用 4/8/12/16/24vp
3. **颜色选择**: 遵循品牌色和设计规范
4. **渐变使用**: 渐变色可以增加视觉层次
5. **边框使用**: 需要突出显示时添加边框

### 4.3 性能优化

- Rect 是轻量级组件,性能开销很小
- 大量使用时考虑复用组件
- 复杂渐变可能影响渲染性能

### 4.4 与其他组件对比

**Rect vs Column/Row:**
- Rect: 纯装饰组件,不能包含子组件
- Column/Row: 布局容器,可以包含子组件

**Rect vs Image:**
- Rect: 纯色或渐变背景
- Image: 图片背景

## 五、常见问题

### Q1: 如何绘制空心矩形?

A: 只设置 stroke,不设置 fill:

```typescript
Rect()
  .width(80)
  .height(80)
  .stroke('#007DFF')
  .strokeWidth(4)
  .radius(8)
```

### Q2: Rect 和 Column 有什么区别?

A:
- Rect 是装饰性组件,用于绘制矩形背景
- Column 是布局容器,可以包含子组件
- 如果需要子组件,使用 Column 并设置 backgroundColor

### Q3: 如何创建不同圆角的矩形?

A: 使用数组参数分别设置四个角:

```typescript
Rect()
  .width(120)
  .height(80)
  .fill('#007DFF')
  .radius([20, 10, 0, 30]) // 左上, 右上, 右下, 左下
```

### Q4: 如何创建矩形图片?

A: 使用 Image 组件配合 borderRadius:

```typescript
Image('https://example.com/image.png')
  .width(120)
  .height(80)
  .borderRadius(12)
```

### Q5: 如何创建阴影效果?

A: 使用 shadow 属性:

```typescript
Rect()
  .width(100)
  .height(80)
  .fill('#FFFFFF')
  .radius(12)
  .shadow({
    radius: 8,
    color: 'rgba(0, 0, 0, 0.1)',
    offsetX: 0,
    offsetY: 2
  })
```

### Q6: 如何创建半透明矩形?

A: 使用 rgba 颜色:

```typescript
Rect()
  .width(100)
  .height(80)
  .fill('rgba(0, 125, 255, 0.5)')
  .radius(12)
```

### Q7: 如何创建矩形动画?

A: 使用 animateTo 方法:

```typescript
@ComponentV2
struct AnimatedRectExample {
  @Local width: number = 100

  build() {
    Rect()
      .width(this.width)
      .height(80)
      .fill('#007DFF')
      .radius(12)
      .onClick(() => {
        animateTo({ duration: 300 }, () => {
          this.width = this.width === 100 ? 150 : 100
        })
      })
  }
}
```

## 六、参考资源

- [HarmonyOS Rect 官方文档](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-drawing-components-rect-0000001478341181-V3)
- [LinearGradient](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-appendix-vmlayerdrawinglingradient-0000001478061429-V3)
- [HarmonyOS ArkUI 浮层属性](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-universal-attributes-overlay)
