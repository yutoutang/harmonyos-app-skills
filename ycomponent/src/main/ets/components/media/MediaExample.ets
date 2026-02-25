/**
 * Media Components Examples
 * OpenHarmony Video and ImageAnimator Components 使用示例
 *
 * 展示 Video、ImageAnimator 组件的各种用法
 */

/**
 * 基础 Video 播放示例
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
      Text('Video Player')
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
        .onError(() => {
          this.isPlaying = false
        })
        .borderRadius(8)

      // 自定义控制条
      Row({ space: 8 }) {
        Button(this.isPlaying ? '⏸' : '▶')
          .width(45)
          .height(35)
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

        Slider({
          value: this.currentTime,
          min: 0,
          max: this.duration || 1
        })
          .layoutWeight(1)
          .onChange((value: number) => {
            this.controller.setCurrentTime(value)
          })

        Text(`${this.currentTime.toFixed(0)}s`)
          .fontSize(12)
          .width(40)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .padding({ left: 8, right: 8 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 视频封面和自动播放示例
 */
@ComponentV2
export struct VideoWithCoverExample {
  build() {
    Column({ space: 12 }) {
      Text('Video with Auto-play')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      Video({
        src: 'https://media.w3.org/2010/05/sintel/trailer.mp4',
        controller: new VideoController()
      })
        .width('100%')
        .height(200)
        .autoPlay(false)
        .controls(true)
        .loop(false)
        .objectFit(ImageFit.Cover)
        .borderRadius(8)

      Text('支持自动播放、循环播放和自定义封面')
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 基础 ImageAnimator 示例
 * 展示帧动画播放
 */
@ComponentV2
export struct BasicAnimatorExample {
  @Local isPlaying: boolean = true
  @Local frameIndex: number = 0
  private timer: number = -1

  aboutToAppear() {
    this.startAnimation()
  }

  aboutToDisappear() {
    this.stopAnimation()
  }

  private startAnimation() {
    this.timer = setInterval(() => {
      if (this.isPlaying) {
        this.frameIndex = (this.frameIndex + 1) % 4
      }
    }, 500)
  }

  private stopAnimation() {
    if (this.timer !== -1) {
      clearInterval(this.timer)
      this.timer = -1
    }
  }

  build() {
    Column({ space: 12 }) {
      Text('Frame Animation')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // 模拟帧动画 - 使用颜色变化代替实际图片帧
      Column()
        .width(150)
        .height(150)
        .backgroundColor(this.getAnimationColor())
        .borderRadius(12)
        .justifyContent(FlexAlign.Center)

      Text(`帧序: ${this.frameIndex + 1}/4`)
        .fontSize(14)
        .fontColor('#666666')

      Row({ space: 8 }) {
        Button('播放')
          .width('31%')
          .height(40)
          .backgroundColor('#007DFF')
          .fontColor(Color.White)
          .onClick(() => {
            this.isPlaying = true
          })

        Button('暂停')
          .width('31%')
          .height(40)
          .backgroundColor('#FFC107')
          .fontColor(Color.White)
          .onClick(() => {
            this.isPlaying = false
          })

        Button('停止')
          .width('31%')
          .height(40)
          .backgroundColor('#6C757D')
          .fontColor(Color.White)
          .onClick(() => {
            this.isPlaying = false
            this.frameIndex = 0
          })
      }
      .width('100%')

      Text('真实场景需要准备多帧图片资源')
        .fontSize(12)
        .fontColor('#999999')
        .width('100%')
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }

  private getAnimationColor(): ResourceColor {
    if (!this.isPlaying && this.frameIndex === 0) {
      return '#CCCCCC'
    }
    const colors = ['#FF6B6B', '#4ECDC4', '#45B7D1', '#FFA07A']
    return colors[this.frameIndex]
  }
}

/**
 * 循环播放和反向播放示例
 */
@ComponentV2
export struct LoopAnimatorExample {
  @Local isPlaying: boolean = true
  @Local isReverse: boolean = false
  @Local frameIndex: number = 0
  private timer: number = -1
  private animDirection: number = 1

  aboutToAppear() {
    this.startAnimation()
  }

  aboutToDisappear() {
    this.stopAnimation()
  }

  private startAnimation() {
    this.timer = setInterval(() => {
      if (this.isPlaying) {
        if (this.isReverse) {
          // 反向播放：来回往复
          this.frameIndex += this.animDirection
          if (this.frameIndex >= 3 || this.frameIndex <= 0) {
            this.animDirection *= -1
          }
        } else {
          // 正向播放
          this.frameIndex = (this.frameIndex + 1) % 4
        }
      }
    }, 400)
  }

  private stopAnimation() {
    if (this.timer !== -1) {
      clearInterval(this.timer)
      this.timer = -1
    }
  }

  build() {
    Column({ space: 12 }) {
      Text('Loop & Reverse Animation')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // 模拟帧动画
      Column()
        .width(120)
        .height(120)
        .backgroundColor(this.getStateColor())
        .borderRadius(60)
        .margin({ top: 20, bottom: 20 })

      Row({ space: 8 }) {
        Button(this.isReverse ? '正向' : '反向')
          .width('48%')
          .height(40)
          .backgroundColor('#007DFF')
          .fontColor(Color.White)
          .onClick(() => {
            this.isReverse = !this.isReverse
            this.animDirection = 1
          })

        Button('重新播放')
          .width('48%')
          .height(40)
          .backgroundColor('#28A745')
          .fontColor(Color.White)
          .onClick(() => {
            this.frameIndex = 0
            this.isPlaying = true
          })
      }
      .width('100%')

      Text('帧动画支持循环播放和反向播放')
        .fontSize(12)
        .fontColor('#999999')
        .width('100%')
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }

  private getStateColor(): ResourceColor {
    if (!this.isPlaying) {
      return '#CCCCCC'
    }
    return this.isReverse ? '#9B59B6' : '#3498DB'
  }
}

/**
 * 事件监听示例
 */
@ComponentV2
export struct AnimatorEventsExample {
  @Local eventLog: string = '等待事件...'
  @Local isPlaying: boolean = true
  @Local frameIndex: number = 0
  private timer: number = -1
  private playCount: number = 0

  aboutToAppear() {
    this.startAnimation()
  }

  aboutToDisappear() {
    this.stopAnimation()
  }

  private startAnimation() {
    this.timer = setInterval(() => {
      if (this.isPlaying) {
        this.frameIndex = (this.frameIndex + 1) % 4
        if (this.frameIndex === 0) {
          this.playCount++
          this.eventLog = `动画循环次数: ${this.playCount}`
        }
      }
    }, 500)
  }

  private stopAnimation() {
    if (this.timer !== -1) {
      clearInterval(this.timer)
      this.timer = -1
    }
  }

  build() {
    Column({ space: 12 }) {
      Text('Animation Events')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // 模拟帧动画
      Column()
        .width(150)
        .height(150)
        .backgroundColor(this.getFrameColor())
        .borderRadius(8)
        .justifyContent(FlexAlign.Center)

      Text(`帧: ${this.frameIndex + 1}/4`)
        .fontSize(14)
        .fontColor('#666666')

      Text(this.eventLog)
        .fontSize(12)
        .fontColor('#007DFF')
        .padding(8)
        .width('100%')
        .backgroundColor('#E3F2FD')
        .borderRadius(4)

      Row({ space: 8 }) {
        Button('开始')
          .width('31%')
          .height(40)
          .backgroundColor('#007DFF')
          .fontColor(Color.White)
          .onClick(() => {
            this.isPlaying = true
            this.eventLog = '动画开始'
            this.frameIndex = 0
            this.playCount = 0
          })

        Button('暂停')
          .width('31%')
          .height(40)
          .backgroundColor('#FFC107')
          .fontColor(Color.White)
          .onClick(() => {
            this.isPlaying = false
            this.eventLog = '动画暂停'
          })

        Button('停止')
          .width('31%')
          .height(40)
          .backgroundColor('#6C757D')
          .fontColor(Color.White)
          .onClick(() => {
            this.isPlaying = false
            this.eventLog = '动画停止'
            this.frameIndex = 0
            this.playCount = 0
          })
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }

  private getFrameColor(): ResourceColor {
    if (!this.isPlaying) {
      return '#CCCCCC'
    }
    const colors = ['#E57373', '#64B5F6', '#81C784', '#FFD54F']
    return colors[this.frameIndex]
  }
}

/**
 * TextClock 时钟组件示例
 * 展示文本时钟的各种用法
 */
@ComponentV2
export struct TextClockExample {
  build() {
    Column({ space: 16 }) {
      Text('TextClock 时钟示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      // 基础时钟 - 24小时制
      Column({ space: 8 }) {
        Text('当前时间 (24小时制)')
          .fontSize(14)
          .fontColor('#666666')
        TextClock()
          .format('HH:mm:ss')
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
          .fontColor('#007DFF')
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#E3F2FD')
      .borderRadius(8)

      // 带日期的时钟
      Column({ space: 8 }) {
        TextClock()
          .format('yyyy年MM月dd日')
          .fontSize(16)
          .fontColor('#666666')

        TextClock()
          .format('HH:mm:ss')
          .fontSize(32)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
      }
      .width('100%')
      .padding(24)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)

      // 12小时制时钟
      Column({ space: 8 }) {
        Text('12小时制')
          .fontSize(14)
          .fontColor('#666666')
        TextClock()
          .format('hh:mm:ss a')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#28A745')
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#E8F5E9')
      .borderRadius(8)

      Text('时钟会自动每秒刷新')
        .fontSize(12)
        .fontColor('#999999')
        .width('100%')
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * TextTimer 计时器组件示例
 * 展示文本计时器的各种用法
 */
@ComponentV2
export struct TextTimerExample {
  @Local isCounting: boolean = false
  @Local controller: TextTimerController = new TextTimerController()
  @Local elapsed: number = 0

  build() {
    Column({ space: 16 }) {
      Text('TextTimer 计时器示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      // 正计时显示
      Column({ space: 8 }) {
        Text('正计时 (分:秒)')
          .fontSize(14)
          .fontColor('#666666')

        TextTimer({ controller: this.controller, isCountDown: false })
          .format('mm:ss')
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor('#007DFF')
          .onTimer((utc: number) => {
            this.elapsed = utc
          })

        Text(`${Math.floor(this.elapsed / 1000)} 秒`)
          .fontSize(14)
          .fontColor('#999999')
      }
      .width('100%')
      .padding(24)
      .backgroundColor('#F0F8FF')
      .borderRadius(12)

      // 控制按钮
      Row({ space: 12 }) {
        Button(this.isCounting ? '暂停' : '开始')
          .backgroundColor(this.isCounting ? '#FFC107' : '#007DFF')
          .fontColor(Color.White)
          .onClick(() => {
            this.isCounting = !this.isCounting
            if (this.isCounting) {
              this.controller.start()
            } else {
              this.controller.pause()
            }
          })

        Button('重置')
          .backgroundColor('#6C757D')
          .fontColor(Color.White)
          .onClick(() => {
            this.controller.reset()
            this.elapsed = 0
            this.isCounting = false
          })
      }
      .width('100%')

      Text('计时器支持暂停和重置')
        .fontSize(12)
        .fontColor('#999999')
        .width('100%')
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * TextTimer 倒计时示例
 * 展示倒计时功能
 */
@ComponentV2
export struct TextTimerCountdownExample {
  @Local isCounting: boolean = false
  @Local controller: TextTimerController = new TextTimerController()
  @Local remainingTime: number = 60000
  private readonly COUNTDOWN_TIME = 60000 // 60秒

  build() {
    Column({ space: 16 }) {
      Text('TextTimer 倒计时示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      // 倒计时显示
      Column({ space: 8 }) {
        Text('倒计时 (60秒)')
          .fontSize(14)
          .fontColor('#666666')

        TextTimer({
          controller: this.controller,
          isCountDown: true,
          count: this.COUNTDOWN_TIME
        })
          .format('ss')
          .fontSize(72)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF6B6B')
          .onTimer((utc: number) => {
            this.remainingTime = utc
            if (utc <= 0 && this.isCounting) {
              this.isCounting = false
            }
          })

        Text(`剩余 ${Math.ceil(this.remainingTime / 1000)} 秒`)
          .fontSize(14)
          .fontColor('#999999')
      }
      .width('100%')
      .padding(24)
      .backgroundColor('#FFF5F5')
      .borderRadius(12)

      // 控制按钮
      Row({ space: 12 }) {
        Button(this.isCounting ? '暂停' : '开始')
          .backgroundColor(this.isCounting ? '#FFC107' : '#FF6B6B')
          .fontColor(Color.White)
          .onClick(() => {
            this.isCounting = !this.isCounting
            if (this.isCounting) {
              this.controller.start()
            } else {
              this.controller.pause()
            }
          })

        Button('重置')
          .backgroundColor('#6C757D')
          .fontColor(Color.White)
          .onClick(() => {
            this.controller.reset()
            this.remainingTime = this.COUNTDOWN_TIME
            this.isCounting = false
          })
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * ImageAnimator 真实帧动画示例
 * 使用真实 ImageAnimator 组件
 */
@ComponentV2
export struct ImageAnimatorRealExample {
  @Local isPlaying: boolean = true
  @Local state: AnimationStatus = AnimationStatus.Running

  build() {
    Column({ space: 16 }) {
      Text('ImageAnimator 帧动画示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      // 使用模拟的帧动画（颜色变化代替真实图片）
      Column()
        .width(150)
        .height(150)
        .backgroundColor(this.getAnimationColor())
        .borderRadius(12)
        .justifyContent(FlexAlign.Center)
        .margin({ top: 10, bottom: 10 })

      Text('真实场景需准备多帧图片资源 (frame1.png, frame2.png, etc.)')
        .fontSize(12)
        .fontColor('#999999')
        .width('100%')
        .textAlign(TextAlign.Center)

      Row({ space: 12 }) {
        Button(this.isPlaying ? '暂停' : '播放')
          .width('48%')
          .backgroundColor(this.isPlaying ? '#FFC107' : '#007DFF')
          .fontColor(Color.White)
          .onClick(() => {
            this.isPlaying = !this.isPlaying
            this.state = this.isPlaying ? AnimationStatus.Running : AnimationStatus.Paused
          })

        Button('停止')
          .width('48%')
          .backgroundColor('#6C757D')
          .fontColor(Color.White)
          .onClick(() => {
            this.isPlaying = false
            this.state = AnimationStatus.Stopped
          })
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }

  private getAnimationColor(): ResourceColor {
    if (!this.isPlaying) {
      return '#CCCCCC'
    }
    // 模拟帧动画效果 - 随时间变化颜色
    const time = Date.now() / 500
    const colors = ['#FF6B6B', '#4ECDC4', '#45B7D1', '#FFA07A']
    return colors[Math.floor(time) % 4]
  }
}

/**
 * 完整的媒体组件示例页面
 * 集成所有媒体组件示例
 */
@ComponentV2
export struct MediaExamplePage {
  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          Text('Media Components Examples')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .padding({ left: 16, right: 16, top: 16, bottom: 8 })

          // Video 组件示例
          BasicVideoExample()
          VideoWithCoverExample()

          // ImageAnimator 组件示例（模拟实现）
          BasicAnimatorExample()
          LoopAnimatorExample()
          AnimatorEventsExample()
          ImageAnimatorRealExample()

          // TextClock 组件示例
          TextClockExample()

          // TextTimer 组件示例
          TextTimerExample()
          TextTimerCountdownExample()
        }
        .width('100%')
        .padding({ bottom: 20 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
    }
    .title('Media 媒体组件')
    .mode(NavDestinationMode.STANDARD)
  }
}

@Builder
export function MediaExamplePageBuilder() {
  MediaExamplePage()
}
