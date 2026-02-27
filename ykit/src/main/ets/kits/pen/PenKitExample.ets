/**
 * Pen Kit 示例页面
 * 演示手写笔功能
 */

import { pen } from '@kit.PenKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * 手写笔数据
 */
interface PenData {
  x: number
  y: number
  pressure: number
  timestamp: number
}

/**
 * Pen Kit 示例 ViewModel
 */
@ObservedV2
export class PenKitExampleVM {
  @Trace isPenSupported: boolean = false
  @Trace penData: PenData[] = []
  @Trace currentPressure: number = 0
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false

  /**
   * 检查手写笔支持
   */
  async checkSupport(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.isPenSupported = true
      hilog.info(0x0000, 'PenExample', 'Pen support checked')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `检查失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'PenExample', 'Check failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 记录手写笔数据
   */
  recordPenData(x: number, y: number, pressure: number): void {
    const data: PenData = {
      x: x,
      y: y,
      pressure: pressure,
      timestamp: Date.now()
    }
    this.penData.push(data)
    this.currentPressure = pressure
  }

  /**
   * 清除数据
   */
  clearData(): void {
    this.penData = []
    this.currentPressure = 0
    hilog.info(0x0000, 'PenExample', 'Data cleared')
  }
}

/**
 * Pen Kit 示例页面
 */
@ComponentV2
export struct PenKitExamplePage {
  @Local vm: PenKitExampleVM = new PenKitExampleVM()

  aboutToAppear(): void {
    this.vm.checkSupport()
  }

  build() {
    Column() {
      Text('手写笔 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 支持状态卡片
          this.buildSupportCard()

          // 手写区域卡片
          if (this.vm.isPenSupported) {
            this.buildDrawingCard()
          }

          // 数据卡片
          if (this.vm.penData.length > 0) {
            this.buildDataCard()
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
  buildSupportCard() {
    Column() {
      Text('手写笔支持')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Row() {
        Circle()
          .width(12)
          .height(12)
          .fill(this.vm.isPenSupported ? '#4CAF50' : '#999999')
          .margin({ right: 8 })

        Text(this.vm.isPenSupported ? '支持' : '不支持')
          .fontSize(14)
          .fontColor(this.vm.isPenSupported ? '#4CAF50' : '#999999')
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  buildDrawingCard() {
    Column() {
      Text('手写区域')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      // 模拟手写区域
      Column() {
        Text('在此区域书写')
          .fontSize(14)
          .fontColor('#999999')

        Text(`压感: ${this.vm.currentPressure.toFixed(2)}`)
          .fontSize(12)
          .fontColor('#666666')
          .margin({ top: 8 })
      }
      .width('100%')
      .height(300)
      .backgroundColor('#F0F0F0')
      .borderRadius(8)
      .justifyContent(FlexAlign.Center)

      Row() {
        Button('模拟书写')
          .flexGrow(1)
          .enabled(!this.vm.isLoading)
          .onClick(() => {
            this.vm.recordPenData(Math.random() * 300, Math.random() * 300, Math.random())
          })

        Button('清除')
          .flexGrow(1)
          .margin({ left: 8 })
          .enabled(!this.vm.isLoading)
          .onClick(() => {
            this.vm.clearData()
          })
      }
      .width('100%')
      .margin({ top: 12 })
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

  @Builder
  buildDataCard() {
    Column() {
      Row() {
        Text('手写数据')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)

        Blank()

        Text(`共 ${this.vm.penData.length} 点`)
          .fontSize(14)
          .fontColor('#999999')
      }
      .width('100%')
      .margin({ bottom: 12 })

      ForEach(this.vm.penData.slice(-5), (data: PenData, index: number) => {
        Text(`点 ${this.vm.penData.length - 5 + index + 1}: (${data.x.toFixed(1)}, ${data.y.toFixed(1)}) 压感: ${data.pressure.toFixed(2)}`)
          .fontSize(12)
          .width('100%')
          .padding(8)
          .backgroundColor('#F5F5F5')
          .borderRadius(4)
          .margin({ bottom: 4 })
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
export function PenKitExamplePageBuilder() {
  PenKitExamplePage()
}
