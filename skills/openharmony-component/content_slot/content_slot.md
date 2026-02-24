# ContentSlot 组件 HarmonyOS 6.0 开发 Skill

## 概述

ContentSlot 是 OpenHarmony 中用于内容占位的特殊容器组件。它允许开发者在特定位置预留内容空间，通常用于动态内容加载、延迟渲染或作为占位符使用。

## 重要说明

- **占位符组件**: ContentSlot 本身不渲染任何可见内容
- **动态内容**: 主要用于动态插入子组件
- **性能优化**: 可以延迟内容渲染，提升页面加载性能
- **布局控制**: 保留内容的空间，即使内容尚未加载
- **使用场景**: 懒加载、条件渲染、动态模板

## 模块信息

- **组件名称**: ContentSlot
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [ContentSlot - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-content-slot-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// ContentSlot 是系统内置组件，无需额外导入
// 直接在 build 方法中使用即可
```

### 1.2 基础用法

```typescript
@ComponentV2
struct ContentSlotExample {
  @Local contentLoaded: boolean = false

  build() {
    Column() {
      if (this.contentLoaded) {
        Text('实际内容')
      } else {
        ContentSlot()
          .width(200)
          .height(100)
          .backgroundColor('#F5F5F5')
      }

      Button('加载内容')
        .onClick(() => {
          this.contentLoaded = true
        })
    }
  }
}
```

## 二、API 参数

### 2.1 ContentSlot 属性

ContentSlot 继承自基础组件，支持以下属性：

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `width` | `number \| string` | - | 组件宽度 |
| `height` | `number \| string` | - | 组件高度 |
| `size` | `Size` | - | 组件尺寸（宽高同时设置） |
| `backgroundColor` | `ResourceColor` | - | 背景颜色 |
| `borderRadius` | `number \| string` | - | 圆角半径 |

### 2.2 通用属性

ContentSlot 支持所有通用属性：
- 尺寸属性：width, height, size, constraintSize
- 位置属性：position, offset, align, alignment
- 背景属性：backgroundColor, backgroundImage
- 边框属性：border, borderRadius, borderStyle
- 透明度：opacity
- 显示控制：visibility, display

## 三、使用示例

### 3.1 基础占位符

```typescript
@ComponentV2
struct BasicContentSlotExample {
  @Local isLoading: boolean = true

  build() {
    Column({ space: 16 }) {
      Text('基础占位符示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      if (this.isLoading) {
        // 加载占位符
        ContentSlot()
          .width('100%')
          .height(200)
          .backgroundColor('#F0F0F0')
          .borderRadius(8)
      } else {
        // 实际内容
        Column() {
          Text('内容已加载')
            .fontSize(16)
          Text('这是实际显示的内容')
            .fontSize(14)
            .fontColor('#666666')
        }
        .width('100%')
        .padding(20)
        .backgroundColor('#FFFFFF')
        .borderRadius(8)
      }

      Button(this.isLoading ? '加载内容' : '重新加载')
        .onClick(() => {
          this.isLoading = !this.isLoading
        })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.2 列表项占位符

```typescript
@ComponentV2
struct ListItemContentSlotExample {
  @Local items: string[] = []
  @Local loading: boolean = false

  loadItems() {
    this.loading = true
    // 模拟异步加载
    setTimeout(() => {
      this.items = ['项目1', '项目2', '项目3', '项目4', '项目5']
      this.loading = false
    }, 2000)
  }

  build() {
    Column() {
      Button('加载数据')
        .onClick(() => {
          this.loadItems()
        })

      List() {
        if (this.loading) {
          // 显示占位符
          ForEach([1, 2, 3, 4, 5], (item: number) => {
            ListItem() {
              ContentSlot()
                .width('100%')
                .height(60)
                .backgroundColor('#F0F0F0')
                .borderRadius(8)
                .margin({ bottom: 8 })
            }
          })
        } else {
          // 显示实际数据
          ForEach(this.items, (item: string) => {
            ListItem() {
              Text(item)
                .width('100%')
                .height(60)
                .padding(16)
                .backgroundColor('#FFFFFF')
                .borderRadius(8)
                .margin({ bottom: 8 })
            }
          })
        }
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(16)
  }
}
```

### 3.3 卡片占位符

```typescript
@ComponentV2
struct CardContentSlotExample {
  @Local cardData?: { title: string, content: string }

  build() {
    Column({ space: 16 }) {
      if (this.cardData) {
        // 实际卡片内容
        Column() {
          Text(this.cardData.title)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
          Text(this.cardData.content)
            .fontSize(14)
            .fontColor('#666666')
            .margin({ top: 8 })
        }
        .width('100%')
        .padding(20)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .shadow({
          radius: 8,
          color: 'rgba(0, 0, 0, 0.1)',
          offsetX: 0,
          offsetY: 2
        })
      } else {
        // 卡片占位符
        Column() {
          ContentSlot()
            .width('80%')
            .height(20)
            .backgroundColor('#E0E0E0')
            .borderRadius(4)
            .margin({ bottom: 12 })

          ContentSlot()
            .width('100%')
            .height(60)
            .backgroundColor('#E0E0E0')
            .borderRadius(4)
        }
        .width('100%')
        .padding(20)
        .backgroundColor('#F5F5F5')
        .borderRadius(12)
      }

      Button('加载卡片')
        .onClick(() => {
          setTimeout(() => {
            this.cardData = {
              title: '卡片标题',
              content: '这是卡片的实际内容'
            }
          }, 1500)
        })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.4 图片占位符

```typescript
@ComponentV2
struct ImageContentSlotExample {
  @Local imageUrl: string = ''
  @Local imageLoading: boolean = false

  loadImage() {
    this.imageLoading = true
    // 模拟图片加载
    setTimeout(() => {
      this.imageUrl = 'https://example.com/image.jpg'
      this.imageLoading = false
    }, 2000)
  }

  build() {
    Column({ space: 16 }) {
      if (this.imageUrl && !this.imageLoading) {
        // 显示实际图片
        Image(this.imageUrl)
          .width('100%')
          .height(200)
          .borderRadius(12)
          .objectFit(ImageFit.Cover)
      } else {
        // 图片占位符
        Column() {
          ContentSlot()
            .width(60)
            .height(60)
            .backgroundColor('#E0E0E0')
            .borderRadius(30)

          Text('加载中...')
            .fontSize(14)
            .fontColor('#999999')
            .margin({ top: 16 })
        }
        .width('100%')
        .height(200)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#F5F5F5')
        .borderRadius(12)
      }

      Button('加载图片')
        .onClick(() => {
          this.loadImage()
        })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.5 动态内容占位

```typescript
@ComponentV2
struct DynamicContentSlotExample {
  @Local contentType: 'text' | 'image' | 'video' | null = null

  loadContent(type: 'text' | 'image' | 'video') {
    this.contentType = null
    setTimeout(() => {
      this.contentType = type
    }, 1000)
  }

  build() {
    Column({ space: 16 }) {
      Text('动态内容加载')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 内容区域
      if (this.contentType === null) {
        // 占位符
        ContentSlot()
          .width('100%')
          .height(250)
          .backgroundColor('#F5F5F5')
          .borderRadius(12)
      } else if (this.contentType === 'text') {
        Text('这是文本内容')
          .width('100%')
          .padding(20)
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
      } else if (this.contentType === 'image') {
        Column() {
          Text('图片内容')
            .fontSize(16)
        }
        .width('100%')
        .height(250)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#E3F2FD')
        .borderRadius(12)
      } else if (this.contentType === 'video') {
        Column() {
          Text('视频内容')
            .fontSize(16)
        }
        .width('100%')
        .height(250)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#FFF3E0')
        .borderRadius(12)
      }

      // 按钮组
      Row({ space: 12 }) {
        Button('文本')
          .onClick(() => {
            this.loadContent('text')
          })

        Button('图片')
          .onClick(() => {
            this.loadContent('image')
          })

        Button('视频')
          .onClick(() => {
            this.loadContent('video')
          })
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.6 带动画的占位符

```typescript
@ComponentV2
struct AnimatedContentSlotExample {
  @Local isLoading: boolean = true
  @Local opacity: number = 1

  loadContent() {
    animateTo({
      duration: 300,
      curve: Curve.EaseInOut
    }, () => {
      this.opacity = 0
    })

    setTimeout(() => {
      this.isLoading = false
      animateTo({
        duration: 300,
        curve: Curve.EaseInOut
      }, () => {
        this.opacity = 1
      })
    }, 300)
  }

  build() {
    Column({ space: 16 }) {
      if (this.isLoading) {
        // 占位符带闪烁动画
        ContentSlot()
          .width('100%')
          .height(150)
          .backgroundColor('#F0F0F0')
          .borderRadius(12)
          .opacity(this.opacity)
      } else {
        // 实际内容
        Column() {
          Text('加载完成的内容')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
          Text('内容已成功加载并显示')
            .fontSize(14)
            .fontColor('#666666')
            .margin({ top: 8 })
        }
        .width('100%')
        .padding(20)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .shadow({
          radius: 8,
          color: 'rgba(0, 0, 0, 0.1)',
          offsetX: 0,
          offsetY: 2
        })
        .opacity(this.opacity)
      }

      Button(this.isLoading ? '加载内容' : '重新加载')
        .onClick(() => {
          if (this.isLoading) {
            this.loadContent()
          } else {
            this.isLoading = true
          }
        })
    }
    .width('100%')
    .padding(16)
  }
}
```

## 四、高级用法

### 4.1 骨架屏效果

```typescript
@ComponentV2
struct SkeletonScreenExample {
  @Local loading: boolean = true
  @Local userData?: { name: string, avatar: string, bio: string }

  build() {
    Column() {
      if (this.loading) {
        // 骨架屏
        Column({ space: 16 }) {
          Row({ space: 16 }) {
            ContentSlot()
              .width(60)
              .height(60)
              .backgroundColor('#E0E0E0')
              .borderRadius(30)

            Column({ space: 8 }) {
              ContentSlot()
                .width(120)
                .height(16)
                .backgroundColor('#E0E0E0')
                .borderRadius(4)

              ContentSlot()
                .width(80)
                .height(14)
                .backgroundColor('#E0E0E0')
                .borderRadius(4)
            }
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding(16)

          ContentSlot()
            .width('100%')
            .height(100)
            .backgroundColor('#E0E0E0')
            .borderRadius(8)
        }
        .width('100%')
        .padding(16)
      } else {
        // 实际用户信息
        Column({ space: 16 }) {
          Row({ space: 16 }) {
            Text('头像')
              .width(60)
              .height(60)
              .fontSize(24)
              .backgroundColor('#007DFF')
              .fontColor(Color.White)
              .borderRadius(30)
              .textAlign(TextAlign.Center)

            Column({ space: 8 }) {
              Text(this.userData?.name ?? '用户名')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)

              Text(this.userData?.bio ?? '个人简介')
                .fontSize(14)
                .fontColor('#666666')
            }
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding(16)

          Text('用户详细内容...')
            .fontSize(14)
            .width('100%')
            .padding(16)
            .backgroundColor('#F5F5F5')
            .borderRadius(8)
        }
        .width('100%')
      }

      Button('切换状态')
        .onClick(() => {
          if (this.loading) {
            this.userData = {
              name: '张三',
              avatar: '',
              bio: '这是个人简介'
            }
            this.loading = false
          } else {
            this.loading = true
            this.userData = undefined
          }
        })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 4.2 条件渲染占位

```typescript
@ComponentV2
struct ConditionalContentSlotExample {
  @Local selectedTab: number = 0
  @Local tabContent: string[] = ['', '', '']
  @Local loading: boolean = false

  loadTabContent(index: number) {
    this.selectedTab = index
    this.loading = true

    setTimeout(() => {
      this.tabContent = ['内容1', '内容2', '内容3']
      this.loading = false
    }, 1000)
  }

  @Builder
  TabContent(index: number) {
    if (this.loading) {
      ContentSlot()
        .width('100%')
        .height(200)
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
    } else {
      Text(this.tabContent[index])
        .width('100%')
        .height(200)
        .padding(20)
        .backgroundColor('#FFFFFF')
        .borderRadius(8)
    }
  }

  build() {
    Column() {
      // 标签页
      Row({ space: 8 }) {
        ForEach(['标签1', '标签2', '标签3'], (tab: string, index: number) => {
          Button(tab)
            .type(ButtonType.Normal)
            .backgroundColor(this.selectedTab === index ? '#007DFF' : '#E0E0E0')
            .fontColor(this.selectedTab === index ? Color.White : '#333333')
            .onClick(() => {
              this.loadTabContent(index)
            })
        })
      }
      .width('100%')
      .margin({ bottom: 16 })

      // 内容区
      this.TabContent(this.selectedTab)
    }
    .width('100%')
    .padding(16)
  }
}
```

## 五、最佳实践

### 5.1 占位符尺寸

```typescript
// ✅ 推荐：占位符尺寸与实际内容一致
Column() {
  if (this.loading) {
    ContentSlot()
      .width('100%')
      .height(200)  // 与实际内容高度一致
      .backgroundColor('#F5F5F5')
  } else {
    Text('实际内容')
      .width('100%')
      .height(200)
  }
}

// ❌ 避免：占位符与实际尺寸差异过大
```

### 5.2 视觉反馈

```typescript
// ✅ 推荐：添加加载提示
Column() {
  if (this.loading) {
    Column() {
      ContentSlot()
        .width('100%')
        .height(150)
      Text('加载中...')
        .fontSize(14)
        .fontColor('#999999')
        .margin({ top: 8 })
    }
  }
}

// ✅ 推荐：使用动画过渡
.animateTo({ duration: 300 }, () => {
  // 切换内容状态
})
```

### 5.3 性能优化

```typescript
// ✅ 推荐：懒加载时使用占位符
@ComponentV2
struct LazyLoadExample {
  @Local shouldLoad: boolean = false

  build() {
    Column() {
      if (!this.shouldLoad) {
        ContentSlot()
          .width(100)
          .height(100)
          .onClick(() => {
            this.shouldLoad = true  // 点击时才加载
          })
      } else {
        HeavyComponent()  // 延迟加载的重量级组件
      }
    }
  }
}
```

### 5.4 可访问性

```typescript
// ✅ 推荐：为占位符添加说明
Column() {
  if (this.loading) {
    Column() {
      ContentSlot()
        .width('100%')
        .height(200)
        .backgroundColor('#F5F5F5')
      Text('正在加载内容，请稍候...')
        .fontSize(14)
        .fontColor('#666666')
        .margin({ top: 8 })
    }
  }
}
```

## 六、常见问题

### Q1: ContentSlot 不显示任何内容？

**问题**: 设置了 ContentSlot 但页面上看不到任何内容。

**解决方案**:
```typescript
// ContentSlot 需要设置尺寸才能看到
ContentSlot()
  .width(200)  // 必须设置宽度
  .height(100)  // 必须设置高度
  .backgroundColor('#F5F5F5')  // 设置背景色以便观察
```

### Q2: 如何让占位符更美观？

**解决方案**:
```typescript
// 添加样式和动画
ContentSlot()
  .width('100%')
  .height(200)
  .backgroundColor('#F5F5F5')
  .borderRadius(12)
  .border({ width: 1, color: '#E0E0E0', style: BorderStyle.Dashed })
```

### Q3: ContentSlot 与其他容器组件的区别？

**说明**:
- **ContentSlot**: 专门用于占位，不渲染内容
- **Column/Row**: 布局容器，会渲染子组件
- **Blank**: 弹性空间填充
- **Divider**: 分隔线

```typescript
// ContentSlot 用于占位
ContentSlot()
  .width(100)
  .height(100)
  .backgroundColor('#F5F5F5')

// Blank 用于填充空间
Blank()
  .width('100%')
  .height('100%')
```

### Q4: 如何实现骨架屏闪烁效果？

**解决方案**:
```typescript
@ComponentV2
struct ShimmerExample {
  @Local opacity: number = 0.3

  aboutToAppear() {
    setInterval(() => {
      animateTo({
        duration: 1000,
        curve: Curve.EaseInOut
      }, () => {
        this.opacity = this.opacity === 0.3 ? 0.6 : 0.3
      })
    }, 1000)
  }

  build() {
    ContentSlot()
      .width('100%')
      .height(100)
      .backgroundColor('#E0E0E0')
      .opacity(this.opacity)
  }
}
```

### Q5: 占位符在列表中的性能？

**解决方案**:
```typescript
// ✅ 使用简单的 ContentSlot 而非复杂组件
List() {
  ForEach([1, 2, 3, 4, 5], (item: number) => {
    ListItem() {
      ContentSlot()  // 简单高效
        .width('100%')
        .height(60)
        .backgroundColor('#F5F5F5')
    }
  })
}

// ❌ 避免使用复杂的占位符组件
```

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 10+ | ✅ | 基础功能支持 |
| API 11+ | ✅ | 增强了样式属性支持 |
| API 12+ | ✅ | 完整功能支持 |

## 八、参考资料

- [ContentSlot 内容占位符 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-content-slot-V5)
- [性能优化指南 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/arkts-performance-improvement-V5)
- [骨架屏设计 - HarmonyOS 设计指南](https://developer.huawei.com/consumer/cn/design/harmonyos-/guidelines/skeleton-screen.html)
