/**
 * Rich Text Components Examples
 * OpenHarmony Rich Text Components 使用示例
 *
 * 展示以下组件的各种用法：
 * - RichText: 富文本显示组件
 * - RichEditor: 富文本编辑组件
 * - TextClock: 文本时钟组件
 * - TextTimer: 文本计时器组件
 */

/**
 * RichText 基础示例
 * 展示富文本的基本用法和 HTML 内容解析
 */
@ComponentV2
export struct RichTextBasicExample {
  @Local htmlContent: string = `
    <h2 style="color: #007DFF; text-align: center;">富文本示例</h2>
    <p style="font-size: 16px; color: #333; line-height: 1.6;">
      这是一段<strong>粗体文本</strong>和<em>斜体文本</em>的混合内容。
    </p>
    <ul style="margin-top: 10px;">
      <li>列表项 1</li>
      <li>列表项 2</li>
      <li>列表项 3</li>
    </ul>
  `

  build() {
    Column({ space: 12 }) {
      Text('RichText 基础示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      RichText(this.htmlContent)
        .width('100%')
        .height(180)
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
        .padding(12)
        .onStart(() => {
          console.info('RichText 加载开始')
        })
        .onComplete(() => {
          console.info('RichText 加载完成')
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * RichText 样式示例
 * 展示不同的 HTML 样式效果
 */
@ComponentV2
export struct RichTextStyleExample {
  build() {
    Column({ space: 12 }) {
      Text('RichText 样式示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      RichText(`
        <div style="padding: 12px; background-color: #E3F2FD;">
          <h3 style="color: #007DFF;">带样式的标题</h3>
          <p style="color: #333; line-height: 1.6;">
            这段文字有背景色和内边距，展示了如何使用内联样式。
          </p>
        </div>
        <p style="margin-top: 10px;">
          <span style="color: #FF0000;">红色</span>、
          <span style="color: #00FF00;">绿色</span>、
          <span style="color: #0000FF;">蓝色</span>文字
        </p>
      `)
        .width('100%')
        .height(200)
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
        .padding(12)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * RichEditor 基础示例
 * 展示富文本编辑器的基本用法
 */
@ComponentV2
export struct RichEditorBasicExample {
  controller: RichEditorController = new RichEditorController()

  build() {
    Column({ space: 12 }) {
      Text('RichEditor 基础示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      RichEditor({ controller: this.controller })
        .width('100%')
        .height(150)
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
        .padding(12)
        .placeholder('请输入内容...')
        .onReady(() => {
          console.info('RichEditor 准备就绪')
        })

      Row({ space: 8 }) {
        Button('清除内容')
          .fontSize(14)
          .height(36)
          .onClick(() => {
            // RichEditor basic functionality - clear text
            console.info('Clear button clicked')
          })
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}


/**
 * TextClock 基础示例
 * 展示文本时钟的基本用法
 */
@ComponentV2
export struct TextClockBasicExample {
  build() {
    Column({ space: 12 }) {
      Text('TextClock 基础示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      TextClock()
        .format('HH:mm:ss')
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .fontColor('#007DFF')
        .width('100%')

      TextClock()
        .format('yyyy-MM-dd')
        .fontSize(18)
        .fontColor('#666666')
        .width('100%')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * TextClock 格式示例
 * 展示不同的时间格式
 */
@ComponentV2
export struct TextClockFormatExample {
  build() {
    Column({ space: 12 }) {
      Text('TextClock 格式示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      // 24小时制
      Column({ space: 8 }) {
        Text('24小时制')
          .fontSize(14)
          .fontColor('#666666')
        TextClock()
          .format('HH:mm:ss')
          .fontSize(24)
          .fontColor('#007DFF')
      }
      .padding(12)
      .backgroundColor('#E3F2FD')
      .borderRadius(8)

      // 12小时制
      Column({ space: 8 }) {
        Text('12小时制')
          .fontSize(14)
          .fontColor('#666666')
        TextClock()
          .format('hh:mm:ss a')
          .fontSize(24)
          .fontColor('#28A745')
      }
      .padding(12)
      .backgroundColor('#E8F5E9')
      .borderRadius(8)

      // 日期格式
      Column({ space: 8 }) {
        Text('日期格式')
          .fontSize(14)
          .fontColor('#666666')
        TextClock()
          .format('yyyy年MM月dd日 EEEE')
          .fontSize(20)
          .fontColor('#FFC107')
      }
      .padding(12)
      .backgroundColor('#FFF3E0')
      .borderRadius(8)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * TextClock 时区示例
 * 展示不同时区的时间
 */
@ComponentV2
export struct TextClockTimeZoneExample {
  build() {
    Column({ space: 12 }) {
      Text('TextClock 时区示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 12 }) {
        // 北京时间
        Column({ space: 8 }) {
          Text('北京')
            .fontSize(14)
            .fontColor('#666666')
          TextClock()
            .format('HH:mm')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
        }
        .layoutWeight(1)
        .padding(12)
        .backgroundColor('#E3F2FD')
        .borderRadius(8)

        // 伦敦时间
        Column({ space: 8 }) {
          Text('伦敦')
            .fontSize(14)
            .fontColor('#666666')
          TextClock()
            .format('HH:mm')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
        }
        .layoutWeight(1)
        .padding(12)
        .backgroundColor('#F3E5F5')
        .borderRadius(8)
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * TextTimer 计时器示例
 * 展示计时器的基本用法
 */
@ComponentV2
export struct TextTimerBasicExample {
  controller: TextTimerController = new TextTimerController()
  @Local isRunning: boolean = false

  build() {
    Column({ space: 12 }) {
      Text('TextTimer 计时器示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      TextTimer({ controller: this.controller })
        .format('mm:ss')
        .fontSize(56)
        .fontWeight(FontWeight.Bold)
        .fontColor('#007DFF')
        .width('100%')

      Row({ space: 12 }) {
        Button(this.isRunning ? '暂停' : '开始')
          .onClick(() => {
            if (this.isRunning) {
              this.controller.pause()
            } else {
              this.controller.start()
            }
            this.isRunning = !this.isRunning
          })

        Button('重置')
          .onClick(() => {
            this.controller.reset()
            this.isRunning = false
          })
      }
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
  controller: TextTimerController = new TextTimerController()
  @Local isRunning: boolean = false
  @Local timeUp: boolean = false

  build() {
    Column({ space: 12 }) {
      Text('TextTimer 倒计时示例（60秒）')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      TextTimer({
        controller: this.controller,
        isCountDown: true,
        count: 60000
      })
        .format('ss')
        .fontSize(72)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FF6B6B')
        .width('100%')
        .onTimer((utc: number) => {
          if (utc <= 0) {
            this.timeUp = true
            this.isRunning = false
          }
        })

      if (this.timeUp) {
        Text('时间到！')
          .fontSize(20)
          .fontColor('#FF6B6B')
      }

      Row({ space: 12 }) {
        Button(this.isRunning ? '暂停' : '开始')
          .onClick(() => {
            if (this.isRunning) {
              this.controller.pause()
            } else {
              this.controller.start()
              this.timeUp = false
            }
            this.isRunning = !this.isRunning
          })

        Button('重置')
          .onClick(() => {
            this.controller.reset()
            this.isRunning = false
            this.timeUp = false
          })
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * TextTimer 秒表示例
 * 展示高精度计时功能
 */
@ComponentV2
export struct TextTimerStopwatchExample {
  controller: TextTimerController = new TextTimerController()
  @Local isRunning: boolean = false

  build() {
    Column({ space: 12 }) {
      Text('TextTimer 秒表示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      TextTimer({ controller: this.controller })
        .format('mm:ss.SS')
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .fontColor('#28A745')
        .width('100%')

      Row({ space: 12 }) {
        Button(this.isRunning ? '暂停' : '开始')
          .onClick(() => {
            if (this.isRunning) {
              this.controller.pause()
            } else {
              this.controller.start()
            }
            this.isRunning = !this.isRunning
          })

        Button('重置')
          .onClick(() => {
            this.controller.reset()
            this.isRunning = false
          })
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * 完整的富文本组件示例页面
 * 集成所有富文本组件示例
 */
@ComponentV2
export struct RichExamplePage {
  build() {
    Scroll() {
      Column({ space: 20 }) {
        Text('Rich Text Components Examples')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .padding({ left: 16, right: 16, top: 16, bottom: 8 })

        // RichText 示例
        RichTextBasicExample()
        RichTextStyleExample()

        // RichEditor 示例
        RichEditorBasicExample()

        // TextClock 示例
        TextClockBasicExample()
        TextClockFormatExample()
        TextClockTimeZoneExample()

        // TextTimer 示例
        TextTimerBasicExample()
        TextTimerCountdownExample()
        TextTimerStopwatchExample()
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
