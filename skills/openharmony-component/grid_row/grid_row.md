# GridRow 组件 HarmonyOS 6.0 开发 Skill

## 概述

GridRow 是 OpenHarmony 栅格布局系统中的容器组件，用于实现响应式网格布局。它将空间划分为 12 列，支持自定义断点、间距和排列方向，是实现自适应布局的理想选择。类似于 Bootstrap 的栅格系统。

## 重要说明

- **基础组件**: GridRow 是 ArkUI 的内置容器组件，无需导入
- **栅格系统**: 基于 12 列栅格系统
- **断点系统**: 支持 xs、sm、md、lg 四个断点
- **响应式**: 根据窗口大小自动调整布局
- **子组件**: 只能包含 GridCol 作为直接子组件

## 模块信息

- **组件名称**: GridRow
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [GridRow 栅格容器 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-gridrow-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// GridRow 是内置组件，无需导入
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
// 默认 12 列
GridRow() {
  GridCol() {
    Text('Item 1')
  }
  GridCol() {
    Text('Item 2')
  }
}

// 自定义列数和间距
GridRow({ columns: 12, gutter: 16 }) {
  GridCol({ span: 6 }) {
    Text('Half Width')
  }
  GridCol({ span: 6 }) {
    Text('Half Width')
  }
}

// 配置断点
GridRow({
  columns: 12,
  gutter: 16,
  breakpoints: {
    value: ['600vp', '800vp', '1200vp']
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

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| options | `GridRowOptions` | 否 | - | 栅格容器配置 |

### 2.2 GridRowOptions 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `columns` | `number` | 12 | 栅格总列数（通常为 12） |
| `gutter` | `number \| string \| Resource` | 0 | 栅格列之间的间距 |
| `breakpoints` | `Breakpoints` | 系统默认 | 断点配置 |
| `direction` | `GridRowDirection` | GridRowDirection.Row | 排列方向 |

### 2.3 Breakpoints 断点配置

```typescript
interface Breakpoints {
  value: Array<string>;  // 断点值数组，单位 vp
  reference?: BreakpointsReference;  // 断点参考对象
}
```

#### 默认断点

| 断点 | 宽度范围 | 设备类型 |
|------|----------|----------|
| `xs` | < 600vp | 手机竖屏 |
| `sm` | 600-800vp | 手机横屏/小平板 |
| `md` | 800-1200vp | 平板 |
| `lg` | ≥ 1200vp | 大屏设备 |

#### BreakpointsReference

| 值 | 描述 |
|------|------|
| `BreakpointsReference.WindowSize` | 基于窗口大小（默认） |
| `BreakpointsReference.ComponentSize` | 基于组件大小 |

### 2.4 GridRowDirection 排列方向

| 值 | 描述 |
|------|------|
| `GridRowDirection.Row` | 横向排列（默认） |
| `GridRowDirection.RowReverse` | 横向反向排列 |

## 三、使用示例

### 3.1 基础栅格

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
.width('100%')
.padding(16)
```

### 3.2 响应式栅格

```typescript
GridRow({
  columns: 12,
  gutter: 16,
  breakpoints: {
    value: ['600vp', '800vp', '1200vp']
  }
}) {
  ForEach([1, 2, 3, 4], (item: number) => {
    GridCol({
      span: {
        xs: 12,  // 手机：全宽
        sm: 6,   // 小屏：半宽
        md: 4,   // 平板：1/3
        lg: 3    // 大屏：1/4
      }
    }) {
      Text(`Item ${item}`)
        .width('100%')
        .height(100)
        .backgroundColor('#007DFF')
        .textAlign(TextAlign.Center)
    }
  })
}
.width('100%')
```

### 3.3 自定义断点

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
      .textAlign(TextAlign.Center)
  }
}
```

### 3.4 不同间距

```typescript
Column() {
  Text('Small Gutter')
    .fontSize(16)
    .margin({ bottom: 8 })

  GridRow({ columns: 12, gutter: 8 }) {
    GridCol({ span: 6 }) {
      Text('Item 1')
        .width('100%')
        .height(80)
        .backgroundColor('#007DFF')
        .textAlign(TextAlign.Center)
    }
    GridCol({ span: 6 }) {
      Text('Item 2')
        .width('100%')
        .height(80)
        .backgroundColor('#28A745')
        .textAlign(TextAlign.Center)
    }
  }
  .width('100%')

  Text('Large Gutter')
    .fontSize(16)
    .margin({ top: 16, bottom: 8 })

  GridRow({ columns: 12, gutter: 24 }) {
    GridCol({ span: 6 }) {
      Text('Item 1')
        .width('100%')
        .height(80)
        .backgroundColor('#007DFF')
        .textAlign(TextAlign.Center)
    }
    GridCol({ span: 6 }) {
      Text('Item 2')
        .width('100%')
        .height(80)
        .backgroundColor('#28A745')
        .textAlign(TextAlign.Center)
    }
  }
  .width('100%')
}
```

### 3.5 嵌套栅格

```typescript
GridRow({ columns: 12, gutter: 16 }) {
  // 主内容区
  GridCol({ span: 8 }) {
    Column() {
      Text('Main Content')
        .fontSize(18)
        .margin({ bottom: 12 })

      // 内层嵌套栅格
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

  // 侧边栏
  GridCol({ span: 4 }) {
    Text('Sidebar')
      .width('100%')
      .height(180)
      .backgroundColor('#F5F5F5')
      .textAlign(TextAlign.Center)
  }
}
.width('100%')
```

### 3.6 卡片网格布局

```typescript
GridRow({
  columns: 12,
  gutter: 16,
  breakpoints: {
    value: ['600vp', '800vp', '1200vp']
  }
}) {
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
        Text('Card description goes here')
          .fontSize(14)
          .fontColor('#666666')
          .margin({ top: 8 })
        Button('Action')
          .margin({ top: 12 })
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(8)
      .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })
      .alignItems(HorizontalAlign.Start)
    }
  })
}
.width('100%')
.padding(16)
.backgroundColor('#F5F5F5')
```

### 3.7 基于组件大小的断点

```typescript
GridRow({
  columns: 12,
  gutter: 16,
  breakpoints: {
    value: ['300vp', '500vp', '700vp'],
    reference: BreakpointsReference.ComponentSize  // 基于组件大小
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
    Text('Component Size Based')
      .width('100%')
      .height(100)
      .backgroundColor('#007DFF')
      .textAlign(TextAlign.Center)
  }
}
.width('80%')  // 容器宽度为 80%
```

### 3.8 反向排列

```typescript
GridRow({
  columns: 12,
  gutter: 16,
  direction: GridRowDirection.RowReverse
}) {
  GridCol({ span: 4 }) {
    Text('First')
      .width('100%')
      .height(80)
      .backgroundColor('#007DFF')
      .textAlign(TextAlign.Center)
  }
  GridCol({ span: 4 }) {
    Text('Second')
      .width('100%')
      .height(80)
      .backgroundColor('#28A745')
      .textAlign(TextAlign.Center)
  }
  GridCol({ span: 4 }) {
    Text('Third')
      .width('100%')
      .height(80)
      .backgroundColor('#FFC107')
      .textAlign(TextAlign.Center)
  }
}
// 视觉顺序：Third, Second, First
```

## 四、最佳实践

### 4.1 始终设置宽度

```typescript
// ✅ 推荐：设置 width('100%')
GridRow({ columns: 12, gutter: 16 }) {
  GridCol({ span: 6 }) {
    Text('Content')
  }
}
.width('100%')  // 必须设置

// ❌ 避免：不设置宽度
GridRow({ columns: 12, gutter: 16 }) {
  GridCol({ span: 6 }) {
    Text('Content')
  }
}
// 缺少 .width('100%')
```

### 4.2 使用 gutter 而非 margin

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
// ✅ 推荐：配置断点并使用响应式 span
GridRow({
  columns: 12,
  gutter: 16,
  breakpoints: {
    value: ['600vp', '800vp', '1200vp']
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

// ❌ 避免：固定 span 不适应不同屏幕
GridRow({ columns: 12 }) {
  GridCol({ span: 6 }) {
    Text('Not Responsive')
  }
}
```

### 4.4 合理设置列数

```typescript
// ✅ 推荐：使用默认 12 列（灵活性最高）
GridRow({ columns: 12, gutter: 16 }) {
  GridCol({ span: 6 }) {  // 6/12 = 1/2
    Text('Half')
  }
}

// ⚠️ 谨慎：使用其他列数
GridRow({ columns: 4, gutter: 16 }) {  // 不太灵活
  GridCol({ span: 2 }) {  // 2/4 = 1/2
    Text('Half')
  }
}
```

### 4.5 结合 Scroll 使用

```typescript
// ✅ 推荐：可滚动的栅格布局
Scroll() {
  GridRow({
    columns: 12,
    gutter: 16,
    breakpoints: {
      value: ['600vp', '800vp', '1200vp']
    }
  }) {
    ForEach(Array.from({ length: 20 }, (_, i) => i + 1), (item: number) => {
      GridCol({
        span: {
          xs: 12,
          sm: 6,
          md: 4,
          lg: 3
        }
      }) {
        Text(`Item ${item}`)
          .width('100%')
          .height(100)
          .backgroundColor('#007DFF')
          .textAlign(TextAlign.Center)
      }
    })
  }
  .width('100%')
}
.width('100%')
.height('100%')
```

## 五、常见问题

### Q1: GridRow 为什么不显示？

**解决方案**:
```typescript
// 确保设置了 width
GridRow({ columns: 12, gutter: 16 }) {
  GridCol({ span: 6 }) {
    Text('Content')
      .width('100%')  // 内容也要设置宽度
      .height(80)
  }
}
.width('100%')  // 必须设置容器宽度
```

### Q2: 响应式布局不生效？

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

### Q3: gutter 为什么不生效？

**解决方案**:
```typescript
// gutter 必须在 GridRow 构造时设置
GridRow({ columns: 12, gutter: 16 }) {  // ✅ 正确
  GridCol({ span: 6 }) {
    Text('Item 1')
  }
  GridCol({ span: 6 }) {
    Text('Item 2')
  }
}

// ❌ 错误：gutter 不能通过链式调用设置
GridRow({ columns: 12 })
  .gutter(16)  // 不存在此方法
```

### Q4: 如何实现垂直居中？

**解决方案**:
```typescript
// GridRow 本身不控制垂直对齐
// 需要在父容器中设置
Column() {
  GridRow({ columns: 12, gutter: 16 }) {
    GridCol({ span: 6 }) {
      Text('Left')
    }
    GridCol({ span: 6 }) {
      Text('Right')
    }
  }
  .width('100%')
}
.width('100%')
.height('100%')
.justifyContent(FlexAlign.Center)  // 父容器设置垂直居中
```

### Q5: 如何实现自适应列数？

**解决方案**:
```typescript
// 使用响应式 span
GridRow({
  columns: 12,
  gutter: 16,
  breakpoints: {
    value: ['600vp', '800vp', '1200vp']
  }
}) {
  // 小屏 1 列，中屏 2 列，大屏 3 列，超大屏 4 列
  ForEach([1, 2, 3, 4], (item: number) => {
    GridCol({
      span: {
        xs: 12,  // 12/12 = 1 列
        sm: 6,   // 12/6 = 2 列
        md: 4,   // 12/4 = 3 列
        lg: 3    // 12/3 = 4 列
      }
    }) {
      Text(`Item ${item}`)
    }
  })
}
```

## 六、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 12+ | ✅ | 完全支持 |
| API 11- | ❌ | 不支持 |

## 七、参考资料

- [GridRow 栅格容器 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-gridrow-V5)
- [GridCol 栅格子组件 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-gridcol-V5)
- [通用属性 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-universal-attributes-size-V5)
