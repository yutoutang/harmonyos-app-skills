/**
 * Status Bar Extension Kit 示例页面
 * 演示状态栏扩展功能 (已弃用)
 */

import { statusBarExtension } from '@kit.StatusBarExtensionKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * Status Bar Extension Kit 示例 ViewModel
 */
@ObservedV2
export class StatusBarExtensionKitExampleVM {
  @Trace isEnabled: boolean = false
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false

  /**
   * 启用状态栏扩展
   */
  async enableExtension(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.isEnabled = true
      hilog.info(0x0000, 'StatusBarExtensionExample', 'Extension enabled')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `启用失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'StatusBarExtensionExample', 'Enable failed')
    } finally {
      this.isLoading = false
    }
  }
}

/**
 * Status Bar Extension Kit 示例页面
 */
@ComponentV2
export struct StatusBarExtensionKitExamplePage {
  @Local vm: StatusBarExtensionKitExampleVM = new StatusBarExtensionKitExampleVM()

  build() {
    Column() {
      Text('状态栏扩展 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      // 弃用警告
      Column() {
        Text('⚠️ 注意')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF9800')
          .width('100%')
          .margin({ bottom: 8 })

        Text('StatusBar Extension Kit 已弃用')
          .fontSize(14)
          .fontColor('#666666')
          .width('100%')
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFF3E0')
      .borderRadius(12)
      .margin({ bottom: 16 })

      Scroll() {
        Column() {
          Text('状态栏扩展功能已被系统级 API 取代')
            .fontSize(16)
            .fontColor('#666666')
            .width('100%')

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
}

@Builder
export function StatusBarExtensionKitExamplePageBuilder() {
  StatusBarExtensionKitExamplePage()
}
