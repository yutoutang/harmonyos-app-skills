/**
 * Speech Kit 示例页面
 * 演示语音识别和语音合成功能
 *
 * 权限要求:
 * - ohos.permission.MICROPHONE (语音识别)
 * - ohos.permission.INTERNET (在线语音服务)
 */

import { speechRecognizer, speechSynthesizer } from '@kit.SpeechKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * 识别结果
 */
interface SpeechRecognitionResult {
  text: string
  confidence: number
  isFinal: boolean
}

/**
 * Speech Kit 示例 ViewModel
 */
@ObservedV2
export class SpeechKitExampleVM {
  @Trace recognitionResults: SpeechRecognitionResult[] = []
  @Trace synthesizedText: string = ''
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false
  @Trace isListening: boolean = false
  @Trace isSpeaking: boolean = false
  @Trace finalText: string = ''

  private recognizer?: speechRecognizer.SpeechRecognitionRecognizer
  private synthesizer?: speechSynthesizer.SpeechSynthesisRecognizer

  /**
   * 初始化语音识别器
   */
  async initRecognizer(): Promise<void> {
    try {
      const config: speechRecognizer.SpeechRecognitionConfig = {
        locale: 'zh-CN',
        mode: speechRecognizer.RecognitionMode.MODE_SHORT
      }

      this.recognizer = await speechRecognizer.createRecognizer(config)

      this.recognizer.on('result', (result) => {
        if (result.result === 'success') {
          this.finalText = result.text
          this.recognitionResults.push({
            text: result.text,
            confidence: 0.95,
            isFinal: result.isLast
          })
        }
      })

      this.recognizer.on('error', (error) => {
        this.errorMessage = `识别错误: ${error.message}`
        this.isListening = false
      })

      this.recognizer.on('end', () => {
        this.isListening = false
        hilog.info(0x0000, 'SpeechKitExample', 'Recognition ended')
      })

      hilog.info(0x0000, 'SpeechKitExample', 'Recognizer initialized')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `初始化失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'SpeechKitExample', 'Init recognizer failed')
    }
  }

  /**
   * 初始化语音合成器
   */
  async initSynthesizer(): Promise<void> {
    try {
      const config: speechSynthesizer.SpeechSynthesisConfig = {
        locale: 'zh-CN',
        rate: 1.0,
        pitch: 1.0
      }

      this.synthesizer = await speechSynthesizer.createSynthesizer(config)

      this.synthesizer.on('start', () => {
        this.isSpeaking = true
        hilog.info(0x0000, 'SpeechKitExample', 'Synthesis started')
      })

      this.synthesizer.on('end', () => {
        this.isSpeaking = false
        hilog.info(0x0000, 'SpeechKitExample', 'Synthesis ended')
      })

      this.synthesizer.on('error', (error) => {
        this.errorMessage = `合成错误: ${error.message}`
        this.isSpeaking = false
      })

      hilog.info(0x0000, 'SpeechKitExample', 'Synthesizer initialized')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `初始化失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'SpeechKitExample', 'Init synthesizer failed')
    }
  }

  /**
   * 开始语音识别
   */
  async startListening(): Promise<void> {
    if (!this.recognizer) {
      await this.initRecognizer()
    }

    this.isListening = true
    this.errorMessage = ''

    try {
      await this.recognizer!.startListening()
      hilog.info(0x0000, 'SpeechKitExample', 'Started listening')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `启动识别失败: ${err.message} (${err.code})`
      this.isListening = false
      hilog.error(0x0000, 'SpeechKitExample', 'Start listening failed')
    }
  }

  /**
   * 停止语音识别
   */
  async stopListening(): Promise<void> {
    if (!this.recognizer) return

    try {
      await this.recognizer.stopListening()
      this.isListening = false
      hilog.info(0x0000, 'SpeechKitExample', 'Stopped listening')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `停止识别失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'SpeechKitExample', 'Stop listening failed')
    }
  }

  /**
   * 语音合成
   */
  async speak(text: string): Promise<void> {
    if (!this.synthesizer) {
      await this.initSynthesizer()
    }

    this.synthesizedText = text
    this.errorMessage = ''

    try {
      await this.synthesizer!.speak(text)
      hilog.info(0x0000, 'SpeechKitExample', 'Started speaking')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `语音合成失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'SpeechKitExample', 'Speak failed')
    }
  }

  /**
   * 停止语音合成
   */
  async stopSpeaking(): Promise<void> {
    if (!this.synthesizer) return

    try {
      await this.synthesizer.stop()
      this.isSpeaking = false
      hilog.info(0x0000, 'SpeechKitExample', 'Stopped speaking')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `停止合成失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'SpeechKitExample', 'Stop speaking failed')
    }
  }

  /**
   * 清除识别记录
   */
  clearRecognitionResults(): void {
    this.recognitionResults = []
    this.finalText = ''
    hilog.info(0x0000, 'SpeechKitExample', 'Results cleared')
  }

  /**
   * 释放资源
   */
  async release(): Promise<void> {
    if (this.recognizer) {
      await this.recognizer.shutdown()
      this.recognizer = undefined
    }

    if (this.synthesizer) {
      await this.synthesizer.shutdown()
      this.synthesizer = undefined
    }

    hilog.info(0x0000, 'SpeechKitExample', 'Resources released')
  }
}

/**
 * Speech Kit 示例页面
 */
@ComponentV2
export struct SpeechKitExamplePage {
  @Local vm: SpeechKitExampleVM = new SpeechKitExampleVM()
  @Local textToSpeak: string = '欢迎使用华为语音服务'

  aboutToAppear(): void {
    this.vm.initRecognizer()
    this.vm.initSynthesizer()
  }

  aboutToDisappear(): void {
    this.vm.release()
  }

  build() {
    Column() {
      // 标题
      Text('语音 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 语音识别卡片
          this.buildRecognitionCard()

          // 语音合成卡片
          this.buildSynthesisCard()

          // 识别记录卡片
          this.buildResultCard()

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

      // 状态指示
      Row() {
        Circle()
          .width(12)
          .height(12)
          .fill(this.vm.isListening ? '#4CAF50' : '#999999')
          .margin({ right: 8 })

        Text(this.vm.isListening ? '正在聆听...' : '未开始')
          .fontSize(14)
          .fontColor(this.vm.isListening ? '#4CAF50' : '#999999')

        Blank()

        if (this.vm.isListening) {
          LoadingProgress()
            .width(20)
            .height(20)
        }
      }
      .width('100%')
      .margin({ bottom: 12 })

      // 控制按钮
      Row() {
        Button(this.vm.isListening ? '停止' : '开始识别')
          .width('100%')
          .backgroundColor(this.vm.isListening ? '#FF3B30' : '#007DFF')
          .onClick(() => {
            if (this.vm.isListening) {
              this.vm.stopListening()
            } else {
              this.vm.startListening()
            }
          })
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  buildSynthesisCard() {
    Column() {
      Text('语音合成')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      // 状态指示
      Row() {
        Circle()
          .width(12)
          .height(12)
          .fill(this.vm.isSpeaking ? '#4CAF50' : '#999999')
          .margin({ right: 8 })

        Text(this.vm.isSpeaking ? '正在朗读...' : '未开始')
          .fontSize(14)
          .fontColor(this.vm.isSpeaking ? '#4CAF50' : '#999999')
      }
      .width('100%')
      .margin({ bottom: 12 })

      // 文本输入
      TextArea({ placeholder: '输入要朗读的文本', text: this.textToSpeak })
        .width('100%')
        .height(80)
        .margin({ bottom: 12 })
        .onChange((value: string) => {
          this.textToSpeak = value
        })

      // 控制按钮
      Row() {
        Button('开始朗读')
          .flexGrow(1)
          .enabled(!this.vm.isSpeaking && this.textToSpeak.length > 0)
          .onClick(() => {
            this.vm.speak(this.textToSpeak)
          })

        Button('停止朗读')
          .flexGrow(1)
          .enabled(this.vm.isSpeaking)
          .backgroundColor('#FF3B30')
          .onClick(() => {
            this.vm.stopSpeaking()
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
  buildResultCard() {
    Column() {
      Row() {
        Text('识别记录')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)

        Blank()

        if (this.vm.recognitionResults.length > 0) {
          Button('清除')
            .fontSize(12)
            .onClick(() => {
              this.vm.clearRecognitionResults()
            })
        }
      }
      .width('100%')
      .margin({ bottom: 12 })

      if (this.vm.recognitionResults.length === 0) {
        Text('暂无识别记录')
          .fontSize(14)
          .fontColor('#999999')
      } else {
       ForEach(this.vm.recognitionResults, (result: SpeechRecognitionResult, index: number) => {
          Column() {
            Row() {
              Text(`#${index + 1}`)
                .fontSize(12)
                .fontColor('#999999')
                .margin({ right: 8 })

              Text(result.text)
                .fontSize(14)
                .layoutWeight(1)

              if (result.isFinal) {
                Text('最终')
                  .fontSize(10)
                  .fontColor('#4CAF50')
                  .padding({ left: 4, right: 4, top: 2, bottom: 2 })
                  .backgroundColor('#E8F5E9')
                  .borderRadius(4)
              }
            }
            .width('100%')

            Text(`置信度: ${(result.confidence * 100).toFixed(1)}%`)
              .fontSize(12)
              .fontColor('#666666')
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
export function SpeechKitExamplePageBuilder() {
  SpeechKitExamplePage()
}
