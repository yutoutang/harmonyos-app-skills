/**
 * Graphics Component Examples
 * OpenHarmony Graphics Components 使用示例
 *
 * 展示 QRCode、Hyperlink、Particle 三种图形组件的各种用法
 */

/**
 * QRCode 基础示例
 * 展示基本的二维码生成
 */
@ComponentV2
export struct QRCodeBasicExample {
  build() {
    Column({ space: 16 }) {
      Text('QRCode Basic')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      Column({ space: 20 }) {
        // 默认二维码
        Column({ space: 8 }) {
          QRCode('https://www.example.com')
            .width(150)
            .height(150)
          Text('Default')
            .fontSize(12)
            .fontColor('#666666')
        }

        // 自定义颜色
        Column({ space: 8 }) {
          QRCode('Custom Color')
            .width(150)
            .height(150)
            .color('#007DFF')
            .backgroundColor('#F0F8FF')
          Text('Blue Theme')
            .fontSize(12)
            .fontColor('#666666')
        }
      }
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * QRCode 生成器示例
 * 展示动态生成二维码
 */
@ComponentV2
export struct QRCodeGeneratorExample {
  @Local qrContent: string = 'Hello HarmonyOS'

  build() {
    Column({ space: 16 }) {
      Text('QRCode Generator')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      TextInput({ placeholder: 'Enter content', text: this.qrContent })
        .onChange((value: string) => {
          this.qrContent = value
        })

      if (this.qrContent) {
        QRCode(this.qrContent)
          .width(200)
          .height(200)
          .color('#28A745')
          .backgroundColor('#F0FFF0')

        Text('Scan the QR code')
          .fontSize(14)
          .fontColor('#666666')
      } else {
        Column() {
          Text('Enter content to generate')
            .fontSize(14)
            .fontColor('#999999')
        }
        .width(200)
        .height(200)
        .backgroundColor('#F5F5F5')
        .justifyContent(FlexAlign.Center)
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
 * Hyperlink 基础示例
 * 展示基本的超链接用法
 */
@ComponentV2
export struct HyperlinkBasicExample {
  build() {
    Column({ space: 16 }) {
      Text('Hyperlink Basic')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      Column({ space: 12 }) {
        // 基础超链接
        Hyperlink('https://www.example.com')
          .onClick(() => {
            console.info('Website link clicked')
          })

        // 帮助链接
        Hyperlink('https://www.example.com/help')
          .onClick(() => {
            console.info('Help link clicked')
          })

        // 关于链接
        Hyperlink('https://www.example.com/about')
          .onClick(() => {
            console.info('About link clicked')
          })

        // 联系链接
        Hyperlink('https://www.example.com/contact')
          .onClick(() => {
            console.info('Contact link clicked')
          })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * Hyperlink 文本示例
 * 展示超链接的不同样式
 */
@ComponentV2
export struct HyperlinkTextExample {
  build() {
    Column({ space: 16 }) {
      Text('Hyperlink Styles')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      Column({ space: 16 }) {
        // 第一个链接
        Hyperlink('https://www.example.com')
          .onClick(() => {
            console.info('Website link clicked')
          })

        // 第二个链接
        Hyperlink('https://www.example.com/privacy')
          .onClick(() => {
            console.info('Privacy link clicked')
          })

        // 第三个链接
        Hyperlink('https://www.example.com/terms')
          .onClick(() => {
            console.info('Terms link clicked')
          })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * Particle 火焰效果示例
 * 展示火焰粒子效果
 */
@ComponentV2
export struct ParticleFireExample {
  @Local particleSize: number = 5
  @Local isActive: boolean = true

  build() {
    Column({ space: 16 }) {
      Text('Particle 火焰效果示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      Stack() {
        // 背景渐变
        Column()
          .width('100%')
          .height(280)
          .linearGradient({
            angle: 180,
            colors: [['#1A000000', 0.0], ['#33000000', 1.0]]
          })
          .borderRadius(8)

        // 火焰容器
        Column() {
          Text('🔥')
            .fontSize(48)
            .margin({ top: 80 })

          if (this.isActive) {
            Column({ space: 4 }) {
              ForEach([1, 2, 3, 4, 5], (item: number) => {
                Row({ space: 8 }) {
                  ForEach([1, 2, 3], (subItem: number) => {
                    Column()
                      .width(this.particleSize)
                      .height(this.particleSize)
                      .backgroundColor('#FF6B35')
                      .borderRadius(this.particleSize / 2)
                      .opacity(Math.random() * 0.5 + 0.5)
                      .animation({
                        duration: 800,
                        curve: Curve.EaseInOut,
                        iterations: -1,
                        playMode: PlayMode.Alternate
                  })
                  })
                }
                .margin({ top: item * 2 })
              })
            }
            .margin({ top: 20 })
          }
        }
        .width('100%')
        .height('100%')

        Text('火焰粒子')
          .fontSize(16)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Bold)
          .margin({ top: 220 })
      }
      .width('100%')
      .height(280)

      Row({ space: 12 }) {
        Button(this.isActive ? '暂停' : '播放')
          .width('48%')
          .backgroundColor('#FF6B35')
          .fontColor(Color.White)
          .onClick(() => {
            this.isActive = !this.isActive
          })

        Button('重置')
          .width('48%')
          .backgroundColor('#6C757D')
          .fontColor(Color.White)
          .onClick(() => {
            this.isActive = true
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
 * Particle 雪花效果示例
 * 展示雪花粒子效果
 */
@ComponentV2
export struct ParticleSnowExample {
  @Local isActive: boolean = true
  @Local snowflakes: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

  build() {
    Column({ space: 16 }) {
      Text('Particle 雪花效果示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      Stack() {
        // 背景渐变 - 冬日天空
        Column()
          .width('100%')
          .height(280)
          .linearGradient({
            angle: 180,
            colors: [['#1A87CEEB', 0.0], ['#3387CEEB', 1.0]]
          })
          .borderRadius(8)

        // 雪花容器
        if (this.isActive) {
          Column() {
            ForEach(this.snowflakes, (item: number, index: number) => {
              Text('❄')
                .fontSize(12 + Math.random() * 8)
                .fontColor('#FFFFFF')
                .opacity(0.6 + Math.random() * 0.4)
                .position({
                  x: Math.random() * 280,
                  y: Math.random() * 280
                })
                .animation({
                  duration: 2000 + Math.random() * 2000,
                  curve: Curve.Linear,
                  iterations: -1
                })
            })
          }
          .width('100%')
          .height('100%')
        }

        Text('❄️ 雪花粒子')
          .fontSize(16)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Bold)
          .margin({ top: 220 })
      }
      .width('100%')
      .height(280)

      Row({ space: 12 }) {
        Button(this.isActive ? '暂停' : '播放')
          .width('48%')
          .backgroundColor('#87CEEB')
          .fontColor(Color.White)
          .onClick(() => {
            this.isActive = !this.isActive
          })

        Button('重置')
          .width('48%')
          .backgroundColor('#6C757D')
          .fontColor(Color.White)
          .onClick(() => {
            this.isActive = true
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
 * Particle 星空效果示例
 * 展示星空粒子效果
 */
@ComponentV2
export struct ParticleStarExample {
  @Local isActive: boolean = true
  @Local stars: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]

  build() {
    Column({ space: 16 }) {
      Text('Particle 星空效果示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      Stack() {
        // 深空背景
        Column()
          .width('100%')
          .height(280)
          .backgroundColor('#000011')
          .borderRadius(8)

        // 星星容器
        if (this.isActive) {
          Column() {
            ForEach(this.stars, (item: number, index: number) => {
              Column()
                .width(2 + Math.random() * 3)
                .height(2 + Math.random() * 3)
                .backgroundColor('#FFFFFF')
                .borderRadius(1)
                .opacity(0.3 + Math.random() * 0.7)
                .position({
                  x: Math.random() * 320,
                  y: Math.random() * 280
                })
                .animation({
                  duration: 1000 + Math.random() * 2000,
                  curve: Curve.EaseInOut,
                  iterations: -1,
                  playMode: PlayMode.Alternate
                })
            })

            // 几颗明亮的星星
            ForEach([1, 2, 3], (item: number) => {
              Text('⭐')
                .fontSize(16)
                .position({
                  x: 50 + Math.random() * 200,
                  y: 50 + Math.random() * 150
                })
                .animation({
                  duration: 1500,
                  curve: Curve.EaseInOut,
                  iterations: -1,
                  playMode: PlayMode.Alternate
                })
            })
          }
          .width('100%')
          .height('100%')
        }

        Text('✨ 星空粒子')
          .fontSize(16)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Bold)
          .margin({ top: 220 })
      }
      .width('100%')
      .height(280)

      Row({ space: 12 }) {
        Button(this.isActive ? '暂停' : '播放')
          .width('48%')
          .backgroundColor('#1A1A2E')
          .fontColor(Color.White)
          .onClick(() => {
            this.isActive = !this.isActive
          })

        Button('重置')
          .width('48%')
          .backgroundColor('#6C757D')
          .fontColor(Color.White)
          .onClick(() => {
            this.isActive = true
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
 * Graphics 组件示例页面
 * 集成所有图形组件示例
 */
@ComponentV2
export struct GraphicsExamplePage {
  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          Text('Graphics Components')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .padding({ left: 16, right: 16, top: 16, bottom: 8 })

          // QRCode 示例
          Text('QRCode Component')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .width('100%')
            .padding({ left: 16, right: 16 })
          QRCodeBasicExample()
          QRCodeGeneratorExample()

          // Hyperlink 示例
          Text('Hyperlink Component')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .width('100%')
            .padding({ left: 16, right: 16 })
          HyperlinkBasicExample()
          HyperlinkTextExample()

          // Particle 示例
          Text('Particle Component')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .width('100%')
            .padding({ left: 16, right: 16 })
          ParticleFireExample()
          ParticleSnowExample()
          ParticleStarExample()
        }
        .width('100%')
        .padding({ bottom: 20 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')
    }
    .title('Graphics 图形组件')
    .mode(NavDestinationMode.STANDARD)
  }
}

@Builder
export function GraphicsExamplePageBuilder() {
  GraphicsExamplePage()
}
