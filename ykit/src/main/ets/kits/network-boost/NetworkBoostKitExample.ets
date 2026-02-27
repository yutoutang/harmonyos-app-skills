/**
 * Network Boost Kit 示例页面
 * 演示网络加速功能
 */

import { networkBoost } from '@kit.NetworkBoostKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * Network Boost Kit 示例 ViewModel
 */
@ObservedV2
export class NetworkBoostKitExampleVM {
  @Trace isEnabled: boolean = false
  @Trace networkType: string = '未知'
  @Trace boostLevel: string = '无'
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false

  /**
   * 启用网络加速
   */
  async enableBoost(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.isEnabled = true
      this.boostLevel = '高'
      hilog.info(0x0000, 'NetworkBoostExample', 'Boost enabled')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `启用失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'NetworkBoostExample', 'Enable failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 禁用网络加速
   */
  async disableBoost(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.isEnabled = false
      this.boostLevel = '无'
      hilog.info(0x0000, 'NetworkBoostExample', 'Boost disabled')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `禁用失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'NetworkBoostExample', 'Disable failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 获取网络信息
   */
  async getNetworkInfo(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.networkType = '5G'
      hilog.info(0x0000, 'NetworkBoostExample', 'Network info obtained')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `获取失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'NetworkBoostExample', 'Get info failed')
    } finally {
      this.isLoading = false
    }
  }
}

/**
 * Network Boost Kit 示例页面
 */
@ComponentV2
export struct NetworkBoostKitExamplePage {
  @Local vm: NetworkBoostKitExampleVM = new NetworkBoostKitExampleVM()

  aboutToAppear(): void {
    this.vm.getNetworkInfo()
  }

  build() {
    Column() {
      Text('网络加速 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 网络信息卡片
          this.buildNetworkInfoCard()

          // 加速控制卡片
          this.buildBoostControlCard()

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
  buildNetworkInfoCard() {
    Column() {
      Text('网络信息')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Text(`网络类型: ${this.vm.networkType}`)
        .fontSize(14)
        .width('100%')

      Text(`加速级别: ${this.vm.boostLevel}`)
        .fontSize(14)
        .fontColor(this.vm.isEnabled ? '#4CAF50' : '#999999')
        .width('100%')
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  buildBoostControlCard() {
    Column() {
      Text('网络加速')
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

      Button(this.vm.isEnabled ? '禁用加速' : '启用加速')
        .width('100%')
        .margin({ top: 12 })
        .enabled(!this.vm.isLoading)
        .onClick(() => {
          if (this.vm.isEnabled) {
            this.vm.disableBoost()
          } else {
            this.vm.enableBoost()
          }
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .margin({ top: 16 })
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
export function NetworkBoostKitExamplePageBuilder() {
  NetworkBoostKitExamplePage()
}
