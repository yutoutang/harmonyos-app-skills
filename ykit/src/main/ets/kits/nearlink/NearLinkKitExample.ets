/**
 * NearLink Kit 示例页面
 * 演示星闪连接功能
 */

import { nearLink } from '@kit.NearLinkKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * NearLink Kit 示例 ViewModel
 */
@ObservedV2
export class NearLinkKitExampleVM {
  @Trace isConnected: boolean = false
  @Trace devices: string[] = []
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false

  /**
   * 扫描设备
   */
  async scanDevices(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.devices = ['设备A', '设备B', '设备C']
      hilog.info(0x0000, 'NearLinkExample', 'Devices scanned')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `扫描失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'NearLinkExample', 'Scan failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 连接设备
   */
  async connectDevice(deviceName: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.isConnected = true
      hilog.info(0x0000, 'NearLinkExample', 'Device connected')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `连接失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'NearLinkExample', 'Connect failed')
    } finally {
      this.isLoading = false
    }
  }
}

/**
 * NearLink Kit 示例页面
 */
@ComponentV2
export struct NearLinkKitExamplePage {
  @Local vm: NearLinkKitExampleVM = new NearLinkKitExampleVM()

  build() {
    Column() {
      Text('星闪 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 连接状态卡片
          this.buildStatusCard()

          // 设备列表卡片
          this.buildDevicesCard()

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
      Text('连接状态')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Row() {
        Circle()
          .width(12)
          .height(12)
          .fill(this.vm.isConnected ? '#4CAF50' : '#999999')
          .margin({ right: 8 })

        Text(this.vm.isConnected ? '已连接' : '未连接')
          .fontSize(14)
          .fontColor(this.vm.isConnected ? '#4CAF50' : '#999999')
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  buildDevicesCard() {
    Column() {
      Text('设备列表')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Button('扫描设备')
        .width('100%')
        .enabled(!this.vm.isLoading)
        .onClick(() => {
          this.vm.scanDevices()
        })

      if (this.vm.devices.length > 0) {
       ForEach(this.vm.devices, (device: string) => {
          Row() {
            Text(device)
              .fontSize(14)
              .layoutWeight(1)

            Button('连接')
              .fontSize(12)
              .enabled(!this.vm.isLoading && !this.vm.isConnected)
              .onClick(() => {
                this.vm.connectDevice(device)
              })
          }
          .width('100%')
          .padding(12)
          .backgroundColor('#F5F5F5')
          .borderRadius(8)
          .margin({ top: 8 })
        })
      }
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
export function NearLinkKitExamplePageBuilder() {
  NearLinkKitExamplePage()
}
