# GridContainer 组件 HarmonyOS 6.0 开发 Skill

## 概述

GridContainer 是 OpenHarmony 中的网格布局容器组件，提供了一种灵活的网格布局系统。它支持自定义列数、行高和间距，可以创建二维网格布局，适用于卡片展示、图片墙等场景。

## 重要说明

- **基础组件**: GridContainer 是 ArkUI 的内置容器组件，无需导入
- **布局方式**: 二维网格布局
- **灵活性**: 支持自定义列数、行高、间距
- **滚动**: 支持垂直滚动

## 模块信息

- **组件名称**: GridContainer
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [GridContainer 网格容器 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-gridcontainer-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// GridContainer 是内置组件，无需导入
// 直接使用即可
GridContainer() {
  GridItem() {
    Text('Item 1')
  }
  GridItem() {
    Text('Item 2')
  }
}
```

### 1.2 基础用法

```typescript
// 简单的网格布局
GridContainer({ columns: 3 }) {
  ForEach([1, 2, 3, 4, 5, 6], (item: number) => {
    GridItem() {
      Text(`Item ${item}`)
        .width('100%')
        .height(100)
        .backgroundColor('#007DFF')
        .fontColor(Color.White)
        .textAlign(TextAlign.Center)
    }
  })
}

// 设置间距
GridContainer({
  columns: 3,
  rows: 2,
  gap: 16
}) {
  ForEach([1, 2, 3, 4, 5, 6], (item: number) => {
    GridItem() {
      Text(`Item ${item}`)
    }
  })
}
```

## 二、API 参数

### 2.1 GridContainer 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| options | `GridContainerOptions` | 否 | - | 网格容器配置 |

### 2.2 GridContainerOptions 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `columns` | `number` | 1 | 列数 |
| `rows` | `number` | - | 行数（可选） |
| `gap` | `number \| string` | 0 | 网格项之间的间距 |
| `width` | `number \| string` | - | 容器宽度 |
| `height` | `number \| string` | - | 容器高度 |

### 2.3 GridItem 属性

GridItem 作为 GridContainer 的子组件，可以设置以下属性：

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `columnStart` | `number` | - | 起始列位置 |
| `columnEnd` | `number` | - | 结束列位置 |
| `rowStart` | `number` | - | 起始行位置 |
| `rowEnd` | `number` | - | 结束行位置 |

## 三、使用示例

### 3.1 基础网格

```typescript
GridContainer({ columns: 3, gap: 12 }) {
  ForEach([1, 2, 3, 4, 5, 6, 7, 8, 9], (item: number) => {
    GridItem() {
      Text(`Item ${item}`)
        .width('100%')
        .height(80)
        .backgroundColor('#007DFF')
        .fontColor(Color.White)
        .borderRadius(8)
        .textAlign(TextAlign.Center)
    }
  })
}
.width('100%')
.padding(16)
```

### 3.2 响应式网格

```typescript
GridContainer({ columns: 2, gap: 12 }) {
  ForEach([1, 2, 3, 4, 5, 6], (item: number) => {
    GridItem() {
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
      .height(120)
      .padding(12)
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

### 3.3 跨列跨行

```typescript
GridContainer({ columns: 4, gap: 12 }) {
  // 占据 2 列 2 行
  GridItem() {
    Text('Large Item')
      .width('100%')
      .height('100%')
      .backgroundColor('#FFC107')
      .textAlign(TextAlign.Center)
  }
  .columnStart(1)
  .columnEnd(2)
  .rowStart(1)
  .rowEnd(2)

  // 普通项
  ForEach([3, 4, 5, 6, 7, 8], (item: number) => {
    GridItem() {
      Text(`Item ${item}`)
        .width('100%')
        .height(80)
        .backgroundColor('#007DFF')
        .fontColor(Color.White)
        .textAlign(TextAlign.Center)
    }
  })
}
.width('100%')
.padding(16)
```

### 3.4 图片网格

```typescript
GridContainer({ columns: 3, gap: 8 }) {
  ForEach([1, 2, 3, 4, 5, 6, 7, 8, 9], (item: number) => {
    GridItem() {
      Image($r('app.media.icon'))
        .width('100%')
        .height(100)
        .objectFit(ImageFit.Cover)
        .borderRadius(8)
        .backgroundColor('#E0E0E0')
    }
  })
}
.width('100%')
.padding(16)
```

### 3.5 可滚动网格

```typescript
Scroll() {
  GridContainer({ columns: 2, gap: 12 }) {
    ForEach(Array.from({ length: 20 }, (_, i) => i + 1), (item: number) => {
      GridItem() {
        Column() {
          Text(`Item ${item}`)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
          Text('Content description')
            .fontSize(14)
            .fontColor('#999999')
            .margin({ top: 4 })
        }
        .width('100%')
        .height(100)
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(8)
      }
    })
  }
  .width('100%')
}
.width('100%')
.height('100%')
.padding(16)
.backgroundColor('#F5F5F5')
```

### 3.6 不规则布局

```typescript
GridContainer({ columns: 4, gap: 12 }) {
  // 主卡片：占据 2 列 2 行
  GridItem() {
    Text('Main Feature')
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
      .width('100%')
      .height('100%')
      .backgroundColor('#007DFF')
      .fontColor(Color.White)
      .textAlign(TextAlign.Center)
  }
  .columnStart(1)
  .columnEnd(2)
  .rowStart(1)
  .rowEnd(2)

  // 次要卡片
  ForEach([3, 4, 5, 6], (item: number) => {
    GridItem() {
      Text(`Feature ${item}`)
        .fontSize(14)
        .width('100%')
        .height(80)
        .backgroundColor('#E3F2FD')
        .textAlign(TextAlign.Center)
    }
  })
}
.width('100%')
.padding(16)
```

## 四、最佳实践

### 4.1 合理设置列数

```typescript
// ✅ 推荐：根据内容选择合适的列数
GridContainer({ columns: 3, gap: 12 }) {
  ForEach(items, (item) => {
    GridItem() {
      Text(item)
    }
  })
}

// ⚠️ 注意：列数过多可能导致内容过小
GridContainer({ columns: 10 }) {  // 列数过多
  ForEach(items, (item) => {
    GridItem() {
      Text(item)
    }
  })
}
```

### 4.2 使用 gap 设置间距

```typescript
// ✅ 推荐：使用 gap
GridContainer({ columns: 3, gap: 16 }) {
  ForEach(items, (item) => {
    GridItem() {
      Text(item)
    }
  })
}

// ❌ 避免：使用 margin
GridContainer({ columns: 3 }) {
  ForEach(items, (item) => {
    GridItem() {
      Text(item)
        .margin({ right: 8, bottom: 8 })
    }
  })
}
```

### 4.3 结合 Scroll 使用

```typescript
// ✅ 推荐：使用 Scroll 实现可滚动网格
Scroll() {
  GridContainer({ columns: 3, gap: 12 }) {
    ForEach(items, (item) => {
      GridItem() {
        Text(item)
      }
    })
  }
  .width('100%')
}
.width('100%')
.height('100%')
```

## 五、常见问题

### Q1: 网格项为什么不显示？

**解决方案**:
```typescript
// 确保设置了 GridContainer 的宽度
GridContainer({ columns: 3, gap: 12 }) {
  ForEach(items, (item) => {
    GridItem() {
      Text(item)
        .width('100%')  // 设置网格项宽度
        .height(80)     // 设置网格项高度
    }
  })
}
.width('100%')  // 必须设置容器宽度
```

### Q2: 如何实现跨列布局？

**解决方案**:
```typescript
// 使用 columnStart 和 columnEnd
GridContainer({ columns: 4, gap: 12 }) {
  GridItem() {
    Text('Spans 2 columns')
  }
  .columnStart(1)
  .columnEnd(2)

  GridItem() {
    Text('Normal')
  }
}
```

### Q3: 如何实现响应式网格？

**解决方案**:
```typescript
// 根据屏幕尺寸动态调整列数
@State columns: number = 2;

GridContainer({ columns: this.columns, gap: 12 }) {
  ForEach(items, (item) => {
    GridItem() {
      Text(item)
    }
  })
}
.onAreaChange((oldValue: Area, newValue: Area) => {
  // 根据宽度调整列数
  if (newValue.width as number > 600) {
    this.columns = 3;
  } else {
    this.columns = 2;
  }
})
```

## 六、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 12+ | ✅ | 完全支持 |

## 七、参考资料

- [GridContainer 网格容器 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-gridcontainer-V5)
- [通用属性 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-universal-attributes-size-V5)
