/**
 * Row Component Examples
 * OpenHarmony Row 布局组件使用示例
 *
 * 展示 Row 水平布局的各种用法
 */

/**
 * Row 基础示例
 */
@ComponentV2
export struct RowBasicExample {
  build() {
    Column({ space: 16 }) {
      Text('Row 基础示例 (Row Basic)')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      // 简单水平布局
      Row({ space: 12 }) {
        Text('左')
          .fontSize(16)

        Text('中')
          .fontSize(16)

        Text('右')
          .fontSize(16)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      // 带间距的水平布局
      Row({ space: 16 }) {
        Text('头像')
          .width(40)
          .height(40)
          .backgroundColor('#E3F2FD')
          .borderRadius(20)

        Text('用户名')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)

        Text('时间')
          .fontSize(14)
          .fontColor('#999999')
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)
    }
    .width('100%')
    .padding(16)
  }
}

/**
 * Row 对齐方式示例
 */
@ComponentV2
export struct RowAlignmentExample {
  build() {
    Column({ space: 16 }) {
      Text('Row 对齐方式 (Row Alignment)')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      // 垂直对齐 (alignItems)
      Column({ space: 8 }) {
        Text('垂直对齐 (alignItems)')
          .fontSize(14)
          .fontColor('#666666')

        Row({ space: 8 }) {
          Text('Top')
            .height(40)
            .padding(8)
            .backgroundColor('#E3F2FD')
            .borderRadius(4)

          Text('Center')
            .height(60)
            .padding(8)
            .backgroundColor('#E3F2FD')
            .borderRadius(4)

          Text('Bottom')
            .height(80)
            .padding(8)
            .backgroundColor('#E3F2FD')
            .borderRadius(4)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .padding(12)
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
      }
      .width('100%')

      // 水平对齐 (justifyContent)
      Column({ space: 8 }) {
        Text('水平对齐 (justifyContent)')
          .fontSize(14)
          .fontColor('#666666')

        Row({ space: 8 }) {
          Text('左')
            .padding(8)
            .backgroundColor('#E8F5E9')
            .borderRadius(4)

          Text('中')
            .padding(8)
            .backgroundColor('#E8F5E9')
            .borderRadius(4)

          Text('右')
            .padding(8)
            .backgroundColor('#E8F5E9')
            .borderRadius(4)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding(12)
        .backgroundColor('#F5F5F5')
        .borderRadius(8)

        Row({ space: 8 }) {
          Text('A')
            .padding(8)
            .backgroundColor('#FFF8E1')
            .borderRadius(4)

          Text('B')
            .padding(8)
            .backgroundColor('#FFF8E1')
            .borderRadius(4)

          Text('C')
            .padding(8)
            .backgroundColor('#FFF8E1')
            .borderRadius(4)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding(12)
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
  }
}

/**
 * Row 权重分配示例
 */
@ComponentV2
export struct RowWeightExample {
  build() {
    Column({ space: 16 }) {
      Text('Row 权重分配 (layoutWeight)')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      // 等比例权重
      Column({ space: 8 }) {
        Text('等比例权重 (1:1:1)')
          .fontSize(14)
          .fontColor('#666666')

        Row() {
          Text('1')
            .height(40)
            .backgroundColor('#007DFF')
            .fontColor('#FFFFFF')
            .textAlign(TextAlign.Center)
            .layoutWeight(1)

          Text('1')
            .height(40)
            .backgroundColor('#28A745')
            .fontColor('#FFFFFF')
            .textAlign(TextAlign.Center)
            .layoutWeight(1)

          Text('1')
            .height(40)
            .backgroundColor('#FFC107')
            .fontColor('#FFFFFF')
            .textAlign(TextAlign.Center)
            .layoutWeight(1)
        }
        .width('100%')
        .borderRadius(8)
      }
      .width('100%')

      // 不同比例权重
      Column({ space: 8 }) {
        Text('不同比例权重 (1:2:1)')
          .fontSize(14)
          .fontColor('#666666')

        Row() {
          Text('25%')
            .height(40)
            .backgroundColor('#007DFF')
            .fontColor('#FFFFFF')
            .textAlign(TextAlign.Center)
            .layoutWeight(1)

          Text('50%')
            .height(40)
            .backgroundColor('#28A745')
            .fontColor('#FFFFFF')
            .textAlign(TextAlign.Center)
            .layoutWeight(2)

          Text('25%')
            .height(40)
            .backgroundColor('#FFC107')
            .fontColor('#FFFFFF')
            .textAlign(TextAlign.Center)
            .layoutWeight(1)
        }
        .width('100%')
        .borderRadius(8)
      }
      .width('100%')

      // 固定宽度 + 弹性
      Column({ space: 8 }) {
        Text('固定宽度 + 弹性 (Fixed + Flexible)')
          .fontSize(14)
          .fontColor('#666666')

        Row() {
          Text('固定')
            .width(60)
            .height(40)
            .backgroundColor('#E91E63')
            .fontColor('#FFFFFF')
            .textAlign(TextAlign.Center)

          Text('弹性')
            .height(40)
            .backgroundColor('#9C27B0')
            .fontColor('#FFFFFF')
            .textAlign(TextAlign.Center)
            .layoutWeight(1)

          Text('80')
            .width(80)
            .height(40)
            .backgroundColor('#673AB7')
            .fontColor('#FFFFFF')
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .borderRadius(8)
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
  }
}

/**
 * Row 实际应用示例
 */
@ComponentV2
export struct RowRealWorldExample {
  build() {
    Column({ space: 16 }) {
      Text('Row 实际应用示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      // 导航栏示例
      Column({ space: 8 }) {
        Text('导航栏 (Navigation Bar)')
          .fontSize(14)
          .fontColor('#666666')

        Row() {
          Text('返回')
            .fontSize(16)
            .fontColor('#007DFF')

          Text('页面标题')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)

          Text('更多')
            .fontSize(16)
            .fontColor('#007DFF')
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#FFFFFF')
        .border({ width: 1, color: '#E0E0E0' })
        .borderRadius(8)
      }
      .width('100%')

      // 列表项示例
      Column({ space: 8 }) {
        Text('列表项 (List Item)')
          .fontSize(14)
          .fontColor('#666666')

        Row({ space: 12 }) {
          Column()
            .width(50)
            .height(50)
            .backgroundColor('#E3F2FD')
            .borderRadius(8)

          Column({ space: 4 }) {
            Text('标题文本')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)

            Text('副标题描述信息')
              .fontSize(14)
              .fontColor('#999999')
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Text('>')
            .fontSize(14)
            .fontColor('#999999')
        }
        .width('100%')
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(8)
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
  }
}

/**
 * Row 主页面
 */
@ComponentV2
export struct RowExamplePage {
  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          Text('Row Component Examples')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .padding({ left: 16, right: 16, top: 16, bottom: 8 })

          RowBasicExample()
          RowAlignmentExample()
          RowWeightExample()
          RowRealWorldExample()

          // 使用说明
          Column({ space: 8 }) {
            Text('使用说明')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .width('100%')

            Text('• Row: 水平方向排列子组件的线性布局容器')
              .fontSize(13)
              .fontColor('#666666')
              .width('100%')

            Text('• space: 子组件之间的间距')
              .fontSize(13)
              .fontColor('#666666')
              .width('100%')

            Text('• alignItems: 垂直方向对齐方式 (Top/Center/Bottom)')
              .fontSize(13)
              .fontColor('#666666')
              .width('100%')

            Text('• justifyContent: 水平方向对齐方式')
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
    .title('Row 水平布局')
    .mode(NavDestinationMode.STANDARD)
  }
}

@Builder
export function RowExamplePageBuilder() {
  RowExamplePage()
}
