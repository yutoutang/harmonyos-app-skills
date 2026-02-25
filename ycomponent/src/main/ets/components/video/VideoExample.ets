/**
 * Video Component Examples
 * OpenHarmony Video Component 使用示例
 *
 * 展示 Video 视频播放器组件的各种用法
 */

/**
 * 视频项接口
 */
interface VideoItem {
  name: string
  url: string
}

/**
 * 基础视频播放器示例
 * 展示视频播放的基础功能
 */
@ComponentV2
export struct BasicVideoExample {
  @Local currentTime: number = 0
  @Local duration: number = 0
  @Local isPlaying: boolean = false
  private controller: VideoController = new VideoController()

  build() {
    Column({ space: 12 }) {
      Text('Video Player 视频播放器')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      Video({
        src: 'https://media.w3.org/2010/05/sintel/trailer.mp4',
        controller: this.controller
      })
        .width('100%')
        .height(200)
        .autoPlay(false)
        .controls(true)
        .objectFit(ImageFit.Contain)
        .loop(false)
        .onStart(() => {
          this.isPlaying = true
          console.info('视频开始播放')
        })
        .onPause(() => {
          this.isPlaying = false
          console.info('视频暂停')
        })
        .onFinish(() => {
          this.isPlaying = false
          console.info('视频播放完成')
        })
        .onError(() => {
          this.isPlaying = false
          console.error('视频加载失败')
        })
        .onPrepared((info: PreparedInfo) => {
          this.duration = info.duration
          console.info(`视频准备完成，时长: ${info.duration}秒`)
        })
        .onSeeking((info: PlaybackInfo) => {
          console.info(`正在跳转到: ${info.time}秒`)
        })
        .onSeeked((info: PlaybackInfo) => {
          this.currentTime = info.time
          console.info(`已跳转到: ${info.time}秒`)
        })
        .onUpdate((info: PlaybackInfo) => {
          this.currentTime = info.time
        })
        .borderRadius(8)

      // 状态显示
      Text(`状态: ${this.isPlaying ? '播放中' : '已暂停'} | 时长: ${this.duration.toFixed(1)}s`)
        .fontSize(12)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 自定义控制条视频播放器
 * 展示如何自定义视频控制条
 */
@ComponentV2
export struct CustomControlVideoExample {
  @Local currentTime: number = 0
  @Local duration: number = 0
  @Local isPlaying: boolean = false
  @Local isMuted: boolean = false
  @Local playbackSpeed: number = 1.0
  private controller: VideoController = new VideoController()

  build() {
    Column({ space: 12 }) {
      Text('自定义控制条')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      Video({
        src: 'https://media.w3.org/2010/05/sintel/trailer.mp4',
        controller: this.controller
      })
        .width('100%')
        .height(200)
        .autoPlay(false)
        .controls(false)
        .objectFit(ImageFit.Contain)
        .onStart(() => {
          this.isPlaying = true
        })
        .onPause(() => {
          this.isPlaying = false
        })
        .onFinish(() => {
          this.isPlaying = false
        })
        .onPrepared((info: PreparedInfo) => {
          this.duration = info.duration
        })
        .onUpdate((info: PlaybackInfo) => {
          this.currentTime = info.time
        })
        .borderRadius(8)

      // 自定义控制条
      Column({ space: 8 }) {
        // 进度条
        Row({ space: 8 }) {
          Text(`${this.currentTime.toFixed(1)}s`)
            .fontSize(12)
            .width(50)

          Slider({
            value: this.currentTime,
            min: 0,
            max: this.duration || 1
          })
            .layoutWeight(1)
            .blockColor('#007DFF')
            .trackColor('#E0E0E0')
            .selectedColor('#007DFF')
            .onChange((value: number) => {
              this.controller.setCurrentTime(value)
            })

          Text(`${this.duration.toFixed(1)}s`)
            .fontSize(12)
            .width(50)
            .textAlign(TextAlign.End)
        }
        .width('100%')

        // 按钮组
        Row({ space: 12 }) {
          // 播放/暂停
          Button(this.isPlaying ? '⏸' : '▶')
            .width(50)
            .height(36)
            .fontSize(16)
            .backgroundColor('#007DFF')
            .fontColor(Color.White)
            .onClick(() => {
              if (this.isPlaying) {
                this.controller.pause()
              } else {
                this.controller.start()
              }
            })

          // 静音/取消静音
          Button(this.isMuted ? '🔇' : '🔊')
            .width(50)
            .height(36)
            .fontSize(16)
            .backgroundColor('#6C757D')
            .fontColor(Color.White)
            .onClick(() => {
              this.isMuted = !this.isMuted
              // Video 组件不直接支持静音API，此处仅为演示
              console.info(`静音: ${this.isMuted}`)
            })

          // 倍速
          Button(`${this.playbackSpeed}x`)
            .width(60)
            .height(36)
            .fontSize(12)
            .backgroundColor('#28A745')
            .fontColor(Color.White)
            .onClick(() => {
              const speeds = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0]
              const currentIndex = speeds.indexOf(this.playbackSpeed)
              const nextIndex = (currentIndex + 1) % speeds.length
              this.playbackSpeed = speeds[nextIndex]
              console.info(`播放速度: ${this.playbackSpeed}x`)
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 多视频源示例
 * 展示如何处理不同的视频源
 */
@ComponentV2
export struct MultipleVideoSourceExample {
  @Local selectedVideo: number = 0
  @Local currentTime: number = 0
  @Local duration: number = 0
  private controller: VideoController = new VideoController()

  videoList: VideoItem[] = [
    { name: '示例视频 1', url: 'https://media.w3.org/2010/05/sintel/trailer.mp4' },
    { name: '示例视频 2', url: 'https://media.w3.org/2010/05/bunny/trailer.mp4' }
  ]

  build() {
    Column({ space: 12 }) {
      Text('多视频源切换')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // 视频播放器
      Video({
        src: this.videoList[this.selectedVideo].url,
        controller: this.controller
      })
        .width('100%')
        .height(200)
        .autoPlay(false)
        .controls(true)
        .objectFit(ImageFit.Contain)
        .onPrepared((info: PreparedInfo) => {
          this.duration = info.duration
        })
        .onUpdate((info: PlaybackInfo) => {
          this.currentTime = info.time
        })
        .borderRadius(8)

      // 视频选择器
      Row({ space: 8 }) {
        ForEach(this.videoList, (video: VideoItem, index: number) => {
          Button(video.name)
            .height(36)
            .type(ButtonType.Normal)
            .backgroundColor(this.selectedVideo === index ? '#007DFF' : '#E0E0E0')
            .fontColor(this.selectedVideo === index ? Color.White : '#333333')
            .onClick(() => {
              if (this.selectedVideo !== index) {
                this.selectedVideo = index
                this.currentTime = 0
                this.duration = 0
                console.info(`切换到: ${video.name}`)
              }
            })
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)

      Text(`当前播放: ${this.videoList[this.selectedVideo].name}`)
        .fontSize(12)
        .fontColor('#666666')
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 视频列表播放示例
 * 展示如何创建播放列表
 */
@ComponentV2
export struct VideoPlaylistExample {
  @Local currentVideoIndex: number = 0
  @Local isPlaying: boolean = false
  private controller: VideoController = new VideoController()

  playlist: VideoItem[] = [
    { name: '视频 1', url: 'https://media.w3.org/2010/05/sintel/trailer.mp4' },
    { name: '视频 2', url: 'https://media.w3.org/2010/05/bunny/trailer.mp4' }
  ]

  build() {
    Column({ space: 12 }) {
      Text('视频播放列表')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // 当前视频
      Video({
        src: this.playlist[this.currentVideoIndex].url,
        controller: this.controller
      })
        .width('100%')
        .height(200)
        .autoPlay(false)
        .controls(true)
        .objectFit(ImageFit.Contain)
        .onFinish(() => {
          // 自动播放下一个
          this.playNext()
        })
        .borderRadius(8)

      // 播放列表
      Column({ space: 8 }) {
        Text('播放列表')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .width('100%')

        ForEach(this.playlist, (video: VideoItem, index: number) => {
          Row({ space: 12 }) {
            // 播放图标
            Text(this.currentVideoIndex === index ? '▶' : '')
              .fontSize(16)
              .fontColor('#007DFF')
              .width(20)

            // 视频名称
            Text(video.name)
              .fontSize(14)
              .fontColor('#333333')
              .layoutWeight(1)
              .fontWeight(this.currentVideoIndex === index ? FontWeight.Medium : FontWeight.Normal)

            // 当前播放指示器
            if (this.currentVideoIndex === index) {
              Text('播放中')
                .fontSize(12)
                .fontColor('#28A745')
            }
          }
          .width('100%')
          .padding(12)
          .backgroundColor(this.currentVideoIndex === index ? '#E3F2FD' : '#FFFFFF')
          .borderRadius(8)
          .onClick(() => {
            if (this.currentVideoIndex !== index) {
              this.currentVideoIndex = index
              this.controller.start()
            }
          })
        }, (video: VideoItem, index: number) => `${index}_${video.name}`)
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      // 控制按钮
      Row({ space: 12 }) {
        Button('上一个')
          .height(36)
          .type(ButtonType.Capsule)
          .enabled(this.currentVideoIndex > 0)
          .onClick(() => {
            this.playPrevious()
          })

        Button('下一个')
          .height(36)
          .type(ButtonType.Capsule)
          .enabled(this.currentVideoIndex < this.playlist.length - 1)
          .onClick(() => {
            this.playNext()
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }

  playNext() {
    if (this.currentVideoIndex < this.playlist.length - 1) {
      this.currentVideoIndex++
      this.controller.start()
    }
  }

  playPrevious() {
    if (this.currentVideoIndex > 0) {
      this.currentVideoIndex--
      this.controller.start()
    }
  }
}

/**
 * 视频封面和自动播放示例
 */
@ComponentV2
export struct VideoWithPosterExample {
  @Local isPlaying: boolean = false
  @Local hasStarted: boolean = false
  private controller: VideoController = new VideoController()

  build() {
    Column({ space: 12 }) {
      Text('视频封面和自动播放')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      Stack() {
        Video({
          src: 'https://media.w3.org/2010/05/sintel/trailer.mp4',
          controller: this.controller
        })
          .width('100%')
          .height(200)
          .autoPlay(false)
          .controls(false)
          .objectFit(ImageFit.Cover)
          .onStart(() => {
            this.isPlaying = true
            this.hasStarted = true
          })
          .onPause(() => {
            this.isPlaying = false
          })
          .borderRadius(8)

        // 封面/播放按钮
        if (!this.hasStarted) {
          Column({ space: 12 }) {
            Button('▶')
              .width(60)
              .height(60)
              .type(ButtonType.Circle)
              .fontSize(24)
              .backgroundColor('rgba(0, 122, 255, 0.9)')
              .fontColor(Color.White)
              .onClick(() => {
                this.hasStarted = true
                this.controller.start()
              })

            Text('点击播放视频')
              .fontSize(14)
              .fontColor(Color.White)
              .fontWeight(FontWeight.Medium)
          }
          .justifyContent(FlexAlign.Center)
          .width('100%')
          .height('100%')
          .backgroundColor('rgba(0, 0, 0, 0.3)')
          .borderRadius(8)
        }
      }
      .width('100%')
      .height(200)

      // 控制按钮
      if (this.hasStarted) {
        Row({ space: 12 }) {
          Button(this.isPlaying ? '暂停' : '播放')
            .height(36)
            .type(ButtonType.Capsule)
            .onClick(() => {
              if (this.isPlaying) {
                this.controller.pause()
              } else {
                this.controller.start()
              }
            })

          Button('重置')
            .height(36)
            .type(ButtonType.Capsule)
            .onClick(() => {
              this.hasStarted = false
              this.isPlaying = false
              this.controller.setCurrentTime(0)
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 视频控制方法示例
 * 展示 VideoController 的各种控制方法
 */
@ComponentV2
export struct VideoControllerExample {
  @Local currentTime: number = 0
  @Local duration: number = 0
  @Local statusMessage: string = '准备就绪'
  private controller: VideoController = new VideoController()

  build() {
    Column({ space: 12 }) {
      Text('VideoController 控制方法')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      Video({
        src: 'https://media.w3.org/2010/05/sintel/trailer.mp4',
        controller: this.controller
      })
        .width('100%')
        .height(180)
        .autoPlay(false)
        .controls(true)
        .onPrepared((info: PreparedInfo) => {
          this.duration = info.duration
          this.statusMessage = `视频已加载，时长: ${info.duration.toFixed(1)}s`
        })
        .onUpdate((info: PlaybackInfo) => {
          this.currentTime = info.time
        })
        .borderRadius(8)

      // 状态信息
      Text(this.statusMessage)
        .fontSize(12)
        .fontColor('#666666')
        .margin({ top: 4 })

      // 控制按钮组
      Column({ space: 8 }) {
        Text('控制方法')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)

        Row({ space: 8 }) {
          Button('开始')
            .height(36)
            .layoutWeight(1)
            .onClick(() => {
              this.controller.start()
              this.statusMessage = '开始播放'
            })

          Button('暂停')
            .height(36)
            .layoutWeight(1)
            .onClick(() => {
              this.controller.pause()
              this.statusMessage = '已暂停'
            })

          Button('停止')
            .height(36)
            .layoutWeight(1)
            .onClick(() => {
              this.controller.pause()
              this.controller.setCurrentTime(0)
              this.statusMessage = '已停止'
            })
        }
        .width('100%')

        Row({ space: 8 }) {
          Button('跳转至 5s')
            .height(36)
            .layoutWeight(1)
            .onClick(() => {
              this.controller.setCurrentTime(5)
              this.statusMessage = '跳转至 5 秒'
            })

          Button('跳转至 15s')
            .height(36)
            .layoutWeight(1)
            .onClick(() => {
              this.controller.setCurrentTime(15)
              this.statusMessage = '跳转至 15 秒'
            })
        }
        .width('100%')

        Button('设置当前时间为 0')
          .height(36)
          .width('100%')
          .onClick(() => {
            this.controller.setCurrentTime(0)
            this.statusMessage = '重置到开始'
          })
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#FFFFFF')
      .borderRadius(8)

      Text(`当前时间: ${this.currentTime.toFixed(1)}s / ${this.duration.toFixed(1)}s`)
        .fontSize(12)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 完整的视频播放器示例页面
 * 集成所有视频播放器示例
 */
@ComponentV2
export struct VideoExamplePage {
  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          Text('Video Component Examples')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .padding({ left: 16, right: 16, top: 16, bottom: 8 })

          BasicVideoExample()
          CustomControlVideoExample()
          MultipleVideoSourceExample()
          VideoPlaylistExample()
          VideoWithPosterExample()
          VideoControllerExample()
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
    }
    .title('Video 视频播放器组件示例')
    .mode(NavDestinationMode.STANDARD)
  }
}

@Builder
export function VideoExamplePageBuilder() {
  VideoExamplePage()
}
