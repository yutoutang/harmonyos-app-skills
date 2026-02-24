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
// 简单的瀑布流
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
.columnsTemplate('1fr 1fr')  // 2 列
.columnsGap(10)
.rowsGap(10)
.width('100%')
.height('100%')
```

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
| `columnsTemplate` | `string` | '1fr' | 列模板，如 '1fr 1fr 1fr' 表示 3 列 |
| `rowsTemplate` | `string` | - | 行模板 |
| `columnsGap` | `number \| string` | 0 | 列间距 |
| `rowsGap` | `number \| string` | 0 | 行间距 |
| `padding` | `Padding \| Length` | 0 | 内边距 |

### 2.4 FlowItem 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `width` | `number \| string` | - | 宽度 |
| `height` | `number \| string` | - | 高度 |
| `backgroundColor` | `ResourceColor` | - | 背景色 |

## 三、使用示例

### 3.1 基础瀑布流

```typescript
@State data: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

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
.columnsTemplate('1fr 1fr')
.columnsGap(12)
.rowsGap(12)
.width('100%')
.height('100%')
.padding(12)
.backgroundColor('#F5F5F5')
```

### 3.2 三列瀑布流

```typescript
@State data: string[] = Array.from({ length: 15 }, (_, i) => `Item ${i + 1}`)

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
.columnsTemplate('1fr 1fr 1fr')
.columnsGap(12)
.rowsGap(12)
.width('100%')
.height('100%')
.padding(12)
```

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

### 4.1 合理设置列数

```typescript
// ✅ 推荐：根据屏幕尺寸设置列数
WaterFlow() {
  ForEach(items, (item) => {
    FlowItem() {
      Text(item)
    }
  })
}
.columnsTemplate('1fr 1fr')  // 2 列适合手机
.columnsGap(12)
.rowsGap(12)

// ⚠️ 注意：列数过多可能导致内容过小
WaterFlow() {
  ForEach(items, (item) => {
    FlowItem() {
      Text(item)
    }
  })
}
.columnsTemplate('1fr 1fr 1fr 1fr 1fr')  // 列数过多
```

### 4.2 设置合适的间距

```typescript
// ✅ 推荐：使用 columnsGap 和 rowsGap
WaterFlow() {
  ForEach(items, (item) => {
    FlowItem() {
      Text(item)
    }
  })
}
.columnsTemplate('1fr 1fr')
.columnsGap(12)  // 列间距
.rowsGap(12)     // 行间距
.padding(12)     // 内边距
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

**解决方案**:
```typescript
@State columnsTemplate: string = '1fr 1fr';

WaterFlow() {
  ForEach(items, (item) => {
    FlowItem() {
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

## 六、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 12+ | ✅ | 完全支持 |

## 七、参考资料

- [WaterFlow 瀑布流 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-waterflow-V5)
- [通用属性 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-universal-attributes-size-V5)
