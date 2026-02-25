# Web 组件 HarmonyOS 6.0 开发 Skill

## 概述

Web 组件是 OpenHarmony 中用于显示 Web 内容的组件，提供类似 WebView 的功能。它支持加载 HTML 页面、执行 JavaScript、与原生应用交互等完整的 Web 浏览能力。

## 重要说明

- **基础组件**: Web 是 ArkUI 的基础内置组件，无需导入
- **功能**: 支持完整的 Web 标准和 JavaScript 交互
- **安全**: 支持混合内容控制和沙箱模式
- **性能**: 支持多进程模式和硬件加速
- **交互**: 支持 Web 页面与原生应用的双向通信

## 模块信息

- **组件名称**: Web
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.Web.WebView.Core
- **更新日期**: 2026-02-24
- **官方文档**:
  - [Web - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-web-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// Web 是内置组件，无需导入
// 直接使用即可
Web({ src: 'https://www.example.com' })
```

### 1.2 基础用法

```typescript
// 加载网页
Web({ src: 'https://www.example.com' })

// 加载本地 HTML
Web({ src: $rawfile('index.html') })

// 加载 HTML 字符串
Web({ src: '<html><body>Hello World</body></html>' })
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| src | `string \| Resource` | 是 | - | 网页数据源 |
| controller | `WebViewController` | 否 | - | Web 控制器 |

### 2.2 WebViewController 方法

| 方法 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `loadUrl(url)` | `string` | `void` | 加载 URL |
| `loadData(data)` | `string` | `void` | 加载 HTML 数据 |
| `reload()` | - | `void` | 刷新页面 |
| `goBack()` | - | `void` | 后退 |
| `goForward()` | - | `void` | 前进 |
| `accessBackward()` | - | `boolean` | 是否可后退 |
| `accessForward()` | - | `boolean` | 是否可前进 |
| `getOriginalUrl()` | - | `string` | 获取原始 URL |
| `getUrl()` | - | `string` | 获取当前 URL |
| `getTitle()` | - | `string` | 获取页面标题 |
| `getPageHeight()` | - | `number` | 获取页面高度 |
| `runJavaScript(script)` | `string` | `Promise<any>` | 执行 JavaScript |
| `createWebMessagePorts()` | - | `WebMessagePort[]` | 创建消息通道 |
| `postMessage(message)` | `string` | `void` | 发送消息到 Web |

### 2.3 Web 事件

| 事件 | 参数类型 | 描述 |
|------|----------|------|
| `onPageBegin` | `() => void` | 页面开始加载 |
| `onPageEnd` | `() => void` | 页面加载完成 |
| `onProgressChange` | `(progress: number) => void` | 加载进度变化 |
| `onErrorReceive` | `(error: WebError) => void` | 加载错误 |
| `onTitleReceive` | `(title: string) => void` | 页面标题接收 |
| `onAlert` | `(url: string, message: string, result: JsResult) => void` | 弹窗事件 |
| `onConsole` | `(message: ConsoleMessage) => void` | 控制台消息 |
| `onRefreshAccessedHistory` | `(url: string, isRefreshed: boolean) => void` | 历史记录刷新 |

## 三、使用示例

### 3.1 基础网页加载

```typescript
@ComponentV2
struct WebExample {
  build() {
    Web({ src: 'https://www.example.com' })
      .width('100%')
      .height('100%')
  }
}
```

### 3.2 自定义控制浏览器

```typescript
@ComponentV2
struct WebBrowser {
  @Local canGoBack: boolean = false
  @Local canGoForward: boolean = false
  @Local currentUrl: string = ''
  @Local title: string = ''
  @Local progress: number = 0
  private controller: WebViewController = new WebViewController()

  build() {
    Column() {
      // 标题栏
      Row() {
        Button('<')
          .enabled(this.canGoBack)
          .onClick(() => {
            this.controller.goBack()
          })

        Button('>')
          .enabled(this.canGoForward)
          .onClick(() => {
            this.controller.goForward()
          })

        Button('刷新')
          .onClick(() => {
            this.controller.reload()
          })
      }
      .padding(10)
      .width('100%')
      .backgroundColor('#F5F5F5')

      // 进度条
      Progress({ value: this.progress, total: 100 })
        .width('100%')

      // 标题显示
      Text(this.title)
        .fontSize(14)
        .padding(8)

      // Web 内容
      Web({ src: 'https://www.example.com', controller: this.controller })
        .width('100%')
        .layoutWeight(1)
        .onPageBegin(() => {
          this.progress = 10
        })
        .onPageEnd(() => {
          this.progress = 100
          this.canGoBack = this.controller.accessBackward()
          this.canGoForward = this.controller.accessForward()
        })
        .onProgressChange((progress: number) => {
          this.progress = progress
        })
        .onTitleReceive((title: string) => {
          this.title = title
        })
    }
  }
}
```

### 3.3 JavaScript 交互

```typescript
@ComponentV2
struct WebJSInteraction {
  @Local result: string = ''
  private controller: WebViewController = new WebViewController()

  build() {
    Column() {
      Web({ src: 'https://www.example.com', controller: this.controller })
        .width('100%')
        .height(300)
        .onPageEnd(() => {
          // 页面加载完成后执行 JavaScript
          this.controller.runJavaScript('document.title')
            .then((title: string) => {
              this.result = `页面标题: ${title}`
            })
        })

      Button('获取页面标题')
        .onClick(() => {
          this.controller.runJavaScript('document.title')
            .then((title: string) => {
              this.result = `页面标题: ${title}`
            })
        })

      Button('修改背景色')
        .onClick(() => {
          this.controller.runJavaScript('document.body.style.backgroundColor = "#f0f0f0"')
        })

      Text(this.result)
        .padding(10)
    }
  }
}
```

### 3.4 加载本地 HTML

```typescript
@ComponentV2
struct LocalHtmlWeb {
  build() {
    Web({ src: $rawfile('index.html') })
      .width('100%')
      .height('100%')
  }
}

// resources/rawfile/index.html:
// <!DOCTYPE html>
// <html>
// <body>
//   <h1>Hello from Local HTML</h1>
// </body>
// </html>
```

### 3.5 JavaScript 消息通信

```typescript
@ComponentV2
struct WebMessagePort {
  private controller: WebViewController = new WebViewController()
  private ports: WebMessagePort[] = []

  build() {
    Column() {
      Web({ src: $rawfile('message.html'), controller: this.controller })
        .width('100%')
        .height(300)
        .onPageEnd(() => {
          // 创建消息通道
          this.ports = this.controller.createWebMessagePorts()
          // 将端口发送到 Web 页面
          this.controller.runJavaScript(`receivePort(${this.ports[1]})`)

          // 监听消息
          this.ports[0].onMessageEvent((message: string) => {
            console.info('收到 Web 消息:', message)
          })
        })

      Button('发送消息到 Web')
        .onClick(() => {
          this.ports[0].postMessage('Hello from HarmonyOS')
        })
    }
  }
}
```

### 3.6 错误处理

```typescript
@ComponentV2
struct WebWithErrorHandling {
  @Local errorMessage: string = ''
  @Local hasError: boolean = false

  build() {
    Column() {
      Web({ src: 'https://www.example.com' })
        .width('100%')
        .height('100%')
        .onErrorReceive((error: WebError) => {
          this.hasError = true
          this.errorMessage = `错误: ${error.errorCode} - ${error.errorInfo}`
        })

      if (this.hasError) {
        Column() {
          Text('页面加载失败')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
          Text(this.errorMessage)
            .fontSize(14)
            .margin({ top: 10 })
          Button('重新加载')
            .onClick(() => {
              this.hasError = false
              // 重新加载页面
            })
        }
        .width('100%')
        .padding(20)
      }
    }
  }
}
```

## 四、高级用法

### 4.1 Cookie 管理

```typescript
@ComponentV2
struct WebWithCookie {
  private controller: WebViewController = new WebViewController()

  build() {
    Column() {
      Web({ src: 'https://www.example.com', controller: this.controller })
        .width('100%')
        .height('100%')
        .onPageEnd(() => {
          // 获取 Cookie
          this.controller.runJavaScript('document.cookie')
            .then((cookie: string) => {
              console.info('Cookie:', cookie)
            })
        })
    }
  }
}
```

### 4.2 拦截弹窗

```typescript
@ComponentV2
struct WebWithAlert {
  build() {
    Web({ src: 'https://www.example.com' })
      .width('100%')
      .height('100%')
      .onAlert((url: string, message: string, result: JsResult) => {
        // 自定义弹窗处理
        console.info('Alert from:', url, 'Message:', message)
        result.handleConfirm()  // 确认弹窗
        // result.handleCancel()  // 取消弹窗
        return true
      })
  }
}
```

### 4.3 控制台日志

```typescript
@ComponentV2
struct WebWithConsole {
  build() {
    Web({ src: 'https://www.example.com' })
      .width('100%')
      .height('100%')
      .onConsole((message: ConsoleMessage) => {
        console.info('Web Console:', message.message)
        return false  // 返回 true 表示阻止消息显示
      })
  }
}
```

## 五、最佳实践

### 5.1 页面加载优化

```typescript
// ✅ 推荐：显示加载进度
@ComponentV2
struct OptimizedWeb {
  @Local isLoading: boolean = true

  build() {
    Stack() {
      Web({ src: 'https://www.example.com' })
        .onPageBegin(() => {
          this.isLoading = true
        })
        .onPageEnd(() => {
          this.isLoading = false
        })

      if (this.isLoading) {
        LoadingProgress()
          .width(50)
          .height(50)
      }
    }
  }
}
```

### 5.2 内存管理

```typescript
// ✅ 推荐：页面销毁时释放资源
@ComponentV2
struct WebPage {
  private controller: WebViewController = new WebViewController()

  aboutToDisappear() {
    // 清理 Web 资源
    this.controller.runJavaScript('localStorage.clear()')
  }

  build() {
    Web({ src: 'https://www.example.com', controller: this.controller })
  }
}
```

### 5.3 安全配置

```typescript
// ✅ 推荐：配置安全策略
Web({ src: 'https://www.example.com' })
  .javaScriptAccess(true)  // 根据需求开启/关闭
  .fileAccess(true)  // 控制文件访问权限
  .mixedMode(MixedMode.Allows)  // 控制混合内容
```

### 5.4 性能优化

```typescript
// ✅ 推荐：缓存策略
Web({ src: 'https://www.example.com' })
  .cacheMode(CacheMode.Default)  // 使用缓存加速加载
```

## 六、常见问题

### Q1: Web 页面无法加载？

**解决方案**:
```typescript
// 1. 检查网络权限
// module.json5 中配置:
{
  "requestPermissions": [
    {
      "name": "ohos.permission.INTERNET"
    }
  ]
}

// 2. 使用 onErrorReceive 查看错误信息
Web({ src: 'https://www.example.com' })
  .onErrorReceive((error) => {
    console.error('加载失败:', error.errorCode, error.errorInfo)
  })
```

### Q2: JavaScript 无法执行？

**解决方案**:
```typescript
// 确保 javaScriptAccess 开启
Web({ src: 'https://www.example.com' })
  .javaScriptAccess(true)
  .onPageEnd(() => {
    // 在页面加载完成后执行
    this.controller.runJavaScript('console.log("Hello")')
  })
```

### Q3: 如何实现原生和 Web 的双向通信？

**解决方案**:
```typescript
// 使用 WebMessagePort
private ports: WebMessagePort[] = []

// 1. 创建消息通道
this.ports = this.controller.createWebMessagePorts()

// 2. 将端口传递给 Web 页面
this.controller.runJavaScript(`initPort(${this.ports[1]})`)

// 3. 发送消息
this.ports[0].postMessage('Hello from Native')

// 4. 接收消息
this.ports[0].onMessageEvent((message) => {
  console.info('收到消息:', message)
})
```

### Q4: 如何处理 HTTP 和 HTTPS 混合内容？

**解决方案**:
```typescript
// 使用 mixedMode 属性
Web({ src: 'https://www.example.com' })
  .mixedMode(MixedMode.Allows)  // 允许混合内容
  // 或
  .mixedMode(MixedMode.Compatibility)  // 兼容模式
```

## 七、常见问题与陷阱 (Common Pitfalls)

### ❌ ERROR: No such resource in current module

**问题：**
使用 `$rawfile()` 加载本地 HTML 文件时，如果文件不存在会导致编译错误。

**错误信息：**
```
Error: No such 'web/sample.html' resource in current module
At File: WebExample.ets:72:18
```

**错误用法：**
```typescript
// ❌ WRONG: 文件不存在
Web({ src: $rawfile('web/sample.html'), controller: this.controller })
  .width('100%')
  .height(250)
```

**正确用法：**
```typescript
// ✅ CORRECT: 使用 data URL 或确保文件存在
// 方案1: 使用 data URL
Web({ src: 'data:text/html,<html><body>Hello</body></html>', controller: this.controller })
  .width('100%')
  .height(250)

// 方案2: 确保文件存在在 src/main/resources/rawfile 目录
// 目录结构:
// src/main/resources/rawfile/
//   ├── web/
//   │   └── sample.html  // 确保文件存在
Web({ src: $rawfile('web/sample.html'), controller: this.controller })
  .width('100%')
  .height(250)
```

**解决方案：**
1. 使用 `data:text/html,...` 格式直接嵌入 HTML 内容
2. 确保 HTML 文件放置在正确的 `resources/rawfile` 目录下
3. 文件路径使用 `/` 分隔，不以 `/` 开头

### ❌ ERROR: Use explicit types instead of "any", "unknown"

**问题：**
JavaScript Promise 的 catch 回调中，error 参数类型未明确指定导致编译错误。

**错误信息：**
```
Error: Use explicit types instead of "any", "unknown"
At File: WebExample.ets:187:22
```

**错误用法：**
```typescript
// ❌ WRONG: error 参数未指定类型
this.controller.runJavaScript('test()')
  .then(result => {
    this.jsResult = result as string
  })
  .catch(error => {  // ❌ Error: implicit any/unknown
    this.jsResult = '调用失败'
  })
```

**正确用法：**
```typescript
// ✅ CORRECT: 明确指定 error 类型为 Error
this.controller.runJavaScript('test()')
  .then(result => {
    this.jsResult = result as string
  })
  .catch((error: Error) => {  // ✅ Explicit type
    this.jsResult = '调用失败'
    console.error('JavaScript error:', error.message)
  })
```

**关键点：**
- ArkTS 要求明确指定类型，不允许隐式 any/unknown
- Promise 的 catch/reject 回调必须明确错误类型
- 推荐使用 `Error` 类型或自定义错误接口

### ⚠️ Web 组件独立使用

**说明：**
在项目重构中，Web 组件已从 MediaExample 中独立出来，作为单独的示例组件。

**原因：**
- MediaExample 包含 Video、ImageAnimator、TextClock、TextTimer 等多个组件
- Web 组件功能完整且独立，应作为单独的示例
- 便于组织和维护

**新位置：**
- 示例文件：`ycomponent/src/main/ets/components/web/WebExample.ets`
- 路由名称：`WebExamplePage`

---

## 八、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 9+ | ✅ | 基础功能 |
| API 10+ | ✅ | 增强了 JavaScript 交互 |
| API 11+ | ✅ | 增加了更多控制选项 |
| API 12+ | ✅ | 性能优化和安全增强 |

## 八、参考资料

- [Web - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-web-V5)
- [WebView 开发指南 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/web-view-V5)
