/**
 * File Manager Service Kit 示例页面
 * 演示文件管理服务功能
 */

import { fileManagerService } from '@kit.FileManagerServiceKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * File Manager Service Kit 示例 ViewModel
 */
@ObservedV2
export class FileManagerServiceKitExampleVM {
  @Trace files: string[] = []
  @Trace currentPath: string = '/data/storage/el2'
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false

  /**
   * 列出文件
   */
  async listFiles(path: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      // 模拟文件列表
      this.files = ['document.txt', 'image.jpg', 'video.mp4']
      this.currentPath = path
      hilog.info(0x0000, 'FileManagerExample', 'Files listed')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `列出失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'FileManagerExample', 'List failed')
    } finally {
      this.isLoading = false
    }
  }
}

/**
 * File Manager Service Kit 示例页面
 */
@ComponentV2
export struct FileManagerServiceKitExamplePage {
  @Local vm: FileManagerServiceKitExampleVM = new FileManagerServiceKitExampleVM()

  aboutToAppear(): void {
    this.vm.listFiles(this.vm.currentPath)
  }

  build() {
    Column() {
      Text('文件管理 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 路径卡片
          this.buildPathCard()

          // 文件列表卡片
          this.buildFileListCard()

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
  buildPathCard() {
    Column() {
      Text('当前路径')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Text(this.vm.currentPath)
        .fontSize(14)
        .fontColor('#666666')
        .width('100%')

      Button('刷新')
        .width('100%')
        .margin({ top: 12 })
        .enabled(!this.vm.isLoading)
        .onClick(() => {
          this.vm.listFiles(this.vm.currentPath)
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
  buildFileListCard() {
    Column() {
      Text('文件列表')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      ForEach(this.vm.files, (file: string, index: number) => {
        Row() {
          Text(`${index + 1}. ${file}`)
            .fontSize(14)
            .layoutWeight(1)
        }
        .width('100%')
        .padding(12)
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
        .margin({ bottom: 8 })
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
export function FileManagerServiceKitExamplePageBuilder() {
  FileManagerServiceKitExamplePage()
}
