/**
 * Web Component Examples
 * OpenHarmony Web Component 使用示例
 *
 * Web 是网页加载组件，用于在应用中展示网页内容
 */
import { webview } from '@kit.ArkWeb'

/**
 * 基础 Web 示例
 * 展示网页加载的基本用法
 */
@ComponentV2
export struct BasicWebExample {
  @Local progress: number = 0
  private controller: webview.WebviewController = new webview.WebviewController()

  build() {
    Column({ space: 12 }) {
      Text('基础 Web 组件')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')

      // 进度条
      Progress({ value: this.progress, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(4)
        .color('#007DFF')

      // Web 内容
      Web({ src: 'https://www.example.com', controller: this.controller })
        .width('100%')
        .height(300)
        .borderRadius(8)
        .backgroundColor('#FFFFFF')
        .onPageBegin(() => {
          this.progress = 10
        })
        .onPageEnd(() => {
          this.progress = 100
        })

      Text('加载进度: ' + this.progress + '%')
        .fontSize(14)
        .fontColor('#666666')
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .margin({ bottom: 8 })
  }
}

/**
 * 本地 HTML 示例
 * 展示如何加载本地 HTML 内容
 */
@ComponentV2
export struct LocalHtmlWebExample {
  private controller: webview.WebviewController = new webview.WebviewController()

  build() {
    Column({ space: 12 }) {
      Text('本地 HTML')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')

      Web({ src: 'data:text/html,<html><body><h1>本地 HTML 内容</h1></body></html>', controller: this.controller })
        .width('100%')
        .height(250)
        .borderRadius(8)
        .backgroundColor('#F5F5F5')

      Text('支持加载本地 HTML 文件')
        .fontSize(14)
        .fontColor('#666666')
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * Web 事件处理示例
 * 展示如何处理 Web 组件的各种事件
 */
@ComponentV2
export struct WebEventsExample {
  @Local pageUrl: string = 'https://www.example.com'
  @Local pageTitle: string = ''
  @Local errorCode: string = ''
  private controller: webview.WebviewController = new webview.WebviewController()

  build() {
    Column({ space: 12 }) {
      Text('Web 事件处理')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')

      Web({ src: this.pageUrl, controller: this.controller })
        .width('100%')
        .height(280)
        .borderRadius(8)
        .backgroundColor('#FFFFFF')
        .onPageBegin((event) => {
          if (event) {
            this.pageUrl = event.url || ''
          }
        })
        .onPageEnd((event) => {
          if (event) {
            this.pageTitle = '加载完成'
          }
        })
        .onErrorReceive((event) => {
          if (event) {
            this.errorCode = '加载错误'
          }
        })

      if (this.pageTitle) {
        Text(this.pageTitle)
          .fontSize(14)
          .fontColor('#4CAF50')
          .margin({ top: 8 })
      }

      if (this.errorCode) {
        Text(this.errorCode)
          .fontSize(14)
          .fontColor('#F44336')
          .margin({ top: 8 })
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * JavaScript 交互示例
 * 展示如何与网页中的 JavaScript 进行交互
 */
@ComponentV2
export struct WebJsInteractionExample {
  @Local jsResult: string = ''
  private controller: webview.WebviewController = new webview.WebviewController()

  build() {
    Column({ space: 12 }) {
      Text('JavaScript 交互')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')

      Web({
        src: 'data:text/html,<html><body><h1>Hello</h1><script>function test(){return"JS调用成功";}</script></body></html>',
        controller: this.controller
      })
        .width('100%')
        .height(200)
        .borderRadius(8)
        .backgroundColor('#FFFFFF')
        .javaScriptAccess(true)
        .onErrorReceive((event) => {
          console.error('Web error: ' + JSON.stringify(event))
        })

      Row({ space: 8 }) {
        Button('调用 JS')
          .fontSize(14)
          .onClick(() => {
            this.controller.runJavaScript('test()')
              .then(result => {
                this.jsResult = result as string
              })
              .catch((error: Error) => {
                this.jsResult = '调用失败'
              })
          })
      }
      .justifyContent(FlexAlign.Center)

      if (this.jsResult) {
        Text('JS 返回: ' + this.jsResult)
          .fontSize(14)
          .fontColor('#007DFF')
          .margin({ top: 8 })
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * 主页面组件
 */
@ComponentV2
export struct WebExamplePage {
  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          Text('Web Component Examples')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .padding({ left: 16, right: 16, top: 16, bottom: 8 })

          BasicWebExample()
          LocalHtmlWebExample()
          WebEventsExample()
          WebJsInteractionExample()
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')
    }
    .title('Web 网页组件')
    .mode(NavDestinationMode.STANDARD)
  }
}

@Builder
export function WebExamplePageBuilder() {
  WebExamplePage()
}
