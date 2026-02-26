# ScrollBar 组件 HarmonyOS 6.0 开发 Skill

## 概述

ScrollBar 组件是 OpenHarmony 中的滚动条组件，用于与可滚动组件（如 List、Grid、Scroll）配合使用，显示当前滚动位置并允许用户快速定位到指定位置。支持垂直和水平方向，以及自定义样式。

## 重要说明

- **基础组件**: ScrollBar 是 ArkUI 的基础内置组件，无需导入
- **控制器绑定**: 必须通过 Scroller 控制器与可滚动组件绑定
- **方向一致**: ScrollBar 方向必须与可滚动组件方向一致
- **自定义支持**: 支持自定义滚动条外观和行为
- **状态控制**: 支持 BarState 控制显示状态（Auto/On/Off）

## 模块信息

- **组件名称**: ScrollBar
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [ScrollBar - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-scrollbar-V5)

## 一、API 参数

### 构造函数

```typescript
ScrollBar(value: ScrollBarOptions)
```

### ScrollBarOptions 参数

| 参数 | 类型 | 必填 | 描述 |
|------|------|------|------|
| scroller | Scroller | 是 | 滚动组件的控制器对象 |
| direction | ScrollBarDirection | 否 | 滚动条方向，默认垂直 |
| state | BarState | 否 | 滚动条状态，默认自动显示 |

### ScrollBarDirection 枚举

| 值 | 描述 |
|----|------|
| ScrollBarDirection.Vertical | 垂直方向 |
| ScrollBarDirection.Horizontal | 水平方向 |

### BarState 枚举

| 值 | 描述 |
|----|------|
| BarState.Auto | 自动显示（滚动时显示，静止时隐藏） |
| BarState.On | 始终显示 |
| BarState.Off | 始终隐藏 |

### 样式属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| width | Length | - | 滚动条宽度 |
| height | Length | - | 滚动条高度 |
| backgroundColor | ResourceColor | - | 滚动条背景颜色 |
| borderRadius | Length | - | 滚动条圆角半径 |

## 二、使用示例

### 2.1 基础 ScrollBar

```typescript
@ComponentV2
struct BasicScrollBarExample {
  private scroller: Scroller = new Scroller()
  @Local items: number[] = Array.from({ length: 20 }, (_, i) => i + 1)

  build() {
    Stack({ alignContent: Alignment.End }) {
      // 可滚动列表
      List({ space: 8 }) {
        ForEach(this.items, (item: number) => {
          ListItem() {
            Text(`Item ${item}`)
              .width('100%')
              .height(60)
              .fontSize(16)
              .padding({ left: 16 })
              .backgroundColor('#F5F5F5')
              .borderRadius(8)
          }
        })
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off) // 隐藏默认滚动条
      .edgeEffect(EdgeEffect.Spring)
      .onScroll((scrollOffset: number, scrollState: ScrollState) => {
        console.info(`Scroll offset: ${scrollOffset}, state: ${scrollState}`)
      })

      // 自定义滚动条
      ScrollBar({
        scroller: this.scroller,
        direction: ScrollBarDirection.Vertical,
        state: BarState.Auto
      }) {
        Text()
          .width(6)
          .height(100)
          .backgroundColor('#CCCCCC')
          .borderRadius(3)
      }
      .width(6)
    }
    .width('100%')
    .height(400)
  }
}
```

### 2.2 水平 ScrollBar

```typescript
@ComponentV2
struct HorizontalScrollBarExample {
  private scroller: Scroller = new Scroller()
  @Local items: string[] = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5', 'Item 6']

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // 水平滚动容器
      Scroll(this.scroller) {
        Row({ space: 12 }) {
          ForEach(this.items, (item: string) => {
            Text(item)
              .width(120)
              .height(120)
              .fontSize(16)
              .textAlign(TextAlign.Center)
              .backgroundColor('#E3F2FD')
              .borderRadius(8)
          })
        }
        .padding({ left: 16, right: 16 })
      }
      .width('100%')
      .height('100%')
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)

      // 水平滚动条
      ScrollBar({
        scroller: this.scroller,
        direction: ScrollBarDirection.Horizontal,
        state: BarState.Auto
      }) {
        Text()
          .width(100)
          .height(6)
          .backgroundColor('#007DFF')
          .borderRadius(3)
      }
      .height(6)
      .margin({ bottom: 16 })
    }
    .width('100%')
    .height(200)
  }
}
```

### 2.3 自定义样式 ScrollBar

```typescript
@ComponentV2
struct CustomStyleScrollBarExample {
  private scroller: Scroller = new Scroller()
  @Local data: number[] = Array.from({ length: 30 }, (_, i) => i + 1)

  build() {
    Stack({ alignContent: Alignment.End }) {
      List({ space: 8 }) {
        ForEach(this.data, (item: number) => {
          ListItem() {
            Text(`Content ${item}`)
              .width('100%')
              .height(50)
              .fontSize(16)
              .padding({ left: 16 })
              .backgroundColor(Color.White)
              .borderRadius(4)
          }
        })
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)

      // 渐变滚动条
      ScrollBar({
        scroller: this.scroller,
        direction: ScrollBarDirection.Vertical,
        state: BarState.Auto
      }) {
        Column() {
          LinearGradient({
            angle: 90,
            colors: [['#007DFF', 0.0], ['#00C6FF', 1.0]]
          })
        }
        .width(8)
        .borderRadius(4)
      }
      .width(8)
      .margin({ right: 4 })
    }
    .width('100%')
    .height(500)
  }
}
```

### 2.4 带缩略图的 ScrollBar

```typescript
@ComponentV2
struct ThumbnailScrollBarExample {
  private scroller: Scroller = new Scroller()
  @Local images: ImageData[] = Array.from({ length: 15 }, (_, i) => ({
    id: i,
    title: `Image ${i + 1}`,
    color: `hsl(${(i * 24) % 360}, 70%, 60%)`
  }))

  build() {
    Stack({ alignContent: Alignment.End }) {
      Scroll(this.scroller) {
        Column({ space: 12 }) {
          ForEach(this.images, (image: ImageData) => {
            Row({ space: 12 }) {
              // 缩略图
              Text()
                .width(80)
                .height(80)
                .backgroundColor(image.color)
                .borderRadius(8)

              // 标题
              Text(image.title)
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')
                .layoutWeight(1)
            }
            .width('100%')
            .padding(16)
            .backgroundColor(Color.White)
            .borderRadius(8)
          })
        }
        .width('100%')
        .padding(16)
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)

      // 滚动条
      ScrollBar({
        scroller: this.scroller,
        direction: ScrollBarDirection.Vertical,
        state: BarState.On // 始终显示
      }) {
        Text()
          .width(10)
          .backgroundColor('rgba(0, 125, 255, 0.6)')
          .borderRadius(5)
      }
      .width(10)
      .margin({ right: 8 })
    }
    .width('100%')
    .height(600)
  }
}

interface ImageData {
  id: number
  title: string
  color: string
}
```

### 2.5 双向滚动条

```typescript
@ComponentV2
struct DualScrollBarExample {
  private scrollerX: Scroller = new Scroller()
  private scrollerY: Scroller = new Scroller()
  @Local gridData: number[] = Array.from({ length: 50 }, (_, i) => i + 1)

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Scroll(this.scrollerY) {
        Scroll(this.scrollerX) {
          Grid() {
            ForEach(this.gridData, (item: number) => {
              GridItem() {
                Text(`${item}`)
                  .width('100%')
                  .height('100%')
                  .fontSize(16)
                  .textAlign(TextAlign.Center)
                  .backgroundColor('#E3F2FD')
                  .borderRadius(4)
              }
            })
          }
          .columnsTemplate('1fr 1fr 1fr 1fr')
          .rowsGap(8)
          .columnsGap(8)
          .width('100%')
          .padding(8)
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .width('100%')
      }
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')

      // 垂直滚动条
      ScrollBar({
        scroller: this.scrollerY,
        direction: ScrollBarDirection.Vertical,
        state: BarState.Auto
      }) {
        Text()
          .width(8)
          .backgroundColor('#007DFF')
          .borderRadius(4)
      }
      .width(8)
      .margin({ right: 4 })

      // 水平滚动条
      ScrollBar({
        scroller: this.scrollerX,
        direction: ScrollBarDirection.Horizontal,
        state: BarState.Auto
      }) {
        Text()
          .width(100)
          .height(8)
          .backgroundColor('#28A745')
          .borderRadius(4)
      }
      .height(8)
      .margin({ bottom: 4 })
    }
    .width('100%')
    .height(400)
  }
}
```

### 2.6 滚动控制按钮

```typescript
@ComponentV2
struct ScrollControlExample {
  private scroller: Scroller = new Scroller()
  @Local items: number[] = Array.from({ length: 20 }, (_, i) => i + 1)

  build() {
    Column() {
      // 可滚动内容
      Stack({ alignContent: Alignment.End }) {
        List({ space: 8 }) {
          ForEach(this.items, (item: number) => {
            ListItem() {
              Text(`Item ${item}`)
                .width('100%')
                .height(60)
                .fontSize(16)
                .padding({ left: 16 })
                .backgroundColor('#F5F5F5')
                .borderRadius(8)
            }
          })
        }
        .width('100%')
        .height('100%')
        .scrollBar(BarState.Off)

        ScrollBar({
          scroller: this.scroller,
          direction: ScrollBarDirection.Vertical,
          state: BarState.Auto
        }) {
          Text()
            .width(6)
            .backgroundColor('#CCCCCC')
            .borderRadius(3)
        }
        .width(6)
      }
      .width('100%')
      .layoutWeight(1)

      // 控制按钮
      Row({ space: 12 }) {
        Button('Top')
          .type(ButtonType.Capsule)
          .onClick(() => {
            this.scroller.scrollTo({ xOffset: 0, yOffset: 0, animation: true })
          })

        Button('Middle')
          .type(ButtonType.Capsule)
          .onClick(() => {
            this.scroller.scrollTo({
              xOffset: 0,
              yOffset: 500,
              animation: true
            })
          })

        Button('Bottom')
          .type(ButtonType.Capsule)
          .onClick(() => {
            this.scroller.scrollEdge(Edge.Bottom)
          })
      }
      .width('100%')
      .padding(16)
    }
    .width('100%')
    .height(500)
  }
}
```

## 三、Scroller 控制器方法

Scroller 提供了以下方法用于控制滚动：

| 方法 | 参数 | 描述 |
|------|------|------|
| scrollTo | { xOffset, yOffset, animation? } | 滚动到指定位置 |
| scrollEdge | Edge.Top \| Edge.Bottom \| Edge.Start \| Edge.End | 滚动到边缘 |
| scrollPage | { next: boolean } | 按页滚动 |
| scrollBy | { xOffset, yOffset, animation? } | 相对当前位置滚动 |
| currentOffset | () => { xOffset, yOffset } | 获取当前滚动偏移量 |

### 使用示例

```typescript
// 滚动到顶部
this.scroller.scrollTo({ xOffset: 0, yOffset: 0, animation: true })

// 滚动到底部
this.scroller.scrollEdge(Edge.Bottom)

// 向下滚动一页
this.scroller.scrollPage({ next: true })

// 相对滚动
this.scroller.scrollBy({ xOffset: 0, yOffset: -100, animation: true })

// 获取当前位置
const offset = this.scroller.currentOffset()
console.info(`Current offset: ${offset.xOffset}, ${offset.yOffset}`)
```

## 四、最佳实践

### 4.1 性能优化

1. **隐藏默认滚动条**: 使用 `.scrollBar(BarState.Off)` 隐藏原生滚动条
2. **自定义渲染**: ScrollBar 子节点应尽量简单，避免复杂布局
3. **合理设置状态**: 使用 BarState.Auto 在需要时显示
4. **避免频繁更新**: 避免在 ScrollBar 子组件中使用频繁变化的 @Local 变量

### 4.2 样式建议

1. **宽度适中**: 垂直滚动条宽度通常为 4-8vp
2. **圆角统一**: 使用 borderRadius 使滚动条更美观
3. **颜色对比**: 滚动条颜色应与背景有足够对比度
4. **位置布局**: 使用 Stack 的 alignContent 控制滚动条位置

### 4.3 交互设计

1. **自动显示**: 使用 BarState.Auto 提供更好的用户体验
2. **始终显示**: 长内容列表使用 BarState.On 帮助用户定位
3. **视觉反馈**: 滚动条颜色应清晰可见但不突兀

### 4.4 常见问题

**Q: ScrollBar 不显示？**
A: 检查 Scroller 是否正确绑定，内容高度是否超过容器高度

**Q: ScrollBar 位置不正确？**
A: 确保 Stack 的 alignContent 设置正确，检查 ScrollBar 的 width/height

**Q: 滚动条跳动？**
A: 可能是 LazyForEach 加载数据导致，使用 childrenMainSize 预设高度

**Q: 滚动条颜色不生效？**
A: 检查 ScrollBar 子组件的 backgroundColor 属性设置

**Q: 方向不匹配？**
A: 确保 ScrollBar 的 direction 与可滚动组件的 scrollable 方向一致

## 五、相关组件

- **List**: 列表组件，常配合 ScrollBar 使用
- **Grid**: 网格组件，常配合 ScrollBar 使用
- **Scroll**: 滚动容器，常配合 ScrollBar 使用
- **Scroller**: 滚动控制器，用于程序化控制滚动
