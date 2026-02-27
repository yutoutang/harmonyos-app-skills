/**
 * Screen Time Guard Kit 示例页面
 * 演示屏幕时间守护功能
 */

import { screenTimeGuard } from '@kit.ScreenTimeGuardKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * Screen Time Guard Kit 示例 ViewModel
 */
@ObservedV2
export class ScreenTimeGuardKitExampleVM {
  @Trace isEnabled: boolean = false
  @Trace dailyLimit: number = 120
  @Trace usedTime: number = 45
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false

  /**
   * 启用屏幕时间守护
   */
  async enableGuard(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.isEnabled = true
      hilog.info(0x0000, 'ScreenTimeGuardExample', 'Guard enabled')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `启用失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'ScreenTimeGuardExample', 'Enable failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 设置每日限制
   */
  async setDailyLimit(minutes: number): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.dailyLimit = minutes
      hilog.info(0x0000, 'ScreenTimeGuardExample', `Daily limit set to ${minutes}`)
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `设置失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'ScreenTimeGuardExample', 'Set limit failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 获取使用时间
   */
  async getUsageTime(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      // 模拟获取使用时间
      hilog.info(0x0000, 'ScreenTimeGuardExample', 'Usage time obtained')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `获取失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'ScreenTimeGuardExample', 'Get usage failed')
    } finally {
      this.isLoading = false
    }
  }
}

/**
 * Screen Time Guard Kit 示例页面
 */
@ComponentV2
export struct ScreenTimeGuardKitExamplePage {
  @Local vm: ScreenTimeGuardKitExampleVM = new ScreenTimeGuardKitExampleVM()

  build() {
    Column() {
      Text('屏幕时间守护 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 守护状态卡片
          this.buildGuardStatusCard()

          // 时间统计卡片
          if (this.vm.isEnabled) {
            this.buildTimeStatsCard()
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
  buildGuardStatusCard() {
    Column() {
      Text('屏幕时间守护')
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

      Button(this.vm.isEnabled ? '禁用守护' : '启用守护')
        .width('100%')
        .margin({ top: 12 })
        .enabled(!this.vm.isLoading)
        .onClick(() => {
          if (this.vm.isEnabled) {
            this.vm.isEnabled = false
          } else {
            this.vm.enableGuard()
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
  buildTimeStatsCard() {
    Column() {
      Text('时间统计')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      // 进度条
      Progress({ value: this.vm.usedTime, total: this.vm.dailyLimit, type: ProgressType.Linear })
        .width('100%')
        .margin({ bottom: 8 })

      Row() {
        Text(`已使用: ${this.vm.usedTime} 分钟`)
          .fontSize(14)
          .layoutWeight(1)

        Text(`限制: ${this.vm.dailyLimit} 分钟`)
          .fontSize(14)
          .fontColor('#666666')
      }
      .width('100%')

      // 设置限制
      Text(`设置每日限制 (分钟)`)
        .fontSize(14)
        .width('100%')
        .margin({ top: 16, bottom: 8 })

      Slider({
        value: this.vm.dailyLimit,
        min: 30,
        max: 300,
        step: 10
      })
        .width('100%')
        .onChange((value: number) => {
          this.vm.setDailyLimit(value)
        })

      Button('刷新使用时间')
        .width('100%')
        .margin({ top: 12 })
        .enabled(!this.vm.isLoading)
        .onClick(() => {
          this.vm.getUsageTime()
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
export function ScreenTimeGuardKitExamplePageBuilder() {
  ScreenTimeGuardKitExamplePage()
}
