/**
 * Wear Engine Kit 示例页面
 * 演示穿戴引擎功能
 */

import { wearEngine } from '@kit.WearEngineKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * 穿戴设备信息
 */
interface WearDevice {
  id: string
  name: string
  type: string
  isConnected: boolean
}

/**
 * Wear Engine Kit 示例 ViewModel
 */
@ObservedV2
export class WearEngineExampleVM {
  @Trace devices: WearDevice[] = []
  @Trace isConnected: boolean = false
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false

  /**
   * 扫描设备
   */
  async scanDevices(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.devices = [
        { id: 'watch_001', name: '华为 Watch GT', type: '智能手表', isConnected: false },
        { id: 'band_001', name: '华为手环 6', type: '智能手环', isConnected: false }
      ]
      hilog.info(0x0000, 'WearEngineExample', 'Devices scanned')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `扫描失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'WearEngineExample', 'Scan failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 连接设备
   */
  async connectDevice(deviceId: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      const device = this.devices.find(d => d.id === deviceId)
      if (device) {
        device.isConnected = true
        this.isConnected = true
      }
      hilog.info(0x0000, 'WearEngineExample', 'Device connected')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `连接失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'WearEngineExample', 'Connect failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 断开设备
   */
  async disconnectDevice(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.devices.forEach(d => d.isConnected = false)
      this.isConnected = false
      hilog.info(0x0000, 'WearEngineExample', 'Device disconnected')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `断开失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'WearEngineExample', 'Disconnect failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 同步数据
   */
  async syncData(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      hilog.info(0x0000, 'WearEngineExample', 'Data synced')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `同步失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'WearEngineExample', 'Sync failed')
    } finally {
      this.isLoading = false
    }
  }
}

/**
 * Wear Engine Kit 示例页面
 */
@ComponentV2
export struct WearEngineExamplePage {
  @Local vm: WearEngineExampleVM = new WearEngineExampleVM()

  aboutToAppear(): void {
    this.vm.scanDevices()
  }

  build() {
    Column() {
      Text('穿戴引擎 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 设备列表卡片
          this.buildDevicesCard()

          // 数据同步卡片
          if (this.vm.isConnected) {
            this.buildSyncCard()
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
  buildDevicesCard() {
    Column() {
      Row() {
        Text('穿戴设备')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)

        Blank()

        Button('扫描')
          .fontSize(12)
          .enabled(!this.vm.isLoading)
          .onClick(() => {
            this.vm.scanDevices()
          })
      }
      .width('100%')
      .margin({ bottom: 12 })

      if (this.vm.devices.length === 0) {
        Text('暂无设备')
          .fontSize(14)
          .fontColor('#999999')
      } else {
       ForEach(this.vm.devices, (device: WearDevice) => {
          Row() {
            Column() {
              Text(device.name)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)

              Text(device.type)
                .fontSize(12)
                .fontColor('#666666')
                .margin({ top: 4 })
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            if (device.isConnected) {
              Text('已连接')
                .fontSize(12)
                .fontColor('#4CAF50')
                .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                .backgroundColor('#E8F5E9')
                .borderRadius(4)
            } else {
              Button('连接')
                .fontSize(12)
                .enabled(!this.vm.isLoading)
                .onClick(() => {
                  this.vm.connectDevice(device.id)
                })
            }
          }
          .width('100%')
          .padding(12)
          .backgroundColor('#F5F5F5')
          .borderRadius(8)
          .margin({ bottom: 8 })
        })
      }
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
  buildSyncCard() {
    Column() {
      Text('数据同步')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Button('同步数据')
        .width('100%')
        .enabled(!this.vm.isLoading)
        .onClick(() => {
          this.vm.syncData()
        })

      Button('断开连接')
        .width('100%')
        .margin({ top: 8 })
        .backgroundColor('#FF3B30')
        .enabled(!this.vm.isLoading)
        .onClick(() => {
          this.vm.disconnectDevice()
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
export function WearEngineExamplePageBuilder() {
  WearEngineExamplePage()
}
