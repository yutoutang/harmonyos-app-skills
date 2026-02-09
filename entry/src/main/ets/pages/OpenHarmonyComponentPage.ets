/**
 * OpenHarmony Component Examples Page
 * 鸿蒙原生组件示例页面
 *
 * 展示各种 OpenHarmony 原生组件的使用示例
 */

// 导入按钮示例组件
import {
  ButtonTypesExample,
  ButtonStyleModeExample,
  ButtonRoleExample,
  ControlSizeExample,
  LabelStyleExample,
  StateEffectExample,
  CustomContentExample,
  LoadingButtonExample,
  ButtonGroupExample
} from '../components/button/ButtonExamples'

/**
 * 组件项数据接口
 */
interface ComponentItem {
  id: string
  name: string
  description: string
  targetPage: string
}

@ComponentV2
struct OpenHarmonyComponentPage {
  @Param navPathStack: NavPathStack = new NavPathStack()

  // 组件列表
  @Local componentList: ComponentItem[] = [
    {
      id: 'button',
      name: 'Button 按钮',
      description: '展示 Button 组件的多种类型和样式',
      targetPage: 'ButtonExamplePage'
    }
  ]

  // 当前显示的示例页面
  @Local showButtonExamples: boolean = false

  build() {
    if (this.showButtonExamples) {
      // 显示按钮示例
      this.ButtonExamplesContent()
    } else {
      // 显示组件列表
      NavDestination() {
        Column() {
          // 页面标题
          this.HeaderBuilder()

          // 组件列表
          Scroll() {
            Column({ space: 12 }) {
              ForEach(this.componentList, (item: ComponentItem) => {
                this.ComponentCardBuilder(item)
              }, (item: ComponentItem) => item.id)
            }
            .width('100%')
            .padding({ left: 16, right: 16, bottom: 16 })
          }
          .width('100%')
          .layoutWeight(1)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#F5F5F5')
      }
      .title('OpenHarmony 组件')
      .mode(NavDestinationMode.STANDARD)
    }
  }

  /**
   * 按钮示例内容
   */
  @Builder
  ButtonExamplesContent() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          // 返回按钮
          Row() {
            Button() {
              Row({ space: 8 }) {
                Text('\uE610') // 返回箭头
                  .fontSize(20)
                  .fontColor('#007DFF')
                Text('返回')
                  .fontSize(16)
                  .fontColor('#007DFF')
              }
            }
            .type(ButtonType.Normal)
            .backgroundColor(Color.Transparent)
            .onClick(() => {
              this.showButtonExamples = false
            })
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 16 })

          // 标题
          Text('Button Component Examples')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .padding({ left: 16, right: 16, top: 8, bottom: 8 })

          // 按钮示例组件
          ButtonTypesExample()
          ButtonStyleModeExample()
          ButtonRoleExample()
          ControlSizeExample()
          LabelStyleExample()
          StateEffectExample()
          CustomContentExample()
          LoadingButtonExample()
          ButtonGroupExample()
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
    }
    .title('Button 示例')
    .mode(NavDestinationMode.STANDARD)
  }

  /**
   * 页面头部构建器
   */
  @Builder
  HeaderBuilder() {
    Column() {
      Text('OpenHarmony 原生组件')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')

      Text('探索鸿蒙系统原生 UI 组件的使用方法')
        .fontSize(14)
        .fontColor('#666666')
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
  }

  /**
   * 组件卡片构建器
   */
  @Builder
  ComponentCardBuilder(item: ComponentItem) {
    Column() {
      Row() {
        Column({ space: 8 }) {
          Text(item.name)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')

          Text(item.description)
            .fontSize(14)
            .fontColor('#999999')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Text('\uE6E0') // 右箭头图标
          .fontSize(20)
          .fontColor('#CCCCCC')
      }
      .width('100%')
      .padding(16)
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .onClick(() => {
      this.navigateToComponentPage(item)
    })
  }

  /**
   * 导航到组件示例页面
   */
  navigateToComponentPage(item: ComponentItem) {
    if (item.targetPage === 'ButtonExamplePage') {
      this.showButtonExamples = true
    }
  }
}

export { OpenHarmonyComponentPage }
