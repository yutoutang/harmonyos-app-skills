/**
 * Span Component Examples (SDK 6 compatible)
 */

@ComponentV2
export struct BasicSpanExample {
  @Local active: boolean = false

  build() {
    Column({ space: 12 }) {
      Text('基础 Span 示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Text() {
        Span('红色').fontColor('#E53935')
        Span(' / ')
        Span('绿色').fontColor('#43A047')
        Span(' / ')
        Span('蓝色').fontColor('#1E88E5')
      }
      .fontSize(16)

      Text() {
        Span('普通')
        Span(' 粗体').fontWeight(FontWeight.Bold)
        Span(' 下划线').decoration({ type: TextDecorationType.Underline, color: '#1E88E5' })
      }
      .fontSize(16)

      Text() {
        Span('点击状态: ')
        Span(this.active ? '已激活' : '未激活')
          .fontColor(this.active ? '#2E7D32' : '#757575')
          .fontWeight(FontWeight.Medium)
      }
      .fontSize(16)

      Button(this.active ? '取消激活' : '激活')
        .onClick(() => {
          this.active = !this.active
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

@ComponentV2
export struct PriceSpanExample {
  build() {
    Column({ space: 12 }) {
      Text('价格展示示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Row() {
        Text() {
          Span('¥').fontSize(14).fontColor('#E53935')
          Span('99').fontSize(30).fontColor('#E53935').fontWeight(FontWeight.Bold)
          Span('.00').fontSize(14).fontColor('#E53935')
        }

        Blank()

        Text('¥129.00')
          .fontSize(14)
          .fontColor('#9E9E9E')
          .decoration({ type: TextDecorationType.LineThrough, color: '#9E9E9E' })
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

@ComponentV2
export struct SpanExamplePage {
  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 16 }) {
          Text('Span Component Examples')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width('100%')

          BasicSpanExample()
          PriceSpanExample()
        }
        .width('100%')
        .padding(16)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')
    }
    .title('Span 文本片段示例')
    .mode(NavDestinationMode.STANDARD)
  }
}

@Builder
export function SpanExamplePageBuilder() {
  SpanExamplePage()
}
