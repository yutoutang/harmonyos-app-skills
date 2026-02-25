/**
 * Stack Component Examples
 * OpenHarmony Stack 层叠布局组件使用示例
 */

@ComponentV2
export struct StackBasicExample {
  build() {
    Column({ space: 16 }) {
      Text('Stack 基础示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

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
  }
}

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
