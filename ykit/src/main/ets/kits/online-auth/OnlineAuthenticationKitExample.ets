/**
 * Online Authentication Kit 示例页面
 * 演示在线认证功能
 */

import { onlineAuthentication } from '@kit.OnlineAuthenticationKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * Online Authentication Kit 示例 ViewModel
 */
@ObservedV2
export class OnlineAuthenticationKitExampleVM {
  @Trace isAuthenticated: boolean = false
  @Trace authToken: string = ''
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false

  /**
   * 在线认证
   */
  async authenticate(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.isAuthenticated = true
      this.authToken = 'token_' + Date.now()
      hilog.info(0x0000, 'OnlineAuthExample', 'Authentication successful')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `认证失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'OnlineAuthExample', 'Authenticate failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 验证令牌
   */
  async verifyToken(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      // 验证逻辑
      hilog.info(0x0000, 'OnlineAuthExample', 'Token verified')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `验证失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'OnlineAuthExample', 'Verify failed')
    } finally {
      this.isLoading = false
    }
  }
}

/**
 * Online Authentication Kit 示例页面
 */
@ComponentV2
export struct OnlineAuthenticationKitExamplePage {
  @Local vm: OnlineAuthenticationKitExampleVM = new OnlineAuthenticationKitExampleVM()

  build() {
    Column() {
      Text('在线认证 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 认证状态卡片
          this.buildAuthStatusCard()

          // 令牌卡片
          if (this.vm.isAuthenticated) {
            this.buildTokenCard()
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
  buildAuthStatusCard() {
    Column() {
      Text('认证状态')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Row() {
        Circle()
          .width(12)
          .height(12)
          .fill(this.vm.isAuthenticated ? '#4CAF50' : '#999999')
          .margin({ right: 8 })

        Text(this.vm.isAuthenticated ? '已认证' : '未认证')
          .fontSize(14)
          .fontColor(this.vm.isAuthenticated ? '#4CAF50' : '#999999')
      }

      Button(this.vm.isAuthenticated ? '重新认证' : '开始认证')
        .width('100%')
        .margin({ top: 12 })
        .enabled(!this.vm.isLoading)
        .onClick(() => {
          this.vm.authenticate()
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
  buildTokenCard() {
    Column() {
      Text('认证令牌')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Text(this.vm.authToken)
        .fontSize(14)
        .fontColor('#666666')
        .width('100%')

      Button('验证令牌')
        .width('100%')
        .margin({ top: 12 })
        .enabled(!this.vm.isLoading)
        .onClick(() => {
          this.vm.verifyToken()
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
export function OnlineAuthenticationKitExamplePageBuilder() {
  OnlineAuthenticationKitExamplePage()
}
