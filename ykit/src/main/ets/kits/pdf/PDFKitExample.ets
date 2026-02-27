/**
 * PDF Kit 示例页面
 * 演示 PDF 文档的创建、渲染、编辑等功能
 */

import { pdf } from '@kit.PDFKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * PDF 文档信息
 */
interface PDFDocumentInfo {
  name: string
  pageCount: number
  size: number
  path: string
}

/**
 * PDF Kit 示例 ViewModel
 */
@ObservedV2
export class PDFKitExampleVM {
  @Trace documents: PDFDocumentInfo[] = []
  @Trace currentPage: number = 0
  @Trace totalPages: number = 0
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false
  @Trace currentDocument: PDFDocumentInfo | null = null

  /**
   * 创建 PDF 文档
   */
  async createPDF(title: string, content: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      // 创建新 PDF 文档
      const doc = new pdf.PDFDocument()

      // 添加页面
      const page = doc.createPage(pdf.PageSize.A4)

      // 添加文本
      page.drawText(title, { x: 100, y: 700, fontSize: 24 })
      page.drawText(content, { x: 100, y: 600, fontSize: 14 })

      // 保存文档
      const filePath = `/data/storage/el2/pdf/${Date.now()}.pdf`
      await doc.save(filePath)

      const docInfo: PDFDocumentInfo = {
        name: title,
        pageCount: 1,
        size: 0,
        path: filePath
      }

      this.documents.unshift(docInfo)
      hilog.info(0x0000, 'PDFKitExample', 'PDF created')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `创建失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'PDFKitExample', 'Create failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 加载 PDF 文档
   */
  async loadPDF(filePath: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      const doc = await pdf.loadDocument(filePath)
      this.totalPages = doc.getPageCount()
      this.currentPage = 0

      this.currentDocument = {
        name: filePath.split('/').pop() || '',
        pageCount: this.totalPages,
        size: 0,
        path: filePath
      }

      hilog.info(0x0000, 'PDFKitExample', 'PDF loaded')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `加载失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'PDFKitExample', 'Load failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 渲染页面
   */
  async renderPage(pageNumber: number): Promise<void> {
    if (!this.currentDocument) return

    this.isLoading = true
    this.errorMessage = ''

    try {
      const doc = await pdf.loadDocument(this.currentDocument.path)
      const page = doc.getPage(pageNumber)
      // 渲染逻辑
      this.currentPage = pageNumber
      hilog.info(0x0000, 'PDFKitExample', `Page ${pageNumber} rendered`)
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `渲染失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'PDFKitExample', 'Render failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 上一页
   */
  previousPage(): void {
    if (this.currentPage > 0) {
      this.renderPage(this.currentPage - 1)
    }
  }

  /**
   * 下一页
   */
  nextPage(): void {
    if (this.currentPage < this.totalPages - 1) {
      this.renderPage(this.currentPage + 1)
    }
  }

  /**
   * 清除文档列表
   */
  clearDocuments(): void {
    this.documents = []
    this.currentDocument = null
    hilog.info(0x0000, 'PDFKitExample', 'Documents cleared')
  }
}

/**
 * PDF Kit 示例页面
 */
@ComponentV2
export struct PDFKitExamplePage {
  @Local vm: PDFKitExampleVM = new PDFKitExampleVM()
  @Local titleInput: string = '示例文档'
  @Local contentInput: string = '这是一个 PDF 示例文档内容。'

  build() {
    Column() {
      // 标题
      Text('PDF Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 创建 PDF 卡片
          this.buildCreatePDFCard()

          // PDF 浏览器卡片
          this.buildPDFViewerCard()

          // 文档列表卡片
          this.buildDocumentListCard()

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
  buildCreatePDFCard() {
    Column() {
      Text('创建 PDF')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      TextInput({ placeholder: '文档标题', text: this.titleInput })
        .width('100%')
        .margin({ bottom: 12 })
        .onChange((value: string) => {
          this.titleInput = value
        })

      TextArea({ placeholder: '文档内容', text: this.contentInput })
        .width('100%')
        .height(100)
        .margin({ bottom: 12 })
        .onChange((value: string) => {
          this.contentInput = value
        })

      Button('创建 PDF')
        .width('100%')
        .enabled(!this.vm.isLoading && this.titleInput.length > 0)
        .onClick(() => {
          this.vm.createPDF(this.titleInput, this.contentInput)
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  buildPDFViewerCard() {
    Column() {
      Text('PDF 浏览器')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      if (this.vm.currentDocument) {
        // 文档信息
        Column() {
          Text(`文档: ${this.vm.currentDocument.name}`)
            .fontSize(14)
            .fontColor('#333333')
            .width('100%')

          Text(`页数: ${this.vm.currentDocument.pageCount}`)
            .fontSize(12)
            .fontColor('#666666')
            .width('100%')
            .margin({ top: 4 })

          // 页面控制
          Row() {
            Button('上一页')
              .enabled(!this.vm.isLoading && this.vm.currentPage > 0)
              .onClick(() => {
                this.vm.previousPage()
              })

            Text(`${this.vm.currentPage + 1} / ${this.vm.totalPages}`)
              .fontSize(14)
              .margin({ left: 16, right: 16 })

            Button('下一页')
              .enabled(!this.vm.isLoading && this.vm.currentPage < this.vm.totalPages - 1)
              .onClick(() => {
                this.vm.nextPage()
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .margin({ top: 12 })

          // PDF 预览区域
          Column() {
            Text('PDF 预览区域')
              .fontSize(14)
              .fontColor('#999999')
          }
          .width('100%')
          .height(300)
          .backgroundColor('#F0F0F0')
          .borderRadius(8)
          .margin({ top: 12 })
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
        .padding(12)
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
      } else {
        Text('请加载 PDF 文档')
          .fontSize(14)
          .fontColor('#999999')
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .margin({ top: 16 })
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  buildDocumentListCard() {
    Column() {
      Row() {
        Text('文档列表')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)

        Blank()

        if (this.vm.documents.length > 0) {
          Button('清除')
            .fontSize(12)
            .onClick(() => {
              this.vm.clearDocuments()
            })
        }
      }
      .width('100%')
      .margin({ bottom: 12 })

      if (this.vm.documents.length === 0) {
        Text('暂无文档')
          .fontSize(14)
          .fontColor('#999999')
      } else {
       ForEach(this.vm.documents, (doc: PDFDocumentInfo) => {
          Row() {
            Column() {
              Text(doc.name)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)

              Text(`${doc.pageCount} 页`)
                .fontSize(12)
                .fontColor('#666666')
                .margin({ top: 4 })
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            Button('打开')
              .fontSize(12)
              .onClick(() => {
                this.vm.loadPDF(doc.path)
              })
          }
          .width('100%')
          .padding(12)
          .backgroundColor('#F5F5F5')
          .borderRadius(8)
          .margin({ bottom: 8 })
        })
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
export function PDFKitExamplePageBuilder() {
  PDFKitExamplePage()
}
