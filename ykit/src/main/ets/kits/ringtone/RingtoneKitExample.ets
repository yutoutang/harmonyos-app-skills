/**
 * Ringtone Kit 示例页面
 * 演示铃声服务功能
 */

import { ringtone } from '@kit.RingtoneKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * Ringtone Kit 示例 ViewModel
 */
@ObservedV2
export class RingtoneKitExampleVM {
  @Trace currentRingtone: string = ''
  @Trace volume: number = 50
  @Trace isPlaying: boolean = false
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false

  /**
   * 设置铃声
   */
  async setRingtone(uri: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.currentRingtone = uri
      hilog.info(0x0000, 'RingtoneExample', 'Ringtone set')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `设置失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'RingtoneExample', 'Set failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 播放铃声
   */
  async playRingtone(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.isPlaying = true
      hilog.info(0x0000, 'RingtoneExample', 'Ringtone playing')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `播放失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'RingtoneExample', 'Play failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 停止铃声
   */
  async stopRingtone(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.isPlaying = false
      hilog.info(0x0000, 'RingtoneExample', 'Ringtone stopped')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `停止失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'RingtoneExample', 'Stop failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 设置音量
   */
  async setVolume(level: number): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.volume = level
      hilog.info(0x0000, 'RingtoneExample', `Volume set to ${level}`)
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `设置失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'RingtoneExample', 'Set volume failed')
    } finally {
      this.isLoading = false
    }
  }
}

/**
 * Ringtone Kit 示例页面
 */
@ComponentV2
export struct RingtoneKitExamplePage {
  @Local vm: RingtoneKitExampleVM = new RingtoneKitExampleVM()
  @Local uriInput: string = '/data/ringtones/default.mp3'

  build() {
    Column() {
      Text('铃声 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 铃声选择卡片
          this.buildRingtoneCard()

          // 播放控制卡片
          this.buildPlaybackCard()

          // 音量控制卡片
          this.buildVolumeCard()

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
  buildRingtoneCard() {
    Column() {
      Text('铃声设置')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      TextInput({ placeholder: '铃声URI', text: this.uriInput })
        .width('100%')
        .margin({ bottom: 12 })
        .onChange((value: string) => {
          this.uriInput = value
        })

      Button('设置铃声')
        .width('100%')
        .enabled(!this.vm.isLoading && this.uriInput.length > 0)
        .onClick(() => {
          this.vm.setRingtone(this.uriInput)
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
  buildPlaybackCard() {
    Column() {
      Text('播放控制')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Row() {
        Circle()
          .width(12)
          .height(12)
          .fill(this.vm.isPlaying ? '#4CAF50' : '#999999')
          .margin({ right: 8 })

        Text(this.vm.isPlaying ? '正在播放' : '未播放')
          .fontSize(14)
          .fontColor(this.vm.isPlaying ? '#4CAF50' : '#999999')
      }

      Row() {
        Button('播放')
          .flexGrow(1)
          .enabled(!this.vm.isLoading && !this.vm.isPlaying)
          .onClick(() => {
            this.vm.playRingtone()
          })

        Button('停止')
          .flexGrow(1)
          .margin({ left: 8 })
          .enabled(!this.vm.isLoading && this.vm.isPlaying)
          .backgroundColor('#FF3B30')
          .onClick(() => {
            this.vm.stopRingtone()
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
  }

  @Builder
  buildVolumeCard() {
    Column() {
      Text('音量控制')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Text(`音量: ${this.vm.volume}%`)
        .fontSize(14)
        .width('100%')
        .margin({ bottom: 12 })

      Slider({
        value: this.vm.volume,
        min: 0,
        max: 100,
        step: 1
      })
        .width('100%')
        .onChange((value: number) => {
          this.vm.setVolume(value)
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
export function RingtoneKitExamplePageBuilder() {
  RingtoneKitExamplePage()
}
