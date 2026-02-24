# GridCol 和 GridRow 组件 HarmonyOS 6.0 开发 Skill

## 概述

GridRow 和 GridCol 是 OpenHarmony 中的栅格布局组件，用于实现响应式网格布局。GridRow 作为栅格容器，将空间划分为 12 列，GridCol 作为栅格子组件，可以指定占据的列数。这套系统类似于 Bootstrap 的栅格系统，是实现自适应布局的理想选择。

## 重要说明

- **基础组件**: GridRow 和 GridCol 是 ArkUI 的内置容器组件，无需导入
- **栅格系统**: 基于 12 列栅格系统
- **断点系统**: 支持 xs、sm、md、lg 四个断点
- **响应式**: 根据窗口大小自动调整布局

## 模块信息

- **组件名称**: GridRow, GridCol
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [GridRow 栅格容器 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-gridrow-V5)
  - [GridCol 栅格子组件 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-gridcol-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// GridRow 和 GridCol 是内置组件，无需导入
// 直接使用即可
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
// 简单的栅格布局
GridRow() {
  GridCol() {
    Text('Item 1')
  }
  GridCol() {
    Text('Item 2')
  }
  GridCol() {
    Text('Item 3')
  }
}

// 指定列数
GridRow() {
  GridCol({ span: 6 }) {  // 占据 6 列（50%）
    Text('Half Width')
  }
  GridCol({ span: 6 }) {  // 占据 6 列（50%）
    Text('Half Width')
  }
}
```

## 二、API 参数

### 2.1 GridRow 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| options | `GridRowOptions` | 否 | - | 栅格容器配置 |

### 2.2 GridRowOptions 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `columns` | `number` | 12 | 栅格总列数 |
| `gutter` | `number \| string \| Resource` | 0 | 栅格间距 |
| `breakpoints` | `Breakpoints` | - | 断点配置 |
| `direction` | `GridRowDirection` | GridRowDirection.Row | 排列方向 |

### 2.3 GridCol 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| options | `GridColOptions` | 否 | - | 栅格子组件配置 |

### 2.4 GridColOptions 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `span` | `number` | 1 | 占据的列数 |
| `offset` | `number` | 0 | 偏移的列数 |
| `order` | `number` | 0 | 排序顺序 |

### 2.5 响应式断点

| 断点 | 设备宽度 | 适用场景 |
|------|----------|----------|
| `xs` | < 600px | 手机竖屏 |
| `sm` | 600px - 800px | 手机横屏/小平板 |
| `md` | 800px - 1200px | 平板 |
| `lg` | ≥ 1200px | 大屏设备 |

## 三、使用示例

### 3.1 等分布局

```typescript
GridRow({ columns: 12, gutter: 16 }) {
  GridCol({ span: 4 }) {
    Text('1/3')
      .width('100%')
      .height(100)
      .backgroundColor('#FFC107')
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
      .backgroundColor('#007DFF')
      .textAlign(TextAlign.Center)
  }
}
.width('100%')
.padding(16)
```

### 3.2 响应式布局

```typescript
GridRow({
  columns: 12,
  gutter: 16,
  breakpoints: {
    value: ['600vp', '800vp', '1200vp']
  }
}) {
  // 小屏幕：12 列（全宽）
  // 中等屏幕：6 列（半宽）
  // 大屏幕：4 列（1/3）
  GridCol({
    span: {
      xs: 12,
      sm: 6,
      md: 4,
      lg: 3
    }
  }) {
    Text('Responsive')
      .width('100%')
      .height(100)
      .backgroundColor('#007DFF')
      .fontColor(Color.White)
      .textAlign(TextAlign.Center)
  }
}
.width('100%')
.padding(16)
```

### 3.3 列偏移

```typescript
GridRow({ columns: 12, gutter: 16 }) {
  // 左侧空白 3 列，内容占据 6 列
  GridCol({ span: 6, offset: 3 }) {
    Text('Offset 3')
      .width('100%')
      .height(100)
      .backgroundColor('#FFC107')
      .textAlign(TextAlign.Center)
  }
}
.width('100%')
.padding(16)
```

### 3.4 嵌套栅格

```typescript
GridRow({ columns: 12, gutter: 16 }) {
  // 外层：占据 8 列
  GridCol({ span: 8 }) {
    Column() {
      Text('Main Content')
        .fontSize(18)
        .margin({ bottom: 12 })

      // 内层：嵌套栅格
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

  // 外层：占据 4 列
  GridCol({ span: 4 }) {
    Text('Sidebar')
      .width('100%')
      .height(180)
      .backgroundColor('#F5F5F5')
      .textAlign(TextAlign.Center)
  }
}
.width('100%')
.padding(16)
```

### 3.5 卡片网格

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
        Text('Description')
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
.width('100%')
.padding(16)
.backgroundColor('#F5F5F5')
```

### 3.6 自定义断点

```typescript
GridRow({
  columns: 12,
  gutter: 16,
  breakpoints: {
    value: ['400vp', '700vp', '1000vp'],
    reference: BreakpointsReference.WindowSize
  }
}) {
  GridCol({
    span: {
      xs: 12,  // < 400vp: 全宽
      sm: 6,   // 400-700vp: 半宽
      md: 4,   // 700-1000vp: 1/3
      lg: 3    // ≥ 1000vp: 1/4
    }
  }) {
    Text('Custom Breakpoint')
      .width('100%')
      .height(100)
      .backgroundColor('#007DFF')
      .fontColor(Color.White)
      .textAlign(TextAlign.Center)
  }
}
.width('100%')
.padding(16)
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

// ❌ 避免：使用固定宽度
Row() {
  Text('Half')
    .width('50%')
  Text('Half')
    .width('50%')
}
```

### 4.2 合理设置间距

```typescript
// ✅ 推荐：使用 gutter
GridRow({ columns: 12, gutter: 16 }) {
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
      .margin({ right: 8 })
  }
  GridCol({ span: 6 }) {
    Text('Item 2')
  }
}
```

### 4.3 响应式设计

```typescript
// ✅ 推荐：为不同断点设置不同的 span
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

## 五、常见问题

### Q1: 栅格列为什么不显示？

**解决方案**:
```typescript
// 确保设置了 GridRow 的宽度
GridRow({ columns: 12, gutter: 16 }) {
  GridCol({ span: 6 }) {
    Text('Content')
  }
}
.width('100%')  // 必须设置宽度
```

### Q2: 如何实现居中对齐？

**解决方案**:
```typescript
// 使用 offset 实现居中
GridRow({ columns: 12 }) {
  GridCol({ span: 6, offset: 3 }) {  // (12 - 6) / 2 = 3
    Text('Centered')
  }
}
.width('100%')
```

### Q3: 响应式布局不生效？

**解决方案**:
```typescript
// 确保正确配置断点
GridRow({
  columns: 12,
  gutter: 16,
  breakpoints: {
    value: ['600vp', '800vp', '1200vp'],  // 断点值
    reference: BreakpointsReference.WindowSize  // 参考对象
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

## 六、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 12+ | ✅ | 完全支持 |

## 七、参考资料

- [GridRow 栅格容器 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-gridrow-V5)
- [GridCol 栅格子组件 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-gridcol-V5)
- [通用属性 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-universal-attributes-size-V5)
