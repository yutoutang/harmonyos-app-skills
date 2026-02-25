/**
 * Column & Row Component Examples
 * OpenHarmony Column 和 Row 布局组件使用示例
 *
 * 展示 Column 和 Row 组件的各种布局方式
 */

/**
 * Column 基础示例
 */
@ComponentV2
export struct ColumnBasicExample {
  build() {
    Column({ space: 16 }) {
      Text('Column 基础示例 (Column Basic)')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 简单垂直布局
      Column({ space: 12 }) {
        Text('标题行')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)

        Text('内容行')
          .fontSize(16)
          .fontColor('#666666')

        Button('按钮')
          .width('100%')
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
 * Column 对齐方式示例
 */
@ComponentV2
export struct ColumnAlignmentExample {
  build() {
    Column({ space: 16 }) {
      Text('Column 对齐方式 (Column Alignment)')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 水平对齐
      Column({ space: 8 }) {
        Text('alignItems.HorizontalAlign.Start (左对齐)')
          .fontSize(14)
          .fontColor('#666666')

        Column({ space: 8 }) {
          Text('左侧对齐')
            .width(120)
            .padding(8)
            .backgroundColor('#E3F2FD')
            .borderRadius(4)
          Text('短文本')
            .width(120)
            .padding(8)
            .backgroundColor('#E3F2FD')
            .borderRadius(4)
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      // 垂直对齐
      Column({ space: 8 }) {
        Text('justifyContent.FlexAlign.Center (垂直居中)')
          .fontSize(14)
          .fontColor('#666666')

        Column({ space: 8 }) {
          Text('顶部')
            .padding(8)
            .backgroundColor('#E8F5E9')
            .borderRadius(4)
          Text('中间')
            .padding(8)
            .backgroundColor('#E8F5E9')
            .borderRadius(4)
          Text('底部')
            .padding(8)
            .backgroundColor('#E8F5E9')
            .borderRadius(4)
        }
        .width('100%')
        .height(150)
        .justifyContent(FlexAlign.Center)
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
 * Row 基础示例
 */
@ComponentV2
export struct RowBasicExample {
  build() {
    Column({ space: 16 }) {
      Text('Row 基础示例 (Row Basic)')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

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

      // 垂直对齐
      Column({ space: 8 }) {
        Text('alignItems.VerticalAlign.Center (垂直居中)')
          .fontSize(14)
          .fontColor('#666666')

        Row({ space: 8 }) {
          Text('小')
            .padding(8)
            .backgroundColor('#E3F2FD')
            .borderRadius(4)

          Text('中等高度')
            .height(40)
            .padding(8)
            .backgroundColor('#E3F2FD')
            .borderRadius(4)

          Text('大高度')
            .height(60)
            .padding(8)
            .backgroundColor('#E3F2FD')
            .borderRadius(4)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      // 水平对齐
      Column({ space: 8 }) {
        Text('justifyContent.FlexAlign.Center (水平居中)')
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
 * 权重分配示例
 */
@ComponentV2
export struct LayoutWeightExample {
  build() {
    Column({ space: 16 }) {
      Text('权重分配 (Layout Weight)')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // Column 权重
      Column({ space: 8 }) {
        Text('Column layoutWeight 示例')
          .fontSize(14)
          .fontColor('#666666')

        Column() {
          Text('固定高度 - 60')
            .height(60)
            .padding(8)
            .backgroundColor('#007DFF')
            .borderRadius(4)

          Text('弹性区域 - layoutWeight(1)')
            .layoutWeight(1)
            .padding(8)
            .backgroundColor('#28A745')
            .borderRadius(4)

          Text('固定高度 - 40')
            .height(40)
            .padding(8)
            .backgroundColor('#FFC107')
            .borderRadius(4)
        }
        .width('100%')
        .height(200)
        .backgroundColor('#F5F5F5')
        .borderRadius(4)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      // Row 权重
      Column({ space: 8 }) {
        Text('Row layoutWeight 示例')
          .fontSize(14)
          .fontColor('#666666')

        Row() {
          Text('固定')
            .width(60)
            .padding(8)
            .backgroundColor('#E91E63')
            .borderRadius(4)

          Text('弹性 layoutWeight(1)')
            .layoutWeight(1)
            .padding(8)
            .backgroundColor('#9C27B0')
            .borderRadius(4)

          Text('固定80')
            .width(80)
            .padding(8)
            .backgroundColor('#673AB7')
            .borderRadius(4)
        }
        .width('100%')
        .height(60)
        .backgroundColor('#F5F5F5')
        .borderRadius(4)
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
 * 嵌套布局示例
 */
@ComponentV2
export struct NestedLayoutExample {
  build() {
    Column({ space: 16 }) {
      Text('嵌套布局 (Nested Layout)')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 顶部导航栏
      Row() {
        Text('返回')
          .fontSize(16)
          .fontColor('#007DFF')

        Text('嵌套布局示例')
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
      .borderRadius(8)

      // 内容区域
      Column() {
        Row({ space: 12 }) {
          Column()
            .layoutWeight(1)
            .height(80)
            .backgroundColor('#E3F2FD')
            .borderRadius(8)

          Column()
            .layoutWeight(1)
            .height(80)
            .backgroundColor('#E8F5E9')
            .borderRadius(8)

          Column()
            .layoutWeight(1)
            .height(80)
            .backgroundColor('#FFF8E1')
            .borderRadius(8)
        }
        .width('100%')

        Row({ space: 12 }) {
          Column()
            .layoutWeight(1)
            .height(80)
            .backgroundColor('#F3E5F5')
            .borderRadius(8)

          Column()
            .layoutWeight(1)
            .height(80)
            .backgroundColor('#E8EAF6')
            .borderRadius(8)

          Column()
            .layoutWeight(1)
            .height(80)
            .backgroundColor('#E0F2F1')
            .borderRadius(8)
        }
        .width('100%')
      }
      .layoutWeight(1)
      .padding(12)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)
    }
    .width('100%')
    .padding(16)
  }
}

/**
 * SpaceBetween 对齐示例
 */
@ComponentV2
export struct SpaceBetweenExample {
  build() {
    Column({ space: 16 }) {
      Text('SpaceBetween 对齐 (SpaceBetween Alignment)')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // Row SpaceBetween
      Column({ space: 12 }) {
        Text('Row justifyContent.SpaceBetween (两端对齐)')
          .fontSize(14)
          .fontColor('#666666')

        Row() {
          Text('左侧文本')
            .fontSize(16)
          Text('中间文本')
            .fontSize(16)
          Text('右侧文本')
            .fontSize(16)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding(12)
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
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
 * 完整的 Column & Row 示例页面
 */
@ComponentV2
export struct ColumnRowExamplePage {
  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          Text('Column & Row Layout Examples')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .padding({ left: 16, right: 16, top: 16, bottom: 8 })

          ColumnBasicExample()
          ColumnAlignmentExample()
          RowBasicExample()
          RowAlignmentExample()
          LayoutWeightExample()
          NestedLayoutExample()
          SpaceBetweenExample()
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
    }
    .title('Column & Row 布局组件示例')
    .mode(NavDestinationMode.STANDARD)
  }
}

@Builder
export function ColumnRowExamplePageBuilder() {
  ColumnRowExamplePage()
}
