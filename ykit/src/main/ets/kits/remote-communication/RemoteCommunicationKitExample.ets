/**
 * Remote Communication Kit 示例页面
 * 演示远程通信功能
 */

import { remoteCommunication } from '@kit.RemoteCommunicationKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * Remote Communication Kit 示例 ViewModel
 */
@ObservedV2
export class RemoteCommunicationKitExampleVM {
  @Trace isConnected: boolean = false
  @Trace deviceName: string = ''
  @Trace communicationLogs: string[] = []
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false

  /**
   * 连接设备
   */
  async connectDevice(deviceId: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.isConnected = true
      this.deviceName = deviceId
      this.communicationLogs.unshift(`已连接到 ${deviceId}`)
      hilog.info(0x0000, 'RemoteCommExample', 'Device connected')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `连接失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'RemoteCommExample', 'Connect failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 断开连接
   */
  async disconnect(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.isConnected = false
      this.deviceName = ''
      this.communicationLogs.unshift('已断开连接')
      hilog.info(0x0000, 'RemoteCommExample', 'Disconnected')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `断开失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'RemoteCommExample', 'Disconnect failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 发送数据
   */
  async sendData(data: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.communicationLogs.unshift(`发送: ${data}`)
      hilog.info(0x0000, 'RemoteCommExample', 'Data sent')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `发送失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'RemoteCommExample', 'Send failed')
    } finally {
      this.isLoading = false
    }
  }
}

/**
 * Remote Communication Kit 示例页面
 */
@ComponentV2
export struct RemoteCommunicationKitExamplePage {
  @Local vm: RemoteCommunicationKitExampleVM = new RemoteCommunicationKitExampleVM()
  @Local deviceIdInput: string = 'device_001'
  @Local dataInput: string = 'Hello'

  build() {
    Column() {
      Text('远程通信 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 连接控制卡片
          this.buildConnectionCard()

          // 数据传输卡片
          if (this.vm.isConnected) {
            this.buildDataTransferCard()
          }

          // 通信日志卡片
          this.buildLogsCard()

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
  buildConnectionCard() {
    Column() {
      Text('设备连接')
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

        Text(this.vm.isConnected ? `已连接: ${this.vm.deviceName}` : '未连接')
          .fontSize(14)
          .fontColor(this.vm.isConnected ? '#4CAF50' : '#999999')
      }

      if (!this.vm.isConnected) {
        TextInput({ placeholder: '设备ID', text: this.deviceIdInput })
          .width('100%')
          .margin({ top: 12 })
          .onChange((value: string) => {
            this.deviceIdInput = value
          })
      }

      Button(this.vm.isConnected ? '断开连接' : '连接设备')
        .width('100%')
        .margin({ top: 12 })
        .enabled(!this.vm.isLoading)
        .onClick(() => {
          if (this.vm.isConnected) {
            this.vm.disconnect()
          } else {
            this.vm.connectDevice(this.deviceIdInput)
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

  @Builder
  buildDataTransferCard() {
    Column() {
      Text('数据传输')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      TextInput({ placeholder: '发送数据', text: this.dataInput })
        .width('100%')
        .margin({ bottom: 12 })
        .onChange((value: string) => {
          this.dataInput = value
        })

      Button('发送')
        .width('100%')
        .enabled(!this.vm.isLoading && this.dataInput.length > 0)
        .onClick(() => {
          this.vm.sendData(this.dataInput)
          this.dataInput = ''
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .margin({ top: 16 })
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  buildLogsCard() {
    Column() {
      Text('通信日志')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      if (this.vm.communicationLogs.length === 0) {
        Text('暂无日志')
          .fontSize(14)
          .fontColor('#999999')
      } else {
       ForEach(this.vm.communicationLogs.slice(0, 10), (log: string, index: number) => {
          Text(log)
            .fontSize(12)
            .width('100%')
            .padding(8)
            .backgroundColor('#F5F5F5')
            .borderRadius(4)
            .margin({ bottom: 4 })
        })
      }
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
export function RemoteCommunicationKitExamplePageBuilder() {
  RemoteCommunicationKitExamplePage()
}
