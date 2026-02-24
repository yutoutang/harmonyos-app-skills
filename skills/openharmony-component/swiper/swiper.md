# Swiper HarmonyOS 6.0 开发 Skill

## 概述

Swiper 是一个容器组件，用于提供滑块切换功能，常用于轮播图、引导页、图片预览等场景。Swiper 通过滑动手势在子组件之间进行切换，支持自动播放、循环播放、自定义指示器等丰富功能。

## 重要说明

- **子组件要求**: 子组件必须是 SwiperItem，每个 SwiperItem 代表一个滑动页面
- **性能优化**: 避免在单个 SwiperItem 中放置过多复杂组件，影响滑动性能
- **内存管理**: 当 Swiper 包含大量图片时，建议使用懒加载策略
- **事件监听**: 通过 onChange 事件监听页面切换，onAnimationEnd 监听动画结束
- **控制方式**: 支持手势滑动和通过 SwiperController 进行程序化控制

## 模块信息

- **组件名称**: Swiper
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **更新日期**: 2026-02-24
- **官方文档**: [Swiper API 参考](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-container-swiper-V14)

## 一、组件基础

### 1.1 导入方式

Swiper 是 ArkUI 内置组件，无需导入。

### 1.2 基础用法

```typescript
@ComponentV2
struct BasicSwiperExample {
  build() {
    Swiper() {
      SwiperItem() {
        Text('Page 1')
          .fontSize(30)
          .width('100%')
          .height('100%')
          .backgroundColor('#FF0000')
      }
      SwiperItem() {
        Text('Page 2')
          .fontSize(30)
          .width('100%')
          .height('100%')
          .backgroundColor('#00FF00')
      }
      SwiperItem() {
        Text('Page 3')
          .fontSize(30)
          .width('100%')
          .height('100%')
          .backgroundColor('#0000FF')
      }
    }
    .width('100%')
    .height(200)
  }
}
```

## 二、API 参数

### 2.1 构造函数

```typescript
Swiper(controller?: SwiperController)
```

**参数**:
- `controller`: SwiperController 对象，用于程序化控制 Swiper

### 2.2 属性 (Properties)

| 属性名 | 参数类型 | 默认值 | 描述 | API 版本 |
|--------|----------|--------|------|----------|
| width | Length | '100%' | 设置组件宽度 | 7+ |
| height | Length | '100%' | 设置组件高度 | 7+ |
| backgroundColor | ResourceColor | - | 设置背景颜色 | 7+ |
| loop | boolean | true | 是否循环播放 | 7+ |
| autoPlay | boolean | false | 是否自动播放 | 7+ |
| interval | number | 3000 | 自动播放时间间隔（毫秒） | 7+ |
| duration | number | 400 | 切换动画时长（毫秒） | 7+ |
| indicator | boolean | true | 是否启用指示器 | 7+ |
| indicatorStyle | { | - | 指示器样式配置 | 7+ |
| &nbsp;&nbsp;left?: Length | | | 指示器距离左侧的偏移量 | |
| &nbsp;&nbsp;top?: Length | | | 指示器距离顶部的偏移量 | |
| &nbsp;&nbsp;right?: Length | | | 指示器距离右侧的偏移量 | |
| &nbsp;&nbsp;bottom?: Length | | | 指示器距离底部的偏移量 | |
| &nbsp;&nbsp;color?: ResourceColor | | | 指示器颜色（未选中） | |
| &nbsp;&nbsp;selectedColor?: ResourceColor | | | 指示器选中颜色 | |
| &nbsp;&nbsp;size?: Length | | | 指示器大小 | |
| &nbsp;&nbsp;selectedSize?: Length | | | 选中指示器大小 | |
| } | | | | |
| displayMode | SwiperDisplayMode | Stretch | 内容显示模式 | 10+ |
| displayCount | number \| string | 1 | 同时显示的 SwiperItem 数量 | 10+ |
| effectMode | EdgeEffect.Spring | EdgeEffect.Spring | 滑动效果 | 7+ |
| disableSwipe | boolean | false | 是否禁用手势滑动 | 7+ |
| curve | Curve \| Curve \| string | Curve.Ease | 动画曲线 | 7+ |
| index | number | 0 | 设置当前显示子组件的索引值 | 7+ |
| itemSpace | Length | 0 | SwiperItem 之间的间距 | 10+ |
| previousMargin | Length | 0 | 前边距 | 10+ |
| nextMargin | Length | 0 | 后边距 | 10+ |
| friction | number | - | 摩擦系数，值越大滑动越困难 | 10+ |
| orientation | SwiperOrientation | Horizontal | 滑动方向：水平/垂直 | 7+ |

**SwiperDisplayMode 枚举**:
- `Stretch`: 拉伸模式，SwiperItem 拉伸以填充 Swiper
- `STRETCH`: 同 Stretch（API 9 之前）
- `AutoLayout`: 自适应布局模式，SwiperItem 根据自身大小显示

**SwiperOrientation 枚举**:
- `Horizontal`: 水平方向滑动（默认）
- `Vertical`: 垂直方向滑动

### 2.3 事件 (Events)

| 事件名 | 功能描述 | 参数类型 | API 版本 |
|--------|----------|----------|----------|
| onChange | 当前显示的组件索引变化时触发 | index: number | 7+ |
| onAnimationStart | 切换动画开始时触发 | index: number | 10+ |
| onAnimationEnd | 切换动画结束时触发 | index: number | 10+ |
| onGestureSwipe | 手势滑动时触发 | index: number, extraInfo: SwiperAnimationInfo | 10+ |
| onAreaChange | 组件区域变化时触发 | { oldValue: Area, newValue: Area } | 7+ |
| onTouch | 触摸事件 | TouchEvent | 10+ |

**SwiperAnimationInfo 接口**:
```typescript
interface SwiperAnimationInfo {
  currentOffset: number  // 当前滑动偏移量
  currentOffsetRatio: number  // 当前滑动偏移比例
  slideOffset: number  // 滑块偏移量
  slideOffsetRatio: number  // 滑块偏移比例
  currentSwipeDirection: number  // 当前滑动方向（0:未滑动, 1:下一页, -1:上一页）
}
```

### 2.4 SwiperController 方法

| 方法名 | 功能描述 | API 版本 |
|--------|----------|----------|
| showNext() | 翻至下一页 | 7+ |
| showPrevious() | 翻至上一页 | 7+ |
| swipeTo(index: number) | 跳转到指定索引的页面 | 7+ |
| changeIndex(index: number, animate?: boolean) | 切换到指定页面（支持配置是否动画） | 10+ |

## 三、使用示例

### 3.1 基础轮播图

```typescript
@ComponentV2
struct BasicBannerExample {
  @Local currentIndex: number = 0

  build() {
    Column({ space: 16 }) {
      Swiper() {
        ForEach([1, 2, 3, 4], (item: number) => {
          SwiperItem() {
            Column() {
              Text(`Banner ${item}`)
                .fontSize(32)
                .fontColor(Color.White)
                .fontWeight(FontWeight.Bold)
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .backgroundColor(`#${item * 50}F0F0`)
          }
        })
      }
      .width('100%')
      .height(200)
      .loop(true)
      .autoPlay(true)
      .interval(3000)
      .indicator(true)
      .onChange((index: number) => {
        this.currentIndex = index
      })

      Text(`当前索引: ${this.currentIndex}`)
        .fontSize(16)
    }
    .padding(16)
  }
}
```

### 3.2 垂直滑动 Swiper

```typescript
@ComponentV2
struct VerticalSwiperExample {
  build() {
    Swiper() {
      ForEach(['Page 1', 'Page 2', 'Page 3'], (item: string) => {
        SwiperItem() {
          Text(item)
            .fontSize(30)
            .width('100%')
            .height('100%')
            .backgroundColor('#F0F0F0')
            .textAlign(TextAlign.Center)
        }
      })
    }
    .width('100%')
    .height('100%')
    .orientation(SwiperOrientation.Vertical)
    .indicator(true)
  }
}
```

### 3.3 自定义指示器样式

```typescript
@ComponentV2
struct CustomIndicatorExample {
  build() {
    Swiper() {
      ForEach([1, 2, 3], (item: number) => {
        SwiperItem() {
          Image($r('app.media.icon'))
            .width('100%')
            .height('100%')
            .objectFit(ImageFit.Cover)
        }
      })
    }
    .width('100%')
    .height(200)
    .indicator(true)
    .indicatorStyle({
      left: 0,
      bottom: 16,
      color: Color.White,
      selectedColor: '#FF6B6B',
      size: 8,
      selectedSize: 12
    })
  }
}
```

### 3.4 多卡片同时显示

```typescript
@ComponentV2
struct MultipleCardsExample {
  @Local datas: string[] = ['Card 1', 'Card 2', 'Card 3', 'Card 4', 'Card 5']

  build() {
    Swiper() {
      ForEach(this.datas, (item: string) => {
        SwiperItem() {
          Column() {
            Text(item)
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
          }
          .width('100%')
          .height('100%')
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .shadow({ radius: 8, color: '#1F000000', offsetX: 0, offsetY: 2 })
          .justifyContent(FlexAlign.Center)
        }
      })
    }
    .width('100%')
    .height(220)
    .loop(true)
    .displayCount(2)  // 同时显示 2 个卡片
    .itemSpace(16)     // 卡片间距
    .previousMargin(32)
    .nextMargin(32)
    .indicator(false)
  }
}
```

### 3.5 程序化控制

```typescript
@ComponentV2
struct ControllerExample {
  @Local currentIndex: number = 0
  swiperController: SwiperController = new SwiperController()

  build() {
    Column({ space: 16 }) {
      Swiper(this.swiperController) {
        ForEach(['Page 1', 'Page 2', 'Page 3'], (item: string) => {
          SwiperItem() {
            Text(item)
              .fontSize(30)
              .width('100%')
              .height(200)
              .backgroundColor('#E0F0FF')
              .textAlign(TextAlign.Center)
          }
        })
      }
      .width('100%')
      .height(200)
      .loop(false)
      .indicator(true)
      .index(this.currentIndex)
      .onChange((index: number) => {
        this.currentIndex = index
      })

      Row({ space: 12 }) {
        Button('上一页')
          .onClick(() => {
            this.swiperController.showPrevious()
          })

        Button('下一页')
          .onClick(() => {
            this.swiperController.showNext()
          })

        Button('跳转第3页')
          .onClick(() => {
            this.swiperController.swipeTo(2)
          })
      }
      .justifyContent(FlexAlign.SpaceAround)
      .width('100%')
    }
    .padding(16)
  }
}
```

### 3.6 自定义动画曲线

```typescript
@ComponentV2
struct CustomCurveExample {
  build() {
    Swiper() {
      ForEach([1, 2, 3, 4], (item: number) => {
        SwiperItem() {
          Text(`Page ${item}`)
            .fontSize(30)
            .width('100%')
            .height('100%')
            .backgroundColor('#FFE0E0')
        }
      })
    }
    .width('100%')
    .height(200)
    .curve(Curve.SpringMotion)  // 使用弹簧动画曲线
    .duration(1000)
    .indicator(true)
  }
}
```

### 3.7 禁用手势滑动

```typescript
@ComponentV2
struct DisableSwipeExample {
  swiperController: SwiperController = new SwiperController()

  build() {
    Column({ space: 16 }) {
      Swiper(this.swiperController) {
        ForEach(['Slide 1', 'Slide 2', 'Slide 3'], (item: string) => {
          SwiperItem() {
            Text(item)
              .fontSize(30)
              .width('100%')
              .height(200)
              .backgroundColor('#E0FFE0')
          }
        })
      }
      .width('100%')
      .height(200)
      .disableSwipe(true)  // 禁用手势滑动
      .indicator(true)

      Button('切换页面')
        .onClick(() => {
          this.swiperController.showNext()
        })
    }
    .padding(16)
  }
}
```

### 3.8 引导页示例

```typescript
@ComponentV2
struct OnboardingExample {
  @Local currentPage: number = 0
  private swiperController: SwiperController = new SwiperController()
  private totalPages: number = 3

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Swiper(this.swiperController) {
        ForEach([1, 2, 3], (item: number) => {
          SwiperItem() {
            Column({ space: 20 }) {
              Image($r('app.media.icon'))
                .width(120)
                .height(120)

              Text(`引导页 ${item}`)
                .fontSize(24)
                .fontWeight(FontWeight.Bold)

              Text(item === 1 ? '欢迎使用应用' :
                   item === 2 ? '探索精彩功能' :
                   '立即开始体验')
                .fontSize(16)
                .fontColor('#666666')
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .padding(32)
          }
        })
      }
      .width('100%')
      .height('100%')
      .loop(false)
      .indicator(false)
      .onChange((index: number) => {
        this.currentPage = index
      })

      // 自定义指示器和按钮
      Column({ space: 16 }) {
        // 自定义指示器
        Row({ space: 8 }) {
          ForEach([0, 1, 2], (index: number) => {
            Circle()
              .width(8)
              .height(8)
              .fill(this.currentPage === index ? '#FF6B6B' : '#CCCCCC')
          })
        }
        .margin({ bottom: 16 })

        // 跳过/完成按钮
        if (this.currentPage < this.totalPages - 1) {
          Button('跳过')
            .backgroundColor('#F0F0F0')
            .fontColor('#333333')
            .onClick(() => {
              this.swiperController.swipeTo(this.totalPages - 1)
            })
        } else {
          Button('立即开始')
            .backgroundColor('#FF6B6B')
            .onClick(() => {
              // 跳转到主页
            })
        }
      }
      .width('100%')
      .padding(32)
    }
    .width('100%')
    .height('100%')
  }
}
```

### 3.9 商品卡片轮播

```typescript
@ComponentV2
struct ProductCardSwiper {
  @Local products: ProductItem[] = [
    { id: 1, name: '商品 1', price: '¥199', image: '' },
    { id: 2, name: '商品 2', price: '¥299', image: '' },
    { id: 3, name: '商品 3', price: '¥399', image: '' },
  ]

  build() {
    Swiper() {
      ForEach(this.products, (product: ProductItem) => {
        SwiperItem() {
          Column({ space: 12 }) {
            // 商品图片
            Column() {
              Text('商品图片')
                .fontSize(16)
                .fontColor('#999999')
            }
            .width('100%')
            .height(180)
            .backgroundColor('#F5F5F5')
            .borderRadius({ topLeft: 12, topRight: 12 })
            .justifyContent(FlexAlign.Center)

            // 商品信息
            Column({ space: 8 }) {
              Text(product.name)
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')

              Text(product.price)
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FF6B6B')
            }
            .alignItems(HorizontalAlign.Start)
            .padding({ left: 16, right: 16, bottom: 16 })
          }
          .width('100%')
          .height(280)
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .shadow({ radius: 8, color: '#1F000000', offsetX: 0, offsetY: 2 })
        }
      })
    }
    .width('100%')
    .height(300)
    .loop(true)
    .autoPlay(true)
    .interval(3000)
    .displayCount(1.2)  // 显示部分下一页
    .previousMargin(16)
    .nextMargin(16)
    .itemSpace(16)
    .indicator(false)
  }
}

interface ProductItem {
  id: number
  name: string
  price: string
  image: string
}
```

### 3.10 图片预览器

```typescript
@ComponentV2
struct ImagePreviewer {
  @Param images: string[] = []
  @Param initialIndex: number = 0
  @Local currentIndex: number = 0

  aboutToAppear() {
    this.currentIndex = this.initialIndex
  }

  build() {
    Stack() {
      // 黑色背景
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#000000')

      // Swiper 图片预览
      Swiper() {
        ForEach(this.images, (image: string) => {
          SwiperItem() {
            Image(image)
              .width('100%')
              .height('100%')
              .objectFit(ImageFit.Contain)
          }
        })
      }
      .width('100%')
      .height('100%')
      .index(this.currentIndex)
      .loop(false)
      .indicator(false)
      .onChange((index: number) => {
        this.currentIndex = index
      })

      // 顶部工具栏
      Row() {
        Text(`${this.currentIndex + 1} / ${this.images.length}`)
          .fontSize(16)
          .fontColor(Color.White)
      }
      .width('100%')
      .padding(16)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
  }
}
```

## 四、最佳实践

### 4.1 性能优化

**1. 懒加载图片**
```typescript
Swiper() {
  ForEach(this.imageList, (image: ImageData, index: number) => {
    SwiperItem() {
      Image(image.url)
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Cover)
        .onAppear(() => {
          // 图片进入可视区域时加载
          image.load()
        })
        .onDisappear(() => {
          // 图片离开可视区域时释放资源
          image.release()
        })
    }
  })
}
```

**2. 限制 SwiperItem 数量**
- 避免在单个 Swiper 中放置过多子组件（建议不超过 10 个）
- 对于大量数据，考虑分页或虚拟滚动

**3. 避免嵌套滚动**
```typescript
// 不推荐：Swiper 中嵌套可滚动组件
Swiper() {
  SwiperItem() {
    List() {  // 可能导致手势冲突
      // ...
    }
  }
}

// 推荐：使用固定布局
Swiper() {
  SwiperItem() {
    Column() {
      // 使用固定内容
    }
  }
}
```

### 4.2 响应式设计

**1. 自适应尺寸**
```typescript
@ComponentV2
struct ResponsiveSwiper {
  @Local windowWidth: number = 0

  build() {
    Swiper() {
      // ...
    }
    .width('100%')
    .height(this.windowWidth * 0.5)  // 根据屏幕宽度动态计算高度
    .onAreaChange((value: Area) => {
      this.windowWidth = value.width as number
    })
  }
}
```

**2. 不同设备适配**
```typescript
@ComponentV2
struct AdaptiveSwiper {
  @Local isFoldable: boolean = false

  build() {
    Swiper() {
      // ...
    }
    .displayCount(this.isFoldable ? 2 : 1)  // 折叠屏显示更多
    .itemSpace(this.isFoldable ? 16 : 0)
  }
}
```

### 4.3 用户体验

**1. 合理的动画时长**
```typescript
Swiper()
  .duration(400)  // 推荐 300-500ms
  .curve(Curve.EaseInOut)  // 使用缓动曲线
```

**2. 自动播放设置**
```typescript
Swiper()
  .autoPlay(true)
  .interval(3000)  // 推荐 2-5 秒
  .loop(true)  // 启用循环播放
```

**3. 指示器位置**
```typescript
Swiper()
  .indicator(true)
  .indicatorStyle({
    bottom: 16,  // 距离底部合适距离
    size: 8,
    selectedSize: 8,
    color: 'rgba(255, 255, 255, 0.5)',
    selectedColor: '#FFFFFF'
  })
```

### 4.4 错误处理

**1. 加载失败处理**
```typescript
SwiperItem() {
  if (this.imageLoaded) {
    Image(this.imageUrl)
      .width('100%')
      .height('100%')
  } else if (this.imageError) {
    Column() {
      Text('图片加载失败')
        .fontSize(14)
        .fontColor('#999999')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
    .justifyContent(FlexAlign.Center)
  } else {
    Column() {
      LoadingProgress()
        .width(40)
        .height(40)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}
```

**2. 边界检查**
```typescript
@ComponentV2
struct SafeSwiper {
  swiperController: SwiperController = new SwiperController()
  @Local currentIndex: number = 0
  private totalItems: number = 5

  jumpToPage(index: number) {
    // 边界检查
    const safeIndex = Math.max(0, Math.min(index, this.totalItems - 1))
    this.swiperController.swipeTo(safeIndex)
  }
}
```

### 4.5 可访问性

**1. 语义化描述**
```typescript
Swiper()
  .accessibilityGroup(true)
  .accessibilityLevel('critical')
  .accessibilityText('图片轮播组件')
```

**2. 键盘导航**
```typescript
@ComponentV2
struct AccessibleSwiper {
  swiperController: SwiperController = new SwiperController()

  build() {
    Swiper(this.swiperController) {
      // ...
    }
    .onKeyEvent((event: KeyEvent) => {
      if (event.type === KeyType.Down) {
        if (event.keyCode === KeyCode.KEYCODE_DPAD_LEFT) {
          this.swiperController.showPrevious()
          return true
        } else if (event.keyCode === KeyCode.KEYCODE_DPAD_RIGHT) {
          this.swiperController.showNext()
          return true
        }
      }
      return false
    })
  }
}
```

## 五、常见问题

### 5.1 Swiper 不显示

**问题**: Swiper 组件在页面上不显示

**可能原因**:
1. 未设置 width 和 height
2. SwiperItem 内容为空
3. backgroundColor 设置为透明且内容不可见

**解决方案**:
```typescript
Swiper()
  .width('100%')   // 必须设置明确的尺寸
  .height(200)
  .backgroundColor('#F5F5F5')  // 设置背景色便于调试
```

### 5.2 指示器不显示

**问题**: indicator 设置为 true 但不显示

**可能原因**:
1. Swiper 高度太小，指示器被裁剪
2. indicatorStyle 颜色与背景色相同
3. 指示器位置超出 Swiper 边界

**解决方案**:
```typescript
Swiper()
  .height(200)  // 确保足够的高度
  .indicator(true)
  .indicatorStyle({
    bottom: 16,  // 设置合适的边距
    color: '#CCCCCC',
    selectedColor: '#FF6B6B',
    size: 8
  })
```

### 5.3 自动播放不工作

**问题**: autoPlay 设置为 true 但不自动播放

**可能原因**:
1. 应用在后台运行
2. 设置了 disableSwipe(true)
3. interval 设置过小

**解决方案**:
```typescript
Swiper()
  .autoPlay(true)
  .interval(3000)  // 推荐至少 1000ms
  .loop(true)      // 自动播放通常需要循环模式
```

### 5.4 滑动卡顿

**问题**: Swiper 滑动时卡顿不流畅

**可能原因**:
1. SwiperItem 内容过于复杂
2. 图片未进行懒加载
3. 同时存在过多动画效果

**解决方案**:
```typescript
// 1. 简化 SwiperItem 内容
SwiperItem() {
  Image(imageUrl)
    .width('100%')
    .height('100%')
    .objectFit(ImageFit.Cover)
    .syncLoad(false)  // 异步加载
}

// 2. 减少动画复杂度
Swiper()
  .duration(300)  // 缩短动画时长
  .curve(Curve.EaseInOut)  // 使用简单的动画曲线

// 3. 限制子组件数量
Swiper() {
  ForEach(this.items.slice(0, 10), (item) => {  // 限制数量
    SwiperItem() {
      // ...
    }
  })
}
```

### 5.5 手势冲突

**问题**: Swiper 与其他可滚动组件手势冲突

**解决方案**:
```typescript
// 方案 1: 使用不同的滑动方向
Column() {
  // 水平 Swiper
  Swiper()
    .orientation(SwiperOrientation.Horizontal)

  // 垂直 List
  List()
    .scrollDirection(ScrollDirection.Vertical)
}

// 方案 2: 禁用嵌套滚动
Swiper() {
  SwiperItem() {
    List() {
      // ...
    }
    .scrollBar(BarState.Off)  // 隐藏滚动条
    .enableScrollInteraction(false)  // 禁用滚动交互
  }
}

// 方案 3: 使用自定义手势处理
Swiper()
  .onTouch((event: TouchEvent) => {
    if (event.type === TouchType.Down) {
      // 记录起始点
    }
  })
```

### 5.6 状态不同步

**问题**: 使用 Controller 跳转后，onChange 回调的 index 与实际不符

**解决方案**:
```typescript
@ComponentV2
struct SyncSwiper {
  @Local currentIndex: number = 0
  swiperController: SwiperController = new SwiperController()

  build() {
    Column() {
      Swiper(this.swiperController)
        .index(this.currentIndex)  // 双向绑定
        .onChange((index: number) => {
          this.currentIndex = index
        })

      Button('Jump')
        .onClick(() => {
          const targetIndex = 2
          this.currentIndex = targetIndex  // 先更新状态
          this.swiperController.swipeTo(targetIndex)
        })
    }
  }
}
```

### 5.7 内存泄漏

**问题**: 大量图片轮播导致内存占用过高

**解决方案**:
```typescript
@ComponentV2
struct MemorySafeSwiper {
  @Local currentIndex: number = 0
  private imageCache: Map<string, ImagePixelMap> = new Map()

  build() {
    Swiper() {
      ForEach(this.images, (image: ImageData, index: number) => {
        SwiperItem() {
          Image(image.url)
            .onAppear(() => {
              // 只加载当前和相邻的图片
              if (Math.abs(index - this.currentIndex) <= 1) {
                this.loadImage(image.url)
              }
            })
            .onDisappear(() => {
              // 释放远离的图片资源
              if (Math.abs(index - this.currentIndex) > 1) {
                this.releaseImage(image.url)
              }
            })
        }
      })
    }
    .onChange((index: number) => {
      this.currentIndex = index
      // 清理不需要的缓存
      this.cleanupCache(index)
    })
  }

  private loadImage(url: string) {
    // 加载图片
  }

  private releaseImage(url: string) {
    // 释放图片资源
    this.imageCache.delete(url)
  }

  private cleanupCache(currentIndex: number) {
    // 清理距离当前索引超过 2 的图片
    for (const [url,] of this.imageCache) {
      const index = this.getImageIndex(url)
      if (Math.abs(index - currentIndex) > 2) {
        this.releaseImage(url)
      }
    }
  }

  private getImageIndex(url: string): number {
    return this.images.findIndex(img => img.url === url)
  }
}
```

### 5.8 折叠屏适配问题

**问题**: 在折叠屏设备上显示异常

**解决方案**:
```typescript
@ComponentV2
struct FoldableSwiper {
  @Local displayCount: number = 1
  @Local itemSpace: number = 0

  aboutToAppear() {
    this.updateLayout()
  }

  build() {
    Swiper() {
      // ...
    }
    .displayCount(this.displayCount)
    .itemSpace(this.itemSpace)
    .onAreaChange(() => {
      this.updateLayout()
    })
  }

  private updateLayout() {
    // 根据屏幕宽度调整布局
    const screenWidth = display.getDefaultDisplaySync().width
    if (screenWidth > 768) {  // 平板或展开状态
      this.displayCount = 2
      this.itemSpace = 16
    } else {  // 手机或折叠状态
      this.displayCount = 1
      this.itemSpace = 0
    }
  }
}
```

## 六、进阶技巧

### 6.1 视差效果

```typescript
@ComponentV2
struct ParallaxSwiper {
  @Local offsetRatio: number = 0

  build() {
    Swiper() {
      ForEach([1, 2, 3], (item: number) => {
        SwiperItem() {
          Stack() {
            // 背景图片（视差移动）
            Image($r('app.media.bg'))
              .width('120%')
              .height('120%')
              .offset({
                x: this.offsetRatio * 50,
                y: 0
              })

            // 前景内容
            Text(`Page ${item}`)
              .fontSize(32)
              .fontColor(Color.White)
          }
        }
      })
    }
    .width('100%')
    .height(300)
    .onChange((index: number) => {
      // 计算偏移比例
    })
    .onGestureSwipe((index: number, info: SwiperAnimationInfo) => {
      this.offsetRatio = info.currentOffsetRatio
    })
  }
}
```

### 6.2 自定义动画效果

```typescript
@ComponentV2
struct CustomAnimationSwiper {
  @Local currentIndex: number = 0
  @Local animationProgress: number = 0

  build() {
    Swiper() {
      ForEach([1, 2, 3], (item: number) => {
        SwiperItem() {
          Column() {
            Text(`Page ${item}`)
              .fontSize(30)
              .scale({
                x: 1 - Math.abs(this.animationProgress) * 0.2,
                y: 1 - Math.abs(this.animationProgress) * 0.2
              })
              .opacity(1 - Math.abs(this.animationProgress) * 0.5)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
        }
      })
    }
    .width('100%')
    .height(300)
    .onAnimationStart((index: number) => {
      this.currentIndex = index
    })
    .onGestureSwipe((index: number, info: SwiperAnimationInfo) => {
      this.animationProgress = info.slideOffsetRatio
    })
    .onAnimationEnd((index: number) => {
      this.animationProgress = 0
    })
  }
}
```

### 6.3 无限循环优化

```typescript
@ComponentV2
struct InfiniteSwiper {
  @Local items: number[] = [1, 2, 3, 4, 5]
  @Local displayItems: number[] = []

  aboutToAppear() {
    // 在首尾各添加两个元素实现无缝循环
    this.displayItems = [
      this.items[this.items.length - 2],
      this.items[this.items.length - 1],
      ...this.items,
      this.items[0],
      this.items[1]
    ]
  }

  build() {
    Swiper() {
      ForEach(this.displayItems, (item: number) => {
        SwiperItem() {
          Text(`${item}`)
            .fontSize(30)
        }
      })
    }
    .width('100%')
    .height(200)
    .loop(true)
    .index(2)  // 从实际第一个元素开始
  }
}
```

## 七、总结

Swiper 是 HarmonyOS 中功能强大的轮播组件，适用于多种场景：

- **轮播图**: 首页 Banner、广告位
- **引导页**: 应用首次启动引导
- **图片预览**: 图库查看、大图浏览
- **卡片滑动**: 商品展示、内容推荐
- **标签切换**: 自定义 Tab 切换效果

**关键要点**:
1. 子组件必须是 SwiperItem
2. 合理设置 autoPlay、loop、interval 参数
3. 使用 SwiperController 实现程序化控制
4. 注意性能优化，避免内存泄漏
5. 处理好手势冲突和状态同步问题

**参考资源**:
- [Swiper 官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-container-swiper-V14)
- [使用 Swiper 构建运营推荐位](https://developer.huawei.com/consumer/cn/codelabsPortal/carddetails/tutorials_Next-SwiperBanner)
