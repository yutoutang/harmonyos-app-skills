/**
 * Advanced Layout Components Examples (SDK 6 compatible)
 */

@ComponentV2
export struct RelativeContainerExample {
  build() {
    Column({ space: 12 }) {
      Text('RelativeContainer')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      RelativeContainer() {
        Text('TL')
          .fontSize(12)
          .fontColor('#FFFFFF')
          .backgroundColor('#1976D2')
          .padding(8)
          .borderRadius(6)
          .alignRules({
            top: { anchor: '__container__', align: VerticalAlign.Top },
            left: { anchor: '__container__', align: HorizontalAlign.Start }
          })

        Text('TR')
          .fontSize(12)
          .fontColor('#FFFFFF')
          .backgroundColor('#2E7D32')
          .padding(8)
          .borderRadius(6)
          .alignRules({
            top: { anchor: '__container__', align: VerticalAlign.Top },
            right: { anchor: '__container__', align: HorizontalAlign.End }
          })

        Text('BL')
          .fontSize(12)
          .fontColor('#FFFFFF')
          .backgroundColor('#D32F2F')
          .padding(8)
          .borderRadius(6)
          .alignRules({
            bottom: { anchor: '__container__', align: VerticalAlign.Bottom },
            left: { anchor: '__container__', align: HorizontalAlign.Start }
          })

        Text('BR')
          .fontSize(12)
          .fontColor('#FFFFFF')
          .backgroundColor('#7B1FA2')
          .padding(8)
          .borderRadius(6)
          .alignRules({
            bottom: { anchor: '__container__', align: VerticalAlign.Bottom },
            right: { anchor: '__container__', align: HorizontalAlign.End }
          })
      }
      .width('100%')
      .height(160)
      .padding(12)
      .backgroundColor('#EEEEEE')
      .borderRadius(12)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

@ComponentV2
export struct GridColRowExample {
  build() {
    Column({ space: 12 }) {
      Text('GridRow / GridCol')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      GridRow({ columns: 12, gutter: 12 }) {
        ForEach([1, 2, 3, 4], (item: number) => {
          GridCol({ span: 6 }) {
            Text(`Card ${item}`)
              .width('100%')
              .height(72)
              .textAlign(TextAlign.Center)
              .fontColor('#FFFFFF')
              .backgroundColor(item % 2 === 0 ? '#1E88E5' : '#43A047')
              .borderRadius(10)
          }
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

@ComponentV2
export struct AdvancedExamplePage {
  build() {
    Scroll() {
      Column({ space: 16 }) {
        Text('Advanced Layout Components')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .width('100%')

        RelativeContainerExample()
        GridColRowExample()
      }
      .width('100%')
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}
