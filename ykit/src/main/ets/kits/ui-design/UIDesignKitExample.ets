/**
 * UI Design Kit (HDS) 示例页面
 * 演示华为设计系统 (HDS) 组件和样式
 */

import { uiDesign } from '@kit.UIDesignKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * UI Design Kit 示例 ViewModel
 */
@ObservedV2
export class UIDesignKitExampleVM {
  @Trace theme: string = '默认'
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false

  /**
   * 应用主题
   */
  async applyTheme(themeName: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.theme = themeName
      hilog.info(0x0000, 'UIDesignExample', `Theme ${themeName} applied`)
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `应用失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'UIDesignExample', 'Apply theme failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 获取设计令牌
   */
  async getDesignTokens(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      // 获取设计令牌逻辑
      hilog.info(0x0000, 'UIDesignExample', 'Design tokens obtained')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `获取失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'UIDesignExample', 'Get tokens failed')
    } finally {
      this.isLoading = false
    }
  }
}

/**
 * UI Design Kit 示例页面
 */
@ComponentV2
export struct UIDesignKitExamplePage {
  @Local vm: UIDesignKitExampleVM = new UIDesignKitExampleVM()

  build() {
    Column() {
      Text('UI 设计 Kit (HDS) 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 主题选择卡片
          this.buildThemeCard()

          // HDS 组件展示卡片
          this.buildComponentsCard()

          // 错误信息
          if (this.vm.errorMessage) {
            Text(this.vm.errorMessage)
              .fontSize(14)
              .fontColor('#FF3B30')
              .margin({ top: 16 })
          }
        }
        .width('100%')
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
  }

  @Builder
  buildThemeCard() {
    Column() {
      Text('HDS 主题')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Text(`当前主题: ${this.vm.theme}`)
        .fontSize(14)
        .width('100%')
        .margin({ bottom: 12 })

      Row() {
        Button('默认')
          .fontSize(14)
          .onClick(() => {
            this.vm.applyTheme('默认')
          })

        Button('深色')
          .fontSize(14)
          .margin({ left: 8 })
          .onClick(() => {
            this.vm.applyTheme('深色')
          })

        Button('高对比')
          .fontSize(14)
          .margin({ left: 8 })
          .onClick(() => {
            this.vm.applyTheme('高对比')
          })
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .alignItems(HorizontalAlign.Start)

    if (this.vm.isLoading) {
      LoadingProgress()
        .width(40)
        .height(40)
        .margin({ top: 16 })
    }
  }

  @Builder
  buildComponentsCard() {
    Column() {
      Text('HDS 组件展示')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      // 按钮样式
      Column() {
        Text('按钮')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .width('100%')
          .margin({ bottom: 8 })

        Row() {
          Button('主要按钮')
            .fontSize(14)
            .backgroundColor('#007DFF')
            .onClick(() => {})

          Button('次要按钮')
            .fontSize(14)
            .backgroundColor('#E0E0E0')
            .fontColor('#333333')
            .margin({ left: 8 })
            .onClick(() => {})
        }
        .width('100%')
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)
      .margin({ bottom: 12 })

      // 输入框样式
      Column() {
        Text('输入框')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .width('100%')
          .margin({ bottom: 8 })

        TextInput({ placeholder: 'HDS 输入框样式' })
          .width('100%')
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      Button('获取设计令牌')
        .width('100%')
        .margin({ top: 16 })
        .enabled(!this.vm.isLoading)
        .onClick(() => {
          this.vm.getDesignTokens()
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .margin({ top: 16 })
    .alignItems(HorizontalAlign.Start)
  }
}

@Builder
export function UIDesignKitExamplePageBuilder() {
  UIDesignKitExamplePage()
}
