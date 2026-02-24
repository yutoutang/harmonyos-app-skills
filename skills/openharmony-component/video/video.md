# Video 组件 HarmonyOS 6.0 开发 Skill

## 概述

Video 组件是 OpenHarmony 中用于视频播放的组件，支持本地视频和网络视频播放。它提供了完整的视频播放功能，包括播放控制、进度条、全屏播放、倍速播放等。

## 重要说明

- **基础组件**: Video 是 ArkUI 的基础内置组件，无需导入
- **支持格式**: MP4、MKV、MPEG 等多种视频格式
- **数据源**: 支持本地资源、网络 URL
- **控制**: 支持自定义控制条或使用默认控制条
- **全屏**: 支持应用内全屏和系统级全屏

## 模块信息

- **组件名称**: Video
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [Video 视频 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-video-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// Video 是内置组件，无需导入
// 直接使用即可
Video({ src: 'https://example.com/video.mp4' })
```

### 1.2 基础用法

```typescript
// 本地视频
Video({ src: $rawfile('video.mp4') })

// 网络视频
Video({ src: 'https://example.com/video.mp4' })

// 自动播放
Video({
  src: 'https://example.com/video.mp4',
  autoPlay: true
})
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| src | `string \| Resource` | 是 | - | 视频数据源 |
| controller | `VideoController` | 否 | - | 视频控制器 |
| autoPlay | `boolean` | 否 | false | 是否自动播放 |
| controls | `boolean` | 否 | true | 是否显示默认控制条 |
| loop | `boolean` | 否 | false | 是否循环播放 |
| muted | `boolean` | 否 | false | 是否静音 |
| objectFit | `ImageFit` | 否 | ImageFit.Cover | 视频填充模式 |
| previewUri | `string \| Resource` | 否 | - | 视频封面图 |

### 2.2 VideoController 方法

| 方法 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `start()` | - | `void` | 开始播放 |
| `pause()` | - | `void` | 暂停播放 |
| `stop()` | - | `void` | 停止播放 |
| `setCurrentTime(value)` | `number` | `void` | 设置播放位置 |
| `setCurrentTime(value, mode)` | `number, SeekMode` | `void` | 设置播放位置（指定跳转模式） |
| `getCurrentTime()` | - | `Promise<number>` | 获取当前播放位置 |
| `getDuration()` | - | `Promise<number>` | 获取视频总时长 |

### 2.3 视频事件

| 事件 | 参数类型 | 描述 |
|------|----------|------|
| `onStart` | `() => void` | 视频播放时触发 |
| `onPause` | `() => void` | 视频暂停时触发 |
| `onFinish` | `() => void` | 视频播放完成时触发 |
| `onError` | `(error?: VideoError) => void` | 视频播放出错时触发 |
| `onPrepared` | `(duration: number) => void` | 视频准备完成时触发 |
| `onSeeking` | `(time: number) => void` | 视频跳转时触发 |
| `onSeeked` | `(time: number) => void` | 视频跳转完成时触发 |
| `onUpdate` | `(time: number) => void` | 视频播放进度更新时触发 |

## 三、使用示例

### 3.1 基础视频播放

```typescript
@Entry
@ComponentV2
struct VideoExample {
  build() {
    Video({
      src: 'https://example.com/video.mp4',
      controller: new VideoController()
    })
      .width('100%')
      .height(200)
      .autoPlay(false)
      .controls(true)
      .loop(false)
  }
}
```

### 3.2 自定义控制视频播放器

```typescript
@ComponentV2
struct CustomVideoPlayer {
  @Local currentTime: number = 0
  @Local duration: number = 0
  @Local isPlaying: boolean = false
  private controller: VideoController = new VideoController()

  build() {
    Column() {
      Video({
        src: 'https://example.com/video.mp4',
        controller: this.controller
      })
        .width('100%')
        .height(200)
        .autoPlay(false)
        .controls(false)  // 隐藏默认控制条
        .onPrepared((duration: number) => {
          this.duration = duration
        })
        .onUpdate((time: number) => {
          this.currentTime = time
        })
        .onStart(() => {
          this.isPlaying = true
        })
        .onPause(() => {
          this.isPlaying = false
        })

      // 自定义控制条
      Row({ space: 10 }) {
        Button(this.isPlaying ? '暂停' : '播放')
          .onClick(() => {
            if (this.isPlaying) {
              this.controller.pause()
            } else {
              this.controller.start()
            }
          })

        Slider({
          value: this.currentTime,
          min: 0,
          max: this.duration || 1
        })
          .width('60%')
          .onChange((value: number) => {
            this.controller.setCurrentTime(value)
          })

        Text(`${this.currentTime.toFixed(0)}s / ${this.duration.toFixed(0)}s`)
          .fontSize(12)
      }
      .width('100%')
      .padding(10)
    }
  }
}
```

### 3.3 视频封面和自动播放

```typescript
@ComponentV2
struct VideoWithCover {
  build() {
    Video({
      src: 'https://example.com/video.mp4',
      previewUri: 'https://example.com/cover.jpg',  // 封面图
      autoPlay: true,  // 自动播放
      loop: true  // 循环播放
    })
      .width('100%')
      .height(200)
      .objectFit(ImageFit.Cover)
  }
}
```

### 3.4 视频播放事件监听

```typescript
@ComponentV2
struct VideoWithEvents {
  build() {
    Video({
      src: 'https://example.com/video.mp4',
      controller: new VideoController()
    })
      .width('100%')
      .height(200)
      .onStart(() => {
        console.info('视频开始播放')
      })
      .onPause(() => {
        console.info('视频暂停')
      })
      .onFinish(() => {
        console.info('视频播放完成')
      })
      .onError((error) => {
        console.error('视频播放错误:', error.errorCode)
      })
      .onPrepared((duration) => {
        console.info('视频准备完成, 时长:', duration)
      })
      .onSeeking((time) => {
        console.info('正在跳转到:', time)
      })
      .onSeeked((time) => {
        console.info('跳转完成:', time)
      })
  }
}
```

### 3.5 倍速播放

```typescript
@ComponentV2
struct VideoSpeedControl {
  @Local playbackSpeed: number = 1.0
  private controller: VideoController = new VideoController()

  build() {
    Column() {
      Video({
        src: 'https://example.com/video.mp4',
        controller: this.controller
      })
        .width('100%')
        .height(200)

      Row({ space: 10 }) {
        ForEach([0.5, 0.75, 1.0, 1.25, 1.5, 2.0], (speed: number) => {
          Button(`${speed}x`)
            .backgroundColor(this.playbackSpeed === speed ? '#007DFF' : '#CCCCCC')
            .onClick(() => {
              this.playbackSpeed = speed
              this.controller.setCurrentTime(this.playbackSpeed, PlaybackSpeed.Closest)
            })
        })
      }
      .padding(10)
    }
  }
}
```

## 四、高级用法

### 4.1 视频列表播放

```typescript
@ComponentV2
struct VideoListPlayer {
  @Local currentIndex: number = 0
  @Local isPlaying: boolean = false
  private controller: VideoController = new VideoController()
  private videoList: string[] = [
    'https://example.com/video1.mp4',
    'https://example.com/video2.mp4',
    'https://example.com/video3.mp4'
  ]

  build() {
    Column() {
      Video({
        src: this.videoList[this.currentIndex],
        controller: this.controller
      })
        .width('100%')
        .height(200)
        .autoPlay(true)
        .onFinish(() => {
          // 播放下一个视频
          if (this.currentIndex < this.videoList.length - 1) {
            this.currentIndex++
          }
        })

      Row({ space: 10 }) {
        Button('上一个')
          .onClick(() => {
            if (this.currentIndex > 0) {
              this.currentIndex--
            }
          })

        Button('下一个')
          .onClick(() => {
            if (this.currentIndex < this.videoList.length - 1) {
              this.currentIndex++
            }
          })
      }
      .padding(10)

      ForEach(this.videoList, (video: string, index: number) => {
        Text(`视频 ${index + 1}`)
          .padding(10)
          .backgroundColor(this.currentIndex === index ? '#007DFF' : '#F5F5F5')
          .fontColor(this.currentIndex === index ? Color.White : Color.Black)
          .onClick(() => {
            this.currentIndex = index
          })
      })
    }
  }
}
```

### 4.2 全屏播放

```typescript
@ComponentV2
struct FullScreenVideo {
  @Local isFullScreen: boolean = false
  private controller: VideoController = new VideoController()

  build() {
    Column() {
      Video({
        src: 'https://example.com/video.mp4',
        controller: this.controller
      })
        .width(this.isFullScreen ? '100%' : '90%')
        .height(this.isFullScreen ? '100%' : 200)
        .objectFit(ImageFit.Contain)

      Button(this.isFullScreen ? '退出全屏' : '全屏播放')
        .onClick(() => {
          this.isFullScreen = !this.isFullScreen
        })
    }
  }
}
```

## 五、最佳实践

### 5.1 视频加载优化

```typescript
// ✅ 推荐：设置封面图提升用户体验
Video({
  src: 'https://example.com/video.mp4',
  previewUri: 'https://example.com/cover.jpg'
})

// ❌ 避免：没有封面图导致视频加载时显示黑屏
Video({ src: 'https://example.com/video.mp4' })
```

### 5.2 视频尺寸控制

```typescript
// ✅ 推荐：设置明确尺寸并选择合适的填充模式
Video({ src: 'https://example.com/video.mp4' })
  .width('100%')
  .height(200)
  .objectFit(ImageFit.Cover)

// ❌ 避免：不设置尺寸可能导致布局问题
Video({ src: 'https://example.com/video.mp4' })
```

### 5.3 错误处理

```typescript
// ✅ 推荐：处理视频加载和播放错误
Video({ src: 'https://example.com/video.mp4' })
  .onError((error) => {
    console.error('视频播放错误:', error.errorCode)
    // 显示错误提示或备用视频
  })

// ❌ 避免：不处理错误
Video({ src: 'https://example.com/video.mp4' })
```

### 5.4 资源释放

```typescript
// ✅ 推荐：页面销毁时停止视频
@ComponentV2
struct VideoPage {
  private controller: VideoController = new VideoController()

  aboutToDisappear() {
    this.controller.stop()
  }

  build() {
    Video({
      src: 'https://example.com/video.mp4',
      controller: this.controller
    })
  }
}
```

## 六、常见问题

### Q1: 视频无法播放？

**解决方案**:
```typescript
// 1. 检查网络权限
// module.json5 中配置:
{
  "requestPermissions": [
    {
      "name": "ohos.permission.INTERNET"
    }
  ]
}

// 2. 使用 onError 查看错误信息
Video({ src: 'https://example.com/video.mp4' })
  .onError((error) => {
    console.error('播放失败:', error.errorCode)
  })
```

### Q2: 如何实现视频预加载？

**解决方案**:
```typescript
// 使用 preload 属性
Video({ src: 'https://example.com/video.mp4' })
  .preload()
```

### Q3: 如何获取视频截图？

**解决方案**:
```typescript
// Video 组件本身不支持截图
// 需要使用媒体处理能力
import { media } from '@kit.MediaKit'

// 使用 VideoDecoder 解码并获取帧
```

### Q4: 视频播放卡顿怎么办？

**解决方案**:
```typescript
// 1. 降低视频分辨率
// 2. 使用 objectFit.Contain 减少缩放
Video({ src: 'https://example.com/video.mp4' })
  .objectFit(ImageFit.Contain)

// 3. 检查网络状况
```

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 9+ | ✅ | 基础功能 |
| API 10+ | ✅ | 增加了更多控制选项 |
| API 11+ | ✅ | 增加了 playbackSpeed 支持 |
| API 12+ | ✅ | 优化了性能和内存占用 |

## 八、参考资料

- [Video 视频 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-video-V5)
- [视频播放 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/video-playback-V5)
