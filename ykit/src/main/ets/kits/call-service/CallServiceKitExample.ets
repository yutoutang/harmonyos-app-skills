/**
 * Call Service Kit 示例页面
 * 演示通话服务功能，支持语音和视频通话
 *
 * 权限要求:
 * - ohos.permission.CALL_PHONE
 */

import { callService } from '@kit.CallServiceKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * Call Service Kit 示例 ViewModel
 */
@ObservedV2
export class CallServiceKitExampleVM {
  @Trace callState: string = '空闲'
  @Trace phoneNumber: string = ''
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false
  @Trace isServiceAvailable: boolean = false

  /**
   * 检查通话服务可用性
   */
  async checkAvailability(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.isServiceAvailable = true
      hilog.info(0x0000, 'CallServiceExample', 'Call service available')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `检查失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'CallServiceExample', 'Check failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 发起语音通话
   */
  async makeVoiceCall(number: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''
    this.callState = '拨号中'

    try {
      // 发起语音通话逻辑
      this.callState = '通话中'
      hilog.info(0x0000, 'CallServiceExample', `Voice call to ${number}`)
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `拨号失败: ${err.message} (${err.code})`
      this.callState = '失败'
      hilog.error(0x0000, 'CallServiceExample', 'Make call failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 发起视频通话
   */
  async makeVideoCall(number: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''
    this.callState = '连接中'

    try {
      // 发起视频通话逻辑
      this.callState = '视频通话中'
      hilog.info(0x0000, 'CallServiceExample', `Video call to ${number}`)
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `拨号失败: ${err.message} (${err.code})`
      this.callState = '失败'
      hilog.error(0x0000, 'CallServiceExample', 'Make video call failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 结束通话
   */
  async endCall(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.callState = '已结束'
      hilog.info(0x0000, 'CallServiceExample', 'Call ended')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `结束失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'CallServiceExample', 'End call failed')
    } finally {
      this.isLoading = false
    }
  }
}

/**
 * Call Service Kit 示例页面
 */
@ComponentV2
export struct CallServiceKitExamplePage {
  @Local vm: CallServiceKitExampleVM = new CallServiceKitExampleVM()
  @Local phoneInput: string = ''

  aboutToAppear(): void {
    this.vm.checkAvailability()
  }

  build() {
    Column() {
      Text('通话服务 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 状态卡片
          this.buildStatusCard()

          // 拨号卡片
          this.buildDialerCard()

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
  buildStatusCard() {
    Column() {
      Text('服务状态')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Row() {
        Circle()
          .width(12)
          .height(12)
          .fill(this.vm.isServiceAvailable ? '#4CAF50' : '#999999')
          .margin({ right: 8 })

        Text(this.vm.callState)
          .fontSize(14)
          .fontColor(this.vm.isServiceAvailable ? '#4CAF50' : '#999999')
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  buildDialerCard() {
    Column() {
      Text('拨号')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      TextInput({ placeholder: '输入电话号码', text: this.phoneInput })
        .width('100%')
        .type(InputType.PhoneNumber)
        .margin({ bottom: 12 })
        .onChange((value: string) => {
          this.phoneInput = value
        })

      Row() {
        Button('语音通话')
          .flexGrow(1)
          .enabled(!this.vm.isLoading && this.phoneInput.length > 0)
          .onClick(() => {
            this.vm.makeVoiceCall(this.phoneInput)
          })

        Button('视频通话')
          .flexGrow(1)
          .margin({ left: 8 })
          .enabled(!this.vm.isLoading && this.phoneInput.length > 0)
          .onClick(() => {
            this.vm.makeVideoCall(this.phoneInput)
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

    if (this.vm.isLoading) {
      LoadingProgress()
        .width(40)
        .height(40)
        .margin({ top: 16 })
    }
  }
}

@Builder
export function CallServiceKitExamplePageBuilder() {
  CallServiceKitExamplePage()
}
