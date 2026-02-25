/**
 * Blank Component Examples
 * OpenHarmony 空白占位组件使用示例
 */

/**
 * Flex 布局中的分隔示例
 */
@ComponentV2
export struct FlexBlankExample {
  build() {
    Column({ space: 20 }) {
      Text('Flex 中的 Blank 示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Flex() {
        Text('左对齐')
          .fontSize(16)
          .padding(12)
          .backgroundColor('#E3F2FD')
          .borderRadius(8)

        Blank()

        Text('右对齐')
          .fontSize(16)
          .padding(12)
          .backgroundColor('#28A745')
          .borderRadius(8)
      }
      .width('100%')
      .padding(20)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)
    }
    .width('100%')
    .padding(16)
  }
}

/**
 * 工具栏布局示例
 */
@ComponentV2
export struct ToolbarBlankExample {
  build() {
    Column({ space: 16 }) {
      Text('工具栏布局')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Flex() {
        Text('◀')
          .fontSize(24)
          .padding(12)

        Blank()

        Text('标题')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)

        Blank()

        Text('▶')
          .fontSize(24)
          .padding(12)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
      .shadow({ radius: 4, color: '#E0E0E0' })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 多个 Blank 组合示例
 */
@ComponentV2
export struct MultipleBlankExample {
  build() {
    Column({ space: 16 }) {
      Text('多个 Blank 组合')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Flex() {
        Text('左')
          .padding(12)
          .backgroundColor('#E3F2FD')
          .borderRadius(8)

        Blank()
          .color('#FFEBEE')

        Text('中')
          .padding(12)
          .backgroundColor('#FFF3E0')
          .borderRadius(8)

        Blank()
          .color('#E8F5E9')

        Text('右')
          .padding(12)
          .backgroundColor('#28A745')
          .borderRadius(8)
      }
      .width('100%')
      .height(80)
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)
    }
    .width('100%')
    .padding(16)
  }
}

/**
 * 卡片底部对齐示例
 */
@ComponentV2
export struct CardAlignExample {
  build() {
    Column({ space: 16 }) {
      Text('卡片底部按钮对齐')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Column() {
        Text('卡片标题')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 12 })

        Text('这是一段很长的卡片内容描述,卡片顶部是对齐的,底部的按钮通过 Blank 实现对齐。')
          .fontSize(14)
          .fontColor('#666666')
          .lineHeight(22)

        Blank()

        Button('操作按钮')
          .width('100%')
          .margin({ top: 16 })
      }
      .width('100%')
      .height(200)
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
      .shadow({ radius: 8, color: '#E0E0E0' })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 带颜色的 Blank 示例
 */
@ComponentV2
export struct ColoredBlankExample {
  build() {
    Column({ space: 16 }) {
      Text('带颜色的 Blank')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Flex() {
        Text('起点')
          .padding(12)
          .backgroundColor('#E3F2FD')
          .borderRadius(8)

        Blank()
          .color('#F5F5F5')

        Text('终点')
          .padding(12)
          .backgroundColor('#28A745')
          .borderRadius(8)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 导航栏布局示例
 */
@ComponentV2
export struct NavbarBlankExample {
  build() {
    Column({ space: 16 }) {
      Text('导航栏布局')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      // 标题居中导航栏
      Flex() {
        Text('返回')
          .fontSize(16)
          .padding(12)

        Blank()

        Text('页面标题')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)

        Blank()

        Text('更多')
          .fontSize(16)
          .padding(12)
      }
      .width('100%')
      .height(56)
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
      .shadow({ radius: 4, color: '#E0E0E0' })

      // 左侧图标导航栏
      Flex({ alignItems: ItemAlign.Center }) {
        Text('☰')
          .fontSize(24)
          .padding(12)

        Blank()

        Text('首页')
          .fontSize(16)
          .padding({ left: 12, right: 12 })
      }
      .width('100%')
      .height(56)
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
      .margin({ top: 12 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 表单布局示例
 */
@ComponentV2
export struct FormBlankExample {
  build() {
    Column({ space: 16 }) {
      Text('表单布局')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      // 用户名输入
      Flex({ alignItems: ItemAlign.Center }) {
        Text('用户名:')
          .fontSize(16)
          .width(80)

        Blank()

        Text('admin')
          .fontSize(16)
          .fontColor('#666666')
      }
      .width('100%')
      .height(48)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')
      .borderRadius(8)

      // 邮箱输入
      Flex({ alignItems: ItemAlign.Center }) {
        Text('邮箱:')
          .fontSize(16)
          .width(80)

        Blank()

        Text('admin@example.com')
          .fontSize(16)
          .fontColor('#666666')
      }
      .width('100%')
      .height(48)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')
      .borderRadius(8)
      .margin({ top: 8 })

      // 电话输入
      Flex({ alignItems: ItemAlign.Center }) {
        Text('电话:')
          .fontSize(16)
          .width(80)

        Blank()

        Text('13800138000')
          .fontSize(16)
          .fontColor('#666666')
      }
      .width('100%')
      .height(48)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')
      .borderRadius(8)
      .margin({ top: 8 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 设置页面布局示例
 */
@ComponentV2
export struct SettingsBlankExample {
  build() {
    Column({ space: 16 }) {
      Text('设置页面布局')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      // WiFi 设置
      Flex({ alignItems: ItemAlign.Center }) {
        Column({ space: 4 }) {
          Text('WiFi')
            .fontSize(16)
          Text('已连接')
            .fontSize(12)
            .fontColor('#999999')
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Text('已开启')
          .fontSize(14)
          .fontColor('#007DFF')
      }
      .width('100%')
      .height(64)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')
      .borderRadius(8)

      // 蓝牙设置
      Flex({ alignItems: ItemAlign.Center }) {
        Column({ space: 4 }) {
          Text('蓝牙')
            .fontSize(16)
          Text('关闭中')
            .fontSize(12)
            .fontColor('#999999')
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Text('关闭')
          .fontSize(14)
          .fontColor('#999999')
      }
      .width('100%')
      .height(64)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')
      .borderRadius(8)
      .margin({ top: 8 })

      // 通知设置
      Flex({ alignItems: ItemAlign.Center }) {
        Column({ space: 4 }) {
          Text('通知')
            .fontSize(16)
          Text('允许通知')
            .fontSize(12)
            .fontColor('#999999')
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Text('>')
          .fontSize(18)
          .fontColor('#CCCCCC')
      }
      .width('100%')
      .height(64)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')
      .borderRadius(8)
      .margin({ top: 8 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 底部操作栏示例
 */
@ComponentV2
export struct BottomBarBlankExample {
  @Local totalPrice: number = 5999

  build() {
    Column({ space: 16 }) {
      Text('底部操作栏')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Flex({ alignItems: ItemAlign.Center }) {
        Column({ space: 4 }) {
          Text('合计:')
            .fontSize(14)
            .fontColor('#666666')

          Text(`¥${this.totalPrice}`)
            .fontSize(20)
            .fontColor('#FF5722')
            .fontWeight(FontWeight.Bold)
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 16 })

        Blank()

        Button('立即购买')
          .height(40)
          .backgroundColor('#007DFF')
          .margin({ right: 16 })
      }
      .width('100%')
      .height(64)
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
      .shadow({ radius: 8, color: '#E0E0E0' })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 主页面
 */
@ComponentV2
export struct BlankExamplePage {
  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          Text('Blank Component Examples')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .padding({ left: 16, right: 16, top: 16, bottom: 8 })

          FlexBlankExample()
          ToolbarBlankExample()
          MultipleBlankExample()
          CardAlignExample()
          ColoredBlankExample()
          NavbarBlankExample()
          FormBlankExample()
          SettingsBlankExample()
          BottomBarBlankExample()
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
    }
    .title('Blank 空白填充')
    .mode(NavDestinationMode.STANDARD)
  }
}

@Builder
export function BlankExamplePageBuilder() {
  BlankExamplePage()
}
