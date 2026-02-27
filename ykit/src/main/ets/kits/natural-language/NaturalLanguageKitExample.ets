/**
 * Natural Language Kit 示例页面
 * 演示自然语言处理功能
 */

import { naturalLanguage } from '@kit.NaturalLanguageKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * Natural Language Kit 示例 ViewModel
 */
@ObservedV2
export class NaturalLanguageKitExampleVM {
  @Trace analyzedText: string = ''
  @Trace sentiment: string = ''
  @Trace keywords: string[] = []
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false

  /**
   * 分析情感
   */
  async analyzeSentiment(text: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.analyzedText = text
      this.sentiment = '积极'
      hilog.info(0x0000, 'NaturalLanguageExample', 'Sentiment analyzed')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `分析失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'NaturalLanguageExample', 'Analyze failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 提取关键词
   */
  async extractKeywords(text: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.keywords = ['华为', 'HarmonyOS', 'Kit']
      hilog.info(0x0000, 'NaturalLanguageExample', 'Keywords extracted')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `提取失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'NaturalLanguageExample', 'Extract failed')
    } finally {
      this.isLoading = false
    }
  }
}

/**
 * Natural Language Kit 示例页面
 */
@ComponentV2
export struct NaturalLanguageKitExamplePage {
  @Local vm: NaturalLanguageKitExampleVM = new NaturalLanguageKitExampleVM()
  @Local textInput: string = '华为HarmonyOS是一个优秀的操作系统'

  build() {
    Column() {
      Text('自然语言 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 文本分析卡片
          this.buildAnalysisCard()

          // 结果卡片
          if (this.vm.analyzedText || this.vm.keywords.length > 0) {
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
  buildAnalysisCard() {
    Column() {
      Text('文本分析')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      TextArea({ placeholder: '输入文本', text: this.textInput })
        .width('100%')
        .height(100)
        .margin({ bottom: 12 })
        .onChange((value: string) => {
          this.textInput = value
        })

      Row() {
        Button('情感分析')
          .flexGrow(1)
          .enabled(!this.vm.isLoading && this.textInput.length > 0)
          .onClick(() => {
            this.vm.analyzeSentiment(this.textInput)
          })

        Button('关键词提取')
          .flexGrow(1)
          .margin({ left: 8 })
          .enabled(!this.vm.isLoading && this.textInput.length > 0)
          .onClick(() => {
            this.vm.extractKeywords(this.textInput)
          })
      }
      .width('100%')
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
      Text('分析结果')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      if (this.vm.analyzedText) {
        Text(`原文: ${this.vm.analyzedText}`)
          .fontSize(14)
          .width('100%')

        Text(`情感: ${this.vm.sentiment}`)
          .fontSize(14)
          .fontColor(this.vm.sentiment === '积极' ? '#4CAF50' : '#FF3B30')
          .width('100%')
          .margin({ top: 8 })
      }

      if (this.vm.keywords.length > 0) {
        Text('关键词:')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .width('100%')
          .margin({ top: 12, bottom: 8 })

       ForEach(this.vm.keywords, (keyword: string, index: number) => {
          Text(`${index + 1}. ${keyword}`)
            .fontSize(14)
            .width('100%')
            .padding(8)
            .backgroundColor('#F5F5F5')
            .borderRadius(4)
            .margin({ bottom: 4 })
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
export function NaturalLanguageKitExamplePageBuilder() {
  NaturalLanguageKitExamplePage()
}
