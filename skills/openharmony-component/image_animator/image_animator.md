# ImageAnimator 组件 HarmonyOS 6.0 开发 Skill

## 概述

ImageAnimator 组件是 OpenHarmony 中用于帧动画播放的组件，可以按照指定的时间顺序播放一组图片，实现动画效果。它支持播放控制、循环播放、帧率控制等功能。

## 重要说明

- **基础组件**: ImageAnimator 是 ArkUI 的基础内置组件，无需导入
- **用途**: 播放帧序列动画（类似 GIF 效果）
- **性能**: 支持预加载和帧缓存
- **控制**: 支持播放、暂停、停止等控制操作
- **灵活性**: 支持固定帧率和自定义每帧时长

## 模块信息

- **组件名称**: ImageAnimator
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [ImageAnimator 图片动画 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-image-animator-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// ImageAnimator 是内置组件，无需导入
// 直接使用即可
ImageAnimator({
  images: [
    { src: $r('app.media.frame1') },
    { src: $r('app.media.frame2') }
  ]
})
```

### 1.2 基础用法

```typescript
// 基础帧动画
ImageAnimator({
  images: [
    { src: $r('app.media.frame1') },
    { src: $r('app.media.frame2') },
    { src: $r('app.media.frame3') }
  ],
  duration: 1000,  // 总时长
  state: AnimationState.Running  // 播放状态
})
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| images | `Array<ImageAnimatorImage>` | 是 | - | 图片帧数组 |
| state | `AnimationState` | 是 | AnimationState.Initial | 动画状态 |
| duration | `number` | 否 | 1000 | 动画总时长（毫秒） |
| iterations | `number` | 否 | 1 | 迭代次数，-1 表示无限循环 |
| reverse | `boolean` | 否 | false | 是否反向播放 |
| fixedSize | `boolean` | 否 | true | 图片尺寸是否固定为组件大小 |

### 2.2 ImageAnimatorImage 参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| src | `string \| Resource` | 是 | - | 图片资源 |
| duration | `number` | 否 | - | 单帧时长（优先级高于总时长） |
| width | `number` | 否 | - | 图片宽度 |
| height | `number` | 否 | - | 图片高度 |

### 2.3 AnimationState 枚举

| 值 | 描述 |
|------|------|
| `AnimationState.Initial` | 初始状态 |
| `AnimationState.Running` | 播放中 |
| `AnimationState.Paused` | 暂停 |
| `AnimationState.Stopped` | 停止 |

### 2.4 ImageAnimator 方法

| 方法 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `start()` | - | `void` | 开始播放 |
| `pause()` | - | `void` | 暂停播放 |
| `stop()` | - | `void` | 停止播放 |
| `onStart()` | `() => void` | `void` | 播放开始回调 |
| `onPause()` | `() => void` | `void` | 暂停回调 |
| `onStop()` | `() => void` | `void` | 停止回调 |
| `onRepeat()` | `() => void` | `void` | 重复播放回调 |
| `onComplete()` | `() => void` | `void` | 播放完成回调 |

## 三、使用示例

### 3.1 基础帧动画

```typescript
@ComponentV2
struct BasicAnimator {
  @Local state: AnimationState = AnimationState.Running

  build() {
    Column({ space: 20 }) {
      ImageAnimator({
        images: [
          { src: $r('app.media.frame1') },
          { src: $r('app.media.frame2') },
          { src: $r('app.media.frame3') },
          { src: $r('app.media.frame4') }
        ],
        state: this.state,
        duration: 1000,
        iterations: -1  // 无限循环
      })
        .width(200)
        .height(200)
        .objectFit(ImageFit.Contain)

      Button('暂停/继续')
        .onClick(() => {
          this.state = this.state === AnimationState.Running
            ? AnimationState.Paused
            : AnimationState.Running
        })
    }
  }
}
```

### 3.2 自定义每帧时长

```typescript
@ComponentV2
struct CustomFrameDuration {
  build() {
    ImageAnimator({
      images: [
        { src: $r('app.media.frame1'), duration: 200 },
        { src: $r('app.media.frame2'), duration: 300 },
        { src: $r('app.media.frame3'), duration: 250 },
        { src: $r('app.media.frame4'), duration: 200 }
      ],
      state: AnimationState.Running
    })
      .width(200)
      .height(200)
  }
}
```

### 3.3 播放控制

```typescript
@ComponentV2
struct AnimatorControl {
  @Local state: AnimationState = AnimationState.Initial

  build() {
    Column({ space: 20 }) {
      ImageAnimator({
        images: [
          { src: $r('app.media.frame1') },
          { src: $r('app.media.frame2') },
          { src: $r('app.media.frame3') }
        ],
        state: this.state,
        duration: 1500,
        iterations: 3  // 播放3次
      })
        .width(200)
        .height(200)
        .onComplete(() => {
          console.info('动画播放完成')
          this.state = AnimationState.Stopped
        })

      Row({ space: 10 }) {
        Button('播放')
          .onClick(() => {
            this.state = AnimationState.Running
          })

        Button('暂停')
          .onClick(() => {
            this.state = AnimationState.Paused
          })

        Button('停止')
          .onClick(() => {
            this.state = AnimationState.Stopped
          })
      }
    }
  }
}
```

### 3.4 循环播放和反向播放

```typescript
@ComponentV2
struct LoopAndReverse {
  @Local iterations: number = -1  // -1 表示无限循环
  @Local reverse: boolean = false
  @Local state: AnimationState = AnimationState.Running

  build() {
    Column({ space: 20 }) {
      ImageAnimator({
        images: [
          { src: $r('app.media.frame1') },
          { src: $r('app.media.frame2') },
          { src: $r('app.media.frame3') }
        ],
        state: this.state,
        duration: 1000,
        iterations: this.iterations,
        reverse: this.reverse
      })
        .width(200)
        .height(200)

      Row({ space: 10 }) {
        Button('反向播放')
          .onClick(() => {
            this.reverse = !this.reverse
          })

        Button('单次播放')
          .onClick(() => {
            this.iterations = 1
            this.state = AnimationState.Running
          })

        Button('循环播放')
          .onClick(() => {
            this.iterations = -1
            this.state = AnimationState.Running
          })
      }
    }
  }
}
```

### 3.5 事件监听

```typescript
@ComponentV2
struct AnimatorWithEvents {
  @Local eventLog: string = '等待事件...'
  @Local state: AnimationState = AnimationState.Running

  build() {
    Column({ space: 20 }) {
      ImageAnimator({
        images: [
          { src: $r('app.media.frame1') },
          { src: $r('app.media.frame2') },
          { src: $r('app.media.frame3') }
        ],
        state: this.state,
        duration: 1000,
        iterations: 2
      })
        .width(200)
        .height(200)
        .onStart(() => {
          this.eventLog = '动画开始播放'
        })
        .onPause(() => {
          this.eventLog = '动画暂停'
        })
        .onRepeat(() => {
          this.eventLog = '动画重复播放'
        })
        .onComplete(() => {
          this.eventLog = '动画播放完成'
        })
        .onStop(() => {
          this.eventLog = '动画停止'
        })

      Text(this.eventLog)
        .fontSize(14)
        .fontColor('#666666')

      Row({ space: 10 }) {
        Button('播放')
          .onClick(() => {
            this.state = AnimationState.Running
          })

        Button('暂停')
          .onClick(() => {
            this.state = AnimationState.Paused
          })

        Button('停止')
          .onClick(() => {
            this.state = AnimationState.Stopped
          })
      }
    }
  }
}
```

## 四、高级用法

### 4.1 加载进度指示器

```typescript
@ComponentV2
struct LoadingIndicator {
  build() {
    ImageAnimator({
      images: [
        { src: $r('app.media.loading1') },
        { src: $r('app.media.loading2') },
        { src: $r('app.media.loading3') },
        { src: $r('app.media.loading4') }
      ],
      state: AnimationState.Running,
      duration: 800,
      iterations: -1
    })
      .width(50)
      .height(50)
      .objectFit(ImageFit.Contain)
  }
}
```

### 4.2 尺寸适配

```typescript
@ComponentV2
struct ResponsiveAnimator {
  @Local imageSize: number = 200

  build() {
    Column({ space: 20 }) {
      ImageAnimator({
        images: [
          { src: $r('app.media.frame1') },
          { src: $r('app.media.frame2') },
          { src: $r('app.media.frame3') }
        ],
        state: AnimationState.Running,
        duration: 1000,
        fixedSize: false  // 图片尺寸自适应
      })
        .width(this.imageSize)
        .height(this.imageSize)
        .objectFit(ImageFit.Contain)

      Slider({
        value: this.imageSize,
        min: 100,
        max: 300
      })
        .width('100%')
        .onChange((value: number) => {
          this.imageSize = value
        })
    }
  }
}
```

### 4.3 动态切换动画

```typescript
@ComponentV2
struct DynamicAnimator {
  @Local currentAnim: number = 0
  @Local state: AnimationState = AnimationState.Running

  private animations = [
    {
      name: '动画1',
      images: [
        { src: $r('app.media.anim1_frame1') },
        { src: $r('app.media.anim1_frame2') }
      ],
      duration: 1000
    },
    {
      name: '动画2',
      images: [
        { src: $r('app.media.anim2_frame1') },
        { src: $r('app.media.anim2_frame2') }
      ],
      duration: 1500
    }
  ]

  build() {
    Column({ space: 20 }) {
      ImageAnimator({
        images: this.animations[this.currentAnim].images,
        state: this.state,
        duration: this.animations[this.currentAnim].duration,
        iterations: -1
      })
        .width(200)
        .height(200)

      Row({ space: 10 }) {
        ForEach(this.animations, (anim: any, index: number) => {
          Button(anim.name)
            .backgroundColor(this.currentAnim === index ? '#007DFF' : '#CCCCCC')
            .onClick(() => {
              this.currentAnim = index
              this.state = AnimationState.Running
            })
        })
      }
    }
  }
}
```

## 五、最佳实践

### 5.1 资源优化

```typescript
// ✅ 推荐：使用适当的帧率和图片尺寸
ImageAnimator({
  images: [
    { src: $r('app.media.frame1') },
    { src: $r('app.media.frame2') }
  ],
  state: AnimationState.Running,
  duration: 500  // 适中的帧率
})

// ❌ 避免：过多的帧或过大的图片
ImageAnimator({
  images: Array(60).fill({ src: $r('app.media.large_frame') }),  // 60帧
  state: AnimationState.Running
})
```

### 5.2 内存管理

```typescript
// ✅ 推荐：组件销毁时停止动画
@ComponentV2
struct AnimatorPage {
  @Local state: AnimationState = AnimationState.Running

  aboutToDisappear() {
    this.state = AnimationState.Stopped
  }

  build() {
    ImageAnimator({
      images: [
        { src: $r('app.media.frame1') },
        { src: $r('app.media.frame2') }
      ],
      state: this.state
    })
  }
}
```

### 5.3 状态控制

```typescript
// ✅ 推荐：明确控制动画状态
@ComponentV2
struct ControlledAnimator {
  @Local state: AnimationState = AnimationState.Initial
  @Local isVisible: boolean = true

  build() {
    Column() {
      if (this.isVisible) {
        ImageAnimator({
          images: [
            { src: $r('app.media.frame1') },
            { src: $r('app.media.frame2') }
          ],
          state: this.state
        })
      }

      Button('显示/隐藏')
        .onClick(() => {
          this.isVisible = !this.isVisible
          if (!this.isVisible) {
            this.state = AnimationState.Paused
          } else {
            this.state = AnimationState.Running
          }
        })
    }
  }
}
```

### 5.4 性能优化

```typescript
// ✅ 推荐：使用固定尺寸减少重绘
ImageAnimator({
  images: [
    { src: $r('app.media.frame1'), width: 200, height: 200 },
    { src: $r('app.media.frame2'), width: 200, height: 200 }
  ],
  state: AnimationState.Running,
  fixedSize: true  // 固定尺寸
})
  .width(200)
  .height(200)
```

## 六、常见问题

### Q1: 动画不播放？

**解决方案**:
```typescript
// 1. 确保状态设置为 Running
ImageAnimator({
  images: [
    { src: $r('app.media.frame1') },
    { src: $r('app.media.frame2') }
  ],
  state: AnimationState.Running  // 必须设置为 Running
})

// 2. 检查图片资源是否存在
ImageAnimator({
  images: [
    { src: $r('app.media.frame1') },  // 确保资源存在
    { src: $r('app.media.frame2') }
  ],
  state: AnimationState.Running
})
```

### Q2: 如何实现类似 GIF 的效果？

**解决方案**:
```typescript
ImageAnimator({
  images: [
    { src: $r('app.media.frame1') },
    { src: $r('app.media.frame2') },
    { src: $r('app.media.frame3') }
  ],
  state: AnimationState.Running,
  duration: 1000,  // 总时长
  iterations: -1,  // 无限循环
  reverse: false
})
```

### Q3: 动画播放不流畅？

**解决方案**:
```typescript
// 1. 减少帧数或增加时长
ImageAnimator({
  images: [
    { src: $r('app.media.frame1') },
    { src: $r('app.media.frame2') }
  ],
  state: AnimationState.Running,
  duration: 2000  // 增加时长
})

// 2. 优化图片大小
ImageAnimator({
  images: [
    { src: $r('app.media.frame1') },
    { src: $r('app.media.frame2') }
  ],
  state: AnimationState.Running,
  fixedSize: true
})
  .width(200)
  .height(200)
```

### Q4: 如何实现帧动画的暂停和恢复？

**解决方案**:
```typescript
@ComponentV2
struct PauseResumeAnimator {
  @Local state: AnimationState = AnimationState.Running

  build() {
    Column() {
      ImageAnimator({
        images: [
          { src: $r('app.media.frame1') },
          { src: $r('app.media.frame2') }
        ],
        state: this.state
      })

      Button('暂停/继续')
        .onClick(() => {
          if (this.state === AnimationState.Running) {
            this.state = AnimationState.Paused
          } else if (this.state === AnimationState.Paused) {
            this.state = AnimationState.Running
          }
        })
    }
  }
}
```

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 9+ | ✅ | 基础功能 |
| API 10+ | ✅ | 增加了更多事件回调 |
| API 11+ | ✅ | 增加了 fixedSize 属性 |
| API 12+ | ✅ | 性能优化 |

## 八、参考资料

- [ImageAnimator 图片动画 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-image-animator-V5)
- [动画概述 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/animation-overview-V5)
