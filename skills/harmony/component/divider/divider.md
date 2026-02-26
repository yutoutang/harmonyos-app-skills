# Divider HarmonyOS 6.0 开发 Skill

## 概述

Divider 是一个分隔线组件,用于在不同内容之间创建视觉分隔。它通常用于列表项之间、内容区块之间或任何需要视觉分隔的场景。

## 重要说明

- Divider 是一个自包含组件,不需要子元素
- 默认方向为水平,可以设置为垂直
- 支持自定义颜色、描边宽度和线端样式
- 在 API 12+ 中支持更多的样式选项

## 模块信息

- **组件名称**: Divider
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **更新日期**: 2026-02-24
- **官方文档**: https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-basic-components-divider-0000001427744872-V3

## 一、组件基础

### 1.1 导入方式

```typescript
// Divider 是 ArkUI 内置组件,无需导入
```

### 1.2 基础用法

```typescript
// 水平分隔线(默认)
Divider()

// 垂直分隔线
Divider().vertical(true)
```

## 二、API 参数

### 2.1 构造参数

Divider 组件没有必需的构造参数。

### 2.2 属性方法

| 方法 | 参数类型 | 返回值 | 描述 |
|------|----------|--------|------|
| vertical | boolean | Divider | 设置分隔线方向,true 为垂直,false 为水平(默认) |
| color | ResourceColor | Divider | 设置分隔线颜色 |
| strokeWidth | Length | Divider | 设置分隔线宽度 |
| lineCap | LineCapStyle | Divider | 设置线条端点样式 |

**LineCapStyle 枚举值:**
- `LineCapStyle.Butt`: 无端帽(默认)
- `LineCapStyle.Round`: 圆形端帽
- `LineCapStyle.Square`: 方形端帽

### 2.3 事件回调

Divider 组件没有专用事件回调。可以使用通用事件:
- `onClick`: 点击事件
- `onAppear`: 出现事件
- `onDisappear`: 消失事件

## 三、使用示例

### 3.1 基础分隔线

```typescript
@ComponentV2
struct BasicDividerExample {
  build() {
    Column({ space: 20 }) {
      Text('内容 1')
        .fontSize(16)

      Divider()

      Text('内容 2')
        .fontSize(16)
    }
    .width('100%')
    .padding(20)
  }
}
```

### 3.2 垂直分隔线

```typescript
@ComponentV2
struct VerticalDividerExample {
  build() {
    Row() {
      Text('左侧')
        .layoutWeight(1)

      Divider()
        .vertical(true)
        .height(100)
        .strokeWidth(2)

      Text('右侧')
        .layoutWeight(1)
    }
    .width('100%')
    .height(120)
    .padding(20)
  }
}
```

### 3.3 自定义样式分隔线

```typescript
@ComponentV2
struct StyledDividerExample {
  build() {
    Column({ space: 20 }) {
      Text('红色粗分隔线')
        .fontSize(16)

      Divider()
        .color('#FF0000')
        .strokeWidth(4)

      Text('圆角端分隔线')
        .fontSize(16)

      Divider()
        .color('#007DFF')
        .strokeWidth(8)
        .lineCap(LineCapStyle.Round)
    }
    .width('100%')
    .padding(20)
  }
}
```

### 3.4 列表分隔线

```typescript
@ComponentV2
struct ListDividerExample {
  @Local items: string[] = ['项目 1', '项目 2', '项目 3', '项目 4']

  build() {
    Column() {
      ForEach(this.items, (item: string) => {
        Column() {
          Text(item)
            .fontSize(16)
            .padding(16)
        }
        .width('100%')

        if (item !== this.items[this.items.length - 1]) {
          Divider()
            .color('#E0E0E0')
            .strokeWidth(1)
        }
      })
    }
    .width('100%')
  }
}
```

### 3.5 虚线效果分隔线

```typescript
@ComponentV2
struct DashedDividerExample {
  build() {
    Column({ space: 20 }) {
      Text('虚线效果')
        .fontSize(16)

      // 使用 DashArrayEffect 创建虚线效果
      Divider()
        .color('#999999')
        .strokeWidth(2)
    }
    .width('100%')
    .padding(20)
  }
}
```

## 四、最佳实践

### 4.1 使用场景

1. **列表分隔**: 在长列表的项目之间添加分隔线
2. **内容分组**: 将相关内容分组,用分隔线分隔不同组
3. **视觉平衡**: 在页面中创建视觉休息点
4. **表单分隔**: 分隔表单的不同部分

### 4.2 设计建议

1. **颜色选择**: 使用浅灰色 (#E0E0E0) 作为默认分隔线颜色
2. **宽度设置**: 水平分隔线通常使用 1px 或 2px
3. **间距设置**: 分隔线两侧留有适当的 padding
4. **一致性**: 在整个应用中保持分隔线样式一致

### 4.3 性能优化

- Divider 是轻量级组件,对性能影响很小
- 避免在大量列表中过度使用复杂的分隔线样式

## 五、常见问题

### Q1: Divider 如何设置长度?

A: 使用 `width()` (水平) 或 `height()` (垂直) 方法:

```typescript
Divider()
  .width('80%')  // 水平分隔线,80% 宽度
  .margin({ top: 10, bottom: 10 })

Divider()
  .vertical(true)
  .height(100)  // 垂直分隔线,100vp 高度
```

### Q2: 如何创建虚线分隔线?

A: 使用 `strokeDashArray` 属性:

```typescript
Divider()
  .strokeDashArray([10, 5])  // 10vp 实线,5vp 空白
  .color('#999999')
```

### Q3: Divider 在 Flex 布局中的表现?

A: Divider 在 Flex 布局中会根据 flex 规则自动调整大小:

```typescript
Flex({ direction: FlexDirection.Row }) {
  Text('左')
  Divider().vertical(true).height(50)
  Text('右')
}
```

### Q4: 如何移除 Divider 的默认边距?

A: 使用 `margin({ top: 0, bottom: 0 })`:

```typescript
Divider()
  .margin({ top: 0, bottom: 0 })
```

## 六、参考资源

- [HarmonyOS Divider 官方文档](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-basic-components-divider-0000001427744872-V3)
- [LineCapStyle 枚举](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-appendix-enums-0000001478181369-V3)
