/**
 * AppGallery Kit 示例页面
 * 演示华为应用市场功能，包括应用详情、评分、评论等
 */

import { appGallery } from '@kit.AppGalleryKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * 应用信息
 */
interface AppInfo {
  appName: string
  packageName: string
  version: string
  developer: string
  rating: number
  downloadCount: number
}

/**
 * AppGallery Kit 示例 ViewModel
 */
@ObservedV2
export class AppGalleryKitExampleVM {
  @Trace appInfo: AppInfo | null = null
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false
  @Trace isAvailable: boolean = false

  /**
   * 检查应用市场是否可用
   */
  async checkAvailability(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.isAvailable = await appGallery.isAppGalleryAvailable()
      hilog.info(0x0000, 'AppGalleryKitExample', 'Availability checked')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `检查失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'AppGalleryKitExample', 'Check failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 显示应用详情页
   */
  async showAppDetails(packageName: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      await appGallery.showAppDetails(packageName)
      hilog.info(0x0000, 'AppGalleryKitExample', `App details shown for ${packageName}`)
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `打开失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'AppGalleryKitExample', 'Show details failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 显示应用评分页面
   */
  async showRatingPage(packageName: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      await appGallery.showAppRating(packageName)
      hilog.info(0x0000, 'AppGalleryKitExample', 'Rating page shown')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `打开失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'AppGalleryKitExample', 'Show rating failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 显示应用评论列表
   */
  async showReviews(packageName: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      await appGallery.showAppReviews(packageName)
      hilog.info(0x0000, 'AppGalleryKitExample', 'Reviews shown')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `打开失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'AppGalleryKitExample', 'Show reviews failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 搜索应用
   */
  async searchApps(keyword: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      await appGallery.searchApps(keyword)
      hilog.info(0x0000, 'AppGalleryKitExample', `Search for ${keyword}`)
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `搜索失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'AppGalleryKitExample', 'Search failed')
    } finally {
      this.isLoading = false
    }
  }
}

/**
 * AppGallery Kit 示例页面
 */
@ComponentV2
export struct AppGalleryKitExamplePage {
  @Local vm: AppGalleryKitExampleVM = new AppGalleryKitExampleVM()
  @Local packageNameInput: string = 'com.huawei.appmarket'
  @Local searchKeyword: string = ''

  aboutToAppear(): void {
    this.vm.checkAvailability()
  }

  build() {
    Column() {
      // 标题
      Text('应用市场 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 状态卡片
          this.buildStatusCard()

          // 应用详情卡片
          this.buildAppDetailsCard()

          // 搜索卡片
          this.buildSearchCard()

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
          .fill(this.vm.isAvailable ? '#4CAF50' : '#999999')
          .margin({ right: 8 })

        Text(this.vm.isAvailable ? '应用市场可用' : '应用市场不可用')
          .fontSize(14)
          .fontColor(this.vm.isAvailable ? '#4CAF50' : '#999999')
      }

      Button('刷新状态')
        .width('100%')
        .margin({ top: 12 })
        .enabled(!this.vm.isLoading)
        .onClick(() => {
          this.vm.checkAvailability()
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  buildAppDetailsCard() {
    Column() {
      Text('应用操作')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      TextInput({ placeholder: '应用包名', text: this.packageNameInput })
        .width('100%')
        .margin({ bottom: 12 })
        .onChange((value: string) => {
          this.packageNameInput = value
        })

      Column() {
        Button('查看应用详情')
          .width('100%')
          .enabled(!this.vm.isLoading && this.vm.isAvailable)
          .onClick(() => {
            this.vm.showAppDetails(this.packageNameInput)
          })

        Button('查看评分')
          .width('100%')
          .margin({ top: 8 })
          .enabled(!this.vm.isLoading && this.vm.isAvailable)
          .onClick(() => {
            this.vm.showRatingPage(this.packageNameInput)
          })

        Button('查看评论')
          .width('100%')
          .margin({ top: 8 })
          .enabled(!this.vm.isLoading && this.vm.isAvailable)
          .onClick(() => {
            this.vm.showReviews(this.packageNameInput)
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
  buildSearchCard() {
    Column() {
      Text('搜索应用')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Row() {
        TextInput({ placeholder: '搜索关键词', text: this.searchKeyword })
          .width('100%')
          .layoutWeight(1)
          .onChange((value: string) => {
            this.searchKeyword = value
          })

        Button('搜索')
          .enabled(!this.vm.isLoading && this.vm.isAvailable && this.searchKeyword.length > 0)
          .onClick(() => {
            this.vm.searchApps(this.searchKeyword)
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
export function AppGalleryKitExamplePageBuilder() {
  AppGalleryKitExamplePage()
}
