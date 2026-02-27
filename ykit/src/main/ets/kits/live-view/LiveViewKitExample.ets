/**
 * Live View Kit 示例页面
 * 演示实时视图功能
 */

import { liveView } from '@kit.LiveViewKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * Live View Kit 示例 ViewModel
 */
@ObservedV2
export class LiveViewKitExampleVM {
  @Trace isActive: boolean = false
  @Trace streamUrl: string = ''
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false

  /**
   * 启动实时视图
   */
  async startLiveView(url: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.streamUrl = url
      this.isActive = true
      hilog.info(0x0000, 'LiveViewExample', 'Live view started')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `启动失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'LiveViewExample', 'Start failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 停止实时视图
   */
  async stopLiveView(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.isActive = false
      hilog.info(0x0000, 'LiveViewExample', 'Live view stopped')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `停止失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'LiveViewExample', 'Stop failed')
    } finally {
      this.isLoading = false
    }
  }
}

/**
 * Live View Kit 示例页面
 */
@ComponentV2
export struct LiveViewKitExamplePage {
  @Local vm: LiveViewKitExampleVM = new LiveViewKitExampleVM()
  @Local urlInput: string = 'rtmp://example.com/live/stream'

  build() {
    Column() {
      Text('实时视图 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 控制卡片
          this.buildControlCard()

          // 视图预览卡片
          if (this.vm.isActive) {
            this.buildPreviewCard()
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
  buildControlCard() {
    Column() {
      Text('实时视图控制')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      TextInput({ placeholder: '流地址', text: this.urlInput })
        .width('100%')
        .margin({ bottom: 12 })
        .enabled(!this.vm.isActive)
        .onChange((value: string) => {
          this.urlInput = value
        })

      Button(this.vm.isActive ? '停止' : '启动')
        .width('100%')
        .enabled(!this.vm.isLoading)
        .backgroundColor(this.vm.isActive ? '#FF3B30' : '#007DFF')
        .onClick(() => {
          if (this.vm.isActive) {
            this.vm.stopLiveView()
          } else {
            this.vm.startLiveView(this.urlInput)
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
  buildPreviewCard() {
    Column() {
      Text('实时预览')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Column() {
        Text('实时流画面')
          .fontSize(14)
          .fontColor('#999999')

        if (this.vm.isActive) {
          LoadingProgress()
            .width(40)
            .height(40)
            .margin({ top: 16 })
        }
      }
      .width('100%')
      .height(300)
      .backgroundColor('#000000')
      .borderRadius(8)
      .justifyContent(FlexAlign.Center)
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
export function LiveViewKitExamplePageBuilder() {
  LiveViewKitExamplePage()
}
