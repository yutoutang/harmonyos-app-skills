/**
 * 华为账号 Kit 示例页面
 * 演示华为账号登录、用户信息获取、退出登录等功能
 */

import {
  authentication,
  LoginWithHuaweiIDButton
} from '@kit.AccountKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * 账号信息模型
 */
interface AuthAccountInfo {
  id: string
  displayName: string
  avatarUri: string
  email?: string
  phone?: string
}

/**
 * 华为账号示例 ViewModel
 */
@ObservedV2
export class AccountKitExampleVM {
  @Trace isLoggedIn: boolean = false
  @Trace isLoading: boolean = false
  @Trace userInfo: AuthAccountInfo | null = null
  @Trace errorMessage: string = ''

  /**
   * 检查登录状态
   */
  async checkLoginStatus(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      const authAccount = await authentication.getAuthAccount()
      this.isLoggedIn = true
      this.userInfo = {
        id: authAccount.id,
        displayName: authAccount.displayName,
        avatarUri: authAccount.avatarUri
      }
    } catch (error) {
      this.isLoggedIn = false
      this.userInfo = null
      hilog.info(0x0000, 'AccountKitExample', 'User not logged in')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 华为账号登录
   */
  async login(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      const result = await authentication.authenticate({
        forceLogin: false,
        requestAuthToken: true,
        requestAccessToken: true
      })

      this.isLoggedIn = true
      hilog.info(0x0000, 'AccountKitExample', 'Login success: %{public}s',
        JSON.stringify(result))

      // 获取用户信息
      await this.loadUserInfo()
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `登录失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'AccountKitExample',
        'Login failed: %{public}d, %{public}s', err.code, err.message)
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 加载用户信息
   */
  async loadUserInfo(): Promise<void> {
    try {
      const authAccount = await authentication.getAuthAccount()
      this.userInfo = {
        id: authAccount.id,
        displayName: authAccount.displayName,
        avatarUri: authAccount.avatarUri
      }
    } catch (error) {
      hilog.error(0x0000, 'AccountKitExample', 'Load user info failed')
    }
  }

  /**
   * 退出登录
   */
  async logout(): Promise<void> {
    this.isLoading = true

    try {
      await authentication.logout()
      this.isLoggedIn = false
      this.userInfo = null
      hilog.info(0x0000, 'AccountKitExample', 'Logout success')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `退出失败: ${err.message}`
      hilog.error(0x0000, 'AccountKitExample', 'Logout failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 获取访问令牌
   */
  async getAccessToken(): Promise<void> {
    try {
      const token = await authentication.getAccessToken()
      hilog.info(0x0000, 'AccountKitExample', 'Access token obtained')
      return token
    } catch (error) {
      hilog.error(0x0000, 'AccountKitExample', 'Get access token failed')
      return ''
    }
  }
}

/**
 * 华为账号 Kit 示例页面
 */
@ComponentV2
export struct AccountKitExamplePage {
  @Local vm: AccountKitExampleVM = new AccountKitExampleVM()

  aboutToAppear(): void {
    this.vm.checkLoginStatus()
  }

  build() {
    Column() {
      // 标题
      Text('华为账号 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      // 登录按钮
      if (!this.vm.isLoggedIn) {
        LoginWithHuaweiIDButton({
          onClicked: (event) => {
            if (event.errorCode === 0) {
              this.vm.checkLoginStatus()
            } else {
              this.vm.errorMessage = `登录失败: ${event.errorCode}`
            }
          }
        })
          .width('80%')
          .height(48)
          .margin({ bottom: 16 })

        // 手动登录按钮
        Button('手动登录')
          .width('80%')
          .enabled(!this.vm.isLoading)
          .onClick(() => {
            this.vm.login()
          })
      }

      // 用户信息卡片
      if (this.vm.isLoggedIn && this.vm.userInfo) {
        Column() {
          // 用户头像
          Image(this.vm.userInfo.avatarUri)
            .width(80)
            .height(80)
            .borderRadius(40)
            .margin({ bottom: 12 })

          // 用户名
          Text(this.vm.userInfo.displayName)
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 8 })

          // 用户ID
          Text(`ID: ${this.vm.userInfo.id}`)
            .fontSize(14)
            .fontColor('#999999')
            .margin({ bottom: 16 })

          // 退出登录按钮
          Button('退出登录')
            .width('60%')
            .backgroundColor('#FF3B30')
            .enabled(!this.vm.isLoading)
            .onClick(() => {
              this.vm.logout()
            })
        }
        .width('100%')
        .padding(20)
        .backgroundColor('#F5F5F5')
        .borderRadius(12)
        .margin({ top: 20 })
      }

      // 错误信息
      if (this.vm.errorMessage) {
        Text(this.vm.errorMessage)
          .fontSize(14)
          .fontColor('#FF3B30')
          .margin({ top: 16 })
      }

      // 加载指示器
      if (this.vm.isLoading) {
        LoadingProgress()
          .width(40)
          .height(40)
          .margin({ top: 20 })
      }

      Blank()
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
  }
}

/**
 * 页面构建器
 */
@Builder
export function AccountKitExamplePageBuilder() {
  AccountKitExamplePage()
}
