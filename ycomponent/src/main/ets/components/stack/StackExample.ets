/**
 * Stack Component Examples
 * OpenHarmony Stack 层叠布局组件使用示例
 */

/**
 * Stack 基础示例
 */
@ComponentV2
export struct StackBasicExample {
  build() {
    Column({ space: 16 }) {
      Text('Stack 基础示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Stack() {
        // 底层
        Rect()
          .width('100%')
          .height('100%')
          .fill('#E3F2FD')
          .radius(8)

        // 中层
        Rect()
          .width('80%')
          .height('60%')
          .fill('#28A745')
          .radius(8)

        // 顶层
        Rect()
          .width('60%')
          .height('40%')
          .fill('#FFC107')
          .radius(8)
      }
      .width('100%')
      .height(200)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * Stack 对齐方式示例
 */
@ComponentV2
export struct StackAlignmentExample {
  build() {
    Column({ space: 16 }) {
      Text('Stack 对齐方式')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      // 顶部对齐
      Column({ space: 8 }) {
        Text('Align.Top (顶部对齐)')
          .fontSize(14)
          .fontColor('#666666')

        Stack({ alignContent: Alignment.Top }) {
          Rect()
            .width('100%')
            .height('100%')
            .fill('#E3F2FD')
            .radius(8)

          Text('顶部内容')
            .fontSize(16)
            .fontColor('#FFFFFF')
            .padding(12)
            .backgroundColor('#007DFF')
            .borderRadius(8)
        }
        .width('100%')
        .height(100)
      }
      .width('100%')

      // 居中对齐
      Column({ space: 8 }) {
        Text('Align.Center (居中对齐)')
          .fontSize(14)
          .fontColor('#666666')

        Stack({ alignContent: Alignment.Center }) {
          Rect()
            .width('100%')
            .height('100%')
            .fill('#E8F5E9')
            .radius(8)

          Text('居中内容')
            .fontSize(16)
            .fontColor('#FFFFFF')
            .padding(12)
            .backgroundColor('#28A745')
            .borderRadius(8)
        }
        .width('100%')
        .height(100)
      }
      .width('100%')

      // 底部对齐
      Column({ space: 8 }) {
        Text('Align.Bottom (底部对齐)')
          .fontSize(14)
          .fontColor('#666666')

        Stack({ alignContent: Alignment.Bottom }) {
          Rect()
            .width('100%')
            .height('100%')
            .fill('#FFF8E1')
            .radius(8)

          Text('底部内容')
            .fontSize(16)
            .fontColor('#FFFFFF')
            .padding(12)
            .backgroundColor('#FFC107')
            .borderRadius(8)
        }
        .width('100%')
        .height(100)
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
 * Stack 图片覆盖示例 (Image Overlay)
 */
@ComponentV2
export struct StackImageOverlayExample {
  build() {
    Column({ space: 16 }) {
      Text('图片覆盖示例 (Image Overlay)')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      // 图片 + 标签
      Column({ space: 8 }) {
        Text('图片 + 角标')
          .fontSize(14)
          .fontColor('#666666')

        Stack() {
          // 底层图片 (用矩形代替)
          Rect()
            .width('100%')
            .height('100%')
            .fill('#E3F2FD')
            .radius(8)

          // 角标
          Text('NEW')
            .fontSize(12)
            .fontColor('#FFFFFF')
            .padding({ left: 8, right: 8, top: 4, bottom: 4 })
            .backgroundColor('#FF0000')
            .borderRadius(4)
            .position({ x: '80%', y: 8 })
        }
        .width('100%')
        .height(150)
      }
      .width('100%')

      // 图片 + 文字覆盖
      Column({ space: 8 }) {
        Text('图片 + 文字覆盖层')
          .fontSize(14)
          .fontColor('#666666')

        Stack({ alignContent: Alignment.Bottom }) {
          // 底层图片 (用矩形代替)
          Rect()
            .width('100%')
            .height('100%')
            .fill('#28A745')
            .radius(8)

          // 底部文字覆盖层
          Column({ space: 4 }) {
            Text('图片标题')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')

            Text('这是图片的描述信息')
              .fontSize(12)
              .fontColor('#FFFFFF')
              .opacity(0.9)
          }
          .width('100%')
          .padding(12)
          .backgroundColor('rgba(0, 0, 0, 0.5)')
          .borderRadius({ bottomLeft: 8, bottomRight: 8 })
        }
        .width('100%')
        .height(150)
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
 * Stack 浮动按钮示例 (Floating Button)
 */
@ComponentV2
export struct StackFloatingButtonExample {
  build() {
    Column({ space: 16 }) {
      Text('浮动按钮示例 (Floating Button)')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      // 内容区域 + 浮动按钮
      Column({ space: 8 }) {
        Text('卡片 + 右下角浮动按钮')
          .fontSize(14)
          .fontColor('#666666')

        Stack() {
          // 底层内容
          Column({ space: 12 }) {
            Text('这是一个内容卡片')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)

            ForEach([1, 2, 3], (item: number) => {
              Row()
                .width('100%')
                .height(40)
                .backgroundColor('#F5F5F5')
                .borderRadius(4)
            }, (item: number) => `line_${item}`)
          }
          .width('100%')
          .height('100%')
          .padding(16)
          .backgroundColor('#FFFFFF')
          .borderRadius(8)

          // 右下角浮动按钮
          Column({ space: 0 }) {
            Text('+')
              .fontSize(24)
              .fontColor('#FFFFFF')
              .width(40)
              .height(40)
              .textAlign(TextAlign.Center)
              .backgroundColor('#007DFF')
              .borderRadius(20)
              .shadow({ radius: 8, color: 'rgba(0, 125, 255, 0.3)' })
          }
          .position({ x: '85%', y: '70%'' })
        }
        .width('100%')
        .height(200)
      }
      .width('100%')

      // 底部操作栏
      Column({ space: 8 }) {
        Text('内容 + 底部操作栏')
          .fontSize(14)
          .fontColor('#666666')

        Stack({ alignContent: Alignment.Bottom }) {
          // 底层内容
          Column({ space: 8 }) {
            Text('主要内容区域')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)

            Row({ space: 8 }) {
              Column()
                .layoutWeight(1)
                .height(60)
                .backgroundColor('#E3F2FD')
                .borderRadius(8)

              Column()
                .layoutWeight(1)
                .height(60)
                .backgroundColor('#E8F5E9')
                .borderRadius(8)
            }
            .width('100%')
          }
          .width('100%')
          .height('100%')
          .padding(16)
          .backgroundColor('#F5F5F5')
          .borderRadius(8)

          // 底部操作栏
          Row({ space: 12 }) {
            Button('取消')
              .fontSize(16)
              .backgroundColor('#F5F5F5')
              .fontColor('#666666')

            Button('确认')
              .fontSize(16)
              .backgroundColor('#007DFF')
              .fontColor('#FFFFFF')
          }
          .width('100%')
          .padding(12)
          .backgroundColor('#FFFFFF')
          .borderRadius({ topLeft: 12, topRight: 12 })
          .shadow({ radius: 4, color: 'rgba(0, 0, 0, 0.1)' })
        }
        .width('100%')
        .height(200)
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
 * Stack 实际应用示例
 */
@ComponentV2
export struct StackRealWorldExample {
  build() {
    Column({ space: 16 }) {
      Text('Stack 实际应用示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      // 用户头像 + 在线状态
      Column({ space: 8 }) {
        Text('用户头像 + 在线状态')
          .fontSize(14)
          .fontColor('#666666')

        Row({ space: 24 }) {
          Stack() {
            // 头像
            Column()
              .width(60)
              .height(60)
              .backgroundColor('#E3F2FD')
              .borderRadius(30)

            // 在线状态点
            Column()
              .width(16)
              .height(16)
              .backgroundColor('#28A745')
              .border({ width: 2, color: '#FFFFFF' })
              .borderRadius(8)
              .position({ x: 44, y: 44 })
          }
          .width(60)
          .height(60)

          Stack() {
            // 头像
            Column()
              .width(60)
              .height(60)
              .backgroundColor('#E8F5E9')
              .borderRadius(30)

            // 离线状态点
            Column()
              .width(16)
              .height(16)
              .backgroundColor('#999999')
              .border({ width: 2, color: '#FFFFFF' })
              .borderRadius(8)
              .position({ x: 44, y: 44 })
          }
          .width(60)
          .height(60)

          Stack() {
            // 头像
            Column()
              .width(60)
              .height(60)
              .backgroundColor('#FFF8E1')
              .borderRadius(30)

            // 忙碌状态点
            Column()
              .width(16)
              .height(16)
              .backgroundColor('#FFC107')
              .border({ width: 2, color: '#FFFFFF' })
              .borderRadius(8)
              .position({ x: 44, y: 44 })
          }
          .width(60)
          .height(60)
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
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
 * Stack 主页面
 */
@ComponentV2
export struct StackExamplePage {
  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          Text('Stack Component Examples')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .padding({ left: 16, right: 16, top: 16, bottom: 8 })

          StackBasicExample()
          StackAlignmentExample()
          StackImageOverlayExample()
          StackFloatingButtonExample()
          StackRealWorldExample()

          // 使用说明
          Column({ space: 8 }) {
            Text('使用说明')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .width('100%')

            Text('• Stack: 层叠布局容器，子组件按顺序堆叠')
              .fontSize(13)
              .fontColor('#666666')
              .width('100%')

            Text('• alignContent: 对齐方式 (Top/Center/Bottom等)')
              .fontSize(13)
              .fontColor('#666666')
              .width('100%')

            Text('• 适用场景: 图片覆盖、浮动按钮、状态角标等')
              .fontSize(13)
              .fontColor('#666666')
              .width('100%')

            Text('• position: 绝对定位，可以精确控制子组件位置')
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
    .title('Stack 层叠布局示例')
    .mode(NavDestinationMode.STANDARD)
  }
}

@Builder
export function StackExamplePageBuilder() {
  StackExamplePage()
}
