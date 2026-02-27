/**
 * Preview Kit 示例页面
 * 演示文件预览功能
 */

import { preview } from '@kit.PreviewKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * Preview Kit 示例 ViewModel
 */
@ObservedV2
export class PreviewKitExampleVM {
  @Trace filePath: string = ''
  @Trace isPreviewing: boolean = false
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false

  /**
   * 预览文件
   */
  async previewFile(path: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.filePath = path
      this.isPreviewing = true
      hilog.info(0x0000, 'PreviewExample', 'File previewed')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `预览失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'PreviewExample', 'Preview failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 关闭预览
   */
  closePreview(): void {
    this.isPreviewing = false
    hilog.info(0x0000, 'PreviewExample', 'Preview closed')
  }
}

/**
 * Preview Kit 示例页面
 */
@ComponentV2
export struct PreviewKitExamplePage {
  @Local vm: PreviewKitExampleVM = new PreviewKitExampleVM()
  @Local pathInput: string = '/data/storage/el2/base/files/document.pdf'

  build() {
    Column() {
      Text('预览 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 文件选择卡片
          this.buildFileCard()

          // 预览区域卡片
          if (this.vm.isPreviewing) {
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
  buildFileCard() {
    Column() {
      Text('文件预览')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      TextInput({ placeholder: '文件路径', text: this.pathInput })
        .width('100%')
        .margin({ bottom: 12 })
        .onChange((value: string) => {
          this.pathInput = value
        })

      Button('预览文件')
        .width('100%')
        .enabled(!this.vm.isLoading && this.pathInput.length > 0)
        .onClick(() => {
          this.vm.previewFile(this.pathInput)
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
      Row() {
        Text('预览')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)

        Blank()

        Button('关闭')
          .fontSize(12)
          .onClick(() => {
            this.vm.closePreview()
          })
      }
      .width('100%')
      .margin({ bottom: 12 })

      Column() {
        Text(`文件: ${this.vm.filePath}`)
          .fontSize(14)
          .fontColor('#666666')

        Text('预览内容区域')
          .fontSize(14)
          .fontColor('#999999')
          .margin({ top: 16 })
      }
      .width('100%')
      .height(400)
      .backgroundColor('#F0F0F0')
      .borderRadius(8)
      .justifyContent(FlexAlign.Center)
      .padding(16)
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
export function PreviewKitExamplePageBuilder() {
  PreviewKitExamplePage()
}
