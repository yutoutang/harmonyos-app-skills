/**
 * Desktop Extension Kit 示例页面
 * 演示桌面扩展功能
 */

import { desktopExtension } from '@kit.DesktopExtensionKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * Desktop Extension Kit 示例 ViewModel
 */
@ObservedV2
export class DesktopExtensionKitExampleVM {
  @Trace isEnabled: boolean = false
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false

  /**
   * 启用桌面扩展
   */
  async enableExtension(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.isEnabled = true
      hilog.info(0x0000, 'DesktopExtensionExample', 'Extension enabled')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `启用失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'DesktopExtensionExample', 'Enable failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 禁用桌面扩展
   */
  async disableExtension(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.isEnabled = false
      hilog.info(0x0000, 'DesktopExtensionExample', 'Extension disabled')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `禁用失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'DesktopExtensionExample', 'Disable failed')
    } finally {
      this.isLoading = false
    }
  }
}

/**
 * Desktop Extension Kit 示例页面
 */
@ComponentV2
export struct DesktopExtensionKitExamplePage {
  @Local vm: DesktopExtensionKitExampleVM = new DesktopExtensionKitExampleVM()

  build() {
    Column() {
      Text('桌面扩展 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 状态卡片
          this.buildStatusCard()

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
  buildStatusCard() {
    Column() {
      Text('桌面扩展状态')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Row() {
        Circle()
          .width(12)
          .height(12)
          .fill(this.vm.isEnabled ? '#4CAF50' : '#999999')
          .margin({ right: 8 })

        Text(this.vm.isEnabled ? '已启用' : '未启用')
          .fontSize(14)
          .fontColor(this.vm.isEnabled ? '#4CAF50' : '#999999')
      }

      Button(this.vm.isEnabled ? '禁用扩展' : '启用扩展')
        .width('100%')
        .margin({ top: 12 })
        .enabled(!this.vm.isLoading)
        .onClick(() => {
          if (this.vm.isEnabled) {
            this.vm.disableExtension()
          } else {
            this.vm.enableExtension()
          }
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
}

@Builder
export function DesktopExtensionKitExamplePageBuilder() {
  DesktopExtensionKitExamplePage()
}
