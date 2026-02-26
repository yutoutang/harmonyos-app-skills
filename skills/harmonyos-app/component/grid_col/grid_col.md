# GridCol 组件 HarmonyOS 6.0 开发 Skill

## 概述

GridCol 是 OpenHarmony 栅格布局系统中的列组件，必须作为 GridRow 的子组件使用。它用于定义每个栅格列占据的列数、偏移量和顺序，是实现响应式布局的基本单元。

## 重要说明

- **基础组件**: GridCol 是 ArkUI 的内置组件，无需导入
- **父容器**: 必须作为 GridRow 的直接子组件使用
- **栅格系统**: 基于 12 列栅格系统
- **响应式**: 支持不同断点的 span 设置

## 模块信息

- **组件名称**: GridCol
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [GridCol 栅格子组件 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-gridcol-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// GridCol 是内置组件，无需导入
// 必须作为 GridRow 的子组件使用
GridRow() {
  GridCol() {
    Text('Column 1')
  }
  GridCol() {
    Text('Column 2')
  }
}
```

### 1.2 基础用法

```typescript
// 默认占据 1 列
GridRow({ columns: 12 }) {
  GridCol() {
    Text('1 Column')
  }
}

// 指定占据的列数
GridRow({ columns: 12 }) {
  GridCol({ span: 6 }) {  // 占据 6 列（50%）
    Text('Half Width')
  }
  GridCol({ span: 6 }) {  // 占据 6 列（50%）
    Text('Half Width')
  }
}

// 使用偏移量
GridRow({ columns: 12 }) {
  GridCol({ span: 6, offset: 3 }) {  // 偏移 3 列，占据 6 列
    Text('Offset 3, Span 6')
  }
}
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| options | `GridColOptions` | 否 | - | 栅格子组件配置 |

### 2.2 GridColOptions 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `span` | `number \| GridColSpanOption` | 1 | 占据的列数（1-12）或响应式配置 |
| `offset` | `number \| GridColOffsetOption` | 0 | 偏移的列数 |
| `order` | `number` | 0 | 排序顺序（用于视觉重排） |

### 2.3 响应式配置

#### GridColSpanOption

```typescript
interface GridColSpanOption {
  xs?: number;  // 超小屏幕（< 600vp）
  sm?: number;  // 小屏幕（600-800vp）
  md?: number;  // 中等屏幕（800-1200vp）
  lg?: number;  // 大屏幕（≥ 1200vp）
}
```

#### GridColOffsetOption

```typescript
interface GridColOffsetOption {
  xs?: number;  // 超小屏幕偏移
  sm?: number;  // 小屏幕偏移
  md?: number;  // 中等屏幕偏移
  lg?: number;  // 大屏幕偏移
}
```

### 2.4 断点说明

| 断点 | 设备宽度 | 适用场景 |
|------|----------|----------|
| `xs` | < 600vp | 手机竖屏 |
| `sm` | 600-800vp | 手机横屏/小平板 |
| `md` | 800-1200vp | 平板 |
| `lg` | ≥ 1200vp | 大屏设备 |

## 三、使用示例

### 3.1 固定列宽

```typescript
GridRow({ columns: 12, gutter: 16 }) {
  GridCol({ span: 4 }) {
    Text('1/3')
      .width('100%')
      .height(100)
      .backgroundColor('#007DFF')
      .textAlign(TextAlign.Center)
  }
  GridCol({ span: 4 }) {
    Text('1/3')
      .width('100%')
      .height(100)
      .backgroundColor('#28A745')
      .textAlign(TextAlign.Center)
  }
  GridCol({ span: 4 }) {
    Text('1/3')
      .width('100%')
      .height(100)
      .backgroundColor('#FFC107')
      .textAlign(TextAlign.Center)
  }
}
```

### 3.2 响应式列

```typescript
GridRow({
  columns: 12,
  gutter: 16,
  breakpoints: {
    value: ['600vp', '800vp', '1200vp']
  }
}) {
  GridCol({
    span: {
      xs: 12,  // 手机：全宽
      sm: 6,   // 小屏：半宽
      md: 4,   // 平板：1/3
      lg: 3    // 大屏：1/4
    }
  }) {
    Text('Responsive Column')
      .width('100%')
      .height(100)
      .backgroundColor('#007DFF')
      .textAlign(TextAlign.Center)
  }
}
```

### 3.3 列偏移

```typescript
GridRow({ columns: 12, gutter: 16 }) {
  // 居中：偏移 3 列，占据 6 列
  GridCol({ span: 6, offset: 3 }) {
    Text('Centered')
      .width('100%')
      .height(100)
      .backgroundColor('#FFC107')
      .textAlign(TextAlign.Center)
  }
}
```

### 3.4 响应式偏移

```typescript
GridRow({ columns: 12 }) {
  GridCol({
    span: {
      xs: 12,
      sm: 6
    },
    offset: {
      xs: 0,   // 手机：不偏移
      sm: 3    // 小屏：偏移 3 列
    }
  }) {
    Text('Responsive Offset')
      .width('100%')
      .height(100)
      .backgroundColor('#007DFF')
      .textAlign(TextAlign.Center)
  }
}
```

### 3.5 卡片布局

```typescript
GridRow({ columns: 12, gutter: 16 }) {
  ForEach([1, 2, 3, 4, 5, 6], (item: number) => {
    GridCol({
      span: {
        xs: 12,
        sm: 6,
        md: 4,
        lg: 3
      }
    }) {
      Column() {
        Text(`Card ${item}`)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
        Text('Description here')
          .fontSize(14)
          .fontColor('#666666')
          .margin({ top: 8 })
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(8)
      .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })
    }
  })
}
```

### 3.6 嵌套布局

```typescript
GridRow({ columns: 12, gutter: 16 }) {
  // 主内容区：占据 8 列
  GridCol({ span: 8 }) {
    Column() {
      Text('Main Content')
        .fontSize(18)
        .margin({ bottom: 12 })

      // 嵌套栅格
      GridRow({ columns: 12, gutter: 8 }) {
        GridCol({ span: 6 }) {
          Text('Sub 1')
            .width('100%')
            .height(80)
            .backgroundColor('#E3F2FD')
            .textAlign(TextAlign.Center)
        }
        GridCol({ span: 6 }) {
          Text('Sub 2')
            .width('100%')
            .height(80)
            .backgroundColor('#E3F2FD')
            .textAlign(TextAlign.Center)
        }
      }
    }
    .width('100%')
  }

  // 侧边栏：占据 4 列
  GridCol({ span: 4 }) {
    Text('Sidebar')
      .width('100%')
      .height(180)
      .backgroundColor('#F5F5F5')
      .textAlign(TextAlign.Center)
  }
}
```

### 3.7 视觉重排（order）

```typescript
GridRow({ columns: 12, gutter: 16 }) {
  GridCol({ span: 4, order: 3 }) {
    Text('Order 3')
      .width('100%')
      .height(100)
      .backgroundColor('#DC3545')
      .textAlign(TextAlign.Center)
  }
  GridCol({ span: 4, order: 1 }) {
    Text('Order 1')
      .width('100%')
      .height(100)
      .backgroundColor('#28A745')
      .textAlign(TextAlign.Center)
  }
  GridCol({ span: 4, order: 2 }) {
    Text('Order 2')
      .width('100%')
      .height(100)
      .backgroundColor('#007DFF')
      .textAlign(TextAlign.Center)
  }
}
// 视觉顺序：Order 1, Order 2, Order 3
```

## 四、最佳实践

### 4.1 使用 span 而非固定宽度

```typescript
// ✅ 推荐：使用 span
GridRow({ columns: 12 }) {
  GridCol({ span: 6 }) {
    Text('Half')
  }
  GridCol({ span: 6 }) {
    Text('Half')
  }
}

// ❌ 避免：在 Column 内使用固定宽度
Row() {
  Text('Half')
    .width('50%')
  Text('Half')
    .width('50%')
}
```

### 4.2 响应式设计

```typescript
// ✅ 推荐：为不同断点设置不同 span
GridCol({
  span: {
    xs: 12,  // 手机：全宽
    sm: 6,   // 平板：半宽
    md: 4,   // 桌面：1/3
    lg: 3    // 大屏：1/4
  }
}) {
  Text('Responsive')
}

// ❌ 避免：固定 span 不适应不同屏幕
GridCol({ span: 6 }) {
  Text('Not Responsive')
}
```

### 4.3 合理使用 offset

```typescript
// ✅ 推荐：使用 offset 实现居中
GridRow({ columns: 12 }) {
  GridCol({ span: 6, offset: 3 }) {  // (12 - 6) / 2 = 3
    Text('Centered')
  }
}

// ❌ 避免：使用 margin 实现居中
GridRow({ columns: 12 }) {
  GridCol({ span: 6 }) {
    Text('Centered')
      .margin({ left: '25%' })  // 不推荐
  }
}
```

### 4.4 卡片内容宽度

```typescript
// ✅ 推荐：卡片内容设置 width('100%')
GridCol({ span: 4 }) {
  Column() {
    Text('Card Content')
  }
  .width('100%')  // 确保卡片填满栅格列
  .padding(16)
  .backgroundColor('#FFFFFF')
}

// ❌ 避免：不设置宽度
GridCol({ span: 4 }) {
  Column() {
    Text('Card Content')
  }
  // 缺少 width('100%')
  .padding(16)
}
```

## 五、常见问题

### Q1: GridCol 内容为什么不显示？

**解决方案**:
```typescript
// 确保设置了内容的宽度
GridCol({ span: 6 }) {
  Text('Content')
    .width('100%')  // 必须设置宽度
    .height(80)
}
```

### Q2: 响应式布局不生效？

**解决方案**:
```typescript
// 确保 GridRow 配置了断点
GridRow({
  columns: 12,
  gutter: 16,
  breakpoints: {
    value: ['600vp', '800vp', '1200vp']  // 必须配置断点
  }
}) {
  GridCol({
    span: {
      xs: 12,
      sm: 6,
      md: 4,
      lg: 3
    }
  }) {
    Text('Responsive')
  }
}
```

### Q3: 如何实现列之间有间距？

**解决方案**:
```typescript
// 使用 gutter 而非 margin
GridRow({ columns: 12, gutter: 16 }) {  // ✅ 推荐
  GridCol({ span: 6 }) {
    Text('Item 1')
  }
  GridCol({ span: 6 }) {
    Text('Item 2')
  }
}

// ❌ 避免：使用 margin
GridRow({ columns: 12 }) {
  GridCol({ span: 6 }) {
    Text('Item 1')
      .margin({ right: 8 })  // 不推荐
  }
}
```

### Q4: span 超过 12 会怎样？

**解决方案**:
```typescript
// span 不能超过父容器的 columns 值
GridRow({ columns: 12 }) {
  GridCol({ span: 12 }) {  // ✅ 正确
    Text('Full Width')
  }
}

// ❌ 错误：span 超过 12
GridRow({ columns: 12 }) {
  GridCol({ span: 13 }) {  // 会报错
    Text('Overflow')
  }
}
```

## 六、常见问题与陷阱 (Common Pitfalls)

### ❌ GridRow/GridCol 在 SDK 6.0.1 中的 API 限制

**问题：**
GridRow 和 GridCol 组件在 HarmonyOS SDK 6.0.1 中的 API 支持不完整，多个属性和方法不可用。

**不支持的 API：**
- `GridRow().columnsTemplate()` - 不存在此属性方法
- `GridRow().columnsGap()` - 不存在，使用构造参数 `gutter`
- `GridRow().rowsGap()` - 不支持
- 响应式断点功能可能不完整

**错误示例：**
```typescript
// ❌ WRONG: 尝试使用 columnsTemplate 属性
GridRow()
  .columnsTemplate('1fr 1fr 1fr')  // Error: Property does not exist
```

**正确用法：**
```typescript
// ✅ CORRECT: 使用构造参数
GridRow({
  columns: 3,      // 列数
  gutter: 16        // 间距
}) {
  GridCol({ span: 1 }) {
    Text('Item')
  }
}
```

**替代方案：**
由于 GridRow/GridCol 在 SDK 6.0.1 中的限制，建议使用以下布局方式：

```typescript
// 方案1: 使用 Flex + 权重
Column() {
  Row() {
    Column()
      .layoutWeight(1)  // 1/3 宽度
    Column()
      .layoutWeight(1)  // 1/3 宽度
    Column()
      .layoutWeight(1)  // 1/3 宽度
  }
  .width('100%')
}

// 方案2: 使用百分比宽度
Row() {
  Column()
    .width('33.3%')
  Column()
    .width('33.3%')
  Column()
    .width('33.3%')
}
```

**SDK 版本注意事项：**
- SDK 6.0.1 中 GridRow/GridCol API 不完整
- 推荐使用 Flex、Column、Row 等基础布局组件
- 如必须使用栅格系统，建议手动计算宽度或使用 layoutWeight

---

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 12+ | ✅ | 完全支持 |
| API 11- | ❌ | 不支持 |

## 七、参考资料

- [GridCol 栅格子组件 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-gridcol-V5)
- [GridRow 栅格容器 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-gridrow-V5)
- [通用属性 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-universal-attributes-size-V5)
