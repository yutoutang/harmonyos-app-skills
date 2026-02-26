# LoadingProgress Component

> OpenHarmony加载进度组件 - 用于显示加载中的动画效果

## Overview

`LoadingProgress` 是 OpenHarmony 提供的加载动画组件,用于在数据加载、页面刷新等场景中提供视觉反馈。与 Progress 不同,LoadingProgress 不显示具体的进度值,而是通过旋转动画表示"正在加载"的状态。

## Basic Syntax

```typescript
LoadingProgress()
  .width(40)
  .height(40)
  .color('#007DFF')
```

## Component Features

### 1. 自动旋转动画

LoadingProgress 内置旋转动画,无需手动实现:

```typescript
LoadingProgress()
  .width(50)
  .height(50)
  .color('#007DFF')
// 自动旋转,无需额外代码
```

### 2. 自定义尺寸

支持任意尺寸设置:

```typescript
// 小尺寸
LoadingProgress()
  .width(24)
  .height(24)

// 标准尺寸
LoadingProgress()
  .width(40)
  .height(40)

// 大尺寸
LoadingProgress()
  .width(60)
  .height(60)
```

### 3. 自定义颜色

支持单一颜色设置:

```typescript
LoadingProgress()
  .color('#007DFF')
```

## Properties

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| color | ResourceColor | '#FFFFFF' | 加载动画颜色 |
| width | Length | - | 宽度 |
| height | Length | - | 高度 |

## Common Patterns

### 1. 页面加载状态

```typescript
@ComponentV2
struct PageLoading {
  build() {
    Column({ space: 16 }) {
      LoadingProgress()
        .width(48)
        .height(48)
        .color('#007DFF')

      Text('加载中...')
        .fontSize(14)
        .fontColor('#666666')
    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
```

### 2. 按钮加载状态

```typescript
@ComponentV2
struct LoadingButton {
  @Local isLoading: boolean = false

  build() {
    Button() {
      if (this.isLoading) {
        Row({ space: 8 }) {
          LoadingProgress()
            .width(20)
            .height(20)
            .color('#FFFFFF')
          Text('提交中...')
            .fontSize(16)
            .fontColor('#FFFFFF')
        }
      } else {
        Text('提交')
          .fontSize(16)
      }
    }
    .width(120)
    .height(40)
    .backgroundColor(this.isLoading ? '#CCCCCC' : '#007DFF')
    .enabled(!this.isLoading)
    .onClick(() => {
      if (!this.isLoading) {
        this.isLoading = true
        // 模拟异步操作
        setTimeout(() => {
          this.isLoading = false
        }, 2000)
      }
    })
  }
}
```

### 3. 列表加载更多

```typescript
@ComponentV2
struct LoadMoreList {
  @Local isLoadingMore: boolean = false
  @Local items: string[] = ['Item 1', 'Item 2', 'Item 3']

  loadMore(): void {
    this.isLoadingMore = true
    setTimeout(() => {
      this.items.push(...['Item 4', 'Item 5', 'Item 6'])
      this.isLoadingMore = false
    }, 1500)
  }

  build() {
    Column() {
      List({ space: 8 }) {
        ForEach(this.items, (item: string) => {
          ListItem() {
            Text(item)
              .width('100%')
              .height(60)
              .backgroundColor('#F5F5F5')
              .borderRadius(8)
              .textAlign(TextAlign.Center)
          }
        })

        if (this.isLoadingMore) {
          ListItem() {
            Row({ space: 8 }) {
              LoadingProgress()
                .width(20)
                .height(20)
                .color('#007DFF')
              Text('加载更多...')
                .fontSize(14)
                .fontColor('#666666')
            }
            .width('100%')
            .justifyContent(FlexAlign.Center)
            .padding(16)
          }
        }
      }
      .width('100%')
      .onReachEnd(() => {
        if (!this.isLoadingMore) {
          this.loadMore()
        }
      })
    }
  }
}
```

### 4. 全屏加载遮罩

```typescript
@ComponentV2
struct FullScreenLoading {
  @Param show: boolean = false

  build() {
    if (this.show) {
      Column() {
        Column({ space: 16 }) {
          LoadingProgress()
            .width(60)
            .height(60)
            .color('#FFFFFF')

          Text('请稍候...')
            .fontSize(16)
            .fontColor('#FFFFFF')
        }
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('rgba(0, 0, 0, 0.5)')
      .justifyContent(FlexAlign.Center)
    } else {
      Column()
        .width(0)
        .height(0)
    }
  }
}
```

### 5. 卡片加载占位

```typescript
@ComponentV2
struct CardLoadingPlaceholder {
  build() {
    Column() {
      // 标题占位
      Row({ space: 12 }) {
        LoadingProgress()
          .width(24)
          .height(24)
          .color('#007DFF')
        Text('加载中...')
          .fontSize(14)
          .fontColor('#666666')
      }
      .width('100%')
      .padding(16)

      // 内容占位
      Column({ space: 8 }) {
        Row()
          .width('60%')
          .height(16)
          .backgroundColor('#F0F0F0')
          .borderRadius(4)

        Row()
          .width('100%')
          .height(16)
          .backgroundColor('#F0F0F0')
          .borderRadius(4)

        Row()
          .width('80%')
          .height(16)
          .backgroundColor('#F0F0F0')
          .borderRadius(4)
      }
      .width('100%')
      .padding({ left: 16, right: 16, bottom: 16 })
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(8)
    .shadow({ radius: 4, color: 'rgba(0, 0, 0, 0.1)' })
  }
}
```

### 6. 数据刷新指示器

```typescript
@ComponentV2
struct RefreshIndicator {
  @Param isRefreshing: boolean = false
  @Param refreshText: string = '下拉刷新'

  build() {
    Row({ space: 8 }) {
      if (this.isRefreshing) {
        LoadingProgress()
          .width(20)
          .height(20)
          .color('#007DFF')
      }

      Text(this.isRefreshing ? '刷新中...' : this.refreshText)
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .padding(16)
  }
}
```

### 7. 多步骤操作加载

```typescript
@ComponentV2
struct StepLoading {
  @Local currentStep: number = 0
  @Local steps: string[] = ['验证中', '处理中', '保存中']

  aboutToAppear(): void {
    this.processSteps()
  }

  processSteps(): void {
    const interval = setInterval(() => {
      if (this.currentStep < this.steps.length - 1) {
        this.currentStep++
      } else {
        clearInterval(interval)
      }
    }, 1500)
  }

  build() {
    Column({ space: 16 }) {
      LoadingProgress()
        .width(48)
        .height(48)
        .color('#007DFF')

      Text(this.steps[this.currentStep])
        .fontSize(16)
        .fontColor('#333333')

      Row({ space: 8 }) {
        ForEach(this.steps, (step: string, index: number) => {
          Row()
            .width(20)
            .height(4)
            .backgroundColor(index <= this.currentStep ? '#007DFF' : '#E0E0E0')
            .borderRadius(2)
        })
      }
    }
    .padding(24)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}
```

## Advanced Usage

### 带超时的加载状态

```typescript
@ComponentV2
struct TimedLoading {
  @Local isLoading: boolean = false
  @Local showTimeout: boolean = false
  private loadingTimeout: number = 5000 // 5秒超时
  private timeoutId?: number

  startLoading(): void {
    this.isLoading = true
    this.showTimeout = false

    // 设置超时
    this.timeoutId = setTimeout(() => {
      if (this.isLoading) {
        this.showTimeout = true
      }
    }, this.loadingTimeout) as unknown as number
  }

  stopLoading(): void {
    this.isLoading = false
    this.showTimeout = false
    if (this.timeoutId) {
      clearTimeout(this.timeoutId)
    }
  }

  build() {
    Column({ space: 16 }) {
      if (this.isLoading) {
        LoadingProgress()
          .width(48)
          .height(48)
          .color(this.showTimeout ? '#FF6B6B' : '#007DFF')

        Text(this.showTimeout ? '加载超时,请重试' : '加载中...')
          .fontSize(14)
          .fontColor(this.showTimeout ? '#FF6B6B' : '#666666')

        if (this.showTimeout) {
          Button('重试')
            .onClick(() => {
              this.stopLoading()
              // 重试逻辑
            })
        }
      }
    }
  }
}
```

### 条件渲染加载器

```typescript
@ComponentV2
struct ConditionalLoader {
  @Local loadingState: 'idle' | 'loading' | 'success' | 'error' = 'idle'

  build() {
    Column() {
      if (this.loadingState === 'loading') {
        Row({ space: 12 }) {
          LoadingProgress()
            .width(24)
            .height(24)
            .color('#007DFF')
          Text('处理中...')
            .fontSize(14)
        }
      } else if (this.loadingState === 'success') {
        Row({ space: 8 }) {
          Text('✓')
            .fontSize(20)
            .fontColor('#00D68F')
          Text('完成')
            .fontSize(14)
        }
      } else if (this.loadingState === 'error') {
        Row({ space: 8 }) {
          Text('✗')
            .fontSize(20)
            .fontColor('#FF6B6B')
          Text('失败')
            .fontSize(14)
        }
      }
    }
  }
}
```

## Best Practices

### 1. 提供上下文信息

```typescript
// GOOD: 带说明文本
Column({ space: 12 }) {
  LoadingProgress()
    .width(48)
    .height(48)
  Text('正在加载数据...')
    .fontSize(14)
}

// AVOID: 孤立的加载器
LoadingProgress()
```

### 2. 使用合适的尺寸

```typescript
// 小型加载器 (按钮、列表项)
LoadingProgress()
  .width(20)
  .height(20)

// 标准加载器 (页面、卡片)
LoadingProgress()
  .width(40)
  .height(40)

// 大型加载器 (全屏遮罩)
LoadingProgress()
  .width(60)
  .height(60)
```

### 3. 颜色与主题一致

```typescript
// 浅色主题
LoadingProgress()
  .color('#007DFF')

// 深色主题
LoadingProgress()
  .color('#FFFFFF')

// 错误状态
LoadingProgress()
  .color('#FF6B6B')
```

### 4. 避免长时间显示

```typescript
@ComponentV2
struct SmartLoading {
  @Local isLoading: boolean = false
  private minDisplayTime: number = 500 // 最小显示时间

  async loadData(): Promise<void> {
    const startTime = Date.now()

    this.isLoading = true
    try {
      await this.fetchData()
    } finally {
      const elapsed = Date.now() - startTime
      const remaining = Math.max(0, this.minDisplayTime - elapsed)
      setTimeout(() => {
        this.isLoading = false
      }, remaining)
    }
  }

  fetchData(): Promise<void> {
    // 实际数据加载逻辑
    return Promise.resolve()
  }

  build() {
    Column() {
      if (this.isLoading) {
        LoadingProgress()
          .width(40)
          .height(40)
      } else {
        // 实际内容
        Text('Content Loaded')
      }
    }
  }
}
```

### 5. 提供取消选项

```typescript
@ComponentV2
struct CancellableLoading {
  @Local isLoading: boolean = false
  private controller: AbortController = new AbortController()

  cancel(): void {
    this.controller.abort()
    this.isLoading = false
  }

  build() {
    if (this.isLoading) {
      Column({ space: 16 }) {
        LoadingProgress()
          .width(48)
          .height(48)

        Button('取消')
          .fontSize(14)
          .onClick(() => this.cancel())
      }
    }
  }
}
```

## Accessibility

### 添加无障碍描述

```typescript
LoadingProgress()
  .width(40)
  .height(40)
  .accessibilityText('正在加载')
  .accessibilityLevel('Important')
```

## Performance Tips

1. **避免过度使用**: 只在真正需要等待的场景使用
2. **及时隐藏**: 加载完成后立即隐藏加载器
3. **使用条件渲染**: 使用 `if` 语句而不是 `visibility` 控制显示
4. **避免嵌套**: 不要在已经显示加载器的区域再嵌套加载器

## Common Issues

### Issue 1: 加载器不显示

**原因**: 组件尺寸设置为 0 或不可见

**解决**:
```typescript
// 确保设置了宽高
LoadingProgress()
  .width(40)
  .height(40)

// 或使用 flex 布局
Column() {
  LoadingProgress()
    .width(40)
    .height(40)
}
.justifyContent(FlexAlign.Center)
```

### Issue 2: 颜色不生效

**原因**: 颜色值格式错误或被主题覆盖

**解决**:
```typescript
// 使用标准颜色格式
LoadingProgress()
  .color('#007DFF')      // 十六进制
  .color($r('app.color.primary'))  // 资源引用
```

### Issue 3: 动画不流畅

**原因**: 在重渲染逻辑中使用

**解决**:
```typescript
@ComponentV2
struct SmoothLoading {
  @Local isLoading: boolean = false

  build() {
    if (this.isLoading) {
      // 使用独立的组件实例
      LoadingProgress()
        .width(40)
        .height(40)
    }
  }
}
```

## Comparison with Other Components

### LoadingProgress vs Progress

| 特性 | LoadingProgress | Progress |
|------|-----------------|----------|
| 显示具体进度 | ❌ 否 | ✅ 是 |
| 动画效果 | ✅ 内置旋转 | ⚠️ 部分类型有动画 |
| 适用场景 | 未知等待时间 | 已知总进度 |
| 数据绑定 | 不需要 | 需要 value/total |
| 类型变体 | 单一样式 | 5种类型 |

### 使用建议

- **使用 LoadingProgress**: 网络请求、页面初始化、异步操作
- **使用 Progress**: 文件下载、上传、表单填写、任务完成度

## Reference

- [LoadingProgress Component API](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/loading-progress-0000001054359314-V3)
