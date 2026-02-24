# Circle HarmonyOS 6.0 开发 Skill

## 概述

Circle 是一个圆形形状组件,用于绘制完美圆形。它是基于 Shape 组件的简化版本,专门用于创建圆形或椭圆形装饰元素。

## 重要说明

- Circle 绘制的是完美圆形,宽高比始终为 1:1
- 可以设置填充颜色、边框、阴影等样式
- 在 API 12+ 中支持更多动画效果
- 常用于头像、装饰性圆点、进度指示器等场景

## 模块信息

- **组件名称**: Circle
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **更新日期**: 2026-02-24
- **官方文档**: https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-drawing-components-circle-0000001478341181-V3

## 一、组件基础

### 1.1 导入方式

```typescript
// Circle 是 ArkUI 内置组件,无需导入
```

### 1.2 基础用法

```typescript
// 基础圆形
Circle({ width: 100, height: 100 })
  .fill('#007DFF')

// 圆形头像
Circle({ width: 60, height: 60 })
  .fill('#E3F2FD')
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| width | Length | 是 | - | 圆形宽度 |
| height | Length | 是 | - | 圆形高度 |

**注意**: 为了绘制完美圆形,width 和 height 应该设置相同的值。

### 2.2 属性方法

| 方法 | 参数类型 | 返回值 | 描述 |
|------|----------|--------|------|
| fill | ResourceColor \| LinearGradient | Circle | 设置填充颜色或渐变 |
| stroke | ResourceColor | Circle | 设置边框颜色 |
| strokeWidth | Length | Circle | 设置边框宽度 |
| radius | number | Circle | 设置圆形半径(覆盖 width/height) |

### 2.3 事件回调

Circle 支持通用事件:
- `onClick`: 点击事件
- `onAppear`: 出现事件
- `onDisappear`: 消失事件

## 三、使用示例

### 3.1 基础圆形

```typescript
@ComponentV2
struct BasicCircleExample {
  build() {
    Row({ space: 20 }) {
      Circle({ width: 80, height: 80 })
        .fill('#007DFF')

      Circle({ width: 80, height: 80 })
        .fill('#28A745')

      Circle({ width: 80, height: 80 })
        .fill('#FFC107')
    }
    .width('100%')
    .height(120)
    .justifyContent(FlexAlign.Center)
    .padding(16)
  }
}
```

### 3.2 圆形头像

```typescript
@ComponentV2
struct AvatarCircleExample {
  build() {
    Column({ space: 20 }) {
      Text('圆形头像示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        // 大头像
        Circle({ width: 80, height: 80 })
          .fill('#E3F2FD')

        // 中头像
        Circle({ width: 60, height: 60 })
          .fill('#E8F5E9')

        // 小头像
        Circle({ width: 40, height: 40 })
          .fill('#FFF3E0')
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.3 带边框的圆形

```typescript
@ComponentV2
struct StrokedCircleExample {
  build() {
    Column({ space: 20 }) {
      Text('带边框的圆形')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        Circle({ width: 80, height: 80 })
          .fill('#E3F2FD')
          .stroke('#007DFF')
          .strokeWidth(4)

        Circle({ width: 80, height: 80 })
          .fill('#FFFFFF')
          .stroke('#28A745')
          .strokeWidth(6)

        Circle({ width: 80, height: 80 })
          .fill('#FFF3E0')
          .stroke('#FFC107')
          .strokeWidth(8)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.4 渐变圆形

```typescript
@ComponentV2
struct GradientCircleExample {
  build() {
    Column({ space: 20 }) {
      Text('渐变圆形')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        Circle({ width: 80, height: 80 })
          .fill(new LinearGradient({
            angle: 135,
            colors: [['#007DFF', 0.0], ['#00BCD4', 1.0]]
          }))

        Circle({ width: 80, height: 80 })
          .fill(new LinearGradient({
            angle: 90,
            colors: [['#FF6B6B', 0.0], ['#FFD93D', 1.0]]
          }))

        Circle({ width: 80, height: 80 })
          .fill(new LinearGradient({
            angle: 180,
            colors: [['#A8E6CF', 0.0], ['#3D9970', 1.0]]
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

### 3.5 进度指示器

```typescript
@ComponentV2
struct ProgressCircleExample {
  @Local progress: number = 75

  build() {
    Column({ space: 20 }) {
      Text('进度指示器')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Stack() {
        // 背景圆
        Circle({ width: 100, height: 100 })
          .fill('#F5F5F5')

        // 进度圆
        Circle({ width: 100, height: 100 })
          .fill(new LinearGradient({
            angle: 90,
            colors: [['#007DFF', 0.0], ['#00BCD4', 1.0]]
          }))
          .clip(new Path().commands([
            'M 50 0',
            'A 50 50 0 1 1 ' +
            `${50 + 50 * Math.cos(2 * Math.PI * this.progress / 100 - Math.PI / 2)} ` +
            `${50 + 50 * Math.sin(2 * Math.PI * this.progress / 100 - Math.PI / 2)}`
          ]))

        // 进度文字
        Text(`${this.progress}%`)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#007DFF')
      }
      .width(100)
      .height(100)

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

### 3.6 状态指示点

```typescript
@ComponentV2
struct StatusCircleExample {
  build() {
    Column({ space: 20 }) {
      Text('状态指示点')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 16 }) {
        Column({ space: 8 }) {
          Circle({ width: 12, height: 12 })
            .fill('#4CAF50')
          Text('在线')
            .fontSize(12)
            .fontColor('#666666')
        }

        Column({ space: 8 }) {
          Circle({ width: 12, height: 12 })
            .fill('#FFC107')
          Text('忙碌')
            .fontSize(12)
            .fontColor('#666666')
        }

        Column({ space: 8 }) {
          Circle({ width: 12, height: 12 })
            .fill('#F44336')
          Text('离线')
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

## 四、最佳实践

### 4.1 使用场景

1. **头像**: 用户头像、联系人头像
2. **装饰**: 装饰性圆点、背景装饰
3. **状态指示**: 在线状态、加载状态
4. **进度显示**: 环形进度条

### 4.2 设计建议

1. **尺寸规范**: 头像常用 40/60/80/100vp
2. **颜色选择**: 遵循品牌色和设计规范
3. **边框使用**: 需要突出显示时添加边框
4. **渐变效果**: 渐变色可以增加视觉层次

### 4.3 性能优化

- Circle 是轻量级组件,性能开销很小
- 大量使用时考虑复用组件

## 五、常见问题

### Q1: 如何绘制空心圆?

A: 只设置 stroke,不设置 fill:

```typescript
Circle({ width: 80, height: 80 })
  .stroke('#007DFF')
  .strokeWidth(4)
```

### Q2: Circle 和 Ellipse 有什么区别?

A: Circle 绘制完美圆形(宽高比 1:1),Ellipse 可以绘制椭圆形(宽高比可变)。

### Q3: 如何创建圆形图片?

A: 使用 Image 组件配合 borderRadius:

```typescript
Image('https://example.com/avatar.png')
  .width(80)
  .height(80)
  .borderRadius(20) // 设置为宽度的一半
```

### Q4: 如何创建阴影效果?

A: 使用 shadow 属性:

```typescript
Circle({ width: 80, height: 80 })
  .fill('#007DFF')
  .shadow({
    radius: 8,
    color: 'rgba(0, 125, 255, 0.3)',
    offsetX: 0,
    offsetY: 4
  })
```

## 六、参考资源

- [HarmonyOS Circle 官方文档](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-drawing-components-circle-0000001478341181-V3)
- [LinearGradient](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-appendix-vmlayerdrawinglingradient-0000001478061429-V3)
