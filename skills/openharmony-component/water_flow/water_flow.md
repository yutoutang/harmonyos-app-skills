# WaterFlow 组件 HarmonyOS 6.0 开发 Skill

## 概述

WaterFlow 是 OpenHarmony 中的瀑布流布局组件，支持子组件按照固定列数或自适应列数排列，每列中的子组件高度可以不同，形成瀑布流效果。它适用于图片展示、商品列表等场景。

## 重要说明

- **基础组件**: WaterFlow 是 ArkUI 的内置容器组件，无需导入
- **布局方式**: 瀑布流布局
- **多列支持**: 支持固定列数或自适应列数
- **性能优化**: 支持懒加载和复用

## 模块信息

- **组件名称**: WaterFlow
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [WaterFlow 瀑布流 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-waterflow-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// WaterFlow 是内置组件，无需导入
// 直接使用即可
WaterFlow() {
  FlowItem() {
    Text('Item 1')
  }
  FlowItem() {
    Text('Item 2')
  }
}
```

### 1.2 基础用法

```typescript
// 简单的瀑布流（SDK 6.0.1）
WaterFlow() {
  ForEach([1, 2, 3, 4, 5, 6], (item: number) => {
    FlowItem() {
      Text(`Item ${item}`)
        .width('100%')
        .height(100 + item * 20)
        .backgroundColor('#007DFF')
        .fontColor(Color.White)
        .textAlign(TextAlign.Center)
    }
  })
}
.width('100%')
.height('100%')
.padding(10)
.backgroundColor('#F5F5F5')
```

**注意：** SDK 6.0.1 不支持 `columnsTemplate`、`columnsGap`、`rowsGap` 参数。列布局由系统自动管理。

## 二、API 参数

### 2.1 WaterFlow 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| options | `WaterFlowOptions` | 否 | - | 瀑布流配置 |

### 2.2 WaterFlowOptions 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `itemConstraintSize` | `SizeConstraint` | - | 流式布局尺寸约束 |

### 2.3 WaterFlow 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `columnsTemplate` | `string` | '1fr' | 列模板，如 '1fr 1fr 1fr' 表示 3 列 ⚠️ SDK 6.0.1 不支持 |
| `rowsTemplate` | `string` | - | 行模板 |
| `columnsGap` | `number \| string` | 0 | 列间距 ⚠️ SDK 6.0.1 不支持 |
| `rowsGap` | `number \| string` | 0 | 行间距 ⚠️ SDK 6.0.1 不支持 |
| `padding` | `Padding \| Length` | 0 | 内边距 |

**SDK 6.0.1 限制：** `columnsTemplate`、`columnsGap`、`rowsGap` 在 SDK 6.0.1 中不可用。请使用简化的 `WaterFlow()` 构造函数。

### 2.4 FlowItem 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `width` | `number \| string` | - | 宽度 |
| `height` | `number \| string` | - | 高度 |
| `backgroundColor` | `ResourceColor` | - | 背景色 |

## 三、使用示例

### 3.1 基础瀑布流

```typescript
// SDK 6.0.1 兼容写法
@Local data: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

WaterFlow() {
  ForEach(this.data, (item: number) => {
    FlowItem() {
      Text(`Item ${item}`)
        .fontSize(16)
        .width('100%')
        .height(100 + (item % 5) * 30)
        .backgroundColor('#007DFF')
        .fontColor(Color.White)
        .borderRadius(8)
        .textAlign(TextAlign.Center)
    }
  })
}
.width('100%')
.height('100%')
.padding(12)
.backgroundColor('#F5F5F5')
```

**注意：** SDK 6.0.1 不支持 `.columnsTemplate()`、`.columnsGap()`、`.rowsGap()` 属性方法。

### 3.2 三列瀑布流

```typescript
// SDK 6.0.1 兼容写法（列布局由系统自动管理）
@Local data: string[] = Array.from({ length: 15 }, (_, i) => `Item ${i + 1}`)

WaterFlow() {
  ForEach(this.data, (item: string, index: number) => {
    FlowItem() {
      Column() {
        Text(`${index + 1}`)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
        Text(item)
          .fontSize(14)
          .fontColor(Color.White)
          .margin({ top: 8 })
      }
      .width('100%')
      .height(120 + (index % 4) * 40)
      .padding(16)
      .backgroundColor('#28A745')
      .borderRadius(8)
      .justifyContent(FlexAlign.Center)
    }
  })
}
.width('100%')
.height('100%')
.padding(12)
```

**注意：** SDK 6.0.1 不支持指定列数，布局由系统自动管理。如需精确控制列数，建议使用 Grid 组件。

### 3.3 图片瀑布流

```typescript
@State images: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

WaterFlow() {
  ForEach(this.images, (item: number) => {
    FlowItem() {
      Column() {
        Image($r('app.media.icon'))
          .width('100%')
          .height(100 + (item % 3) * 50)
          .objectFit(ImageFit.Cover)
          .borderRadius({ topLeft: 8, topRight: 8 })

        Text(`Image ${item}`)
          .fontSize(14)
          .margin({ top: 8 })
      }
      .width('100%')
      .backgroundColor('#FFFFFF')
      .borderRadius(8)
      .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })
    }
  })
}
.columnsTemplate('1fr 1fr')
.columnsGap(12)
.rowsGap(12)
.width('100%')
.height('100%')
.padding(12)
.backgroundColor('#F5F5F5')
```

### 3.4 可滚动瀑布流

```typescript
@State data: number[] = Array.from({ length: 50 }, (_, i) => i + 1)

WaterFlow() {
  ForEach(this.data, (item: number) => {
    FlowItem() {
      Column() {
        Text(`Card ${item}`)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
        Text('Description text here')
          .fontSize(14)
          .fontColor('#666666')
          .margin({ top: 8 })
      }
      .width('100%')
      .height(80 + (item % 6) * 30)
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(8)
      .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })
    }
  })
}
.columnsTemplate('1fr 1fr')
.columnsGap(12)
.rowsGap(12)
.width('100%')
.height('100%')
.padding(12)
.backgroundColor('#F5F5F5')
```

### 3.5 自定义列宽

```typescript
WaterFlow() {
  ForEach([1, 2, 3, 4, 5, 6], (item: number) => {
    FlowItem() {
      Text(`Item ${item}`)
        .fontSize(16)
        .width('100%')
        .height(100 + item * 20)
        .backgroundColor('#FFC107')
        .fontColor(Color.White)
        .textAlign(TextAlign.Center)
        .borderRadius(8)
    }
  })
}
.columnsTemplate('1fr 2fr 1fr')  // 列宽比例 1:2:1
.columnsGap(12)
.rowsGap(12)
.width('100%')
.height('100%')
.padding(12)
```

### 3.6 带头部的瀑布流

```typescript
WaterFlow() {
  // 头部
  FlowItem() {
    Column() {
      Text('Water Flow Header')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
      Text('Swipe down to see more')
        .fontSize(14)
        .fontColor('#666666')
        .margin({ top: 8 })
    }
    .width('100%')
    .height(120)
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(8)
    .justifyContent(FlexAlign.Center)
  }
  .columnStart(0)
  .columnEnd(1)

  // 内容
  ForEach([1, 2, 3, 4, 5, 6], (item: number) => {
    FlowItem() {
      Text(`Item ${item}`)
        .fontSize(16)
        .width('100%')
        .height(100 + item * 20)
        .backgroundColor('#007DFF')
        .fontColor(Color.White)
        .textAlign(TextAlign.Center)
        .borderRadius(8)
    }
  })
}
.columnsTemplate('1fr 1fr')
.columnsGap(12)
.rowsGap(12)
.width('100%')
.height('100%')
.padding(12)
.backgroundColor('#F5F5F5')
```

## 四、最佳实践

### 4.1 WaterFlow 在 SDK 6.0.1 中的使用限制

```typescript
// ✅ 推荐：SDK 6.0.1 使用简化 API
WaterFlow() {
  ForEach(items, (item) => {
    FlowItem() {
      Text(item)
        .width('100%')
        .height(100 + Math.random() * 100)
    }
  })
}
.width('100%')
.height('100%')
.padding(12)

// ❌ 避免：尝试设置列数（SDK 6.0.1 不支持）
WaterFlow() {
  ForEach(items, (item) => {
    FlowItem() {
      Text(item)
    }
  })
}
.columnsTemplate('1fr 1fr')  // SDK 6.0.1 中不可用
.columnsGap(12)              // SDK 6.0.1 中不可用
.rowsGap(12)                 // SDK 6.0.1 中不可用
```

### 4.2 替代方案：使用 Grid 实现固定列布局

如需精确控制列数和间距，建议使用 Grid 组件：

```typescript
// ✅ 推荐：使用 Grid 代替 WaterFlow（如需固定列数）
Grid() {
  ForEach(items, (item) => {
    GridItem() {
      Text(item)
        .width('100%')
        .height(100 + item * 20)
    }
  })
}
.columnsTemplate('1fr 1fr')  // ✅ Grid 支持列模板
.columnsGap(12)              // ✅ Grid 支持列间距
.rowsGap(12)                 // ✅ Grid 支持行间距
.width('100%')
.height('100%')
.padding(12)
```

### 4.3 使用 FlowItem 而非其他容器

```typescript
// ✅ 推荐：使用 FlowItem
WaterFlow() {
  ForEach(items, (item) => {
    FlowItem() {
      Text(item)
    }
  })
}

// ❌ 避免：使用其他容器
WaterFlow() {
  ForEach(items, (item) => {
    Column() {  // 应该使用 FlowItem
      Text(item)
    }
  })
}
```

## 五、常见问题

### Q1: 瀑布流不显示？

**解决方案**:
```typescript
// 确保设置了宽度和高度
WaterFlow() {
  ForEach(items, (item) => {
    FlowItem() {
      Text(item)
        .width('100%')  // FlowItem 必须设置宽度
        .height(100)    // FlowItem 必须设置高度
    }
  })
}
.columnsTemplate('1fr 1fr')
.columnsGap(12)
.rowsGap(12)
.width('100%')   // WaterFlow 必须设置宽度
.height('100%')  // WaterFlow 必须设置高度
```

### Q2: 如何实现自适应列数？

**问题：** SDK 6.0.1 不支持 `columnsTemplate`，无法动态调整列数。

**解决方案：** 使用 Grid 组件代替：
```typescript
@Local columnsTemplate: string = '1fr 1fr';

Grid() {
  ForEach(items, (item) => {
    GridItem() {
      Text(item)
    }
  })
}
.columnsTemplate(this.columnsTemplate)
.onAreaChange((oldValue: Area, newValue: Area) => {
  // 根据宽度调整列数
  if (newValue.width as number > 600) {
    this.columnsTemplate = '1fr 1fr 1fr';
  } else {
    this.columnsTemplate = '1fr 1fr';
  }
})
```

### Q3: FlowItem 高度不生效？

**解决方案**:
```typescript
// FlowItem 必须明确设置高度
FlowItem() {
  Column() {
    Text('Content')
  }
  .width('100%')
  .height(150)  // 必须设置高度
}
```

## 六、常见问题与陷阱 (Common Pitfalls)

### ❌ ERROR: Property 'columnsTemplate' does not exist on type 'WaterFlowAttribute'

**问题：**
在 HarmonyOS SDK 6.0.1 中，WaterFlow 组件不支持 `columnsTemplate`、`columnsGap`、`rowsGap` 作为属性方法或构造参数。

**错误信息：**
```
Property 'columnsTemplate' does not exist on type 'WaterFlowAttribute'
columnsTemplate does not exist in type 'WaterFlowOptions'
```

**错误用法：**
```typescript
// ❌ WRONG: columnsTemplate 不作为属性方法
WaterFlow()
  .columnsTemplate('1fr 1fr')  // ❌ Error
  .columnsGap(10)              // ❌ Error
  .rowsGap(10)                 // ❌ Error
```

```typescript
// ❌ WRONG: columnsTemplate 不作为构造参数
WaterFlow({
  columnsTemplate: '1fr 1fr',  // ❌ Error
  columnsGap: 10,              // ❌ Error
  rowsGap: 10                  // ❌ Error
}) {}
```

**正确用法：**
```typescript
// ✅ CORRECT: SDK 6.0.1 使用简化的 WaterFlow API
WaterFlow() {
  ForEach(this.dataSource, (item: number) => {
    FlowItem() {
      Text(`项目 ${item}`)
        .fontSize(16)
        .fontColor(Color.White)
    }
    .width('100%')
    .height(item % 2 === 0 ? 120 : 180)
    .backgroundColor(item % 2 === 0 ? '#2196F3' : '#4CAF50')
    .borderRadius(8)
    .justifyContent(FlexAlign.Center)
  })
}
.width('100%')
.height(400)
.padding(10)
.backgroundColor('#F5F5F5')
.borderRadius(8)
```

**关键点：**
- SDK 6.0.1 中 WaterFlow API 非常简化
- 不支持 `columnsTemplate`、`columnsGap`、`rowsGap` 参数
- 使用 FlowItem 控制布局，通过设置不同的高度实现瀑布流效果
- 列布局由系统自动管理

**替代方案：**
如果需要精确控制列数和间距，考虑使用：
1. **Grid + GridItem** - 适用于固定列网格布局
2. **Flex + Column** - 使用 layoutWeight 实现列布局
3. **List + ListItem** - 适用于列表型布局

```typescript
// 方案1: 使用 Grid 实现类似效果
Grid() {
  ForEach(this.dataSource, (item: number) => {
    GridItem() {
      Text(`项目 ${item}`)
    }
    .width('100%')
    .height(100)
    .backgroundColor('#007DFF')
  })
}
.columnsTemplate('1fr 1fr')
.columnsGap(8)
.rowsGap(8)
```

**SDK 版本注意事项：**
- SDK 6.0.1 中 WaterFlow API 极其有限
- 官方文档中描述的完整 API 可能在更高版本中才支持
- 开发时建议测试实际 API 可用性

---

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 12+ (SDK 6.0.1) | ⚠️ 部分 | 仅支持基础 WaterFlow()，不支持列/行配置参数 |
| API 12+ (高版本) | ✅ | 完整支持 columnsTemplate、columnsGap、rowsGap |

## 八、参考资料

- [WaterFlow 瀑布流 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-waterflow-V5)
- [通用属性 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-universal-attributes-size-V5)
