# Tabs 组件 HarmonyOS 6.0 开发 Skill

## 概述

Tabs 组件是 OpenHarmony 中的标签页容器组件，用于实现页面的标签切换功能。它通过 TabContent 子组件来定义每个标签页的内容，支持多种布局模式和自定义样式。

## 重要说明

- **基础组件**: Tabs 是 ArkUI 的基础内置组件，无需导入
- **子组件**: 必须配合 TabContent 使用
- **布局模式**: 支持顶部固定、底部固定、左侧固定、右侧固定四种模式
- **响应式**: 配合 @State/@Local 使用实现响应式更新
- **滑动支持**: 支持手势滑动切换标签页

## 模块信息

- **组件名称**: Tabs
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [Tabs - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-tabs-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// Tabs 是内置组件，无需导入
// 直接使用即可
Tabs() {
  TabContent() {
    // 内容
  }
}
```

### 1.2 基础用法

```typescript
// 简单的标签页
Tabs() {
  TabContent() {
    Text('标签页 1')
  }
  .tabBar('首页')

  TabContent() {
    Text('标签页 2')
  }
  .tabBar('发现')
}

// 垂直标签页
Tabs({ barPosition: BarPosition.Start }) {
  TabContent() {
    Text('标签页 1')
  }
  .tabBar('标签 1')
}
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| barPosition | `BarPosition` | 否 | BarPosition.Start | 标签栏位置 |
| index | `number` | 否 | 0 | 初始选中标签索引 |

### 2.2 BarPosition 枚举

| 值 | 描述 | 使用场景 |
|----|------|----------|
| `BarPosition.Start` | 标签栏在顶部/左侧 | 默认模式，顶部标签页 |
| `BarPosition.End` | 标签栏在底部/右侧 | 底部导航栏模式 |
| `BarPosition.Top` (已废弃) | 标签栏在顶部 | 使用 Start 替代 |
| `BarPosition.Bottom` (已废弃) | 标签栏在底部 | 使用 End 替代 |

### 2.3 Tabs 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `barPosition` | `BarPosition` | BarPosition.Start | 标签栏位置 |
| `index` | `number` | 0 | 当前选中标签索引 |
| `animationDuration` | `number` | 300 | 切换动画时长（ms） |
| `scrollable` | `boolean` | true | 是否支持滑动切换 |
| `barMode` | `BarMode` | BarMode.Fixed | 标签栏模式 |
| `barWidth` | `number \| string` | - | 标签栏宽度 |
| `barHeight` | `number \| string` | - | 标签栏高度 |
| `vertical` | `boolean` | false | 是否为垂直标签页 |

### 2.4 BarMode 枚举

| 值 | 描述 |
|----|------|
| `BarMode.Fixed` | 固定模式，所有标签平分空间 |
| `BarMode.Scrollable` | 可滚动模式，标签可滚动 |

### 2.5 样式属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `divider` | `DividerStyle \| null` | - | 分割线样式 |
| `barBackgroundColor` | `ResourceColor` | - | 标签栏背景色 |
| `barOverlay` | `boolean` | false | 标签栏是否浮在内容上方 |

### 2.6 事件回调

| 事件 | 类型 | 描述 |
|------|------|------|
| `onChange` | `(index: number) => void` | 标签切换回调 |

## 三、使用示例

### 3.1 基础标签页示例

```typescript
@ComponentV2
struct BasicTabsExample {
  @Local currentIndex: number = 0

  build() {
    Tabs({ index: this.currentIndex }) {
      TabContent() {
        Column() {
          Text('首页内容')
            .fontSize(24)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .tabBar('首页')

      TabContent() {
        Column() {
          Text('发现内容')
            .fontSize(24)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .tabBar('发现')

      TabContent() {
        Column() {
          Text('我的内容')
            .fontSize(24)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .tabBar('我的')
    }
    .width('100%')
    .height('100%')
    .onChange((index: number) => {
      this.currentIndex = index
      console.info('Selected tab: ' + index)
    })
  }
}
```

### 3.2 底部导航栏示例

```typescript
@ComponentV2
struct BottomTabsExample {
  @Local currentIndex: number = 0

  build() {
    Tabs({ barPosition: BarPosition.End, index: this.currentIndex }) {
      TabContent() {
        Column() {
          Text('首页')
            .fontSize(24)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .tabBar(this.tabBuilder('首页', 0, '\uE100'))

      TabContent() {
        Column() {
          Text('订单')
            .fontSize(24)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .tabBar(this.tabBuilder('订单', 1, '\uE101'))

      TabContent() {
        Column() {
          Text('我的')
            .fontSize(24)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .tabBar(this.tabBuilder('我的', 2, '\uE102'))
    }
    .width('100%')
    .height('100%')
    .barHeight(60)
    .onChange((index: number) => {
      this.currentIndex = index
    })
  }

  @Builder
  tabBuilder(title: string, index: number, icon: string) {
    Column({ space: 4 }) {
      Text(icon)
        .fontSize(24)
        .fontColor(this.currentIndex === index ? '#007DFF' : '#999999')

      Text(title)
        .fontSize(12)
        .fontColor(this.currentIndex === index ? '#007DFF' : '#999999')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}
```

### 3.3 可滚动标签栏示例

```typescript
@ComponentV2
struct ScrollableTabsExample {
  @Local currentIndex: number = 0

  build() {
    Tabs({ barPosition: BarPosition.Start, index: this.currentIndex }) {
      ForEach(['推荐', '热门', '视频', '音乐', '图片', '新闻', '体育', '科技'], (title: string, index: number) => {
        TabContent() {
          Column() {
            Text(`${title}内容`)
              .fontSize(24)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
        }
        .tabBar(title)
      })
    }
    .width('100%')
    .height('100%')
    .barMode(BarMode.Scrollable)
    .barHeight(50)
    .onChange((index: number) => {
      this.currentIndex = index
    })
  }
}
```

### 3.4 垂直标签页示例

```typescript
@ComponentV2
struct VerticalTabsExample {
  @Local currentIndex: number = 0

  build() {
    Tabs({ barPosition: BarPosition.Start, index: this.currentIndex }) {
      TabContent() {
        Column() {
          Text('标签页 1 内容')
            .fontSize(20)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .tabBar('标签 1')

      TabContent() {
        Column() {
          Text('标签页 2 内容')
            .fontSize(20)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .tabBar('标签 2')
    }
    .width('100%')
    .height('100%')
    .vertical(true)
    .barWidth(100)
    .onChange((index: number) => {
      this.currentIndex = index
    })
  }
}
```

### 3.5 自定义样式标签页示例

```typescript
@ComponentV2
struct CustomStyleTabsExample {
  @Local currentIndex: number = 0

  build() {
    Tabs({ index: this.currentIndex }) {
      TabContent() {
        Column() {
          Text('聊天')
            .fontSize(24)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#F5F5F5')
      }
      .tabBar(this.customTabBuilder('聊天', 0, 5))

      TabContent() {
        Column() {
          Text('联系人')
            .fontSize(24)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#FFFFFF')
      }
      .tabBar(this.customTabBuilder('联系人', 1, 0))

      TabContent() {
        Column() {
          Text('动态')
            .fontSize(24)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#F5F5F5')
      }
      .tabBar(this.customTabBuilder('动态', 2, 12))
    }
    .width('100%')
    .height('100%')
    .barHeight(60)
    .barBackgroundColor('#FFFFFF')
    .onChange((index: number) => {
      this.currentIndex = index
    })
  }

  @Builder
  customTabBuilder(title: string, index: number, badge: number) {
    Column({ space: 4 }) {
      Text(title)
        .fontSize(16)
        .fontWeight(this.currentIndex === index ? FontWeight.Bold : FontWeight.Normal)
        .fontColor(this.currentIndex === index ? '#007DFF' : '#666666')

      if (this.currentIndex === index) {
        Divider()
          .strokeWidth(3)
          .color('#007DFF')
          .width(30)
      }
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .position({ x: 0, y: 0 })
  }
}
```

### 3.6 无动画切换示例

```typescript
@ComponentV2
struct NoAnimationTabsExample {
  @Local currentIndex: number = 0

  build() {
    Tabs({ index: this.currentIndex }) {
      TabContent() {
        Text('标签页 1')
          .fontSize(24)
      }
      .tabBar('标签 1')

      TabContent() {
        Text('标签页 2')
          .fontSize(24)
      }
      .tabBar('标签 2')
    }
    .width('100%')
    .height(200)
    .animationDuration(0) // 禁用动画
    .onChange((index: number) => {
      this.currentIndex = index
    })
  }
}
```

### 3.7 禁用滑动切换示例

```typescript
@ComponentV2
struct NoScrollTabsExample {
  @Local currentIndex: number = 0

  build() {
    Tabs({ index: this.currentIndex }) {
      TabContent() {
        Text('标签页 1')
          .fontSize(24)
      }
      .tabBar('标签 1')

      TabContent() {
        Text('标签页 2')
          .fontSize(24)
      }
      .tabBar('标签 2')
    }
    .width('100%')
    .height(200)
    .scrollable(false) // 禁用滑动切换
    .onChange((index: number) => {
      this.currentIndex = index
    })
  }
}
```

## 四、高级用法

### 4.1 动态标签页

```typescript
@ComponentV2
struct DynamicTabsExample {
  @Local currentIndex: number = 0
  @Local tabs: string[] = ['标签1', '标签2', '标签3']

  build() {
    Column() {
      Tabs({ index: this.currentIndex }) {
        ForEach(this.tabs, (tab: string, index: number) => {
          TabContent() {
            Column() {
              Text(`${tab} 内容`)
                .fontSize(24)
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
          }
          .tabBar(tab)
        }, (tab: string, index: number) => index.toString())
      }
      .width('100%')
      .layoutWeight(1)
      .onChange((index: number) => {
        this.currentIndex = index
      })

      Button('添加标签')
        .onClick(() => {
          this.tabs.push(`标签${this.tabs.length + 1}`)
        })
    }
    .width('100%')
    .height('100%')
  }
}
```

### 4.2 带图标的标签页

```typescript
@ComponentV2
struct IconTabsExample {
  @Local currentIndex: number = 0

  build() {
    Tabs({ index: this.currentIndex }) {
      TabContent() {
        Column() {
          Text('首页内容')
            .fontSize(24)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .tabBar(this.iconTabBuilder('\uE100', '首页', 0))

      TabContent() {
        Column() {
          Text('发现内容')
            .fontSize(24)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .tabBar(this.iconTabBuilder('\uE101', '发现', 1))

      TabContent() {
        Column() {
          Text('我的内容')
            .fontSize(24)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .tabBar(this.iconTabBuilder('\uE102', '我的', 2))
    }
    .width('100%')
    .height('100%')
    .barHeight(60)
    .onChange((index: number) => {
      this.currentIndex = index
    })
  }

  @Builder
  iconTabBuilder(icon: string, title: string, index: number) {
    Row({ space: 8 }) {
      Text(icon)
        .fontSize(24)
        .fontColor(this.currentIndex === index ? '#007DFF' : '#666666')

      Text(title)
        .fontSize(16)
        .fontColor(this.currentIndex === index ? '#007DFF' : '#666666')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}
```

## 五、最佳实践

### 5.1 标签栏位置选择

```typescript
// ✅ 推荐：底部导航用于应用主导航
Tabs({ barPosition: BarPosition.End }) {
  // 主要功能标签页
}

// ✅ 推荐：顶部标签用于内容分类
Tabs({ barPosition: BarPosition.Start }) {
  // 内容分类标签页
}
```

### 5.2 标签数量控制

```typescript
// ✅ 推荐：底部导航 2-5 个标签
Tabs({ barPosition: BarPosition.End }) {
  // 3-5 个主要功能
}

// ✅ 推荐：顶部标签可以使用可滚动模式
Tabs() {
  // 多个内容分类
}
.barMode(BarMode.Scrollable)
```

### 5.3 性能优化

```typescript
// ✅ 推荐：使用 keyGenerator
ForEach(tabs, (tab: TabData, index: number) => {
  TabContent() {
    // 内容
  }
  .tabBar(tab.title)
}, (tab: TabData) => tab.id)
```

## 六、常见问题

### Q1: Tabs 内容显示不全？

**解决方案**:
```typescript
// 确保设置了高度
Tabs() {
  TabContent() {
    Column() {
      // 内容
    }
  }
}
.width('100%')
.height('100%') // 必须设置高度
```

### Q2: 如何实现底部导航栏？

**解决方案**:
```typescript
Tabs({ barPosition: BarPosition.End }) {
  // 标签页
}
.barHeight(60)
```

### Q3: 标签栏可以滚动吗？

**解决方案**:
```typescript
Tabs() {
  // 标签页
}
.barMode(BarMode.Scrollable) // 启用可滚动模式
```

### Q4: 如何禁用滑动切换？

**解决方案**:
```typescript
Tabs() {
  // 标签页
}
.scrollable(false)
```

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 9+ | ✅ | 完全支持 |
| API 10+ | ✅ | 增加了更多自定义选项 |
| API 12+ | ✅ | 性能优化 |

## 八、参考资料

- [Tabs 组件 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-tabs-V5)
- [TabContent 组件 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-tabcontent-V5)
