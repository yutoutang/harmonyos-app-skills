/**
 * Cloud Foundation Kit 示例页面
 * 演示云基础服务功能
 */

import { cloudFoundation } from '@kit.CloudFoundationKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * Cloud Foundation Kit 示例 ViewModel
 */
@ObservedV2
export class CloudFoundationKitExampleVM {
  @Trace isConnected: boolean = false
  @Trace cloudStorage: string = ''
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false

  /**
   * 初始化云服务
   */
  async initializeCloud(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.isConnected = true
      hilog.info(0x0000, 'CloudFoundationExample', 'Cloud initialized')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `初始化失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'CloudFoundationExample', 'Initialize failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 同步数据
   */
  async syncData(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.cloudStorage = '同步时间: ' + new Date().toLocaleString()
      hilog.info(0x0000, 'CloudFoundationExample', 'Data synced')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `同步失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'CloudFoundationExample', 'Sync failed')
    } finally {
      this.isLoading = false
    }
  }
}

/**
 * Cloud Foundation Kit 示例页面
 */
@ComponentV2
export struct CloudFoundationKitExamplePage {
  @Local vm: CloudFoundationKitExampleVM = new CloudFoundationKitExampleVM()

  build() {
    Column() {
      Text('云基础 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 初始化卡片
          this.buildInitCard()

          // 同步卡片
          if (this.vm.isConnected) {
            this.buildSyncCard()
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
  buildInitCard() {
    Column() {
      Text('云服务状态')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Row() {
        Circle()
          .width(12)
          .height(12)
          .fill(this.vm.isConnected ? '#4CAF50' : '#999999')
          .margin({ right: 8 })

        Text(this.vm.isConnected ? '已连接' : '未连接')
          .fontSize(14)
          .fontColor(this.vm.isConnected ? '#4CAF50' : '#999999')
      }

      Button('初始化云服务')
        .width('100%')
        .margin({ top: 12 })
        .enabled(!this.vm.isLoading)
        .onClick(() => {
          this.vm.initializeCloud()
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  buildSyncCard() {
    Column() {
      Text('数据同步')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Button('同步数据')
        .width('100%')
        .enabled(!this.vm.isLoading)
        .onClick(() => {
          this.vm.syncData()
        })

      if (this.vm.cloudStorage) {
        Text(this.vm.cloudStorage)
          .fontSize(14)
          .fontColor('#666666')
          .width('100%')
          .margin({ top: 12 })
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
export function CloudFoundationKitExamplePageBuilder() {
  CloudFoundationKitExamplePage()
}
