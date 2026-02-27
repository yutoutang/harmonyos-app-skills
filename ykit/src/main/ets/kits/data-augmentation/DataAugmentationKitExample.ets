/**
 * Data Augmentation Kit 示例页面
 * 演示数据增强功能
 */

import { dataAugmentation } from '@kit.DataAugmentationKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * Data Augmentation Kit 示例 ViewModel
 */
@ObservedV2
export class DataAugmentationKitExampleVM {
  @Trace augmentedData: string = ''
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false
  @Trace originalData: string = ''

  /**
   * 数据增强
   */
  async augmentData(data: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.originalData = data
      this.augmentedData = `增强后: ${data} (已处理)`
      hilog.info(0x0000, 'DataAugmentationExample', 'Data augmented')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `增强失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'DataAugmentationExample', 'Augment failed')
    } finally {
      this.isLoading = false
    }
  }
}

/**
 * Data Augmentation Kit 示例页面
 */
@ComponentV2
export struct DataAugmentationKitExamplePage {
  @Local vm: DataAugmentationKitExampleVM = new DataAugmentationKitExampleVM()
  @Local dataInput: string = '示例数据'

  build() {
    Column() {
      Text('数据增强 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 数据输入卡片
          this.buildInputCard()

          // 结果卡片
          if (this.vm.augmentedData) {
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
      Text('数据增强')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      TextInput({ placeholder: '输入数据', text: this.dataInput })
        .width('100%')
        .margin({ bottom: 12 })
        .onChange((value: string) => {
          this.dataInput = value
        })

      Button('开始增强')
        .width('100%')
        .enabled(!this.vm.isLoading && this.dataInput.length > 0)
        .onClick(() => {
          this.vm.augmentData(this.dataInput)
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
      Text('增强结果')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Text(`原始数据: ${this.vm.originalData}`)
        .fontSize(14)
        .fontColor('#666666')
        .width('100%')
        .margin({ bottom: 8 })

      Text(this.vm.augmentedData)
        .fontSize(14)
        .width('100%')
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
export function DataAugmentationKitExamplePageBuilder() {
  DataAugmentationKitExamplePage()
}
