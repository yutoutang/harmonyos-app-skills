# FlowItem 组件 HarmonyOS 6.0 开发 Skill

## 概述

FlowItem 是 OpenHarmony 中用于瀑布流布局的子项组件。它只能作为 WaterFlow 容器的直接子组件使用，用于展示瀑布流中的单个内容项。

## 重要说明

- **父容器限制**: FlowItem 必须作为 WaterFlow 的直接子组件使用
- **布局方式**: 瀑布流布局，高度自适应
- **典型用途**: 图片列表、商品展示、卡片式内容
- **核心属性**: 配合 WaterFlow 的 columnsTemplate 和 rowsGap 使用

## 模块信息

- **组件名称**: FlowItem
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [WaterFlow 瀑布流容器 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-waterflow-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// FlowItem 是内置组件，无需导入
// 必须在 WaterFlow 容器内使用
WaterFlow() {
  FlowItem() {
    // 内容
  }
}
```

### 1.2 基本语法

```typescript
WaterFlow() {
  FlowItem() {
    Column() {
      Image('...')
      Text('标题')
    }
  }
}
.columnsTemplate('1fr 1fr')
.columnsGap(12)
.rowsGap(12)
```

## 二、核心概念

### 2.1 WaterFlow 配置

FlowItem 的布局行为由 WaterFlow 容器控制：

```typescript
WaterFlow() {
  // FlowItem 内容
}
.columnsTemplate('1fr 1fr')  // 列模板：2列
.columnsGap(12)              // 列间距
.rowsGap(12)                 // 行间距
```

**列模板示例**:
- `'1fr 1fr'` - 2列等宽
- `'1fr 1fr 1fr'` - 3列等宽
- `'1fr 2fr'` - 第1列占1份，第2列占2份

### 2.2 FlowItem 尺寸

```typescript
FlowItem() {
  Column() {
    // 内容
  }
  .width('100%')
  .height(200)  // FlowItem 高度可以不同
}
```

**关键特性**:
- **宽度**: 由列模板自动计算
- **高度**: 可自定义，支持不同高度
- **自适应**: 根据内容自动调整位置

## 三、典型用法

### 3.1 图片瀑布流

```typescript
@Local images: Array<{url: string, height: number}> = [
  { url: 'image1.jpg', height: 200 },
  { url: 'image2.jpg', height: 280 },
  { url: 'image3.jpg', height: 180 }
]

WaterFlow() {
  ForEach(this.images, (image) => {
    FlowItem() {
      Image(image.url)
        .width('100%')
        .height(image.height)
        .borderRadius(8)
    }
  })
}
.columnsTemplate('1fr 1fr')
.columnsGap(12)
.rowsGap(12)
```

### 3.2 商品卡片瀑布流

```typescript
interface Product {
  id: number
  name: string
  price: string
  imageHeight: number
}

@Local products: Product[] = [...]

WaterFlow() {
  ForEach(this.products, (product) => {
    FlowItem() {
      Column({ space: 8 }) {
        // 商品图片
        Image(product.image)
          .width('100%')
          .height(product.imageHeight)
          .borderRadius({ topLeft: 8, topRight: 8 })

        // 商品信息
        Column({ space: 4 }) {
          Text(product.name)
            .fontSize(14)
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

          Text(product.price)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#F44336')
        }
        .width('100%')
        .padding(8)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .backgroundColor('#FFFFFF')
      .borderRadius(8)
      .shadow({ radius: 4, color: '#1A000000' })
    }
  })
}
.columnsTemplate('1fr 1fr')
.columnsGap(12)
.rowsGap(12)
```

### 3.3 动态列数

```typescript
@Local columnCount: number = 2

WaterFlow() {
  ForEach(items, (item) => {
    FlowItem() {
      // 内容
    }
  })
}
.columnsTemplate(`1fr `.repeat(this.columnCount).trim())
.columnsGap(12)
.rowsGap(12)
```

**切换列数**:
```typescript
Row() {
  Button('2列').onClick(() => this.columnCount = 2)
  Button('3列').onClick(() => this.columnCount = 3)
  Button('4列').onClick(() => this.columnCount = 4)
}
```

## 四、高级用法

### 4.1 交互式 FlowItem

```typescript
@Local selectedId: number = -1

WaterFlow() {
  ForEach(items, (item) => {
    FlowItem() {
      Column() {
        Text(item.title)
      }
      .width('100%')
      .backgroundColor(this.selectedId === item.id ? '#1976D2' : '#FFFFFF')
      .border({
        width: this.selectedId === item.id ? 3 : 0,
        color: '#1976D2'
      })
    }
    .onClick(() => {
      this.selectedId = item.id
    })
  })
}
```

### 4.2 加载更多

```typescript
@Local page: number = 1
@Local items: ItemData[] = []
@Local loading: boolean = false

WaterFlow() {
  ForEach(this.items, (item) => {
    FlowItem() {
      ItemCard({ data: item })
    }
  })

  // 加载指示器
  if (this.loading) {
    FlowItem() {
      LoadingProgress()
        .width('100%')
    }
  }
}
.onReachEnd(() => {
  if (!this.loading) {
    this.loadMore()
  }
})
.columnsTemplate('1fr 1fr')
.columnsGap(12)
.rowsGap(12)

async loadMore() {
  this.loading = true
  this.page++
  const newData = await fetchItems(this.page)
  this.items.push(...newData)
  this.loading = false
}
```

### 4.3 删除动画

```typescript
@Local items: ItemData[] = []

deleteItem(id: number) {
  const index = this.items.findIndex(item => item.id === id)
  if (index >= 0) {
    animateTo({ duration: 300 }, () => {
      this.items.splice(index, 1)
    })
  }
}

// FlowItem 内部
Button('删除')
  .onClick(() => {
    this.deleteItem(item.id)
  })
```

## 五、性能优化

### 5.1 使用缓存

```typescript
WaterFlow() {
  ForEach(this.items, (item) => {
    FlowItem() {
      ItemCard({ data: item })
    }
  }, (item) => item.id.toString())  // 唯一键值
}
.cachedCount(5)  // 缓存屏幕外5个FlowItem
```

### 5.2 懒加载图片

```typescript
FlowItem() {
  Image(item.url)
    .width('100%')
    .height(item.height)
    .objectFit(ImageFit.Cover)
    .onAppear(() => {
      // 图片进入视口时加载
      this.loadImage(item.id)
    })
}
```

### 5.3 避免嵌套滚动

```typescript
// ❌ 不推荐：FlowItem 内有 Scroll
FlowItem() {
  Scroll() {
    // 内容
  }
}

// ✅ 推荐：直接显示内容
FlowItem() {
  Column() {
    // 内容
  }
}
```

## 六、最佳实践

### 6.1 数据结构设计

```typescript
interface WaterFlowItem {
  id: number              // 唯一标识
  height: number          // 预估高度
  aspectRatio?: number    // 宽高比（可选）
  content: any           // 实际内容
  type?: string          // 类型（用于区分不同Item样式）
}
```

### 6.2 响应式列数

```typescript
WaterFlow() {
  // FlowItem 内容
}
.columnsTemplate({
  sm: '1fr 1fr',      // 小屏 2列
  md: '1fr 1fr 1fr',  // 中屏 3列
  lg: '1fr 1fr 1fr 1fr'  // 大屏 4列
})
.columnsGap({ sm: 8, md: 12, lg: 16 })
.rowsGap({ sm: 8, md: 12, lg: 16 })
```

### 6.3 错误处理

```typescript
FlowItem() {
  if (item.loadError) {
    Column() {
      Text('加载失败')
        .fontColor('#999999')
      Button('重试')
        .onClick(() => this.retryLoad(item.id))
    }
    .width('100%')
    .height(200)
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#F5F5F5')
  } else {
    ItemContent({ data: item })
  }
}
```

## 七、常见问题

### Q1: FlowItem 可以直接添加点击事件吗？

**A**: 可以。FlowItem 支持通用事件：

```typescript
FlowItem() {
  // 内容
}
.onClick(() => {
  console.log('FlowItem clicked')
})
.onAppear(() => {
  console.log('FlowItem appeared')
})
```

### Q2: 如何实现不同高度的瀑布流？

**A**: 为每个 FlowItem 设置不同的高度：

```typescript
ForEach(items, (item) => {
  FlowItem() {
    Column() {
      Image(item.image)
        .width('100%')
        .height(item.height)
    }
  }
})
```

### Q3: FlowItem 可以嵌套列表吗？

**A**: 不推荐。FlowItem 应该保持简单的卡片结构：

```typescript
// ❌ 不推荐
FlowItem() {
  List() { }
}

// ✅ 推荐
FlowItem() {
  Column() {
    ForEach(subItems, (item) => {
      Text(item.title)
    })
  }
}
```

### Q4: 如何优化大量数据的性能？

**A**: 使用缓存和懒加载：

```typescript
WaterFlow() {
  ForEach(items, (item) => {
    FlowItem() {
      LazyContent({ item })
    }
  }, (item) => item.id)
}
.cachedCount(10)
.columnsTemplate('1fr 1fr')
```

## 八、相关组件

- **WaterFlow**: 瀑布流容器
- **Grid**: 网格布局（等高）
- **List**: 列表布局（单列/多列等高）
- **GridCol**: 响应式网格列

## 九、完整示例

### 瀑布流图片库

```typescript
@Entry
@ComponentV2
struct WaterFlowGallery {
  @Local images: ImageData[] = []
  @Local columnCount: number = 2

  async aboutToAppear() {
    this.images = await this.loadImages()
  }

  build() {
    Column() {
      // 列数切换
      Row({ space: 12 }) {
        ForEach([2, 3, 4], (count) => {
          Button(`${count}列`)
            .onClick(() => this.columnCount = count)
        })
      }
      .padding(12)

      // 瀑布流
      WaterFlow() {
        ForEach(this.images, (image) => {
          FlowItem() {
            ImageCard({
              data: image,
              onClick: () => this.viewImage(image)
            })
          }
        }, (image) => image.id)
      }
      .columnsTemplate(`1fr `.repeat(this.columnCount).trim())
      .columnsGap(12)
      .rowsGap(12)
      .padding(12)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
  }
}
```

---

**更新日期**: 2026-02-24
**SDK 版本**: HarmonyOS 6.0 (API 12+)
**组件类型**: 布局容器
