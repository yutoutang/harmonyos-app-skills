# SymbolGlyph 组件 HarmonyOS 6.0 开发 Skill

## 概述

SymbolGlyph 是 OpenHarmony 中用于显示 SF Symbols 图标的独立组件。与 SymbolSpan 不同，SymbolGlyph 可以单独使用，不依赖于 Text 组件。它提供了更强大的图标渲染能力，支持多种渲染策略、动画效果和样式定制。

## 重要说明

- **独立组件**: SymbolGlyph 可以单独使用，不需要父容器
- **系统图标**: 使用 HarmonyOS 系统预定义的 Symbol 图标
- **资源格式**: 使用 `$r('sys.symbol.xxx')` 格式引用图标
- **渲染策略**: 支持多种渲染模式（单色、多层、调色板等）
- **动画支持**: 支持丰富的动画效果

## 模块信息

- **组件名称**: SymbolGlyph
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [SymbolGlyph 符号字形 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-symbol-glyph-V5)

## 一、组件基础

### 1.1 基础用法

```typescript
// 简单图标
SymbolGlyph($r('sys.symbol.house'))
  .fontSize(48)

// 带颜色的图标
SymbolGlyph($r('sys.symbol.heart_fill'))
  .fontSize(48)
  .fontColor('#E91E63')

// 带效果的图标
SymbolGlyph($r('sys.symbol.star_fill'))
  .fontSize(48)
  .fontColor('#FFC107')
  .symbolEffect(SymbolEffect.BOUNCE)
```

### 1.2 SymbolGlyph vs SymbolSpan

```typescript
// SymbolSpan - 必须在 Text 中使用
Text() {
  SymbolSpan($r('sys.symbol.house'))
    .fontSize(24)
  TextSpan(' 首页')
}

// SymbolGlyph - 可以单独使用
Column() {
  SymbolGlyph($r('sys.symbol.house'))
    .fontSize(48)
  Text('首页')
    .fontSize(16)
}
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| id | `Resource` | 是 | - | Symbol 图标资源 ID |
| options | `SymbolGlyphOptions` | 否 | - | 图标选项 |

### 2.2 样式属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `fontSize` | `number \| string \| Resource` | - | 图标大小 |
| `fontColor` | `ResourceColor` | - | 图标颜色 |
| `fontWeight` | `number \| FontWeight \| string` | - | 图标线条粗细 |

### 2.3 渲染属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `renderingStrategy` | `SymbolRenderingStrategy` | SINGLE | 渲染策略 |
| `symbolEffect` | `SymbolEffect` | - | 动画效果 |

### 2.4 交互属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `onClick` | `() => void` | - | 点击事件 |

## 三、渲染策略 (Rendering Strategy)

SymbolGlyph 支持以下渲染策略：

| 策略 | 描述 | 适用场景 |
|------|------|----------|
| `SymbolRenderingStrategy.SINGLE` | 单色渲染（默认） | 简单图标 |
| `SymbolRenderingStrategy.MULTIPLE_COLOR` | 多色渲染 | 彩色图标 |
| `SymbolRenderingStrategy.PALETTE` | 调色板渲染 | 需要自定义颜色的图标 |
| `SymbolRenderingStrategy.HIERARCHICAL` | 分层渲染 | 多层图标 |

## 四、使用示例

### 4.1 基础图标示例

```typescript
@ComponentV2
struct BasicSymbolGlyphExample {
  build() {
    Column({ space: 16 }) {
      Text('基础 SymbolGlyph')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      // 不同尺寸
      Row({ space: 16 }) {
        SymbolGlyph($r('sys.symbol.heart_fill'))
          .fontSize(24)
          .fontColor('#E91E63')

        SymbolGlyph($r('sys.symbol.heart_fill'))
          .fontSize(32)
          .fontColor('#E91E63')

        SymbolGlyph($r('sys.symbol.heart_fill'))
          .fontSize(48)
          .fontColor('#E91E63')

        SymbolGlyph($r('sys.symbol.heart_fill'))
          .fontSize(64)
          .fontColor('#E91E63')
      }
      .justifyContent(FlexAlign.SpaceEvenly)

      // 不同颜色
      Row({ space: 16 }) {
        SymbolGlyph($r('sys.symbol.star_fill'))
          .fontSize(48)
          .fontColor('#FF0000')

        SymbolGlyph($r('sys.symbol.star_fill'))
          .fontSize(48)
          .fontColor('#28A745')

        SymbolGlyph($r('sys.symbol.star_fill'))
          .fontSize(48)
          .fontColor('#007DFF')

        SymbolGlyph($r('sys.symbol.star_fill'))
          .fontSize(48)
          .fontColor('#FFC107')
      }
    }
  }
}
```

### 4.2 渲染策略示例

```typescript
@ComponentV2
struct RenderingStrategyExample {
  build() {
    Column({ space: 16 }) {
      Text('渲染策略示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      // 单色渲染（默认）
      Column({ space: 8 }) {
        Text('单色渲染 (SINGLE)')
          .fontSize(14)
          .fontColor('#666666')

        SymbolGlyph($r('sys.symbol.person_crop_circle_fill'))
          .fontSize(64)
          .renderingStrategy(SymbolRenderingStrategy.SINGLE)
          .fontColor('#007DFF')
      }

      // 多色渲染
      Column({ space: 8 }) {
        Text('多色渲染 (MULTIPLE_COLOR)')
          .fontSize(14)
          .fontColor('#666666')

        SymbolGlyph($r('sys.symbol.person_crop_circle_fill'))
          .fontSize(64)
          .renderingStrategy(SymbolRenderingStrategy.MULTIPLE_COLOR)
      }

      // 调色板渲染
      Column({ space: 8 }) {
        Text('调色板渲染 (PALETTE)')
          .fontSize(14)
          .fontColor('#666666')

        SymbolGlyph($r('sys.symbol.person_crop_circle_fill'))
          .fontSize(64)
          .renderingStrategy(SymbolRenderingStrategy.PALETTE)
          .fontColor('#007DFF')
      }
    }
  }
}
```

### 4.3 动画效果示例

```typescript
@ComponentV2
struct SymbolEffectExample {
  @Local isPulsing: boolean = false
  @Local isBouncing: boolean = false
  @Local isRotating: boolean = false

  build() {
    Column({ space: 16 }) {
      Text('动画效果示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      // 脉冲效果
      Column({ space: 8 }) {
        Text('脉冲效果 (PULSE)')
          .fontSize(14)
          .fontColor('#666666')

        SymbolGlyph($r('sys.symbol.heart_fill'))
          .fontSize(64)
          .fontColor('#E91E63')
          .symbolEffect(this.isPulsing ? SymbolEffect.PULSE : undefined)
          .onClick(() => {
            this.isPulsing = !this.isPulsing
          })
      }

      // 弹跳效果
      Column({ space: 8 }) {
        Text('弹跳效果 (BOUNCE)')
          .fontSize(14)
          .fontColor('#666666')

        SymbolGlyph($r('sys.symbol.circle_fill'))
          .fontSize(64)
          .fontColor('#007DFF')
          .symbolEffect(this.isBouncing ? SymbolEffect.BOUNCE : undefined)
          .onClick(() => {
            this.isBouncing = !this.isBouncing
          })
      }

      // 旋转效果
      Column({ space: 8 }) {
        Text('旋转效果 (ROTATE)')
          .fontSize(14)
          .fontColor('#666666')

        SymbolGlyph($r('sys.symbol.arrow_clockwise'))
          .fontSize(64)
          .fontColor('#28A745')
          .rotate({ angle: this.isRotating ? 360 : 0 })
          .animation({
            duration: 1000,
            curve: Curve.Linear,
            iterations: -1
          })
          .onClick(() => {
            this.isRotating = !this.isRotating
          })
      }
    }
  }
}
```

### 4.4 交互示例

```typescript
@ComponentV2
struct InteractiveSymbolGlyphExample {
  @Local isLiked: boolean = false
  @Local isStarred: boolean = false
  @Local isMuted: boolean = false

  build() {
    Column({ space: 16 }) {
      Text('交互式 SymbolGlyph')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      // 点赞按钮
      Row({ space: 16 }) {
        SymbolGlyph(this.isLiked ? $r('sys.symbol.heart_fill') : $r('sys.symbol.heart'))
          .fontSize(48)
          .fontColor(this.isLiked ? '#E91E63' : '#757575')
          .onClick(() => {
            this.isLiked = !this.isLiked
            if (this.isLiked) {
              // 触发动画
            }
          })

        SymbolGlyph(this.isStarred ? $r('sys.symbol.star_fill') : $r('sys.symbol.star'))
          .fontSize(48)
          .fontColor(this.isStarred ? '#FFC107' : '#757575')
          .onClick(() => {
            this.isStarred = !this.isStarred
          })

        SymbolGlyph(this.isMuted ? $r('sys.symbol.speaker_slash_fill') : $r('sys.symbol.speaker_2_fill'))
          .fontSize(48)
          .fontColor(this.isMuted ? '#FF0000' : '#757575')
          .onClick(() => {
            this.isMuted = !this.isMuted
          })
      }
      .justifyContent(FlexAlign.SpaceEvenly)

      // 状态文本
      Text(`点赞: ${this.isLiked ? '已点赞' : '未点赞'} | 收藏: ${this.isStarred ? '已收藏' : '未收藏'} | 静音: ${this.isMuted ? '已静音' : '未静音'}`)
        .fontSize(14)
        .fontColor('#666666')
    }
  }
}
```

### 4.5 图标网格示例

```typescript
@ComponentV2
struct SymbolGlyphGridExample {
  @Local icons: Array<{
    id: Resource;
    name: string;
    color: string;
  }> = [
    { id: $r('sys.symbol.house_fill'), name: '首页', color: '#007DFF' },
    { id: $r('sys.symbol.magnifyingglass'), name: '搜索', color: '#FFC107' },
    { id: $r('sys.symbol.bell_fill'), name: '通知', color: '#E91E63' },
    { id: $r('sys.symbol.person_fill'), name: '我的', color: '#28A745' },
    { id: $r('sys.symbol.gear'), name: '设置', color: '#757575' },
    { id: $r('sys.symbol.heart_fill'), name: '喜欢', color: '#E91E63' },
    { id: $r('sys.symbol.star_fill'), name: '收藏', color: '#FFC107' },
    { id: $r('sys.symbol.checkmark'), name: '完成', color: '#28A745' }
  ]

  build() {
    Column({ space: 16 }) {
      Text('图标网格')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Grid() {
        ForEach(this.icons, (icon: { id: Resource; name: string; color: string }) => {
          GridItem() {
            Column({ space: 8 }) {
              SymbolGlyph(icon.id)
                .fontSize(40)
                .fontColor(icon.color)

              Text(icon.name)
                .fontSize(12)
                .fontColor('#666666')
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#F5F5F5')
            .borderRadius(8)
            .onClick(() => {
              console.info(`点击了 ${icon.name}`)
            })
          }
        })
      }
      .columnsTemplate('1fr 1fr 1fr 1fr')
      .rowsGap(12)
      .columnsGap(12)
      .height(300)
    }
  }
}
```

### 4.6 状态指示示例

```typescript
@ComponentV2
struct StatusIndicatorExample {
  @Local currentStatus: 'loading' | 'success' | 'warning' | 'error' = 'loading'

  build() {
    Column({ space: 24 }) {
      Text('状态指示器')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      // 状态图标
      if (this.currentStatus === 'loading') {
        SymbolGlyph($r('sys.symbol.clock'))
          .fontSize(64)
          .fontColor('#007DFF')
          .rotate({ angle: 360 })
          .animation({
            duration: 1000,
            curve: Curve.Linear,
            iterations: -1
          })

        Text('加载中...')
          .fontSize(14)
          .fontColor('#666666')

      } else if (this.currentStatus === 'success') {
        SymbolGlyph($r('sys.symbol.checkmark_circle_fill'))
          .fontSize(64)
          .fontColor('#28A745')

        Text('操作成功')
          .fontSize(14)
          .fontColor('#28A745')

      } else if (this.currentStatus === 'warning') {
        SymbolGlyph($r('sys.symbol.exclamationmark_triangle_fill'))
          .fontSize(64)
          .fontColor('#FFC107')

        Text('警告信息')
          .fontSize(14)
          .fontColor('#FFC107')

      } else if (this.currentStatus === 'error') {
        SymbolGlyph($r('sys.symbol.xmark_circle_fill'))
          .fontSize(64)
          .fontColor('#DC3545')

        Text('操作失败')
          .fontSize(14)
          .fontColor('#DC3545')
      }

      // 状态切换按钮
      Row({ space: 8 }) {
        Button('加载')
          .onClick(() => {
            this.currentStatus = 'loading'
          })
        Button('成功')
          .onClick(() => {
            this.currentStatus = 'success'
          })
        Button('警告')
          .onClick(() => {
            this.currentStatus = 'warning'
          })
        Button('错误')
          .onClick(() => {
            this.currentStatus = 'error'
          })
      }
      .margin({ top: 16 })
    }
  }
}
```

## 五、高级用法

### 5.1 自定义调色板

```typescript
@ComponentV2
struct CustomPaletteExample {
  build() {
    Column({ space: 16 }) {
      Text('自定义调色板')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      // 使用调色板渲染策略
      SymbolGlyph($r('sys.symbol.person_crop_circle_fill'))
        .fontSize(64)
        .renderingStrategy(SymbolRenderingStrategy.PALETTE)
        .fontColor('#007DFF')

      SymbolGlyph($r('sys.symbol.wifi'))
        .fontSize(48)
        .renderingStrategy(SymbolRenderingStrategy.PALETTE)
        .fontColor('#28A745')
    }
  }
}
```

### 5.2 图标组合

```typescript
@ComponentV2
struct SymbolGlyphCompositionExample {
  build() {
    Column({ space: 16 }) {
      Text('图标组合')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      // 背景图标 + 前景图标
      Stack({ alignContent: Alignment.Center }) {
        SymbolGlyph($r('sys.symbol.circle_fill'))
          .fontSize(64)
          .fontColor('#E3F2FD')

        SymbolGlyph($r('sys.symbol.heart_fill'))
          .fontSize(32)
          .fontColor('#E91E63')
      }

      // 多层图标叠加
      Stack({ alignContent: Alignment.Center }) {
        SymbolGlyph($r('sys.symbol.star_fill'))
          .fontSize(64)
          .fontColor('#FFC107')
          .rotate({ angle: 30 })

        SymbolGlyph($r('sys.symbol.star_fill'))
          .fontSize(64)
          .fontColor('#FFC107')
          .rotate({ angle: -30 })

        SymbolGlyph($r('sys.symbol.person_fill'))
          .fontSize(32)
          .fontColor('#FFFFFF')
      }
    }
  }
}
```

### 5.3 响应式图标

```typescript
@ComponentV2
struct ResponsiveSymbolGlyphExample {
  @Local iconSize: number = 48
  @Local iconColor: string = '#007DFF'

  build() {
    Column({ space: 16 }) {
      Text('响应式图标')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      // 响应式图标
      SymbolGlyph($r('sys.symbol.heart_fill'))
        .fontSize(this.iconSize)
        .fontColor(this.iconColor)

      // 控制滑块
      Column({ space: 8 }) {
        Text(`大小: ${this.iconSize}`)
          .fontSize(14)

        Slider({
          value: this.iconSize,
          min: 24,
          max: 96,
          step: 4
        })
          .width('100%')
          .onChange((value: number) => {
            this.iconSize = value
          })

        Text('颜色')
          .fontSize(14)

        Row({ space: 8 }) {
          Button('红')
            .backgroundColor('#FF0000')
            .onClick(() => {
              this.iconColor = '#FF0000'
            })
          Button('绿')
            .backgroundColor('#28A745')
            .onClick(() => {
              this.iconColor = '#28A745'
            })
          Button('蓝')
            .backgroundColor('#007DFF')
            .onClick(() => {
              this.iconColor = '#007DFF'
            })
        }
      }
      .width('100%')
    }
  }
}
```

## 六、最佳实践

### 6.1 图标大小选择

```typescript
// ✅ 推荐：使用标准尺寸
SymbolGlyph($r('sys.symbol.house'))
  .fontSize(24)  // 小图标
SymbolGlyph($r('sys.symbol.house'))
  .fontSize(48)  // 标准图标
SymbolGlyph($r('sys.symbol.house'))
  .fontSize(64)  // 大图标
```

### 6.2 渲染策略选择

```typescript
// ✅ 单色图标使用 SINGLE
SymbolGlyph($r('sys.symbol.heart_fill'))
  .renderingStrategy(SymbolRenderingStrategy.SINGLE)
  .fontColor('#E91E63')

// ✅ 彩色图标使用 MULTIPLE_COLOR
SymbolGlyph($r('sys.symbol.person_crop_circle_fill'))
  .renderingStrategy(SymbolRenderingStrategy.MULTIPLE_COLOR)
```

### 6.3 性能优化

```typescript
// ✅ 推荐：避免频繁切换动画
SymbolGlyph($r('sys.symbol.heart_fill'))
  .symbolEffect(shouldAnimate ? SymbolEffect.PULSE : undefined)

// ❌ 避免：每个图标都应用复杂动画
SymbolGlyph($r('sys.symbol.heart_fill'))
  .symbolEffect(SymbolEffect.PULSE)
  .symbolEffect(SymbolEffect.BOUNCE)  // 冲突
```

## 七、常见问题

### Q1: SymbolGlyph 和 SymbolSpan 有什么区别？

**答案**:
- SymbolGlyph 是独立组件，可以单独使用
- SymbolSpan 必须在 Text 组件中使用
- SymbolGlyph 支持更多渲染策略和动画效果
- SymbolGlyph 更适合大型图标和独立显示

### Q2: 如何选择渲染策略？

**答案**:
- 单色图标：使用 `SymbolRenderingStrategy.SINGLE`
- 彩色图标：使用 `SymbolRenderingStrategy.MULTIPLE_COLOR`
- 自定义颜色：使用 `SymbolRenderingStrategy.PALETTE`

### Q3: SymbolGlyph 可以添加点击事件吗？

**答案**: 可以。

```typescript
SymbolGlyph($r('sys.symbol.heart_fill'))
  .fontSize(48)
  .onClick(() => {
    console.info('图标被点击')
  })
```

### Q4: 如何实现图标的脉冲动画？

**解决方案**:
```typescript
SymbolGlyph($r('sys.symbol.heart_fill'))
  .fontSize(48)
  .symbolEffect(SymbolEffect.PULSE)
```

## 八、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 12+ | ✅ | 完全支持 |
| API 11- | ❌ | 不支持 |

## 九、参考资料

- [SymbolGlyph 符号字形 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-symbol-glyph-V5)
- [SymbolSpan 符号图标 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-symbol-span-V5)
- [SF Symbols - Apple Developer](https://developer.apple.com/sf-symbols/)
