/**
 * Core Vision Kit 示例页面
 * 演示核心视觉服务功能
 */

import { coreVision } from '@kit.CoreVisionKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * Core Vision Kit 示例 ViewModel
 */
@ObservedV2
export class CoreVisionKitExampleVM {
  @Trace detectedObjects: string[] = []
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false
  @Trace imageUri: string = ''

  /**
   * 检测对象
   */
  async detectObjects(imageUri: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''
    this.detectedObjects = []

    try {
      // 模拟检测结果
      this.detectedObjects = ['人', '汽车', '建筑物']
      hilog.info(0x0000, 'CoreVisionExample', 'Objects detected')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `检测失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'CoreVisionExample', 'Detect failed')
    } finally {
      this.isLoading = false
    }
  }
}

/**
 * Core Vision Kit 示例页面
 */
@ComponentV2
export struct CoreVisionKitExamplePage {
  @Local vm: CoreVisionKitExampleVM = new CoreVisionKitExampleVM()
  @Local imageInput: string = ''

  build() {
    Column() {
      Text('核心视觉 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 图像输入卡片
          this.buildInputCard()

          // 检测结果卡片
          if (this.vm.detectedObjects.length > 0) {
            this.buildResultCard()
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
  buildInputCard() {
    Column() {
      Text('对象检测')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      TextInput({ placeholder: '图像 URI', text: this.imageInput })
        .width('100%')
        .margin({ bottom: 12 })
        .onChange((value: string) => {
          this.imageInput = value
        })

      Button('开始检测')
        .width('100%')
        .enabled(!this.vm.isLoading && this.imageInput.length > 0)
        .onClick(() => {
          this.vm.detectObjects(this.imageInput)
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
  buildResultCard() {
    Column() {
      Text('检测结果')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      ForEach(this.vm.detectedObjects, (obj: string, index: number) => {
        Text(`${index + 1}. ${obj}`)
          .fontSize(14)
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
export function CoreVisionKitExamplePageBuilder() {
  CoreVisionKitExamplePage()
}
