/**
 * Device Security Kit 示例页面
 * 演示设备安全功能
 */

import { deviceSecurity } from '@kit.DeviceSecurityKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * Device Security Kit 示例 ViewModel
 */
@ObservedV2
export class DeviceSecurityKitExampleVM {
  @Trace securityLevel: string = '未知'
  @Trace isDeviceSecure: boolean = false
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false

  /**
   * 检查设备安全状态
   */
  async checkSecurity(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.isDeviceSecure = true
      this.securityLevel = '高'
      hilog.info(0x0000, 'DeviceSecurityExample', 'Security checked')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `检查失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'DeviceSecurityExample', 'Check failed')
    } finally {
      this.isLoading = false
    }
  }
}

/**
 * Device Security Kit 示例页面
 */
@ComponentV2
export struct DeviceSecurityKitExamplePage {
  @Local vm: DeviceSecurityKitExampleVM = new DeviceSecurityKitExampleVM()

  build() {
    Column() {
      Text('设备安全 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 安全状态卡片
          this.buildSecurityCard()

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
  buildSecurityCard() {
    Column() {
      Text('设备安全状态')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Row() {
        Circle()
          .width(12)
          .height(12)
          .fill(this.vm.isDeviceSecure ? '#4CAF50' : '#FF3B30')
          .margin({ right: 8 })

        Text(this.vm.isDeviceSecure ? '设备安全' : '设备不安全')
          .fontSize(14)
          .fontColor(this.vm.isDeviceSecure ? '#4CAF50' : '#FF3B30')
      }

      Text(`安全等级: ${this.vm.securityLevel}`)
        .fontSize(14)
        .fontColor('#666666')
        .width('100%')
        .margin({ top: 8 })

      Button('检查安全状态')
        .width('100%')
        .margin({ top: 12 })
        .enabled(!this.vm.isLoading)
        .onClick(() => {
          this.vm.checkSecurity()
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
export function DeviceSecurityKitExamplePageBuilder() {
  DeviceSecurityKitExamplePage()
}
