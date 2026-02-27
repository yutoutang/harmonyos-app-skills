/**
 * App Linking Kit 示例页面
 * 演示应用链接功能，支持跨应用深度链接
 */

import { appLinking } from '@kit.AppLinkingKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * App Linking Kit 示例 ViewModel
 */
@ObservedV2
export class AppLinkingKitExampleVM {
  @Trace linkingUrl: string = ''
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false
  @Trace isAvailable: boolean = false

  /**
   * 检查 App Linking 可用性
   */
  async checkAvailability(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.isAvailable = true
      hilog.info(0x0000, 'AppLinkingExample', 'App Linking available')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `检查失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'AppLinkingExample', 'Check failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 创建 App Linking
   */
  async createLinking(uri: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      // 创建 App Linking 逻辑
      this.linkingUrl = `https://example.dl.alibaba.com/${uri}`
      hilog.info(0x0000, 'AppLinkingExample', 'Linking created')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `创建失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'AppLinkingExample', 'Create failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 处理接收的 App Linking
   */
  async handleLinking(url: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      // 处理 App Linking 逻辑
      hilog.info(0x0000, 'AppLinkingExample', `Linking handled: ${url}`)
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `处理失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'AppLinkingExample', 'Handle failed')
    } finally {
      this.isLoading = false
    }
  }
}

/**
 * App Linking Kit 示例页面
 */
@ComponentV2
export struct AppLinkingKitExamplePage {
  @Local vm: AppLinkingKitExampleVM = new AppLinkingKitExampleVM()
  @Local uriInput: string = 'product/detail'

  aboutToAppear(): void {
    this.vm.checkAvailability()
  }

  build() {
    Column() {
      Text('应用链接 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 创建链接卡片
          this.buildCreateLinkingCard()

          // 显示链接卡片
          if (this.vm.linkingUrl) {
            this.buildDisplayLinkingCard()
          }

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
  buildCreateLinkingCard() {
    Column() {
      Text('创建 App Linking')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      TextInput({ placeholder: 'URI 路径', text: this.uriInput })
        .width('100%')
        .margin({ bottom: 12 })
        .onChange((value: string) => {
          this.uriInput = value
        })

      Button('创建链接')
        .width('100%')
        .enabled(!this.vm.isLoading && this.vm.isAvailable)
        .onClick(() => {
          this.vm.createLinking(this.uriInput)
        })
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
  buildDisplayLinkingCard() {
    Column() {
      Text('生成的链接')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Text(this.vm.linkingUrl)
        .fontSize(14)
        .fontColor('#007DFF')
        .width('100%')

      Button('复制链接')
        .width('100%')
        .margin({ top: 12 })
        .onClick(() => {
          // 复制到剪贴板
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
export function AppLinkingKitExamplePageBuilder() {
  AppLinkingKitExamplePage()
}
