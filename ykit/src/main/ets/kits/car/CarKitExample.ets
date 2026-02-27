/**
 * Car Kit 示例页面
 * 演示车载服务功能
 */

import { carService } from '@kit.CarKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * Car Kit 示例 ViewModel
 */
@ObservedV2
export class CarKitExampleVM {
  @Trace isConnected: boolean = false
  @Trace vehicleInfo: string = ''
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false

  /**
   * 连接车载设备
   */
  async connect(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      // 连接逻辑
      this.isConnected = true
      hilog.info(0x0000, 'CarKitExample', 'Connected to vehicle')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `连接失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'CarKitExample', 'Connect failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 获取车辆信息
   */
  async getVehicleInfo(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.vehicleInfo = '品牌: 华为 | 型号: 智选 | 车牌: 粤A12345'
      hilog.info(0x0000, 'CarKitExample', 'Vehicle info obtained')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `获取失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'CarKitExample', 'Get info failed')
    } finally {
      this.isLoading = false
    }
  }
}

/**
 * Car Kit 示例页面
 */
@ComponentV2
export struct CarKitExamplePage {
  @Local vm: CarKitExampleVM = new CarKitExampleVM()

  build() {
    Column() {
      Text('车载 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 连接状态
          this.buildConnectionCard()

          // 车辆信息
          if (this.vm.isConnected) {
            this.buildVehicleInfoCard()
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
  buildConnectionCard() {
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

      Button(this.vm.isConnected ? '断开连接' : '连接车辆')
        .width('100%')
        .margin({ top: 12 })
        .enabled(!this.vm.isLoading)
        .onClick(() => {
          if (this.vm.isConnected) {
            this.vm.isConnected = false
          } else {
            this.vm.connect()
          }
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  buildVehicleInfoCard() {
    Column() {
      Text('车辆信息')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      if (this.vm.vehicleInfo) {
        Text(this.vm.vehicleInfo)
          .fontSize(14)
          .width('100%')
      } else {
        Button('获取车辆信息')
          .width('100%')
          .enabled(!this.vm.isLoading)
          .onClick(() => {
            this.vm.getVehicleInfo()
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
export function CarKitExamplePageBuilder() {
  CarKitExamplePage()
}
