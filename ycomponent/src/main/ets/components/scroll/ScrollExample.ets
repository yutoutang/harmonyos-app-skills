/**
 * Scroll Component Examples
 * OpenHarmony Scroll 滚动容器组件使用示例
 *
 * 展示 Scroll 滚动容器的各种用法
 */

/**
 * 垂直滚动示例
 */
@ComponentV2
export struct VerticalScrollExample {
  build() {
    Column({ space: 16 }) {
      Text('Scroll 垂直滚动')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Scroll() {
        Column({ space: 12 }) {
          ForEach([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], (num: number) => {
            Text(`内容项 ${num}`)
              .fontSize(16)
              .padding(16)
              .width('100%')
              .backgroundColor('#E3F2FD')
              .borderRadius(8)
          }, (num: number) => `scroll_${num}`)
        }
        .width('100%')
        .padding(12)
      }
      .width('100%')
      .height(200)
      .scrollBar(BarState.Auto)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)

      Text('Scroll 组件提供了可滚动的内容区域')
        .fontSize(12)
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
 * 滚动方向控制示例
 */
@ComponentV2
export struct ScrollDirectionExample {
  build() {
    Column({ space: 16 }) {
      Text('滚动方向控制')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      // 垂直滚动
      Text('垂直滚动:')
        .fontSize(14)
        .fontColor('#666666')

      Scroll() {
        Row({ space: 12 }) {
          ForEach([1, 2, 3, 4, 5], (num: number) => {
            Text(`项${num}`)
              .fontSize(14)
              .padding(12)
              .backgroundColor('#E3F2FD')
              .borderRadius(4)
          }, (num: number) => `vscroll_${num}`)
        }
        .height(100)
        .padding(8)
        .backgroundColor('#F5F5F5')
      }
      .width('100%')
      .scrollBar(BarState.Auto)
      .scrollable(ScrollDirection.Vertical)

      // 水平滚动
      Text('水平滚动:')
        .fontSize(14)
        .fontColor('#666666')
        .margin({ top: 12 })

      Scroll() {
        Row({ space: 12 }) {
          ForEach([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], (num: number) => {
            Text(`项${num}`)
              .fontSize(14)
              .padding(12)
              .backgroundColor('#E8F5E9')
              .borderRadius(4)
          }, (num: number) => `hscroll_${num}`)
        }
        .height(100)
        .padding(8)
        .backgroundColor('#F5F5F5')
      }
      .width('100%')
      .scrollBar(BarState.Auto)
      .scrollable(ScrollDirection.Horizontal)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * 滚动位置控制示例
 */
@ComponentV2
export struct ScrollPositionExample {
  scroller: Scroller = new Scroller()

  build() {
    Column({ space: 16 }) {
      Text('滚动位置控制')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Scroll(this.scroller) {
        Column({ space: 12 }) {
          ForEach([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], (num: number) => {
            Text(`内容项 ${num}`)
              .fontSize(16)
              .padding(16)
              .width('100%')
              .backgroundColor('#E3F2FD')
              .borderRadius(8)
          }, (num: number) => `pos_${num}`)
        }
        .width('100%')
        .padding(12)
        .margin({ bottom: 60 })
      }
      .width('100%')
      .height(200)
      .scrollBar(BarState.Auto)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)

      // 滚动控制按钮
      Row({ space: 12 }) {
        Button('顶部')
          .onClick(() => {
            this.scroller.scrollToIndex(0)
          })

        Button('中间')
          .onClick(() => {
            this.scroller.scrollToIndex(5)
          })

        Button('底部')
          .onClick(() => {
            this.scroller.scrollToIndex(9)
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * Scroll 主页面
 */
@ComponentV2
export struct ScrollExamplePage {
  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          Text('Scroll Component Examples')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .padding({ left: 16, right: 16, top: 16, bottom: 8 })

          VerticalScrollExample()
          ScrollDirectionExample()
          ScrollPositionExample()

          // 使用说明
          Column({ space: 8 }) {
            Text('使用说明')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .width('100%')

            Text('• scrollable() 设置滚动方向（Vertical/Horizontal/Both）')
              .fontSize(13)
              .fontColor('#666666')
              .width('100%')

            Text('• scrollBar() 设置滚动条显示状态')
              .fontSize(13)
              .fontColor('#666666')
              .width('100%')

            Text('• Scroller: 滚动控制器，用于控制滚动位置')
              .fontSize(13)
              .fontColor('#666666')
              .width('100%')

            Text('• scrollToIndex() 滚动到指定索引项')
              .fontSize(13)
              .fontColor('#666666')
              .width('100%')
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#E3F2FD')
          .borderRadius(12)
          .margin({ bottom: 16 })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
    }
    .title('Scroll 滚动容器')
    .mode(NavDestinationMode.STANDARD)
  }
}

@Builder
export function ScrollExamplePageBuilder() {
  ScrollExamplePage()
}
