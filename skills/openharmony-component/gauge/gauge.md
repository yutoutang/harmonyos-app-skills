# Gauge Component

> OpenHarmony仪表盘组件 - 用于展示数值的环形仪表盘UI

## Overview

`Gauge` 是 OpenHarmony 提供的仪表盘组件,以环形图表的方式展示数据。与 Progress 组件不同,Gauge 提供了更丰富的自定义选项,包括渐变色、指针、刻度等,适合制作类似汽车仪表盘、性能监控器等界面。

## Basic Syntax

```typescript
Gauge(options: {value: number, min: number, max: number})
```

## Core Properties

### 基础属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| value | number | 0 | 当前值 |
| min | number | 0 | 最小值 |
| max | number | 100 | 最大值 |

### 样式属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| width | Length | - | 宽度 |
| height | Length | - | 高度 |
| colors | Array<[Color, number]> | - | 颜色渐变配置 |
| thickness | Length | - | 仪表盘环的宽度 |
| startAngle | number | 270 | 起始角度 |
| endAngle | number | 90 | 结束角度 |
| shadow | ShadowOptions | - | 阴影效果 |

### 指针属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| indicator | GaugeOptions | - | 指针配置 |
| track | GaugeOptions | - | 轨道配置 |

## Common Patterns

### 1. 基础仪表盘

```typescript
@ComponentV2
struct BasicGauge {
  @Local currentValue: number = 75

  build() {
    Column({ space: 16 }) {
      Gauge({ value: this.currentValue, min: 0, max: 100 })
        .width(200)
        .height(200)
        .colors([[0x007DFF, 1]])
        .thickness(20)

      Text(`${this.currentValue}%`)
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
    }
  }
}
```

### 2. 渐变色仪表盘

```typescript
@ComponentV2
struct GradientGauge {
  @Local speed: number = 85

  build() {
    Column({ space: 16 }) {
      Text('速度')
        .fontSize(16)
        .fontColor('#666666')

      Gauge({ value: this.speed, min: 0, max: 120 })
        .width(220)
        .height(220)
        .colors([
          [0x00D68F, 0.3],  // 低速区间 - 绿色
          [0xFFB020, 0.6],  // 中速区间 - 黄色
          [0xFF6B6B, 1.0]   // 高速区间 - 红色
        ])
        .thickness(25)

      Text(`${this.speed} km/h`)
        .fontSize(36)
        .fontWeight(FontWeight.Bold)
    }
    .padding(24)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}
```

### 3. 半圆形仪表盘

```typescript
@ComponentV2
struct SemiCircleGauge {
  @Local temperature: number = 65

  build() {
    Column({ space: 20 }) {
      Gauge({ value: this.temperature, min: 0, max: 100 })
        .width(280)
        .height(140)
        .startAngle(180)
        .endAngle(360)
        .colors([[0xFF6B6B, 1]])
        .thickness(30)

      Text('温度')
        .fontSize(14)
        .fontColor('#666666')

      Text(`${this.temperature}°C`)
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
  }
}
```

### 4. 自定义指针仪表盘

```typescript
@ComponentV2
struct CustomPointerGauge {
  @Local value: number = 50

  build() {
    Column({ space: 16 }) {
      Gauge({ value: this.value, min: 0, max: 100 })
        .width(200)
        .height(200)
        .colors([[0x007DFF, 1]])
        .thickness(20)
        .indicator({
          icon: '',
          space: 8,
          length: 10,
          width: 4,
          color: '#333333',
          pointer: {
            width: 4,
            color: '#FF6B6B'
          }
        })

      Text(`${this.value}`)
        .fontSize(32)
        .fontWeight(FontWeight.Medium)
    }
  }
}
```

### 5. CPU 使用率监控

```typescript
@ComponentV2
struct CPUMonitor {
  @Local cpuUsage: number = 45
  @Local memoryUsage: number = 62

  build() {
    Column({ space: 24 }) {
      Text('系统监控')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Row({ space: 20 }) {
        // CPU 仪表盘
        Column({ space: 8 }) {
          Gauge({ value: this.cpuUsage, min: 0, max: 100 })
            .width(120)
            .height(120)
            .colors([[0x007DFF, 1]])
            .thickness(15)

          Text('CPU')
            .fontSize(14)
            .fontColor('#666666')

          Text(`${this.cpuUsage}%`)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
        }

        // 内存仪表盘
        Column({ space: 8 }) {
          Gauge({ value: this.memoryUsage, min: 0, max: 100 })
            .width(120)
            .height(120)
            .colors([[0x9B59B6, 1]])
            .thickness(15)

          Text('Memory')
            .fontSize(14)
            .fontColor('#666666')

          Text(`${this.memoryUsage}%`)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
        }
      }
    }
    .width('100%')
    .padding(24)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}
```

### 6. 网络速度仪表盘

```typescript
@ComponentV2
struct NetworkSpeedGauge {
  @Local downloadSpeed: number = 85
  @Local uploadSpeed: number = 45

  build() {
    Column({ space: 20 }) {
      Text('网络状态')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 16 }) {
        Column({ space: 8 }) {
          Gauge({ value: this.downloadSpeed, min: 0, max: 100 })
            .width(100)
            .height(100)
            .colors([
              [0x00D68F, 0.5],
              [0x007DFF, 1]
            ])
            .thickness(18)

          Text('下载')
            .fontSize(12)
            .fontColor('#666666')

          Text(`${this.downloadSpeed}`)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
        }

        Column({ space: 8 }) {
          Gauge({ value: this.uploadSpeed, min: 0, max: 100 })
            .width(100)
            .height(100)
            .colors([
              [0xFFB020, 0.5],
              [0xFF6B6B, 1]
            ])
            .thickness(18)

          Text('上传')
            .fontSize(12)
            .fontColor('#666666')

          Text(`${this.uploadSpeed}`)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
        }
      }
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#F8F8F8')
    .borderRadius(12)
  }
}
```

### 7. 电池电量显示

```typescript
@ComponentV2
struct BatteryGauge {
  @Local batteryLevel: number = 78

  build() {
    Column({ space: 16 }) {
      Gauge({ value: this.batteryLevel, min: 0, max: 100 })
        .width(180)
        .height(180)
        .colors([
          [0xFF6B6B, 0.2],
          [0xFFB020, 0.5],
          [0x00D68F, 1]
        ])
        .thickness(22)
        .startAngle(270)
        .endAngle(90)

      Text('电池电量')
        .fontSize(14)
        .fontColor('#666666')

      Text(`${this.batteryLevel}%`)
        .fontSize(42)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.getBatteryColor())
    }
    .padding(24)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .shadow({
      radius: 8,
      color: 'rgba(0, 0, 0, 0.1)',
      offsetX: 0,
      offsetY: 2
    })
  }

  getBatteryColor(): string {
    if (this.batteryLevel > 50) {
      return '#00D68F'
    } else if (this.batteryLevel > 20) {
      return '#FFB020'
    } else {
      return '#FF6B6B'
    }
  }
}
```

### 8. 音量控制仪表盘

```typescript
@ComponentV2
struct VolumeControlGauge {
  @Local volume: number = 65

  build() {
    Column({ space: 16 }) {
      Gauge({ value: this.volume, min: 0, max: 100 })
        .width(160)
        .height(160)
        .colors([
          [0x007DFF, 0.3],
          [0x00D68F, 0.7],
          [0x007DFF, 1]
        ])
        .thickness(20)
        .startAngle(225)
        .endAngle(135)

      Row({ space: 24 }) {
        Button('-')
          .width(40)
          .height(40)
          .fontSize(20)
          .onClick(() => {
            if (this.volume > 0) {
              this.volume -= 5
            }
          })

        Text(`${this.volume}%`)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .width(80)
          .textAlign(TextAlign.Center)

        Button('+')
          .width(40)
          .height(40)
          .fontSize(20)
          .onClick(() => {
            if (this.volume < 100) {
              this.volume += 5
            }
          })
      }
    }
    .padding(24)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}
```

### 9. 多指标综合仪表盘

```typescript
@ComponentV2
struct DashboardGauge {
  @Local mainValue: number = 72
  @Local metrics: Metrics = new Metrics()

  build() {
    Column({ space: 20 }) {
      // 主仪表盘
      Gauge({ value: this.mainValue, min: 0, max: 100 })
        .width(240)
        .height(240)
        .colors([
          [0x00D68F, 0.6],
          [0xFFB020, 0.8],
          [0xFF6B6B, 1]
        ])
        .thickness(28)
        .startAngle(240)
        .endAngle(120)

      Text('综合评分')
        .fontSize(16)
        .fontColor('#666666')

      Text(`${this.mainValue}`)
        .fontSize(56)
        .fontWeight(FontWeight.Bold)

      // 子指标
      Row({ space: 12 }) {
        this.MetricItem('性能', this.metrics.performance)
        this.MetricItem('稳定', this.metrics.stability)
        this.MetricItem('安全', this.metrics.security)
      }
    }
    .width('100%')
    .padding(24)
    .backgroundColor('#F8F8F8')
    .borderRadius(16)
  }

  @Builder
  MetricItem(label: string, value: number) {
    Column({ space: 4 }) {
      Text(label)
        .fontSize(12)
        .fontColor('#999999')

      Text(`${value}`)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
    }
  }
}

class Metrics {
  performance: number = 85
  stability: number = 78
  security: number = 92
}
```

### 10. 动态更新的仪表盘

```typescript
@ComponentV2
struct DynamicGauge {
  @Local currentValue: number = 0
  private minValue: number = 0
  private maxValue: number = 100
  private intervalId?: number

  aboutToAppear(): void {
    this.startSimulation()
  }

  aboutToDisappear(): void {
    if (this.intervalId) {
      clearInterval(this.intervalId)
    }
  }

  startSimulation(): void {
    this.intervalId = setInterval(() => {
      this.currentValue = Math.floor(Math.random() * (this.maxValue - this.minValue + 1)) + this.minValue
    }, 2000)
  }

  build() {
    Column({ space: 16 }) {
      Text('实时监控')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Gauge({ value: this.currentValue, min: this.minValue, max: this.maxValue })
        .width(200)
        .height(200)
        .colors([
          [0x00D68F, 0.4],
          [0x007DFF, 0.7],
          [0xFF6B6B, 1]
        ])
        .thickness(24)

      Text(`${this.currentValue}`)
        .fontSize(36)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.getValueColor())
    }
    .padding(24)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }

  getValueColor(): string {
    const ratio = this.currentValue / this.maxValue
    if (ratio < 0.4) {
      return '#00D68F'
    } else if (ratio < 0.7) {
      return '#007DFF'
    } else {
      return '#FF6B6B'
    }
  }
}
```

## Advanced Usage

### 自定义刻度间隔

```typescript
@ComponentV2
struct CustomScaleGauge {
  @Local value: number = 55

  build() {
    Gauge({ value: this.value, min: 0, max: 10 })
      .width(200)
      .height(200)
      .colors([[0x007DFF, 1]])
      .thickness(20)
      .track({
        width: 2,
        color: '#E0E0E0',
        dashArray: [5, 5]
      })
  }
}
```

### 带动画的仪表盘

```typescript
@ComponentV2
struct AnimatedGauge {
  @Local currentValue: number = 0
  @Local targetValue: number = 75

  animateToValue(target: number): void {
    animateTo({ duration: 1000, curve: Curve.EaseInOut }, () => {
      this.currentValue = target
    })
  }

  build() {
    Column({ space: 16 }) {
      Gauge({ value: this.currentValue, min: 0, max: 100 })
        .width(200)
        .height(200)
        .colors([[0x007DFF, 1]])

      Button('更新')
        .onClick(() => {
          this.targetValue = Math.floor(Math.random() * 100)
          this.animateToValue(this.targetValue)
        })
    }
  }
}
```

## Best Practices

### 1. 合理设置颜色区间

```typescript
// GOOD: 清晰的颜色分区
Gauge({ value: 75, min: 0, max: 100 })
  .colors([
    [0x00D68F, 0.6],  // 0-60%: 正常 - 绿色
    [0xFFB020, 0.8],  // 60-80%: 警告 - 黄色
    [0xFF6B6B, 1.0]   // 80-100%: 危险 - 红色
  ])

// AVOID: 不清晰的颜色
Gauge({ value: 75, min: 0, max: 100 })
  .colors([
    [0x007DFF, 0.5],
    [0x0066CC, 1.0]  // 颜色差异太小
  ])
```

### 2. 使用合适的尺寸

```typescript
// 小型仪表盘 (卡片、列表)
Gauge({ value: 50, min: 0, max: 100 })
  .width(80)
  .height(80)
  .thickness(10)

// 标准仪表盘 (页面主体)
Gauge({ value: 50, min: 0, max: 100 })
  .width(200)
  .height(200)
  .thickness(20)

// 大型仪表盘 (主展示区)
Gauge({ value: 50, min: 0, max: 100 })
  .width(300)
  .height(300)
  .thickness(30)
```

### 3. 提供清晰的标签

```typescript
// GOOD: 带完整上下文
Column({ space: 8 }) {
  Text('CPU 使用率')
    .fontSize(14)
    .fontColor('#666666')

  Gauge({ value: 65, min: 0, max: 100 })
    .width(180)
    .height(180)

  Text('65%')
    .fontSize(32)
    .fontWeight(FontWeight.Bold)
}

// AVOID: 缺少上下文
Gauge({ value: 65, min: 0, max: 100 })
  .width(180)
  .height(180)
```

### 4. 响应式更新

```typescript
@ComponentV2
struct ResponsiveGauge {
  @Local value: number = 50
  private lastUpdateTime: number = 0

  updateValue(newValue: number): void {
    const now = Date.now()
    // 限制更新频率 (至少 500ms)
    if (now - this.lastUpdateTime > 500) {
      animateTo({ duration: 300 }, () => {
        this.value = newValue
      })
      this.lastUpdateTime = now
    }
  }

  build() {
    Gauge({ value: this.value, min: 0, max: 100 })
      .width(200)
      .height(200)
  }
}
```

### 5. 边界值处理

```typescript
@ComponentV2
struct SafeGauge {
  @Local rawValue: number = 50
  @Local minValue: number = 0
  @Local maxValue: number = 100

  get clampedValue(): number {
    return Math.min(Math.max(this.rawValue, this.minValue), this.maxValue)
  }

  get displayValue(): number {
    return Math.round(this.clampedValue)
  }

  build() {
    Gauge({
      value: this.clampedValue,
      min: this.minValue,
      max: this.maxValue
    })
      .width(200)
      .height(200)
  }
}
```

## Accessibility

### 添加无障碍支持

```typescript
Gauge({ value: 75, min: 0, max: 100 })
  .accessibilityText('当前进度 75%')
  .accessibilityLevel('Important')
```

## Performance Tips

1. **限制更新频率**: 避免过于频繁的数值更新 (建议 > 500ms)
2. **使用动画**: 使用 `animateTo` 提供平滑过渡
3. **避免重渲染**: 将 Gauge 放在独立组件中
4. **合理设置厚度**: 过大的 thickness 会影响性能

## Common Issues

### Issue 1: 仪表盘不显示

**原因**: value 超出 min/max 范围

**解决**:
```typescript
@ComponentV2
struct SafeGaugeExample {
  @Local value: number = 50

  build() {
    Gauge({
      value: Math.min(Math.max(this.value, 0), 100),  // 确保在范围内
      min: 0,
      max: 100
    })
  }
}
```

### Issue 2: 颜色渐变不生效

**原因**: colors 数组格式错误

**解决**:
```typescript
// 正确格式
Gauge({ value: 50, min: 0, max: 100 })
  .colors([
    [0x00D68F, 0.5],  // [颜色, 位置], 位置在 0-1 之间
    [0xFF6B6B, 1.0]
  ])
```

### Issue 3: 角度设置错误

**原因**: startAngle 或 endAngle 超出有效范围

**解决**:
```typescript
// 角度范围应在 0-360 之间
Gauge({ value: 50, min: 0, max: 100 })
  .startAngle(270)  // ✅ 有效
  .endAngle(90)     // ✅ 有效

// 避免超出范围
Gauge({ value: 50, min: 0, max: 100 })
  .startAngle(-90)  // ❌ 无效
  .endAngle(450)    // ❌ 无效
```

## Comparison with Progress

| 特性 | Gauge | Progress (Ring/ScaleRing) |
|------|-------|---------------------------|
| 颜色渐变 | ✅ 支持多段渐变 | ⚠️ 单一颜色 |
| 自定义角度 | ✅ 灵活 | ❌ 固定角度 |
| 指针选项 | ✅ 可自定义 | ❌ 无 |
| 刻度控制 | ✅ 精细控制 | ⚠️ 有限 |
| 性能 | 相对较低 | 较高 |
| 适用场景 | 仪表盘、监控器 | 简单进度显示 |

## Reference

- [Gauge Component API](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/gauge-0000001054359314-V3)
- [Gauge Style Options](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/gauge-0000001054359314-V3)
