/**
 * Grid Component Examples
 * OpenHarmony Grid 网格布局组件使用示例
 *
 * 展示 Grid 网格布局的各种用法
 */

/**
 * 基础网格布局示例
 */
@ComponentV2
export struct BasicGridExample {
  build() {
    Column({ space: 16 }) {
      Text('Grid 基础网格布局')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Grid() {
        GridItem() {
          Text('1')
            .fontSize(24)
            .fontColor('#FFFFFF')
            .backgroundColor('#007DFF')
            .width('100%')
            .height(60)
            .textAlign(TextAlign.Center)
            .borderRadius(8)
        }
        GridItem() {
          Text('2')
            .fontSize(24)
            .fontColor('#FFFFFF')
            .backgroundColor('#28A745')
            .width('100%')
            .height(60)
            .textAlign(TextAlign.Center)
            .borderRadius(8)
        }
        GridItem() {
          Text('3')
            .fontSize(24)
            .fontColor('#FFFFFF')
            .backgroundColor('#DC3545')
            .width('100%')
            .height(60)
            .textAlign(TextAlign.Center)
            .borderRadius(8)
        }
        GridItem() {
          Text('4')
            .fontSize(24)
            .fontColor('#FFFFFF')
            .backgroundColor('#FFC107')
            .width('100%')
            .height(60)
            .textAlign(TextAlign.Center)
            .borderRadius(8)
        }
      }
      .columnsTemplate('1fr 1fr')
      .rowsTemplate('1fr 1fr')
      .width('100%')
      .height(220)
      .columnsGap(12)
      .rowsGap(12)
      .backgroundColor('#F5F5F5')
      .padding(12)
      .borderRadius(12)

      Text('Grid 组件使用 columnsTemplate 和 rowsTemplate 定义网格列数和行数')
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
 * Grid 固定行列数示例
 */
@ComponentV2
export struct FixedGridExample {
  build() {
    Column({ space: 16 }) {
      Text('固定行列网格')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Grid() {
        ForEach([1, 2, 3, 4, 5, 6, 7, 8, 9], (item: number) => {
          GridItem() {
            Text(`${item}`)
              .fontSize(20)
              .fontColor('#FFFFFF')
              .backgroundColor('#007DFF')
              .width('100%')
              .height(60)
              .textAlign(TextAlign.Center)
              .borderRadius(8)
          }
        }, (item: number) => `grid_${item}`)
      }
      .columnsTemplate('1fr 1fr 1fr')
      .rowsTemplate('1fr 1fr 1fr')
      .columnsGap(8)
      .rowsGap(8)
      .width('100%')
      .height(240)
      .backgroundColor('#F5F5F5')
      .padding(12)
      .borderRadius(12)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * Grid 跨行跨列示例
 */
@ComponentV2
export struct SpanGridExample {
  build() {
    Column({ space: 16 }) {
      Text('跨行跨列网格')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Grid() {
        GridItem() {
          Text('1')
            .fontSize(20)
            .fontColor('#FFFFFF')
            .backgroundColor('#007DFF')
            .width('100%')
            .height(60)
            .textAlign(TextAlign.Center)
            .borderRadius(8)
        }
        GridItem() {
          Text('2')
            .fontSize(20)
            .fontColor('#FFFFFF')
            .backgroundColor('#28A745')
            .width('100%')
            .height(60)
            .textAlign(TextAlign.Center)
            .borderRadius(8)
        }
        GridItem() {
          Text('3')
            .fontSize(20)
            .fontColor('#FFFFFF')
            .backgroundColor('#DC3545')
            .width('100%')
            .height(60)
            .textAlign(TextAlign.Center)
            .borderRadius(8)
        }
        GridItem() {
          Text('4')
            .fontSize(20)
            .fontColor('#FFFFFF')
            .backgroundColor('#FFC107')
            .width('100%')
            .height(60)
            .textAlign(TextAlign.Center)
            .borderRadius(8)
        }
      }
      .columnsTemplate('1fr 1fr')
      .rowsTemplate('1fr 1fr')
      .columnsGap(8)
      .rowsGap(8)
      .width('100%')
      .height(160)
      .backgroundColor('#F5F5F5')
      .padding(12)
      .borderRadius(12)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * Grid 主页面
 */
@ComponentV2
export struct GridExamplePage {
  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          Text('Grid Component Examples')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .padding({ left: 16, right: 16, top: 16, bottom: 8 })

          BasicGridExample()
          FixedGridExample()
          SpanGridExample()

          // 使用说明
          Column({ space: 8 }) {
            Text('使用说明')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .width('100%')

            Text('• columnsTemplate: 定义网格列宽度，如 "1fr 1fr 1fr" 表示三列等宽')
              .fontSize(13)
              .fontColor('#666666')
              .width('100%')

            Text('• rowsTemplate: 定义网格行高度，如 "1fr 1fr" 表示两行等高')
              .fontSize(13)
              .fontColor('#666666')
              .width('100%')

            Text('• columnsGap/rowsGap: 设置列间距和行间距')
              .fontSize(13)
              .fontColor('#666666')
              .width('100%')

            Text('• GridItem: 网格项，可以设置跨行跨列')
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
    .title('Grid 网格布局')
    .mode(NavDestinationMode.STANDARD)
  }
}

@Builder
export function GridExamplePageBuilder() {
  GridExamplePage()
}
