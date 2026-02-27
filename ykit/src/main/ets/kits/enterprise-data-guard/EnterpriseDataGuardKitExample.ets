/**
 * Enterprise Data Guard Kit 示例页面
 * 演示企业数据保护功能
 */

import { enterpriseDataGuard } from '@kit.EnterpriseDataGuardKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * Enterprise Data Guard Kit 示例 ViewModel
 */
@ObservedV2
export class EnterpriseDataGuardKitExampleVM {
  @Trace isProtected: boolean = false
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false

  /**
   * 启用数据保护
   */
  async enableProtection(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.isProtected = true
      hilog.info(0x0000, 'EnterpriseDataGuardExample', 'Protection enabled')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `启用失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'EnterpriseDataGuardExample', 'Enable failed')
    } finally {
      this.isLoading = false
    }
  }
}

/**
 * Enterprise Data Guard Kit 示例页面
 */
@ComponentV2
export struct EnterpriseDataGuardKitExamplePage {
  @Local vm: EnterpriseDataGuardKitExampleVM = new EnterpriseDataGuardKitExampleVM()

  build() {
    Column() {
      Text('企业数据保护 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 保护状态卡片
          this.buildProtectionCard()

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
  buildProtectionCard() {
    Column() {
      Text('数据保护状态')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Row() {
        Circle()
          .width(12)
          .height(12)
          .fill(this.vm.isProtected ? '#4CAF50' : '#999999')
          .margin({ right: 8 })

        Text(this.vm.isProtected ? '已启用保护' : '未启用保护')
          .fontSize(14)
          .fontColor(this.vm.isProtected ? '#4CAF50' : '#999999')
      }

      Button('启用数据保护')
        .width('100%')
        .margin({ top: 12 })
        .enabled(!this.vm.isLoading && !this.vm.isProtected)
        .onClick(() => {
          this.vm.enableProtection()
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
export function EnterpriseDataGuardKitExamplePageBuilder() {
  EnterpriseDataGuardKitExamplePage()
}
