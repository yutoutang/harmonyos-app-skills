/**
 * Reader Kit 示例页面
 * 演示阅读器服务功能
 */

import { reader } from '@kit.ReaderKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * Reader Kit 示例 ViewModel
 */
@ObservedV2
export class ReaderKitExampleVM {
  @Trace currentPage: number = 1
  @Trace totalPages: number = 100
  @Trace bookTitle: string = ''
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false

  /**
   * 打开书籍
   */
  async openBook(bookPath: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.bookTitle = '示例书籍'
      this.currentPage = 1
      hilog.info(0x0000, 'ReaderExample', 'Book opened')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `打开失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'ReaderExample', 'Open failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 翻到下一页
   */
  nextPage(): void {
    if (this.currentPage < this.totalPages) {
      this.currentPage++
      hilog.info(0x0000, 'ReaderExample', `Page ${this.currentPage}`)
    }
  }

  /**
   * 翻到上一页
   */
  previousPage(): void {
    if (this.currentPage > 1) {
      this.currentPage--
      hilog.info(0x0000, 'ReaderExample', `Page ${this.currentPage}`)
    }
  }

  /**
   * 跳转到指定页
   */
  async jumpToPage(page: number): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      if (page >= 1 && page <= this.totalPages) {
        this.currentPage = page
        hilog.info(0x0000, 'ReaderExample', `Jumped to page ${page}`)
      }
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `跳转失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'ReaderExample', 'Jump failed')
    } finally {
      this.isLoading = false
    }
  }
}

/**
 * Reader Kit 示例页面
 */
@ComponentV2
export struct ReaderKitExamplePage {
  @Local vm: ReaderKitExampleVM = new ReaderKitExampleVM()
  @Local bookPathInput: string = '/data/books/sample.epub'
  @Local pageInput: string = '1'

  build() {
    Column() {
      Text('阅读器 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 打开书籍卡片
          this.buildOpenBookCard()

          // 阅读控制卡片
          if (this.vm.bookTitle) {
            this.buildReaderCard()
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
  buildOpenBookCard() {
    Column() {
      Text('打开书籍')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      TextInput({ placeholder: '书籍路径', text: this.bookPathInput })
        .width('100%')
        .margin({ bottom: 12 })
        .onChange((value: string) => {
          this.bookPathInput = value
        })

      Button('打开书籍')
        .width('100%')
        .enabled(!this.vm.isLoading && this.bookPathInput.length > 0)
        .onClick(() => {
          this.vm.openBook(this.bookPathInput)
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
  buildReaderCard() {
    Column() {
      // 书籍信息
      Text(this.vm.bookTitle)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 12 })

      // 阅读区域
      Column() {
        Text(`第 ${this.vm.currentPage} 页`)
          .fontSize(14)
          .fontColor('#999999')

        Text('书籍内容区域')
          .fontSize(16)
          .fontColor('#666666')
          .margin({ top: 16 })
      }
      .width('100%')
      .height(300)
      .backgroundColor('#F0F0F0')
      .borderRadius(8)
      .justifyContent(FlexAlign.Center)
      .margin({ bottom: 16 })

      // 页面控制
      Row() {
        Button('上一页')
          .flexGrow(1)
          .enabled(!this.vm.isLoading && this.vm.currentPage > 1)
          .onClick(() => {
            this.vm.previousPage()
          })

        Text(`${this.vm.currentPage} / ${this.vm.totalPages}`)
          .fontSize(14)
          .margin({ left: 16, right: 16 })

        Button('下一页')
          .flexGrow(1)
          .enabled(!this.vm.isLoading && this.vm.currentPage < this.vm.totalPages)
          .onClick(() => {
            this.vm.nextPage()
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      // 跳转控制
      Row() {
        TextInput({ placeholder: '页码', text: this.pageInput })
          .width('100%')
          .layoutWeight(1)
          .type(InputType.Number)
          .onChange((value: string) => {
            this.pageInput = value
          })

        Button('跳转')
          .margin({ left: 8 })
          .enabled(!this.vm.isLoading && this.pageInput.length > 0)
          .onClick(() => {
            const page = parseInt(this.pageInput) || 1
            this.vm.jumpToPage(page)
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
}

@Builder
export function ReaderKitExamplePageBuilder() {
  ReaderKitExamplePage()
}
