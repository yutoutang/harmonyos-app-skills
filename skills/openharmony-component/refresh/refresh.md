# Refresh 下拉刷新组件 HarmonyOS 6.0 开发 Skill

## 概述

Refresh 下拉刷新组件是 OpenHarmony 中用于实现下拉刷新功能的容器组件,从 API 8 开始支持。用户可以通过下拉手势触发刷新操作,刷新完成后会自动回弹。从 API 11 开始,子组件会跟随手势下拉而下移。

## 重要说明

- **容器组件**: Refresh 是一个容器组件,必须包含一个子组件
- **手势支持**: 支持下拉手势触发刷新
- **API 11+**: 子组件会跟随手势下拉而下移
- **状态管理**: 通过 refreshing 参数控制刷新状态
- **自定义内容**: 支持自定义刷新提示内容

## 模块信息

- **组件名称**: Refresh
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [Refresh 下拉刷新 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-container-refresh)

## 一、组件基础

### 1.1 导入方式

```typescript
// Refresh 是内置组件,无需导入
// 直接使用即可
Refresh({ refreshing: false }) {
  // 子组件
}
```

### 1.2 基础用法

```typescript
@ComponentV2
struct BasicRefreshExample {
  @Local isRefreshing: boolean = false

  build() {
    Refresh({ refreshing: this.isRefreshing }) {
      Column() {
        Text('内容区域')
      }
    }
    .onStateChange((isRefreshing: boolean) => {
      this.isRefreshing = isRefreshing
    })
  }
}
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| refreshing | `boolean` | 是 | - | 是否正在刷新 |
| builder | `CustomBuilder` | 否 | - | 自定义刷新提示内容 |
| promptText | `ResourceStr` | 否 | - | 刷新提示文本 |

### 2.2 事件

| 事件 | 类型 | 描述 |
|------|------|------|
| `onStateChange` | `(isRefreshing: boolean) => void` | 刷新状态变化时触发 |
| `onRefreshing` | `() => void` | 下拉到刷新位置时触发 |

### 2.3 样式属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `refreshingOffset` | `Length` | - | 刷新位置偏移量 |
| `friction` | `number` | - | 下拉摩擦系数 |
| `backgroundColor` | `ResourceColor` | - | 背景色 |

## 三、使用示例

### 3.1 基础下拉刷新示例

```typescript
@ComponentV2
struct BasicRefreshExample {
  @Local isRefreshing: boolean = false
  @Local items: string[] = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5']

  // 刷新数据
  refreshData(): void {
    this.isRefreshing = true

    // 模拟网络请求
    setTimeout(() => {
      this.items = [
        `Item ${Math.floor(Math.random() * 100)}`,
        `Item ${Math.floor(Math.random() * 100)}`,
        `Item ${Math.floor(Math.random() * 100)}`,
        `Item ${Math.floor(Math.random() * 100)}`,
        `Item ${Math.floor(Math.random() * 100)}`
      ]
      this.isRefreshing = false
    }, 2000)
  }

  build() {
    Refresh({ refreshing: this.isRefreshing }) {
      Column() {
        ForEach(this.items, (item: string, index: number) => {
          Text(item)
            .width('100%')
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
            .margin({ bottom: 8 })
        })
      }
      .width('100%')
      .padding(16)
    }
    .backgroundColor('#F5F5F5')
    .onStateChange((isRefreshing: boolean) => {
      this.isRefreshing = isRefreshing
    })
    .onRefreshing(() => {
      this.refreshData()
    })
  }
}
```

### 3.2 自定义刷新内容

```typescript
@ComponentV2
struct CustomRefreshExample {
  @Local isRefreshing: boolean = false
  @Local data: string[] = ['Data 1', 'Data 2', 'Data 3']

  @Builder
  refreshIndicator() {
    Column({ space: 8 }) {
      if (this.isRefreshing) {
        LoadingProgress()
          .width(30)
          .height(30)
          .color('#007DFF')
      } else {
        Text('↓')
          .fontSize(30)
          .fontColor('#007DFF')
      }
      Text(this.isRefreshing ? '刷新中...' : '下拉刷新')
        .fontSize(14)
        .fontColor('#666666')
    }
  }

  refreshData(): void {
    this.isRefreshing = true
    setTimeout(() => {
      this.data = [
        `Data ${Math.floor(Math.random() * 100)}`,
        `Data ${Math.floor(Math.random() * 100)}`,
        `Data ${Math.floor(Math.random() * 100)}`
      ]
      this.isRefreshing = false
    }, 2000)
  }

  build() {
    Refresh({ refreshing: this.isRefreshing }) {
      List() {
        ForEach(this.data, (item: string) => {
          ListItem() {
            Text(item)
              .width('100%')
              .padding(16)
              .backgroundColor('#FFFFFF')
              .borderRadius(8)
              .margin({ bottom: 8 })
          }
        })
      }
      .width('100%')
      .padding(16)
      .divider({ strokeWidth: 1, color: '#E0E0E0' })
    }
    .backgroundColor('#F5F5F5')
    .builder(this.refreshIndicator())
    .onStateChange((isRefreshing: boolean) => {
      this.isRefreshing = isRefreshing
    })
    .onRefreshing(() => {
      this.refreshData()
    })
  }
}
```

### 3.3 列表下拉刷新

```typescript
@ComponentV2
struct ListRefreshExample {
  @Local isRefreshing: boolean = false
  @Local listData: string[] = []

  aboutToAppear(): void {
    // 初始化数据
    for (let i = 1; i <= 20; i++) {
      this.listData.push(`Item ${i}`)
    }
  }

  refreshList(): void {
    this.isRefreshing = true

    setTimeout(() => {
      this.listData = []
      for (let i = 1; i <= 20; i++) {
        this.listData.push(`New Item ${i}`)
      }
      this.isRefreshing = false
    }, 1500)
  }

  build() {
    Refresh({ refreshing: this.isRefreshing }) {
      List({ space: 8 }) {
        ForEach(this.listData, (item: string, index: number) => {
          ListItem() {
            Row({ space: 12 }) {
              Text(`${index + 1}`)
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor('#007DFF')
                .width(40)

              Text(item)
                .fontSize(16)
                .layoutWeight(1)
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
          }
        })
      }
      .width('100%')
      .padding({ left: 16, right: 16 })
    }
    .backgroundColor('#F5F5F5')
    .onStateChange((isRefreshing: boolean) => {
      this.isRefreshing = isRefreshing
    })
    .onRefreshing(() => {
      this.refreshList()
    })
  }
}
```

### 3.4 网格下拉刷新

```typescript
@ComponentV2
struct GridRefreshExample {
  @Local isRefreshing: boolean = false
  @Local gridData: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9]

  refreshGrid(): void {
    this.isRefreshing = true

    setTimeout(() => {
      this.gridData = this.gridData.map(() => Math.floor(Math.random() * 100))
      this.isRefreshing = false
    }, 2000)
  }

  build() {
    Refresh({ refreshing: this.isRefreshing }) {
      Grid() {
        ForEach(this.gridData, (item: number) => {
          GridItem() {
            Column({ space: 8 }) {
              Text(`${item}`)
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#007DFF')
              Text('Card')
                .fontSize(14)
                .fontColor('#666666')
            }
            .width('100%')
            .height(120)
            .justifyContent(FlexAlign.Center)
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
          }
        })
      }
      .columnsTemplate('1fr 1fr 1fr')
      .columnsGap(8)
      .rowsGap(8)
      .width('100%')
      .padding(16)
    }
    .backgroundColor('#F5F5F5')
    .onStateChange((isRefreshing: boolean) => {
      this.isRefreshing = isRefreshing
    })
    .onRefreshing(() => {
      this.refreshGrid()
    })
  }
}
```

### 3.5 带加载状态的下拉刷新

```typescript
@ComponentV2
struct RefreshWithLoadingExample {
  @Local isRefreshing: boolean = false
  @Local isLoading: boolean = false
  @Local items: string[] = ['Item 1', 'Item 2', 'Item 3']

  refreshItems(): void {
    this.isRefreshing = true

    setTimeout(() => {
      this.items = [
        `Refreshed ${Date.now()}`,
        `Refreshed ${Date.now() + 1}`,
        `Refreshed ${Date.now() + 2}`
      ]
      this.isRefreshing = false
    }, 2000)
  }

  loadMore(): void {
    if (this.isLoading || this.isRefreshing) {
      return
    }

    this.isLoading = true
    setTimeout(() => {
      this.items.push(`More ${this.items.length + 1}`)
      this.isLoading = false
    }, 1500)
  }

  build() {
    Column() {
      Refresh({ refreshing: this.isRefreshing }) {
        List({ space: 8 }) {
          ForEach(this.items, (item: string) => {
            ListItem() {
              Text(item)
                .width('100%')
                .padding(16)
                .backgroundColor('#FFFFFF')
                .borderRadius(8)
            }
          })

          // 加载更多项
          if (this.isLoading) {
            ListItem() {
              Column({ space: 8 }) {
                LoadingProgress()
                  .width(30)
                  .height(30)
                  .color('#007DFF')
                Text('加载中...')
                  .fontSize(14)
                  .fontColor('#666666')
              }
              .width('100%')
              .padding(20)
            }
          }
        }
        .width('100%')
        .padding(16)
        .onReachEnd(() => {
          this.loadMore()
        })
      }
      .backgroundColor('#F5F5F5')
      .layoutWeight(1)
      .onStateChange((isRefreshing: boolean) => {
        this.isRefreshing = isRefreshing
      })
      .onRefreshing(() => {
        this.refreshItems()
      })
    }
    .width('100%')
    .height('100%')
  }
}
```

### 3.6 新闻列表下拉刷新

```typescript
@ComponentV2
struct NewsRefreshExample {
  @Local isRefreshing: boolean = false
  @Local newsList: Array<{ title: string; time: string }> = []

  aboutToAppear(): void {
    this.newsList = [
      { title: '新闻标题 1', time: '10:30' },
      { title: '新闻标题 2', time: '09:15' },
      { title: '新闻标题 3', time: '08:45' }
    ]
  }

  refreshNews(): void {
    this.isRefreshing = true

    setTimeout(() => {
      this.newsList = [
        { title: `最新新闻 ${Date.now()}`, time: '刚刚' },
        { title: '新闻标题 2', time: '10分钟前' },
        { title: '新闻标题 3', time: '30分钟前' }
      ]
      this.isRefreshing = false
    }, 2000)
  }

  build() {
    Refresh({ refreshing: this.isRefreshing, promptText: '下拉刷新新闻' }) {
      List({ space: 0 }) {
        ForEach(this.newsList, (news: { title: string; time: string }) => {
          ListItem() {
            Row({ space: 12 }) {
              Column({ space: 4 }) {
                Text(news.title)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                Text(news.time)
                  .fontSize(12)
                  .fontColor('#999999')
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Text('>')
                .fontSize(16)
                .fontColor('#CCCCCC')
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FFFFFF')
          }
        })
      }
      .width('100%')
      .divider({ strokeWidth: 1, color: '#F0F0F0' })
    }
    .backgroundColor('#F5F5F5')
    .onStateChange((isRefreshing: boolean) => {
      this.isRefreshing = isRefreshing
    })
    .onRefreshing(() => {
      this.refreshNews()
    })
  }
}
```

## 四、最佳实践

### 4.1 正确管理刷新状态

```typescript
// ✅ 推荐:在回调中正确管理状态
Refresh({ refreshing: this.isRefreshing }) {
  // 内容
}
.onStateChange((isRefreshing: boolean) => {
  this.isRefreshing = isRefreshing
})
.onRefreshing(() => {
  // 执行刷新操作
  this.loadData()
})
```

### 4.2 提供刷新反馈

```typescript
// ✅ 推荐:使用 LoadingProgress 提供反馈
@Builder
refreshIndicator() {
  if (this.isRefreshing) {
    LoadingProgress()
      .width(30)
      .height(30)
  }
}
```

### 4.3 避免嵌套滚动

```typescript
// ✅ 推荐:Refresh 内使用 List 或 Grid
Refresh({ refreshing: this.isRefreshing }) {
  List() { } // 推荐
}

// ❌ 避免:Refresh 内嵌套 Scroll
Refresh({ refreshing: this.isRefreshing }) {
  Scroll() {
    List() { } // 不推荐
  }
}
```

## 五、常见问题

### Q1: 如何结束刷新状态?

**解决方案**:
```typescript
// 在数据加载完成后设置 isRefreshing = false
refreshData(): void {
  this.isRefreshing = true

  setTimeout(() => {
    // 加载数据
    this.loadData()
    // 结束刷新
    this.isRefreshing = false
  }, 2000)
}
```

### Q2: 如何自定义刷新内容?

**解决方案**:
```typescript
// 使用 builder 参数
@Builder
customRefresh() {
  Row({ space: 8 }) {
    LoadingProgress()
    Text('自定义刷新内容')
  }
}

Refresh({ refreshing: this.isRefreshing }) {
  // 内容
}
.builder(this.customRefresh())
```

## 六、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 8+ | ✅ | 完全支持 |
| API 11+ | ✅ | 子组件跟随手势下拉 |
| API 12+ | ✅ | 性能优化 |

## 七、参考资料

- [Refresh 下拉刷新 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-container-refresh)
- [容器组件 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-container-components)
