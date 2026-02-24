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
  build() {
    Column({ space: 16 }) {
      Text('Fire Effect')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      Stack() {
        Text('Fire')
          .fontSize(16)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Bold)
          .zIndex(1)

        // Note: Particle component requires complex configuration
        // This is a placeholder showing the component location
        Column()
          .width('100%')
          .height(250)
          .backgroundColor('#1A000000')
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
 * Particle 雪花效果示例
 * 展示雪花粒子效果
 */
@ComponentV2
export struct ParticleSnowExample {
  build() {
    Column({ space: 16 }) {
      Text('Snow Effect')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      Stack() {
        Text('Snow')
          .fontSize(16)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Bold)
          .zIndex(1)

        // Note: Particle component requires complex configuration
        // This is a placeholder showing the component location
        Column()
          .width('100%')
          .height(250)
          .backgroundColor('#1A87CEEB')
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
 * Particle 星空效果示例
 * 展示星空粒子效果
 */
@ComponentV2
export struct ParticleStarExample {
  build() {
    Column({ space: 16 }) {
      Text('Star Effect')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      Stack() {
        Text('Stars')
          .fontSize(16)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Bold)
          .zIndex(1)

        // Note: Particle component requires complex configuration
        // This is a placeholder showing the component location
        Column()
          .width('100%')
          .height(250)
          .backgroundColor('#000011')
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
 * Graphics 组件示例页面
 * 集成所有图形组件示例
 */
@ComponentV2
export struct GraphicsExamplePage {
  build() {
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
}
