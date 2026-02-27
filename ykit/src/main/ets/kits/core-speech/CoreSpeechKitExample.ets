/**
 * Core Speech Kit 示例页面
 * 演示核心语音服务功能
 */

import { coreSpeech } from '@kit.CoreSpeechKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * Core Speech Kit 示例 ViewModel
 */
@ObservedV2
export class CoreSpeechKitExampleVM {
  @Trace isListening: boolean = false
  @Trace recognizedText: string = ''
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false

  /**
   * 开始语音识别
   */
  async startListening(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.isListening = true
      hilog.info(0x0000, 'CoreSpeechExample', 'Started listening')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `启动失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'CoreSpeechExample', 'Start failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 停止语音识别
   */
  async stopListening(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.isListening = false
      this.recognizedText = '识别到的文本示例'
      hilog.info(0x0000, 'CoreSpeechExample', 'Stopped listening')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `停止失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'CoreSpeechExample', 'Stop failed')
    } finally {
      this.isLoading = false
    }
  }
}

/**
 * Core Speech Kit 示例页面
 */
@ComponentV2
export struct CoreSpeechKitExamplePage {
  @Local vm: CoreSpeechKitExampleVM = new CoreSpeechKitExampleVM()

  build() {
    Column() {
      Text('核心语音 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 语音识别卡片
          this.buildRecognitionCard()

          // 识别结果卡片
          if (this.vm.recognizedText) {
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
  buildRecognitionCard() {
    Column() {
      Text('语音识别')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Row() {
        Circle()
          .width(12)
          .height(12)
          .fill(this.vm.isListening ? '#4CAF50' : '#999999')
          .margin({ right: 8 })

        Text(this.vm.isListening ? '正在聆听...' : '未开始')
          .fontSize(14)
          .fontColor(this.vm.isListening ? '#4CAF50' : '#999999')
      }

      Button(this.vm.isListening ? '停止识别' : '开始识别')
        .width('100%')
        .margin({ top: 12 })
        .enabled(!this.vm.isLoading)
        .onClick(() => {
          if (this.vm.isListening) {
            this.vm.stopListening()
          } else {
            this.vm.startListening()
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
  buildResultCard() {
    Column() {
      Text('识别结果')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Text(this.vm.recognizedText)
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
export function CoreSpeechKitExamplePageBuilder() {
  CoreSpeechKitExamplePage()
}
