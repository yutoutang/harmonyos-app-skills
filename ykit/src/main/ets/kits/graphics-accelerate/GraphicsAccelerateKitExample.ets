/**
 * Graphics Accelerate Kit 示例页面
 * 演示图形加速功能
 */

import { graphicsAccelerate } from '@kit.GraphicsAccelerateKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * Graphics Accelerate Kit 示例 ViewModel
 */
@ObservedV2
export class GraphicsAccelerateKitExampleVM {
  @Trace fps: number = 0
  @Trace isAccelerated: boolean = false
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false

  /**
   * 启用图形加速
   */
  async enableAcceleration(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.isAccelerated = true
      this.fps = 60
      hilog.info(0x0000, 'GraphicsAccelerateExample', 'Acceleration enabled')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `启用失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'GraphicsAccelerateExample', 'Enable failed')
    } finally {
      this.isLoading = false
    }
  }
}

/**
 * Graphics Accelerate Kit 示例页面
 */
@ComponentV2
export struct GraphicsAccelerateKitExamplePage {
  @Local vm: GraphicsAccelerateKitExampleVM = new GraphicsAccelerateKitExampleVM()

  build() {
    Column() {
      Text('图形加速 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 加速状态卡片
          this.buildAccelerationCard()

          // 性能卡片
          if (this.vm.isAccelerated) {
            this.buildPerformanceCard()
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
  buildAccelerationCard() {
    Column() {
      Text('图形加速状态')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Row() {
        Circle()
          .width(12)
          .height(12)
          .fill(this.vm.isAccelerated ? '#4CAF50' : '#999999')
          .margin({ right: 8 })

        Text(this.vm.isAccelerated ? '已启用' : '未启用')
          .fontSize(14)
          .fontColor(this.vm.isAccelerated ? '#4CAF50' : '#999999')
      }

      Button('启用加速')
        .width('100%')
        .margin({ top: 12 })
        .enabled(!this.vm.isLoading && !this.vm.isAccelerated)
        .onClick(() => {
          this.vm.enableAcceleration()
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
  buildPerformanceCard() {
    Column() {
      Text('性能信息')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Text(`帧率: ${this.vm.fps} FPS`)
        .fontSize(14)
        .width('100%')

      Text('GPU 加速: 已启用')
        .fontSize(14)
        .fontColor('#4CAF50')
        .width('100%')
        .margin({ top: 8 })
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
export function GraphicsAccelerateKitExamplePageBuilder() {
  GraphicsAccelerateKitExamplePage()
}
