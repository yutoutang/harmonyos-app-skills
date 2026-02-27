/**
 * Intents Kit 示例页面
 * 演示意图服务功能
 */

import { intents } from '@kit.IntentsKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * Intents Kit 示例 ViewModel
 */
@ObservedV2
export class IntentsKitExampleVM {
  @Trace intentResults: string[] = []
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false

  /**
   * 发送意图
   */
  async sendIntent(action: string, data: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      const result = `意图: ${action} | 数据: ${data}`
      this.intentResults.unshift(result)
      hilog.info(0x0000, 'IntentsExample', 'Intent sent')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `发送失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'IntentsExample', 'Send failed')
    } finally {
      this.isLoading = false
    }
  }
}

/**
 * Intents Kit 示例页面
 */
@ComponentV2
export struct IntentsKitExamplePage {
  @Local vm: IntentsKitExampleVM = new IntentsKitExampleVM()
  @Local actionInput: string = 'android.intent.action.VIEW'
  @Local dataInput: string = 'https://example.com'

  build() {
    Column() {
      Text('意图 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 发送意图卡片
          this.buildSendIntentCard()

          // 意图结果卡片
          if (this.vm.intentResults.length > 0) {
            this.buildResultsCard()
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
  buildSendIntentCard() {
    Column() {
      Text('发送意图')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      TextInput({ placeholder: 'Action', text: this.actionInput })
        .width('100%')
        .margin({ bottom: 12 })
        .onChange((value: string) => {
          this.actionInput = value
        })

      TextInput({ placeholder: 'Data/URI', text: this.dataInput })
        .width('100%')
        .margin({ bottom: 12 })
        .onChange((value: string) => {
          this.dataInput = value
        })

      Button('发送意图')
        .width('100%')
        .enabled(!this.vm.isLoading && this.actionInput.length > 0)
        .onClick(() => {
          this.vm.sendIntent(this.actionInput, this.dataInput)
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
  buildResultsCard() {
    Column() {
      Text('意图历史')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      ForEach(this.vm.intentResults, (result: string, index: number) => {
        Text(`${index + 1}. ${result}`)
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
export function IntentsKitExamplePageBuilder() {
  IntentsKitExamplePage()
}
