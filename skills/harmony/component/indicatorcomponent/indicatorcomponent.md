# IndicatorComponent 指示器组件

## 组件概述

**IndicatorComponent** 是 OpenHarmony 中的指示器组件,通常与轮播图、图片查看器等配合使用,用于显示当前位置或页码。

### 核心特性

- **显示指示点**: 通过圆点指示当前位置
- **支持自定义样式**: 可自定义颜色、大小、形状
- **动态更新**: 可根据页面变化动态更新当前索引
- **双向绑定**: 支持数据双向绑定

## 基本语法

```typescript
IndicatorComponent(controller?: IndicatorComponentController)
```

### 参数说明

| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| controller | IndicatorComponentController | 否 | 指示器控制器,用于编程式控制指示器 |

## 属性方法

### 基础属性

```typescript
.count(totalCount: number)              // 设置指示器总数
.initialIndex(index: number)            // 设置初始索引
.loop(isLoop: boolean)                  // 是否循环
.vertical(isVertical: boolean)          // 是否垂直方向
```

### 样式设置

```typescript
.style(indicatorStyle: DotIndicator | DigitIndicator)  // 设置指示器样式
```

**DotIndicator (圆点指示器):**
```typescript
new DotIndicator()
  .itemWidth(length: Length)            // 未选中项宽度
  .itemHeight(length: Length)           // 未选中项高度
  .selectedItemWidth(length: Length)    // 选中项宽度
  .selectedItemHeight(length: Length)   // 选中项高度
  .color(value: ResourceColor)          // 未选中颜色
  .selectedColor(value: ResourceColor)  // 选中颜色
  .itemSpace(length: Length)            // 指示项间距
```

**DigitIndicator (数字指示器):**
```typescript
new DigitIndicator()
  .fontSize(length: Length)             // 字体大小
  .selectedFontSize(length: Length)     // 选中项字体大小
  .fontColor(value: ResourceColor)      // 字体颜色
  .selectedFontColor(value: ResourceColor)  // 选中项字体颜色
```

### 事件回调

```typescript
.onChange(event: Callback<number>)  // 索引变化时触发,返回当前索引
```

## IndicatorComponentController 方法

```typescript
controller.showNext()                    // 显示下一个指示器
controller.showPrevious()                // 显示上一个指示器
controller.changeIndex(index: number, useAnimation?: boolean)  // 跳转到指定索引
```

## 使用示例

### 基础示例

```typescript
@ComponentV2
struct BasicIndicatorExample {
  @Local currentIndex: number = 0
  private totalCount: number = 5
  private indicatorController: IndicatorComponentController = new IndicatorComponentController()

  build() {
    Column({ space: 20 }) {
      // 轮播内容区域
      Swiper() {
        ForEach(Array.from({ length: this.totalCount }), (_, index) => {
          Text(`页面 ${index + 1}`)
            .fontSize(30)
            .width('100%')
            .height(200)
            .backgroundColor('#E0E0E0')
        })
      }
      .loop(false)
      .onChange((index: number) => {
        this.currentIndex = index
      })

      // 指示器
      IndicatorComponent(this.indicatorController)
        .count(this.totalCount)
        .initialIndex(0)
        .style(
          new DotIndicator()
            .itemWidth(8)
            .itemHeight(8)
            .selectedItemWidth(16)
            .selectedItemHeight(8)
            .color('#CCCCCC')
            .selectedColor('#007DFF')
        )
        .onChange((index: number) => {
          this.currentIndex = index
        })
    }
  }
}
```

### 自定义样式示例

```typescript
@ComponentV2
struct CustomIndicatorExample {
  @Local currentIndex: number = 0

  build() {
    Column({ space: 20 }) {
      // 圆形指示器
      IndicatorComponent({ count: 6, currentIndex: this.currentIndex })
        .itemWidth(10)
        .itemHeight(10)
        .selectedItemWidth(10)
        .selectedItemHeight(10)
        .color('#E0E0E0')
        .selectedColor('#FF0000')

      // 胶囊形指示器
      IndicatorComponent({ count: 4, currentIndex: this.currentIndex })
        .itemWidth(6)
        .itemHeight(6)
        .selectedItemWidth(20)
        .selectedItemHeight(6)
        .itemSpace(8)
        .color('#BDBDBD')
        .selectedColor('#00FF00')

      // 大尺寸指示器
      IndicatorComponent({ count: 3, currentIndex: this.currentIndex })
        .itemWidth(15)
        .itemHeight(15)
        .selectedItemWidth(15)
        .selectedItemHeight(15)
        .color('#9E9E9E')
        .selectedColor('#FF9800')
    }
    .width('100%')
    .padding(20)
  }
}
```

### 手动控制示例

```typescript
@ComponentV2
struct ManualControlIndicatorExample {
  @Local currentIndex: number = 0
  private totalCount: number = 5

  build() {
    Column({ space: 20 }) {
      Text(`当前页面: ${this.currentIndex + 1} / ${this.totalCount}`)
        .fontSize(18)

      // 指示器
      IndicatorComponent({ count: this.totalCount, currentIndex: this.currentIndex })
        .width(120)
        .itemWidth(8)
        .itemHeight(8)
        .selectedItemWidth(20)
        .selectedItemHeight(8)
        .color('#CCCCCC')
        .selectedColor('#007DFF')

      // 控制按钮
      Row({ space: 20 }) {
        Button('上一页')
          .enabled(this.currentIndex > 0)
          .onClick(() => {
            if (this.currentIndex > 0) {
              this.currentIndex--
            }
          })

        Button('下一页')
          .enabled(this.currentIndex < this.totalCount - 1)
          .onClick(() => {
            if (this.currentIndex < this.totalCount - 1) {
              this.currentIndex++
            }
          })
      }

      Button('跳转到第一页')
        .onClick(() => {
          this.currentIndex = 0
        })
    }
    .width('100%')
    .padding(20)
  }
}
```

### 与图片查看器集成示例

```typescript
@ComponentV2
struct ImageGalleryIndicatorExample {
  @Local currentIndex: number = 0
  private images: string[] = [
    'https://example.com/image1.jpg',
    'https://example.com/image2.jpg',
    'https://example.com/image3.jpg'
  ]

  build() {
    Column() {
      Stack() {
        // 图片查看器
        Swiper() {
          ForEach(this.images, (image: string, index: number) => {
            Image(image)
              .width('100%')
              .height(300)
              .objectFit(ImageFit.Cover)
          })
        }
        .loop(false)
        .onChange((index: number) => {
          this.currentIndex = index
        })

        // 底部指示器
        Column() {
          IndicatorComponent({ count: this.images.length, currentIndex: this.currentIndex })
            .itemWidth(8)
            .itemHeight(8)
            .selectedItemWidth(16)
            .selectedItemHeight(8)
            .color('rgba(255, 255, 255, 0.5)')
            .selectedColor('#FFFFFF')
        }
        .position({ x: '50%', y: '90%' })
        .translate({ x: '-50%', y: '-50%' })
      }
      .width('100%')
      .height(300)
    }
  }
}
```

## 常见问题

### 1. 如何动态更新指示器数量?

确保 `count` 参数是响应式数据:

```typescript
@ComponentV2
struct DynamicCountExample {
  @Local currentIndex: number = 0
  @Local totalCount: number = 3

  build() {
    Column({ space: 20 }) {
      IndicatorComponent({ count: this.totalCount, currentIndex: this.currentIndex })

      Button('增加页面')
        .onClick(() => {
          this.totalCount++
        })
    }
  }
}
```

### 2. 如何自定义指示器形状?

通过设置不同的宽高比例实现不同形状:

```typescript
// 圆形
.itemWidth(10)
.itemHeight(10)
.selectedItemWidth(10)
.selectedItemHeight(10)

// 胶囊形(选中时)
.itemWidth(8)
.itemHeight(8)
.selectedItemWidth(20)
.selectedItemHeight(8)

// 矩形
.itemWidth(20)
.itemHeight(4)
.selectedItemWidth(20)
.selectedItemHeight(4)
```

### 3. 如何实现垂直指示器?

旋转组件实现垂直布局:

```typescript
IndicatorComponent({ count: 5, currentIndex: this.currentIndex })
  .rotate({ angle: 90 })
  .itemWidth(8)
  .itemHeight(8)
```

## 最佳实践

1. **与内容同步**: 确保指示器索引与实际内容索引保持同步
2. **合理间距**: 根据指示器大小调整 `itemSpace`,避免过于拥挤或稀疏
3. **视觉层次**: 选中颜色应该比未选中颜色更醒目
4. **尺寸适配**: 指示器尺寸应该与内容区域大小相协调
5. **状态反馈**: 当到达边界时,可以禁用相应的导航按钮

## 性能优化建议

1. **避免频繁更新**: 使用 `@Local` 装饰器时,避免在短时间内频繁更新索引
2. **合理使用动画**: 在索引变化时可以使用 `animateTo` 添加过渡动画

```typescript
Button('下一页').onClick(() => {
  animateTo({ duration: 300 }, () => {
    this.currentIndex++
  })
})
```

## 相关组件

- **Swiper**: 轮播容器组件
- **Tabs**: 标签页组件
- **Image**: 图片组件

## API 参考版本

- **最低支持版本**: API Level 9
- **稳定版本**: API Level 21+
