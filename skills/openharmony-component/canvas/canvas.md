# Canvas 组件 HarmonyOS 6.0 开发 Skill

## 概述

Canvas 组件是 OpenHarmony 中提供 2D 绘图能力的画布组件，支持使用 CanvasRenderingContext2D API 进行自定义图形绘制。它提供了丰富的绘图接口，包括路径、矩形、圆形、文本、图像等多种图形元素的绘制能力。

## 重要说明

- **绘图上下文**: 使用 `CanvasRenderingContext2D` 进行所有绘图操作
- **坐标系**: 原点在画布左上角，X 轴向右，Y 轴向下
- **性能**: 绘图操作较重，避免在频繁刷新的场景过度使用
- **动画**: 建议配合 `requestAnimationFrame` 实现流畅动画
- **离屏绘制**: 支持离屏 Canvas (OffscreenCanvas) 用于后台绘制

## 模块信息

- **组件名称**: Canvas
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [Canvas 画布 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-canvas-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// Canvas 是内置组件，无需导入
// 需要导入绘图上下文类型
import { CanvasRenderingContext2D } from '@kit.ArkGraphics2D'
```

### 1.2 基础用法

```typescript
@ComponentV2
struct CanvasExample {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Column() {
      Canvas(this.context)
        .width('100%')
        .height(300)
        .backgroundColor('#F5F5F5')
        .onReady(() => {
          // 绘制矩形
          this.context.fillStyle = '#007DFF'
          this.context.fillRect(50, 50, 200, 100)
        })
    }
  }
}
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| context | `CanvasRenderingContext2D` | 是 | - | 绘图上下文对象 |
| options | `CanvasOptions` | 否 | - | 画布选项 |

### 2.2 画布属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `width` | `number \| string` | - | 画布宽度 |
| `height` | `number \| string` | - | 画布高度 |
| `backgroundColor` | `ResourceColor` | - | 背景颜色 |
| `onReady` | `() => void` | - | 画布准备完成回调 |

## 三、绘图上下文 API

### 3.1 状态管理

```typescript
// 保存当前状态
this.context.save()

// 恢复之前保存的状态
this.context.restore()

// 重置变换矩阵
this.context.resetTransform()
```

### 3.2 变换操作

```typescript
// 平移
this.context.translate(x, y)

// 旋转
this.context.rotate(angle)

// 缩放
this.context.scale(x, y)

// 变换矩阵
this.context.transform(a, b, c, d, e, f)
```

### 3.3 矩形绘制

```typescript
// 填充矩形
this.context.fillStyle = '#007DFF'
this.context.fillRect(x, y, width, height)

// 描边矩形
this.context.strokeStyle = '#FF0000'
this.context.lineWidth = 2
this.context.strokeRect(x, y, width, height)

// 清除矩形区域
this.context.clearRect(x, y, width, height)
```

### 3.4 路径绘制

```typescript
// 开始新路径
this.context.beginPath()

// 移动画笔
this.context.moveTo(x, y)

// 绘制直线
this.context.lineTo(x, y)

// 绘制矩形路径
this.context.rect(x, y, width, height)

// 绘制圆形/圆弧
this.context.arc(x, y, radius, startAngle, endAngle, anticlockwise?)

// 绘制椭圆
this.context.ellipse(x, y, radiusX, radiusY, rotation, startAngle, endAngle)

// 二次贝塞尔曲线
this.context.quadraticCurveTo(cpx, cpy, x, y)

// 三次贝塞尔曲线
this.context.bezierCurveTo(cp1x, cp1y, cp2x, cp2y, x, y)

// 关闭路径
this.context.closePath()

// 填充路径
this.context.fill()

// 描边路径
this.context.stroke()
```

### 3.5 样式设置

```typescript
// 填充样式
this.context.fillStyle = '#007DFF'
this.context.fillStyle = 'rgba(0, 125, 255, 0.5)'

// 描边样式
this.context.strokeStyle = '#FF0000'

// 线宽
this.context.lineWidth = 2

// 线端点样式
this.context.lineCap = 'round' // 'butt' | 'round' | 'square'

// 线连接样式
this.context.lineJoin = 'round' // 'bevel' | 'round' | 'miter'

// 虚线模式
this.context.setLineDash([5, 5])

// 阴影
this.context.shadowBlur = 10
this.context.shadowColor = 'rgba(0, 0, 0, 0.5)'
this.context.shadowOffsetX = 5
this.context.shadowOffsetY = 5
```

### 3.6 文本绘制

```typescript
// 设置字体
this.context.font = '30px sans-serif'

// 文本对齐
this.context.textAlign = 'center' // 'start' | 'end' | 'left' | 'right' | 'center'

// 文本基线
this.context.textBaseline = 'middle' // 'top' | 'hanging' | 'middle' | 'alphabetic' | 'ideographic' | 'bottom'

// 填充文本
this.context.fillText('Hello World', x, y)

// 描边文本
this.context.strokeText('Hello World', x, y)

// 测量文本宽度
const width = this.context.measureText('Hello World').width
```

### 3.7 图像绘制

```typescript
// 绘制图像
this.context.drawImage(image, sx, sy, sWidth, sHeight, dx, dy, dWidth, dHeight)

// 创建图像数据
const imageData = this.context.createImageData(width, height)

// 获取图像数据
const imageData = this.context.getImageData(x, y, width, height)

// 放置图像数据
this.context.putImageData(imageData, x, y)
```

### 3.8 渐变

```typescript
// 线性渐变
const gradient = this.context.createLinearGradient(x0, y0, x1, y1)
gradient.addColorStop(0, '#007DFF')
gradient.addColorStop(1, '#00C6FF')
this.context.fillStyle = gradient

// 径向渐变
const gradient = this.context.createRadialGradient(x0, y0, r0, x1, y1, r1)
gradient.addColorStop(0, '#007DFF')
gradient.addColorStop(1, '#FFFFFF')
this.context.fillStyle = gradient
```

### 3.9 裁剪

```typescript
// 创建裁剪区域
this.context.beginPath()
this.context.arc(x, y, radius, 0, 2 * Math.PI)
this.context.clip()

// 之后的所有绘制操作都只显示在裁剪区域内
```

## 四、常见使用场景

### 4.1 绘制基本图形

```typescript
@ComponentV2
struct BasicShapes {
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  build() {
    Canvas(this.context)
      .width('100%')
      .height(300)
      .onReady(() => {
        // 绘制填充矩形
        this.context.fillStyle = '#007DFF'
        this.context.fillRect(20, 20, 100, 60)

        // 绘制描边矩形
        this.context.strokeStyle = '#FF0000'
        this.context.lineWidth = 2
        this.context.strokeRect(140, 20, 100, 60)

        // 绘制圆形
        this.context.beginPath()
        this.context.arc(70, 150, 40, 0, 2 * Math.PI)
        this.context.fillStyle = '#28A745'
        this.context.fill()

        // 绘制三角形
        this.context.beginPath()
        this.context.moveTo(200, 110)
        this.context.lineTo(260, 190)
        this.context.lineTo(140, 190)
        this.context.closePath()
        this.context.fillStyle = '#FFC107'
        this.context.fill()
      })
  }
}
```

### 4.2 绘制图表

```typescript
@ComponentV2
struct ChartCanvas {
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  build() {
    Canvas(this.context)
      .width('100%')
      .height(300)
      .onReady(() => {
        const data = [30, 60, 45, 80, 55]
        const barWidth = 40
        const gap = 20
        const startX = 30
        const maxHeight = 200

        data.forEach((value, index) => {
          const x = startX + index * (barWidth + gap)
          const height = (value / 100) * maxHeight
          const y = 250 - height

          // 绘制柱状图
          this.context.fillStyle = '#007DFF'
          this.context.fillRect(x, y, barWidth, height)

          // 绘制数值
          this.context.fillStyle = '#333'
          this.context.font = '14px sans-serif'
          this.context.textAlign = 'center'
          this.context.fillText(value.toString(), x + barWidth / 2, y - 5)
        })
      })
  }
}
```

### 4.3 绘制路径和曲线

```typescript
@ComponentV2
struct PathCanvas {
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  build() {
    Canvas(this.context)
      .width('100%')
      .height(300)
      .onReady(() => {
        // 绘制贝塞尔曲线
        this.context.beginPath()
        this.context.moveTo(20, 150)
        this.context.bezierCurveTo(100, 50, 200, 250, 280, 150)
        this.context.strokeStyle = '#007DFF'
        this.context.lineWidth = 3
        this.context.stroke()

        // 绘制二次曲线
        this.context.beginPath()
        this.context.moveTo(20, 250)
        this.context.quadraticCurveTo(150, 100, 280, 250)
        this.context.strokeStyle = '#28A745'
        this.context.lineWidth = 3
        this.context.stroke()
      })
  }
}
```

### 4.4 动画效果

```typescript
@ComponentV2
struct AnimationCanvas {
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))
  @Local angle: number = 0

  build() {
    Canvas(this.context)
      .width('100%')
      .height(300)
      .onReady(() => {
        this.animate()
      })

    Button('Stop')
      .onClick(() => {
        this.angle = 0
      })
  }

  animate() {
    this.context.clearRect(0, 0, 300, 300)

    this.context.save()
    this.context.translate(150, 150)
    this.context.rotate(this.angle * Math.PI / 180)

    this.context.fillStyle = '#007DFF'
    this.context.fillRect(-50, -50, 100, 100)

    this.context.restore()

    this.angle += 2
    if (this.angle < 360) {
      setTimeout(() => this.animate(), 16)
    }
  }
}
```

### 4.5 渐变效果

```typescript
@ComponentV2
struct GradientCanvas {
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  build() {
    Canvas(this.context)
      .width('100%')
      .height(300)
      .onReady(() => {
        // 线性渐变
        const linearGradient = this.context.createLinearGradient(20, 20, 20, 120)
        linearGradient.addColorStop(0, '#007DFF')
        linearGradient.addColorStop(1, '#00C6FF')
        this.context.fillStyle = linearGradient
        this.context.fillRect(20, 20, 120, 100)

        // 径向渐变
        const radialGradient = this.context.createRadialGradient(200, 70, 10, 200, 70, 60)
        radialGradient.addColorStop(0, '#FFC107')
        radialGradient.addColorStop(1, '#FF9800')
        this.context.fillStyle = radialGradient
        this.context.fillRect(140, 20, 120, 100)

        // 文本渐变
        const textGradient = this.context.createLinearGradient(20, 180, 280, 180)
        textGradient.addColorStop(0, '#007DFF')
        textGradient.addColorStop(0.5, '#28A745')
        textGradient.addColorStop(1, '#FFC107')
        this.context.fillStyle = textGradient
        this.context.font = 'bold 40px sans-serif'
        this.context.textAlign = 'center'
        this.context.fillText('Gradient Text', 150, 210)
      })
  }
}
```

## 五、性能优化建议

### 5.1 减少重绘

```typescript
// 不好的做法：每次状态改变都完全重绘
@Local count: number = 0
this.context.clearRect(0, 0, width, height)
this.drawEverything() // 重绘所有内容

// 好的做法：只重绘变化的部分
this.context.clearRect(x, y, width, height) // 只清除变化区域
this.drawChangedPart()
```

### 5.2 使用离屏 Canvas

```typescript
// 创建离屏 Canvas 进行复杂绘制
private offscreenCanvas: OffscreenCanvas = new OffscreenCanvas(300, 300)
private offscreenContext: CanvasRenderingContext2D = this.offscreenCanvas.getContext('2d')

// 在离屏 Canvas 上绘制
this.offscreenContext.fillStyle = '#007DFF'
this.offscreenContext.fillRect(0, 0, 300, 300)

// 将离屏 Canvas 绘制到主 Canvas
this.context.drawImage(this.offscreenCanvas, 0, 0)
```

### 5.3 优化绘图操作

```typescript
// 批量设置样式
this.context.fillStyle = '#007DFF'
this.context.strokeStyle = '#FF0000'
this.context.lineWidth = 2

// 批量绘制路径
this.context.beginPath()
this.context.moveTo(x1, y1)
this.context.lineTo(x2, y2)
this.context.lineTo(x3, y3)
this.context.closePath()
this.context.fill()
this.context.stroke()
```

## 六、常见问题

### 6.1 Canvas 内容模糊

```typescript
// 处理高分屏显示
const dpr = display.getDefaultDisplaySync().densityDPI / 160
const canvasWidth = 300 * dpr
const canvasHeight = 300 * dpr

Canvas(this.context)
  .width(300)
  .height(300)
  .onReady(() => {
    this.context.scale(dpr, dpr)
    // 绘制内容
  })
```

### 6.2 绘制顺序问题

```typescript
// Canvas 绘制是按顺序的，后绘制的内容会覆盖先绘制的内容
this.context.fillStyle = '#007DFF'  // 先绘制蓝色
this.context.fillRect(0, 0, 100, 100)

this.context.fillStyle = '#FF0000'  // 后绘制红色，会覆盖蓝色
this.context.fillRect(50, 50, 100, 100)
```

### 6.3 动画性能

```typescript
// 使用 requestAnimationFrame 获得更好的动画性能
animate() {
  this.draw()
  this.animationFrameId = requestAnimationFrame(() => this.animate())
}

// 组件销毁时取消动画
aboutToDisappear() {
  if (this.animationFrameId) {
    cancelAnimationFrame(this.animationFrameId)
  }
}
```

## 七、最佳实践

1. **及时清理资源**: 在组件销毁时清理动画和事件监听
2. **使用离屏 Canvas**: 对于复杂图形，使用离屏 Canvas 预渲染
3. **优化绘制频率**: 避免不必要的重绘，使用脏矩形技术
4. **合理使用 save/restore**: 及时保存和恢复绘图状态
5. **批量操作**: 将相同样式的绘制操作批量执行
6. **硬件加速**: 启用硬件加速提升绘图性能
