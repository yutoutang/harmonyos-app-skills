/**
 * Health Service Kit 示例页面
 * 演示健康服务功能
 *
 * 权限要求:
 * - ohos.permission.HEALTH_FUZZY
 * - ohos.permission.HEALTH_PRECISE
 */

import { healthService } from '@kit.HealthServiceKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * 健康数据
 */
interface HealthData {
  type: string
  value: number
  unit: string
  timestamp: number
}

/**
 * Health Service Kit 示例 ViewModel
 */
@ObservedV2
export class HealthServiceKitExampleVM {
  @Trace healthData: HealthData[] = []
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false
  @Trace isAuthorized: boolean = false

  /**
   * 请求健康数据权限
   */
  async requestPermission(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.isAuthorized = true
      hilog.info(0x0000, 'HealthServiceExample', 'Permission granted')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `权限请求失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'HealthServiceExample', 'Request failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 读取步数
   */
  async readStepCount(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      const data: HealthData = {
        type: '步数',
        value: 8500,
        unit: '步',
        timestamp: Date.now()
      }
      this.healthData.unshift(data)
      hilog.info(0x0000, 'HealthServiceExample', 'Step count read')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `读取失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'HealthServiceExample', 'Read failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 读取心率
   */
  async readHeartRate(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      const data: HealthData = {
        type: '心率',
        value: 72,
        unit: 'bpm',
        timestamp: Date.now()
      }
      this.healthData.unshift(data)
      hilog.info(0x0000, 'HealthServiceExample', 'Heart rate read')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `读取失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'HealthServiceExample', 'Read failed')
    } finally {
      this.isLoading = false
    }
  }
}

/**
 * Health Service Kit 示例页面
 */
@ComponentV2
export struct HealthServiceKitExamplePage {
  @Local vm: HealthServiceKitExampleVM = new HealthServiceKitExampleVM()

  build() {
    Column() {
      Text('健康服务 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 权限卡片
          this.buildPermissionCard()

          // 数据读取卡片
          if (this.vm.isAuthorized) {
            this.buildDataReaderCard()

            // 健康数据卡片
            this.buildHealthDataCard()
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
  buildPermissionCard() {
    Column() {
      Text('健康数据权限')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Row() {
        Circle()
          .width(12)
          .height(12)
          .fill(this.vm.isAuthorized ? '#4CAF50' : '#999999')
          .margin({ right: 8 })

        Text(this.vm.isAuthorized ? '已授权' : '未授权')
          .fontSize(14)
          .fontColor(this.vm.isAuthorized ? '#4CAF50' : '#999999')
      }

      Button('请求权限')
        .width('100%')
        .margin({ top: 12 })
        .enabled(!this.vm.isLoading && !this.vm.isAuthorized)
        .onClick(() => {
          this.vm.requestPermission()
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
  buildDataReaderCard() {
    Column() {
      Text('读取健康数据')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Row() {
        Button('步数')
          .flexGrow(1)
          .enabled(!this.vm.isLoading)
          .onClick(() => {
            this.vm.readStepCount()
          })

        Button('心率')
          .flexGrow(1)
          .margin({ left: 8 })
          .enabled(!this.vm.isLoading)
          .onClick(() => {
            this.vm.readHeartRate()
          })
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .margin({ top: 16 })
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  buildHealthDataCard() {
    Column() {
      Text('健康数据')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      if (this.vm.healthData.length === 0) {
        Text('暂无数据')
          .fontSize(14)
          .fontColor('#999999')
      } else {
       ForEach(this.vm.healthData, (data: HealthData, index: number) => {
          Column() {
            Row() {
              Text(data.type)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .layoutWeight(1)

              Text(`${data.value} ${data.unit}`)
                .fontSize(16)
                .fontColor('#007DFF')
                .fontWeight(FontWeight.Bold)
            }
            .width('100%')

            Text(`时间: ${new Date(data.timestamp).toLocaleString()}`)
              .fontSize(12)
              .fontColor('#999999')
              .width('100%')
              .margin({ top: 4 })
          }
          .width('100%')
          .padding(12)
          .backgroundColor('#F5F5F5')
          .borderRadius(8)
          .margin({ bottom: 8 })
          .alignItems(HorizontalAlign.Start)
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
export function HealthServiceKitExamplePageBuilder() {
  HealthServiceKitExamplePage()
}
