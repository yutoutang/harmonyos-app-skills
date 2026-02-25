/**
 * Flex, Scroll, List, Grid 组件示例
 * OpenHarmony 布局组件综合示例
 */

@ComponentV2
export struct FlexExample {
  build() {
    Column({ space: 16 }) {
      Text('Flex 弹性布局示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 横向弹性布局
      Flex({ direction: FlexDirection.Row }) {
        Text('Flex 1')
          .layoutWeight(1)
          .padding(12)
          .backgroundColor('#E3F2FD')
          .borderRadius(4)

        Text('Flex 2')
          .layoutWeight(2)
          .padding(12)
          .backgroundColor('#28A745')
          .borderRadius(4)
      }
      .width('100%')
      .height(60)
    }
    .width('100%')
    .padding(16)
  }
}

@ComponentV2
export struct ScrollExample {
  build() {
    Column({ space: 16 }) {
      Text('Scroll 滚动容器示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Scroll() {
        Column({ space: 8 }) {
          ForEach([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], (item: number) => {
            Text(`滚动项 ${item}`)
              .width('100%')
              .height(50)
              .padding(16)
              .backgroundColor('#F5F5F5')
              .borderRadius(8)
          })
        }
        .width('100%')
      }
      .width('100%')
      .height(200)
      .border({ width: 1, color: '#E0E0E0' })
      .borderRadius(8)
    }
    .width('100%')
    .padding(16)
  }
}

@ComponentV2
export struct ListExample {
  @Local items: string[] = []

  aboutToAppear() {
    for (let i = 1; i <= 20; i++) {
      this.items.push(`列表项 ${i}`)
    }
  }

  build() {
    Column({ space: 16 }) {
      Text('List 列表示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      List({ space: 12 }) {
        ForEach(this.items, (item: string, index: number) => {
          ListItem() {
            Text(`${item}`)
              .width('100%')
              .height(60)
              .padding(16)
              .backgroundColor('#F5F5F5')
              .borderRadius(8)
          }
        })
      }
      .width('100%')
      .height(200)
      .padding(8)
      .border({ width: 1, color: '#E0E0E0' })
      .borderRadius(8)
    }
    .width('100%')
    .padding(16)
  }
}

@ComponentV2
export struct GridExample {
  build() {
    Column({ space: 16 }) {
      Text('Grid 网格布局示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Grid() {
        ForEach([1, 2, 3, 4, 5, 6, 7, 8, 9], (item: number) => {
          GridItem() {
            Text(`${item}`)
              .width('100%')
              .height(60)
              .textAlign(TextAlign.Center)
              .backgroundColor('#E3F2FD')
              .borderRadius(8)
          }
        })
      }
      .columnsTemplate('1fr 1fr 1fr')
      .rowsGap(12)
      .columnsGap(12)
      .width('100%')
      .height(300)
      .padding(8)
      .border({ width: 1, color: '#E0E0E0' })
      .borderRadius(8)
    }
    .width('100%')
    .padding(16)
  }
}

@ComponentV2
export struct LayoutExamplePage {
  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          Text('Layout Component Examples')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .padding({ left: 16, right: 16, top: 16, bottom: 8 })

          FlexExample()
          ScrollExample()
          ListExample()
          GridExample()
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
    }
    .title('Flex/Scroll/List/Grid 布局')
    .mode(NavDestinationMode.STANDARD)
  }
}

@Builder
export function FlexExamplePageBuilder() {
  FlexExample()
}

@Builder
export function LayoutExamplePageBuilder() {
  LayoutExamplePage()
}
