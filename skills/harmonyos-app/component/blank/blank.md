# Blank HarmonyOS 6.0 开发 Skill

## 概述

Blank 是一个空白占位组件,用于在布局中创建弹性空白区域。它可以自动填充容器中的剩余空间,常用于实现元素之间的间距分隔或对齐布局。

## 重要说明

- Blank 组件只能在沿主轴方向上有剩余空间的容器中生效
- 它会自动填充剩余空间,类似于 `layoutWeight(1)` 的效果
- 常用于 Flex 容器中实现弹性间距
- 不建议在 Column 或 Row 中使用(应使用 space 或 justifyContent)

## 模块信息

- **组件名称**: Blank
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **更新日期**: 2026-02-24
- **官方文档**: https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-basic-components-blank-0000001427585024-V3

## 一、组件基础

### 1.1 导入方式

```typescript
// Blank 是 ArkUI 内置组件,无需导入
```

### 1.2 基础用法

```typescript
// 在 Flex 容器中使用
Flex() {
  Text('左侧内容')
  Blank()  // 自动填充中间空间
  Text('右侧内容')
}
```

### 1.3 工作原理

Blank 组件会自动计算并填充容器中的剩余空间:

```
┌──────────────────────────────┐
│ [左侧] ←------Blank------→ [右侧] │
└──────────────────────────────┘
```

## 二、API 参数

### 2.1 构造参数

Blank 组件没有必需的构造参数。

### 2.2 属性方法

| 方法 | 参数类型 | 返回值 | 描述 |
|------|----------|--------|------|
| color | ResourceColor | Blank | 设置空白区域的填充颜色(默认透明) |

### 2.3 事件回调

Blank 组件没有专用事件回调。

## 三、使用示例

### 3.1 Flex 布局中的分隔

```typescript
@ComponentV2
struct FlexBlankExample {
  build() {
    Column({ space: 20 }) {
      Text('Flex 中的 Blank 示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Flex() {
        Text('左对齐')
          .fontSize(16)
          .padding(12)
          .backgroundColor('#E3F2FD')
          .borderRadius(8)

        Blank()

        Text('右对齐')
          .fontSize(16)
          .padding(12)
          .backgroundColor('#28A745')
          .borderRadius(8)
      }
      .width('100%')
      .padding(20)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.2 工具栏布局

```typescript
@ComponentV2
struct ToolbarBlankExample {
  build() {
    Column({ space: 16 }) {
      Text('工具栏布局')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Flex() {
        Text('◀')
          .fontSize(24)
          .padding(12)

        Blank()

        Text('标题')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)

        Blank()

        Text('▶')
          .fontSize(24)
          .padding(12)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
      .shadow({ radius: 4, color: '#E0E0E0' })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.3 多个 Blank 组合

```typescript
@ComponentV2
struct MultipleBlankExample {
  build() {
    Column({ space: 16 }) {
      Text('多个 Blank 组合')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Flex() {
        Text('左')
          .padding(12)

        Blank()
          .color('#FFEBEE')

        Text('中')
          .padding(12)

        Blank()
          .color('#E8F5E9')

        Text('右')
          .padding(12)
      }
      .width('100%')
      .height(80)
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.4 卡片底部对齐

```typescript
@ComponentV2
struct CardAlignExample {
  build() {
    Column({ space: 16 }) {
      Text('卡片底部按钮对齐')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Column() {
        Text('卡片标题')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 12 })

        Text('这是一段很长的卡片内容描述,卡片顶部是对齐的,底部的按钮通过 Blank 实现对齐。')
          .fontSize(14)
          .fontColor('#666666')
          .lineHeight(22)

        Blank()

        Button('操作按钮')
          .width('100%')
          .margin({ top: 16 })
      }
      .width('100%')
      .height(200)
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
      .shadow({ radius: 8, color: '#E0E0E0' })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.5 带颜色的 Blank

```typescript
@ComponentV2
struct ColoredBlankExample {
  build() {
    Column({ space: 16 }) {
      Text('带颜色的 Blank')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Flex() {
        Text('起点')
          .padding(12)
          .backgroundColor('#E3F2FD')
          .borderRadius(8)

        Blank()
          .color('#F5F5F5')

        Text('终点')
          .padding(12)
          .backgroundColor('#28A745')
          .borderRadius(8)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
    }
    .width('100%')
    .padding(16)
  }
}
```

## 四、最佳实践

### 4.1 适用场景

1. **工具栏布局**: 实现左右对齐的工具栏
2. **卡片布局**: 将按钮推到卡片底部
3. **导航栏**: 标题居中,两侧内容对齐
4. **表单布局**: 标签和输入框之间的弹性间距

### 4.2 设计建议

1. **Flex 容器**: Blank 主要用于 Flex 容器中
2. **替代方案**: 在 Column/Row 中,使用 `justifyContent` 或 `space` 参数更合适
3. **性能考虑**: Blank 是轻量级组件,性能开销很小

### 4.3 与其他方法对比

| 方案 | 适用场景 | 优点 | 缺点 |
|------|----------|------|------|
| Blank() | Flex 布局,需要弹性间距 | 简单直接 | 仅适用于 Flex |
| layoutWeight(1) | Column/Row 布局 | 通用性强 | 需要应用于具体元素 |
| justifyContent | Column/Row 整体对齐 | 布局统一 | 无法实现局部间距 |
| space 参数 | Column/Row 均匀间距 | 自动计算 | 所有间距相同 |

## 五、常见问题

### Q1: Blank 在 Column 中不生效?

A: Blank 主要设计用于 Flex 布局。在 Column 中应使用 `justifyContent` 或 `space`:

```typescript
// 错误: Blank 在 Column 中不生效
Column() {
  Text('顶部')
  Blank()  // 不会填充空间
  Text('底部')
}

// 正确: 使用 justifyContent
Column() {
  Text('顶部')
  Text('底部')
}
.justifyContent(FlexAlign.SpaceBetween)
```

### Q2: 如何限制 Blank 的最大宽度?

A: 使用 `maxWidth` 或 `maxHeight`:

```typescript
Blank()
  .maxWidth(200)  // 最多填充 200vp
```

### Q3: Blank 和 Spacer 有什么区别?

A: 在 HarmonyOS ArkUI 中,Blank 是内置组件,功能类似于 Spacer。两者用法基本相同。

### Q4: 如何创建左侧固定、右侧自适应的布局?

A: 使用 Blank 填充右侧空间:

```typescript
Flex() {
  Column() {
    Text('固定内容')
      .width(200)
  }

  Blank()  // 填充剩余空间

  Text('自适应内容')
}
```

## 六、参考资源

- [HarmonyOS Blank 官方文档](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-basic-components-blank-0000001427585024-V3)
- [Flex 布局组件](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-container-flex-0000001427744872-V3)
