# Progress Component

> OpenHarmony进度条组件 - 用于显示操作进度的UI组件

## Overview

`Progress` 是 OpenHarmony 提供的进度条组件,用于展示操作的完成进度。支持多种样式类型,适用于文件下载、数据加载、表单填写等场景。

## Basic Syntax

```typescript
Progress(options: {value: number, total: number, type: ProgressType})
```

## Component Types

### 1. ProgressType.Linear (线性进度条)

最常用的进度条类型,横向显示进度。

```typescript
Progress({ value: 50, total: 100, type: ProgressType.Linear })
  .width('100%')
  .height(4)
  .color('#007DFF')
  .backgroundColor('#F0F0F0')
```

**特点:**
- 水平条形显示
- 占用空间小
- 适合列表、卡片等紧凑布局

### 2. ProgressType.Ring (环形进度条)

圆形进度条,适合居中显示。

```typescript
Progress({ value: 75, total: 100, type: ProgressType.Ring })
  .width(80)
  .height(80)
  .color('#007DFF')
```

**特点:**
- 圆形环状显示
- 视觉效果突出
- 适合加载动画、完成度展示

### 3. ProgressType.ScaleRing (刻度环形进度条)

带刻度的环形进度条。

```typescript
Progress({ value: 60, total: 100, type: ProgressType.ScaleRing })
  .width(100)
  .height(100)
  .color('#FF6B6B')
```

**特点:**
- 环形带刻度显示
- 更精确的进度感知
- 适合仪表盘风格界面

### 4. ProgressType.Capsule (胶囊形进度条)

两端圆角的线性进度条。

```typescript
Progress({ value: 30, total: 100, type: ProgressType.Capsule })
  .width(200)
  .height(12)
  .color('#00D68F')
```

**特点:**
- 圆角胶囊形状
- 现代化设计风格
- 适合按钮风格进度显示

### 5. ProgressType.Eclipse (椭圆进度条)

椭圆形状的进度条。

```typescript
Progress({ value: 85, total: 100, type: ProgressType.Eclipse })
  .width(120)
  .height(80)
  .color('#9B59B6')
```

**特点:**
- 椭圆环状显示
- 独特视觉效果
- 适合特殊设计需求

## Properties

### 核心属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| value | number | 0 | 当前进度值 |
| total | number | 100 | 总进度值 |
| type | ProgressType | ProgressType.Linear | 进度条类型 |

### 样式属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| color | ResourceColor | '#007DFF' | 进度条颜色 |
| backgroundColor | ResourceColor | - | 进度条背景色 |
| width | Length | - | 宽度 |
| height | Length | - | 高度 |
| style | ProgressStyle | - | 自定义样式(仅ScaleRing) |

## Common Patterns

### 1. 文件下载进度

```typescript
@ComponentV2
struct DownloadProgress {
  @Local downloadProgress: number = 0
  @Local isDownloading: boolean = false

  build() {
    Column({ space: 8 }) {
      Row() {
        Text('下载中...')
          .fontSize(14)
        Blank()
        Text(`${this.downloadProgress}%`)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')

      Progress({
        value: this.downloadProgress,
        total: 100,
        type: ProgressType.Linear
      })
        .width('100%')
        .height(4)
        .color('#007DFF')
        .backgroundColor('#F0F0F0')
    }
    .padding(16)
  }
}
```

### 2. 任务完成度

```typescript
@ComponentV2
struct TaskProgress {
  @Local completedTasks: number = 7
  @Local totalTasks: number = 10

  build() {
    Column({ space: 12 }) {
      Text('任务进度')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)

      Progress({
        value: this.completedTasks,
        total: this.totalTasks,
        type: ProgressType.Capsule
      })
        .width('100%')
        .height(12)
        .color('#00D68F')

      Row() {
        Text(`${this.completedTasks}/${this.totalTasks}`)
          .fontSize(14)
          .fontColor('#666666')
      }
    }
    .padding(16)
  }
}
```

### 3. 环形加载指示器

```typescript
@ComponentV2
struct LoadingRing {
  @Local progress: number = 0

  build() {
    Column({ space: 16 }) {
      Progress({
        value: this.progress,
        total: 100,
        type: ProgressType.Ring
      })
        .width(80)
        .height(80)
        .color('#007DFF')

      Text(`${this.progress}%`)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
  }
}
```

### 4. 仪表盘样式

```typescript
@ComponentV2
struct DashboardProgress {
  @Local cpuUsage: number = 65

  build() {
    Column({ space: 12 }) {
      Text('CPU 使用率')
        .fontSize(14)
        .fontColor('#666666')

      Progress({
        value: this.cpuUsage,
        total: 100,
        type: ProgressType.ScaleRing
      })
        .width(120)
        .height(120)
        .color(this.cpuUsage > 80 ? '#FF6B6B' : '#007DFF')

      Text(`${this.cpuUsage}%`)
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
    }
  }
}
```

### 5. 步骤进度条

```typescript
@ComponentV2
struct StepProgress {
  @Local currentStep: number = 2
  @Local totalSteps: number = 5

  build() {
    Column({ space: 16 }) {
      Text('步骤进度')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)

      Progress({
        value: this.currentStep,
        total: this.totalSteps,
        type: ProgressType.Linear
      })
        .width('100%')
        .height(8)
        .color('#007DFF')

      Row() {
        ForEach(Array.from({ length: this.totalSteps }), (_, index) => {
          Column({ space: 4 }) {
            Text(`${index + 1}`)
              .width(24)
              .height(24)
              .fontSize(12)
              .fontColor(index < this.currentStep ? '#FFFFFF' : '#666666')
              .backgroundColor(index < this.currentStep ? '#007DFF' : '#F0F0F0')
              .borderRadius(12)
              .textAlign(TextAlign.Center)

            if (index < this.totalSteps - 1) {
              Divider()
                .vertical(true)
                .height(2)
                .color(index < this.currentStep - 1 ? '#007DFF' : '#F0F0F0')
            }
          }
        })
      }
      .width('100%')
    }
    .padding(16)
  }
}
```

## Advanced Usage

### 自定义颜色

```typescript
Progress({ value: 70, total: 100, type: ProgressType.Linear })
  .color('#FF6B6B')
  .backgroundColor('#FFF0F0')
```

### 响应式进度

```typescript
@ComponentV2
struct ResponsiveProgress {
  @Local progress: number = 0

  aboutToAppear(): void {
    // 模拟进度更新
    setInterval(() => {
      if (this.progress < 100) {
        this.progress += 5
      }
    }, 500)
  }

  build() {
    Progress({ value: this.progress, total: 100, type: ProgressType.Linear })
      .width('100%')
      .height(8)
      .color(this.progress >= 100 ? '#00D68F' : '#007DFF')
  }
}
```

### 动态进度条类型

```typescript
@ComponentV2
struct DynamicProgress {
  @Local progressType: ProgressType = ProgressType.Linear
  @Local progressValue: number = 50

  build() {
    Column({ space: 16 }) {
      Progress({
        value: this.progressValue,
        total: 100,
        type: this.progressType
      })
        .width(100)
        .height(100)

      Row({ space: 8 }) {
        Button('线性')
          .onClick(() => {
            this.progressType = ProgressType.Linear
          })

        Button('环形')
          .onClick(() => {
            this.progressType = ProgressType.Ring
          })

        Button('胶囊')
          .onClick(() => {
            this.progressType = ProgressType.Capsule
          })
      }
    }
  }
}
```

## Best Practices

### 1. 选择合适的类型

- **Linear**: 文件下载、表单填写、列表项进度
- **Ring**: 加载状态、完成度百分比
- **ScaleRing**: 仪表盘、数据监控
- **Capsule**: 现代化UI、按钮风格
- **Eclipse**: 特殊设计需求

### 2. 提供清晰的文本说明

```typescript
// GOOD: 带说明文本
Column({ space: 8 }) {
  Row() {
    Text('上传文件')
    Blank()
    Text('75%')
  }
  Progress({ value: 75, total: 100, type: ProgressType.Linear })
}

// AVOID: 孤立的进度条
Progress({ value: 75, total: 100, type: ProgressType.Linear })
```

### 3. 使用适当的尺寸

```typescript
// GOOD: 合理的尺寸
Progress({ value: 50, total: 100, type: ProgressType.Linear })
  .width('100%')
  .height(4)  // 线性进度条高度适中

Progress({ value: 50, total: 100, type: ProgressType.Ring })
  .width(80)
  .height(80)  // 环形进度条大小适中

// AVOID: 过大或过小
Progress({ value: 50, total: 100, type: ProgressType.Linear })
  .height(20)  // 过高显得笨重
```

### 4. 响应式颜色

```typescript
Progress({
  value: this.cpuUsage,
  total: 100,
  type: ProgressType.Linear
})
  .color(this.cpuUsage > 80 ? '#FF6B6B' : '#007DFF')
```

### 5. 动画效果

使用 `animateTo` 为进度变化添加平滑动画:

```typescript
@ComponentV2
struct AnimatedProgress {
  @Local progress: number = 0

  updateProgress(newValue: number): void {
    animateTo({ duration: 300 }, () => {
      this.progress = newValue
    })
  }

  build() {
    Progress({ value: this.progress, total: 100, type: ProgressType.Linear })
      .width('100%')
  }
}
```

## Accessibility

### 添加语义化描述

```typescript
Progress({ value: 75, total: 100, type: ProgressType.Linear })
  .accessibilityText('下载进度 75%')
  .accessibilityLevel('Important')
```

## Performance Tips

1. **避免频繁更新**: 进度更新频率控制在 100ms-500ms 之间
2. **使用 @Local**: 对于动态进度值,使用 `@Local` 装饰器
3. **合理设置 total**: 确保 total 值合理,避免过大的计算量

## Common Issues

### Issue 1: 进度条不显示

**原因**: value 或 total 值为 0 或负数

**解决**:
```typescript
// 确保 value 和 total 为正数
Progress({ value: 50, total: 100, type: ProgressType.Linear })
```

### Issue 2: 样式不生效

**原因**: 样式属性设置在错误的类型上

**解决**:
```typescript
// 检查类型是否支持该样式
Progress({ value: 50, total: 100, type: ProgressType.ScaleRing })
  .style({
    strokeWidth: 10,
    scaleCount: 20
  })  // ScaleRing 特有样式
```

### Issue 3: 进度值超出范围

**原因**: value > total

**解决**:
```typescript
@ComponentV2
struct SafeProgress {
  @Local value: number = 0
  @Local total: number = 100

  get clampedValue(): number {
    return Math.min(Math.max(this.value, 0), this.total)
  }

  build() {
    Progress({
      value: this.clampedValue,
      total: this.total,
      type: ProgressType.Linear
    })
  }
}
```

## Reference

- [Progress Component API](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/progress-0000001054359314-V3)
- [ProgressType Enum](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/progress-0000001054359314-V3)
