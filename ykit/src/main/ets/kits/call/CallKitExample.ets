/**
 * Call Kit 示例页面
 * 演示通话功能 (已弃用，建议使用 CallService Kit)
 *
 * 权限要求:
 * - ohos.permission.PLACE_CALL
 * - ohos.permission.CALL_PHONE
 */

import { call } from '@kit.CallKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * Call Kit 示例 ViewModel
 */
@ObservedV2
export class CallKitExampleVM {
  @Trace phoneNumber: string = ''
  @Trace callState: string = '空闲'
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false

  /**
   * 拨打电话
   */
  async makeCall(number: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''
    this.callState = '拨号中'

    try {
      await call.makeCall(number, {
        accountId: '',
        videoState: 0
      })

      this.callState = '通话中'
      hilog.info(0x0000, 'CallKitExample', `Call initiated to ${number}`)
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `拨号失败: ${err.message} (${err.code})`
      this.callState = '失败'
      hilog.error(0x0000, 'CallKitExample', 'Make call failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 格式化电话号码
   */
  formatPhoneNumber(number: string): string {
    // 移除非数字字符
    return number.replace(/\D/g, '')
  }
}

/**
 * Call Kit 示例页面
 */
@ComponentV2
export struct CallKitExamplePage {
  @Local vm: CallKitExampleVM = new CallKitExampleVM()
  @Local phoneInput: string = ''

  build() {
    Column() {
      // 标题
      Text('通话 Kit 示例')
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

        Text('Call Kit 已弃用，请使用 CallService Kit')
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
          // 拨号卡片
          this.buildDialerCard()

          // 状态卡片
          this.buildStatusCard()

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
  buildDialerCard() {
    Column() {
      Text('拨号')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      // 电话输入
      TextInput({ placeholder: '输入电话号码', text: this.phoneInput })
        .width('100%')
        .type(InputType.PhoneNumber)
        .maxLength(15)
        .margin({ bottom: 12 })
        .onChange((value: string) => {
          this.phoneInput = value
        })

      // 拨号按钮
      Button('拨打电话')
        .width('100%')
        .enabled(!this.vm.isLoading && this.phoneInput.length > 0)
        .onClick(() => {
          const number = this.vm.formatPhoneNumber(this.phoneInput)
          if (number.length > 0) {
            this.vm.makeCall(number)
          }
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  buildStatusCard() {
    Column() {
      Text('通话状态')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Row() {
        Circle()
          .width(12)
          .height(12)
          .fill(this.vm.callState === '通话中' ? '#4CAF50' : '#999999')
          .margin({ right: 8 })

        Text(this.vm.callState)
          .fontSize(14)
          .fontColor(this.vm.callState === '通话中' ? '#4CAF50' : '#999999')
      }
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
export function CallKitExamplePageBuilder() {
  CallKitExamplePage()
}
