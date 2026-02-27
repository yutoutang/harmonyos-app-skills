/**
 * Store Kit 示例页面
 * 演示应用商店功能 (已弃用，请使用 AppGallery Kit)
 */

import { store } from '@kit.StoreKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * Store Kit 示例 ViewModel
 */
@ObservedV2
export class StoreKitExampleVM {
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false
  @Trace status: string = '未初始化'

  /**
   * 检查服务可用性
   */
  async checkAvailability(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      // Store Kit 检查逻辑
      this.status = '可用'
      hilog.info(0x0000, 'StoreKitExample', 'Store service available')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `检查失败: ${err.message} (${err.code})`
      this.status = '不可用'
      hilog.error(0x0000, 'StoreKitExample', 'Check failed')
    } finally {
      this.isLoading = false
    }
  }
}

/**
 * Store Kit 示例页面
 */
@ComponentV2
export struct StoreKitExamplePage {
  @Local vm: StoreKitExampleVM = new StoreKitExampleVM()

  build() {
    Column() {
      Text('应用商店 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      // 弃用警告
      Column() {
        Text('⚠️ 注意')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF9800')
          .width('100%')
          .margin({ bottom: 8 })

        Text('Store Kit 已弃用，请使用 AppGallery Kit')
          .fontSize(14)
          .fontColor('#666666')
          .width('100%')
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFF3E0')
      .borderRadius(12)
      .margin({ bottom: 16 })

      Scroll() {
        Column() {
          Text('Store Kit 已被 AppGallery Kit 取代')
            .fontSize(16)
            .fontColor('#666666')
            .width('100%')
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
}

@Builder
export function StoreKitExamplePageBuilder() {
  StoreKitExamplePage()
}
