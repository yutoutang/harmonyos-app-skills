# PageTransition 页面转场动画

## 概述

`PageTransition` 是 OpenHarmony 中用于实现页面转场动画的组件。通过配置不同的转场效果，可以实现页面切换时的平滑过渡动画，提升用户体验。

## 基本用法

### 1. 基础透明度转场

```typescript
@ComponentV2
struct BasicTransitionExample {
  @Local isShowing: boolean = true

  build() {
    Column() {
      if (this.isShowing) {
        Text('Hello')
          .transition(TransitionEffect.OPACITY.duration(500))
      }

      Button('Toggle')
        .onClick(() => {
          this.isShowing = !this.isShowing
        })
    }
  }
}
```

### 2. 滑动转场

```typescript
// 从左侧滑入
.transition(TransitionEffect.SLIDE_LEFT.duration(500))

// 从右侧滑入
.transition(TransitionEffect.SLIDE_RIGHT.duration(500))

// 从顶部滑入
.transition(TransitionEffect.SLIDE_TOP.duration(500))

// 从底部滑入
.transition(TransitionEffect.SLIDE_BOTTOM.duration(500))
```

### 3. 组合转场效果

```typescript
// 透明度 + 滑动
.transition(
  TransitionEffect.OPACITY
    .combine(TransitionEffect.SLIDE_LEFT)
    .duration(600)
    .curve(Curve.EaseOut)
)
```

### 4. 缩放转场

```typescript
// 缩放效果
.transition(
  TransitionEffect.OPACITY
    .combine(TransitionEffect.scale({ x: 0, y: 0 }))
    .duration(500)
)
```

### 5. 旋转转场

```typescript
// 旋转效果
.transition(
  TransitionEffect.OPACITY
    .combine(TransitionEffect.rotate({ angle: 180 }))
    .duration(600)
)
```

## 转场类型

### TransitionEffect 类型

| 类型 | 说明 | 使用场景 |
|------|------|---------|
| `OPACITY` | 透明度渐变 | 淡入淡出效果 |
| `SLIDE_LEFT` | 从左滑入 | 页面从左侧进入 |
| `SLIDE_RIGHT` | 从右滑入 | 页面从右侧进入 |
| `SLIDE_TOP` | 从上滑入 | 页面从顶部进入 |
| `SLIDE_BOTTOM` | 从下滑入 | 页面从底部进入 |
| `scale()` | 缩放 | 放大缩小效果 |
| `rotate()` | 旋转 | 旋转动画效果 |

## 动画参数

### duration（持续时间）

```typescript
.transition(
  TransitionEffect.OPACITY.duration(500) // 500毫秒
)
```

### curve（动画曲线）

```typescript
.transition(
  TransitionEffect.OPACITY
    .duration(500)
    .curve(Curve.EaseInOut) // 可选：Ease, EaseIn, EaseOut, Linear 等
)
```

常用动画曲线：
- `Curve.Ease` - 缓动（默认）
- `Curve.EaseIn` - 缓入
- `Curve.EaseOut` - 缓出
- `Curve.EaseInOut` - 缓入缓出
- `Curve.Linear` - 线性

### 组合效果

```typescript
// 使用 combine 方法组合多个效果
TransitionEffect.OPACITY
  .combine(TransitionEffect.SLIDE_LEFT)
  .combine(TransitionEffect.scale({ x: 0.8, y: 0.8 }))
```

## 实际应用场景

### 1. 页面切换动画

```typescript
@Entry
@ComponentV2
struct PageTransitionExample {
  @Local currentPage: number = 0

  build() {
    Stack() {
      if (this.currentPage === 0) {
        PageOne()
          .transition(TransitionEffect.SLIDE_LEFT.duration(300))
      } else {
        PageTwo()
          .transition(TransitionEffect.SLIDE_RIGHT.duration(300))
      }
    }
  }
}
```

### 2. 模态弹窗动画

```typescript
@ComponentV2
struct ModalDialog {
  @Local isVisible: boolean = false

  build() {
    Stack() {
      // 主内容
      Column() { /* ... */ }

      // 弹窗
      if (this.isVisible) {
        Column() {
          // 弹窗内容
        }
        .transition(
          TransitionEffect.OPACITY
            .combine(TransitionEffect.scale({ x: 0.8, y: 0.8 }))
            .duration(300)
            .curve(Curve.EaseOut)
        )
      }
    }
  }
}
```

### 3. 列表项展开/收起

```typescript
@ComponentV2
struct ExpandableItem {
  @Local isExpanded: boolean = false

  build() {
    Column() {
      // 标题行
      Row() { /* ... */ }
        .onClick(() => {
          this.isExpanded = !this.isExpanded
        })

      // 展开内容
      if (this.isExpanded) {
        Column() {
          // 详细内容
        }
        .transition(
          TransitionEffect.OPACITY
            .combine(TransitionEffect.SLIDE_TOP)
            .duration(300)
        )
      }
    }
  }
}
```

### 4. 卡片翻转效果

```typescript
@ComponentV2
struct FlipCard {
  @Local isFlipped: boolean = false

  build() {
    Stack() {
      if (!this.isFlipped) {
        // 正面
        Column() { /* 正面内容 */ }
          .transition(
            TransitionEffect.rotate({ angle: 180 })
              .duration(600)
          )
      } else {
        // 背面
        Column() { /* 背面内容 */ }
          .transition(
            TransitionEffect.rotate({ angle: -180 })
              .duration(600)
          )
      }
    }
    .onClick(() => {
      this.isFlipped = !this.isFlipped
    })
  }
}
```

## 最佳实践

### 1. 动画时长建议

- **快速切换**：200-300ms（按钮状态、小元素）
- **常规切换**：300-500ms（页面切换、弹窗）
- **慢速切换**：500-800ms（复杂场景、强调效果）

### 2. 曲线选择

```typescript
// 进入动画 - 使用 EaseOut
.transition(TransitionEffect.SLIDE_LEFT.curve(Curve.EaseOut))

// 退出动画 - 使用 EaseIn
.transition(TransitionEffect.SLIDE_RIGHT.curve(Curve.EaseIn))

// 往复动画 - 使用 EaseInOut
.transition(TransitionEffect.OPACITY.curve(Curve.EaseInOut))
```

### 3. 性能优化

```typescript
// 避免频繁触发状态变化
@ComponentV2
struct OptimizedExample {
  @Local isVisible: boolean = false
  private transitionTimer: number = -1

  triggerTransition() {
    if (this.transitionTimer !== -1) {
      clearTimeout(this.transitionTimer)
    }

    this.isVisible = false
    this.transitionTimer = setTimeout(() => {
      this.isVisible = true
      this.transitionTimer = -1
    }, 100)
  }
}
```

### 4. 条件渲染优化

```typescript
// 使用 if 条件语句控制组件显示/隐藏
if (this.shouldShow) {
  Content()
    .transition(TransitionEffect.OPACITY)
}

// 避免使用 opacity 属性控制显示/隐藏（性能较差）
```

## 注意事项

1. **性能考虑**：
   - 复杂转场动画可能影响性能
   - 避免同时进行多个复杂转场
   - 在低端设备上考虑简化动画效果

2. **状态管理**：
   - 使用 `@Local` 状态变量控制转场
   - 避免在动画过程中频繁更新状态

3. **嵌套转场**：
   - 父子组件可以分别设置转场效果
   - 注意嵌套转场的性能影响

4. **生命周期**：
   - 转场动画在组件挂载/卸载时触发
   - 使用 `if` 条件语句控制组件生命周期

## 相关组件

- **Navigation** - 页面导航容器
- **NavDestination** - 导航目标页面
- **Animator** - 属性动画
- **AnimateTo** - 显式动画

## 示例代码

完整示例请参考：
- `/ycomponent/src/main/ets/components/pagetransition/PageTransitionExample.ets`

## 参考资源

- [HarmonyOS PageTransition 官方文档](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-transition-property-V3)
- [HarmonyOS 动画曲线](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-appendix-enums-V3)
