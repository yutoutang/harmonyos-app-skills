# GridItem 组件 HarmonyOS 6.0 开发 Skill

## 概述

GridItem 组件是 OpenHarmony 中 Grid 组件的子组件，用于表示网格中的单个网格项。每个 GridItem 必须作为 Grid 的直接子组件使用，支持跨列、跨行等布局特性。

## 重要说明

- **基础组件**: GridItem 是 ArkUI 的基础内置组件，无需导入
- **父组件要求**: 必须作为 Grid 的直接子组件
- **跨度支持**: 支持跨列（columnStart/columnEnd）和跨行（rowStart/rowEnd）
- **布局灵活**: 可以设置固定尺寸或使用自适应布局
- **渲染控制**: 支持 if/else、ForEach、LazyForEach

## 模块信息

- **组件名称**: GridItem
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [GridItem - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-griditem-V5)

## 一、API 参数

### 构造函数

```typescript
GridItem()
```

### 布局属性（跨度控制）

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| columnStart | number | 0 | 起始列索引 |
| columnEnd | number | - | 结束列索引 |
| rowStart | number | 0 | 起始行索引 |
| rowEnd | number | - | 结束行索引 |
| forceRebuild | boolean | false | 是否强制重建 |

### 通用属性

GridItem 支持以下通用属性：

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| width | Length | - | 宽度 |
| height | Length | - | 高度 |
| backgroundColor | ResourceColor | - | 背景颜色 |
| borderRadius | Length | - | 圆角半径 |
| margin | Padding | - | 外边距 |
| padding | Padding | - | 内边距 |
| onClick | () => void | - | 点击事件 |

## 二、使用示例

### 2.1 基础 GridItem

```typescript
@ComponentV2
struct BasicGridItemExample {
  @Local items: string[] = [
    'Item 1', 'Item 2', 'Item 3',
    'Item 4', 'Item 5', 'Item 6'
  ]

  build() {
    Grid() {
      ForEach(this.items, (item: string) => {
        GridItem() {
          Text(item)
            .width('100%')
            .height('100%')
            .fontSize(16)
            .textAlign(TextAlign.Center)
            .backgroundColor('#E3F2FD')
            .borderRadius(8)
        }
      })
    }
    .columnsTemplate('1fr 1fr 1fr')
    .rowsGap(12)
    .columnsGap(12)
    .width('100%')
    .height(300)
  }
}
```

### 2.2 自定义样式 GridItem

```typescript
@ComponentV2
struct CustomStyleGridItemExample {
  @Local icons: IconData[] = [
    { name: 'Home', symbol: '\uE639', color: '#007DFF' },
    { name: 'Search', symbol: '\uE8EF', color: '#28A745' },
    { name: 'Settings', symbol: '\uE640', color: '#FFC107' },
    { name: 'Profile', symbol: '\uE641', color: '#FF5252' },
    { name: 'Messages', symbol: '\uE642', color: '#9C27B0' },
    { name: 'Gallery', symbol: '\uE643', color: '#FF9800' }
  ]

  build() {
    Grid() {
      ForEach(this.icons, (icon: IconData) => {
        GridItem() {
          Column({ space: 8 }) {
            // 图标
            Text(icon.symbol)
              .fontSize(32)
              .fontColor(Color.White)
              .width(60)
              .height(60)
              .backgroundColor(icon.color)
              .borderRadius(30)
              .textAlign(TextAlign.Center)

            // 名称
            Text(icon.name)
              .fontSize(14)
              .fontColor('#333333')
              .fontWeight(FontWeight.Medium)
          }
          .width('100%')
          .height('100%')
          .padding(16)
          .backgroundColor(Color.White)
          .borderRadius(12)
          .shadow({ radius: 4, color: '#E0E0E0', offsetX: 0, offsetY: 2 })
        }
      })
    }
    .columnsTemplate('repeat(3, 1fr)')
    .rowsGap(16)
    .columnsGap(16)
    .width('100%')
    .height(400)
    .padding(16)
  }
}

interface IconData {
  name: string
  symbol: string
  color: string
}
```

### 2.3 跨列跨行 GridItem

```typescript
@ComponentV2
struct SpanningGridItemExample {
  build() {
    Grid() {
      // 标准项（1列1行）
      GridItem() {
        Text('1x1')
          .width('100%')
          .height('100%')
          .fontSize(20)
          .textAlign(TextAlign.Center)
          .backgroundColor('#E3F2FD')
          .borderRadius(8)
      }

      // 跨2列
      GridItem() {
        Text('2x1')
          .width('100%')
          .height('100%')
          .fontSize(20)
          .textAlign(TextAlign.Center)
          .backgroundColor('#E8F5E9')
          .borderRadius(8)
      }
      .columnStart(0)
      .columnEnd(1)

      // 跨2行
      GridItem() {
        Text('1x2')
          .width('100%')
          .height('100%')
          .fontSize(20)
          .textAlign(TextAlign.Center)
          .backgroundColor('#FFF8E1')
          .borderRadius(8)
      }
      .rowStart(1)
      .rowEnd(2)

      // 跨2列2行
      GridItem() {
        Text('2x2')
          .width('100%')
          .height('100%')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          .backgroundColor('#FCE4EC')
          .borderRadius(8)
      }
      .columnStart(1)
      .columnEnd(2)
      .rowStart(1)
      .rowEnd(2)
    }
    .columnsTemplate('1fr 1fr 1fr')
    .rowsTemplate('1fr 1fr 1fr')
    .rowsGap(12)
    .columnsGap(12)
    .width('100%')
    .height(400)
  }
}
```

### 2.4 可交互 GridItem

```typescript
@ComponentV2
struct InteractiveGridItemExample {
  @Local selectedItem: number = -1
  @Local products: Product[] = [
    { id: 1, name: 'Laptop', price: 999, image: '💻' },
    { id: 2, name: 'Phone', price: 699, image: '📱' },
    { id: 3, name: 'Tablet', price: 499, image: '📱' },
    { id: 4, name: 'Watch', price: 299, image: '⌚' },
    { id: 5, name: 'Headphones', price: 199, image: '🎧' },
    { id: 6, name: 'Camera', price: 799, image: '📷' }
  ]

  build() {
    Column() {
      // 产品网格
      Grid() {
        ForEach(this.products, (product: Product) => {
          GridItem() {
            Column({ space: 8 }) {
              // 产品图片
              Text(product.image)
                .fontSize(40)
                .width('100%')

              // 产品名称
              Text(product.name)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })

              // 产品价格
              Text(`$${product.price}`)
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor('#007DFF')
            }
            .width('100%')
            .height('100%')
            .padding(12)
            .backgroundColor(
              this.selectedItem === product.id ? '#E3F2FD' : Color.White
            )
            .borderRadius(8)
            .border({
              width: this.selectedItem === product.id ? 2 : 1,
              color: this.selectedItem === product.id ? '#007DFF' : '#E0E0E0'
            })
            .onClick(() => {
              this.selectedItem = product.id
              console.info(`Selected: ${product.name}`)
            })
          }
        })
      }
      .columnsTemplate('repeat(2, 1fr)')
      .rowsGap(12)
      .columnsGap(12)
      .width('100%')
      .height(400)

      // 底部按钮
      Button(this.selectedItem > 0 ? 'Buy Now' : 'Select a Product')
        .width('90%')
        .height(45)
        .type(ButtonType.Capsule)
        .backgroundColor(this.selectedItem > 0 ? '#007DFF' : '#CCCCCC')
        .fontColor(Color.White)
        .enabled(this.selectedItem > 0)
        .margin({ top: 16 })
    }
    .width('100%')
    .height(500)
  }
}

interface Product {
  id: number
  name: string
  price: number
  image: string
}
```

### 2.5 响应式 GridItem

```typescript
@ComponentV2
struct ResponsiveGridItemExample {
  @Local cards: CardData[] = [
    { title: 'Card 1', description: 'Short desc', color: '#E3F2FD' },
    { title: 'Card 2', description: 'Medium description here', color: '#E8F5E9' },
    { title: 'Card 3', description: 'Another card', color: '#FFF8E1' },
    { title: 'Card 4', description: 'Longer description text', color: '#FCE4EC' },
    { title: 'Card 5', description: 'More content', color: '#E0F2F1' },
    { title: 'Card 6', description: 'Final card', color: '#F3E5F5' }
  ]

  build() {
    Grid() {
      ForEach(this.cards, (card: CardData) => {
        GridItem() {
          Column({ space: 8 }) {
            Text(card.title)
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')

            Text(card.description)
              .fontSize(14)
              .fontColor('#666666')
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
          }
          .width('100%')
          .height('100%')
          .padding(16)
          .alignItems(HorizontalAlign.Start)
          .backgroundColor(card.color)
          .borderRadius(12)
        }
      })
    }
    .columnsTemplate('repeat(auto-fit, minmax(150, 1fr))')
    .rowsGap(12)
    .columnsGap(12)
    .width('100%')
    .height('100%')
    .padding(16)
  }
}

interface CardData {
  title: string
  description: string
  color: string
}
```

### 2.6 动画 GridItem

```typescript
@ComponentV2
struct AnimatedGridItemExample {
  @Local scaleValues: number[] = [1, 1, 1, 1, 1, 1]

  build() {
    Grid() {
      ForEach([1, 2, 3, 4, 5, 6], (item: number, index: number) => {
        GridItem() {
          Text(`Item ${item}`)
            .width('100%')
            .height('100%')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .textAlign(TextAlign.Center)
            .backgroundColor('#007DFF')
            .fontColor(Color.White)
            .borderRadius(12)
            .scale({ x: this.scaleValues[index], y: this.scaleValues[index] })
            .onClick(() => {
              this.animateScale(index)
            })
        }
      })
    }
    .columnsTemplate('repeat(3, 1fr)')
    .rowsGap(12)
    .columnsGap(12)
    .width('100%')
    .height(300)
  }

  private animateScale(index: number) {
    // 缩小动画
    this.scaleValues[index] = 0.9
    setTimeout(() => {
      // 恢复动画
      this.scaleValues[index] = 1
    }, 100)
  }
}
```

## 三、最佳实践

### 3.1 性能优化

1. **使用 LazyForEach**: 对于大量数据（>50 项），使用 LazyForEach 而非 ForEach
2. **避免复杂布局**: GridItem 内部避免多层嵌套和复杂布局
3. **固定尺寸**: 为 GridItem 设置固定或自适应的高度，提升性能
4. **合理使用跨度**: 避免过多跨列跨行导致布局计算复杂

### 3.2 布局建议

1. **统一尺寸**: 相同类型的 GridItem 使用一致的尺寸
2. **间距统一**: 使用相同的 rowsGap 和 columnsGap
3. **圆角一致**: 所有 GridItem 使用相同的 borderRadius
4. **内容居中**: 使用 textAlign 和 alignItems 居中对齐内容

### 3.3 交互设计

1. **点击反馈**: 使用 backgroundColor 或 scale 提供点击反馈
2. **选中状态**: 使用边框或背景色区分选中状态
3. **禁用状态**: 使用 opacity 或灰色显示不可点击的项

### 3.4 跨度使用

1. **colStart/colEnd**: 列索引从 0 开始，colEnd 包含该列
2. **rowStart/rowEnd**: 行索引从 0 开始，rowEnd 包含该行
3. **注意事项**: 跨度可能导致布局重叠，需谨慎使用

### 3.5 常见问题

**Q: GridItem 宽度不生效？**
A: GridItem 宽度由 Grid 的 columnsTemplate 控制，设置固定宽度可能无效

**Q: 跨列显示不正确？**
A: 检查 colStart 和 colEnd 的值，确保不超过 Grid 的总列数

**Q: GridItem 高度不一致？**
A: 为所有 GridItem 设置相同的 height 或使用自适应布局

**Q: 内容被截断？**
A: 使用 maxLines 和 textOverflow 控制文本显示，或调整 GridItem 高度

**Q: 点击事件不响应？**
A: 检查是否设置了 onClick，或是否有其他组件遮挡

## 四、相关组件

- **Grid**: GridItem 的父容器
- **LazyForEach**: 高性能数据渲染
- **ForEach**: 简单数据渲染
- **Column/Row**: GridItem 内部布局组件
