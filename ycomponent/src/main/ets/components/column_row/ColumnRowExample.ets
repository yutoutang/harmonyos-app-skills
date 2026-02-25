/**
 * Column & Row Component Examples
 * OpenHarmony Column & Row 布局组件使用示例
 *
 * 展示 Column 和 Row 线性布局的各种用法
 */

/**
 * Column 垂直布局示例
 */
@ComponentV2
export struct ColumnLayoutExample {
  build() {
    Column({ space: 16 }) {
      Text('Column 垂直布局')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Column({ space: 12 }) {
        ForEach([1, 2, 3, 4, 5], (num: number) => {
          Text(`项目 ${num}`)
            .fontSize(16)
            .padding(16)
            .width('100%')
            .backgroundColor('#E3F2FD')
            .borderRadius(8)
        }, (num: number) => `col_${num}`)
      }
      .width('100%')
      .height(250)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)
      .padding(12)

      Text('Column 组件用于垂直方向排列子元素')
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
 * Row 水平布局示例
 */
@ComponentV2
export struct RowLayoutExample {
  build() {
    Column({ space: 16 }) {
      Text('Row 水平布局')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Row({ space: 12 }) {
        ForEach([1, 2, 3, 4, 5], (num: number) => {
          Text(`项${num}`)
            .fontSize(14)
            .padding(12)
            .backgroundColor('#E8F5E9')
            .borderRadius(4)
        }, (num: number) => `row_${num}`)
      }
      .width('100%')
      .height(80)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)
      .padding(12)
      .alignItems(VerticalAlign.Center)

      Text('Row 组件用于水平方向排列子元素')
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
 * 对齐方式示例
 */
@ComponentV2
export struct AlignmentExample {
  build() {
    Column({ space: 16 }) {
      Text('对齐方式控制')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      // Column 对齐示例
      Text('Column 水平对齐:')
        .fontSize(14)
        .fontColor('#666666')

      Row({ space: 12 }) {
        Column({ space: 8 }) {
          Text('Start')
            .fontSize(12)
          Text('内容')
            .fontSize(14)
            .padding(8)
            .backgroundColor('#E3F2FD')
            .borderRadius(4)
        }
        .width(80)
        .height(60)
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.Center)

        Column({ space: 8 }) {
          Text('Center')
            .fontSize(12)
          Text('内容')
            .fontSize(14)
            .padding(8)
            .backgroundColor('#E3F2FD')
            .borderRadius(4)
        }
        .width(80)
        .height(60)
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)

        Column({ space: 8 }) {
          Text('End')
            .fontSize(12)
          Text('内容')
            .fontSize(14)
            .padding(8)
            .backgroundColor('#E3F2FD')
            .borderRadius(4)
        }
        .width(80)
        .height(60)
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
        .alignItems(HorizontalAlign.End)
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')

      // Row 对齐示例
      Text('Row 垂直对齐:')
        .fontSize(14)
        .fontColor('#666666')
        .margin({ top: 12 })

      Column({ space: 8 }) {
        Row({ space: 8 }) {
          Text('Top')
            .fontSize(12)
          Text('内容')
            .fontSize(14)
            .padding(8)
            .backgroundColor('#E8F5E9')
            .borderRadius(4)
        }
        .height(50)
        .width('100%')
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
        .alignItems(VerticalAlign.Top)

        Row({ space: 8 }) {
          Text('Center')
            .fontSize(12)
          Text('内容')
            .fontSize(14)
            .padding(8)
            .backgroundColor('#E8F5E9')
            .borderRadius(4)
        }
        .height(50)
        .width('100%')
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
        .alignItems(VerticalAlign.Center)

        Row({ space: 8 }) {
          Text('Bottom')
            .fontSize(12)
          Text('内容')
            .fontSize(14)
            .padding(8)
            .backgroundColor('#E8F5E9')
            .borderRadius(4)
        }
        .height(50)
        .width('100%')
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
        .alignItems(VerticalAlign.Bottom)
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
 * 权重示例 (layoutWeight)
 */
@ComponentV2
export struct LayoutWeightExample {
  build() {
    Column({ space: 16 }) {
      Text('布局权重 (layoutWeight)')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      // Row 权重示例
      Text('Row 权重分配:')
        .fontSize(14)
        .fontColor('#666666')

      Row() {
        Text('25%')
          .fontSize(14)
          .height(40)
          .backgroundColor('#007DFF')
          .fontColor('#FFFFFF')
          .textAlign(TextAlign.Center)
          .layoutWeight(1)

        Text('50%')
          .fontSize(14)
          .height(40)
          .backgroundColor('#28A745')
          .fontColor('#FFFFFF')
          .textAlign(TextAlign.Center)
          .layoutWeight(2)

        Text('25%')
          .fontSize(14)
          .height(40)
          .backgroundColor('#FFC107')
          .fontColor('#FFFFFF')
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
      }
      .width('100%')
      .borderRadius(8)

      // Column 权重示例
      Text('Column 权重分配:')
        .fontSize(14)
        .fontColor('#666666')
        .margin({ top: 12 })

      Row() {
        Column() {
          Text('33%')
            .fontSize(14)
            .fontColor('#FFFFFF')
            .textAlign(TextAlign.Center)
        }
        .height(100)
        .backgroundColor('#DC3545')
        .borderRadius(8)
        .justifyContent(FlexAlign.Center)
        .layoutWeight(1)

        Column() {
          Text('33%')
            .fontSize(14)
            .fontColor('#FFFFFF')
            .textAlign(TextAlign.Center)
        }
        .height(100)
        .backgroundColor('#17A2B8')
        .borderRadius(8)
        .justifyContent(FlexAlign.Center)
        .layoutWeight(1)

        Column() {
          Text('33%')
            .fontSize(14)
            .fontColor('#FFFFFF')
            .textAlign(TextAlign.Center)
        }
        .height(100)
        .backgroundColor('#6C757D')
        .borderRadius(8)
        .justifyContent(FlexAlign.Center)
        .layoutWeight(1)
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
 * Column & Row 主页面
 */
@ComponentV2
export struct ColumnRowExamplePage {
  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          Text('Column & Row Component Examples')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .padding({ left: 16, right: 16, top: 16, bottom: 8 })

          ColumnLayoutExample()
          RowLayoutExample()
          AlignmentExample()
          LayoutWeightExample()

          // 使用说明
          Column({ space: 8 }) {
            Text('使用说明')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .width('100%')

            Text('• Column: 垂直方向排列子组件的线性布局容器')
              .fontSize(13)
              .fontColor('#666666')
              .width('100%')

            Text('• Row: 水平方向排列子组件的线性布局容器')
              .fontSize(13)
              .fontColor('#666666')
              .width('100%')

            Text('• space: 子组件之间的间距')
              .fontSize(13)
              .fontColor('#666666')
              .width('100%')

            Text('• alignItems: 交叉轴对齐方式')
              .fontSize(13)
              .fontColor('#666666')
              .width('100%')

            Text('• justifyContent: 主轴对齐方式')
              .fontSize(13)
              .fontColor('#666666')
              .width('100%')

            Text('• layoutWeight: 布局权重，按比例分配剩余空间')
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
    .title('Column & Row 线性布局')
    .mode(NavDestinationMode.STANDARD)
  }
}

@Builder
export function ColumnRowExamplePageBuilder() {
  ColumnRowExamplePage()
}
