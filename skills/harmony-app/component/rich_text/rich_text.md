# RichText 组件 HarmonyOS 6.0 开发 Skill

## 概述

RichText 组件是 OpenHarmony 中用于显示富文本的组件，支持 HTML 格式的文本内容。它可以解析和显示包含 HTML 标签的文本，如文本样式、图片、链接等。

## 重要说明

- **富文本解析**: 支持常用的 HTML 标签和 CSS 样式
- **安全限制**: 出于安全考虑，不支持 JavaScript 脚本执行
- **性能**: 对于复杂富文本内容，建议控制内容大小
- **样式冲突**: CSS 样式可能与组件样式冲突，需谨慎使用

## 模块信息

- **组件名称**: RichText
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [RichText 富文本 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-richtext-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// RichText 是内置组件，无需导入
// 直接使用即可
RichText('<h1>Hello World</h1>')
```

### 1.2 基础用法

```typescript
// 简单富文本
RichText('<h1>Title</h1><p>Paragraph content</p>')

// 设置样式
RichText('<p>Hello World</p>')
  .width('100%')
  .height(200)
  .backgroundColor('#F5F5F5')

// 使用资源引用
RichText($r('app.string.rich_content'))
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| content | `string \| Resource` | 是 | - | HTML 格式的文本内容 |
| options | `RichTextOptions` | 否 | - | 富文本选项 |

### 2.2 支持的 HTML 标签

| 标签 | 描述 | 示例 |
|------|------|------|
| `<h1>` - `<h6>` | 标题 | `<h1>Title</h1>` |
| `<p>` | 段落 | `<p>Paragraph</p>` |
| `<span>` | 行内容器 | `<span>Text</span>` |
| `<div>` | 块级容器 | `<div>Content</div>` |
| `<br>` | 换行 | `Line1<br>Line2` |
| `<strong>` / `<b>` | 粗体 | `<strong>Bold</strong>` |
| `<em>` / `<i>` | 斜体 | `<em>Italic</em>` |
| `<u>` | 下划线 | `<u>Underline</u>` |
| `<del>` / `<s>` | 删除线 | `<del>Deleted</del>` |
| `<a>` | 链接 | `<a href="url">Link</a>` |
| `<img>` | 图片 | `<img src="url" />` |
| `<ul>` / `<ol>` | 列表 | `<ul><li>Item</li></ul>` |
| `<li>` | 列表项 | `<li>Item</li>` |
| `<table>` | 表格 | `<table>...</table>` |
| `<tr>` / `<td>` / `<th>` | 表格行/单元格 | `<tr><td>Cell</td></tr>` |

### 2.3 支持的 CSS 样式

| 样式 | 描述 | 示例 |
|------|------|------|
| `color` | 文本颜色 | `color: #FF0000` |
| `font-size` | 字体大小 | `font-size: 16px` |
| `font-weight` | 字体粗细 | `font-weight: bold` |
| `font-style` | 字体样式 | `font-style: italic` |
| `text-decoration` | 文本装饰 | `text-decoration: underline` |
| `text-align` | 文本对齐 | `text-align: center` |
| `line-height` | 行高 | `line-height: 1.5` |
| `background-color` | 背景颜色 | `background-color: #F5F5F5` |
| `padding` | 内边距 | `padding: 10px` |
| `margin` | 外边距 | `margin: 10px` |

## 三、使用示例

### 3.1 基础富文本示例

```typescript
// 标题和段落
RichText(`
  <h1>主标题</h1>
  <h2>副标题</h2>
  <p>这是一段普通文本内容。</p>
`)
  .width('100%')
  .padding(16)

// 文本样式
RichText(`
  <p><strong>粗体文本</strong></p>
  <p><em>斜体文本</em></p>
  <p><u>下划线文本</u></p>
  <p><del>删除线文本</del></p>
`)
  .width('100%')
  .padding(16)
```

### 3.2 列表示例

```typescript
// 无序列表
RichText(`
  <h3>无序列表</h3>
  <ul>
    <li>列表项 1</li>
    <li>列表项 2</li>
    <li>列表项 3</li>
  </ul>
`)
  .width('100%')
  .padding(16)

// 有序列表
RichText(`
  <h3>有序列表</h3>
  <ol>
    <li>第一步</li>
    <li>第二步</li>
    <li>第三步</li>
  </ol>
`)
  .width('100%')
  .padding(16)
```

### 3.3 链接示例

```typescript
RichText(`
  <p>访问 <a href="https://developer.huawei.com">华为开发者官网</a> 获取更多信息</p>
  <p>或者 <a href="https://gitee.com">Gitee</a> 查看开源项目</p>
`)
  .width('100%')
  .padding(16)
  .onStart(() => {
    console.info('RichText 开始加载')
  })
  .onComplete(() => {
    console.info('RichText 加载完成')
  })
```

### 3.4 表格示例

```typescript
RichText(`
  <h3>成绩表</h3>
  <table border="1" style="border-collapse: collapse; width: 100%;">
    <tr>
      <th style="padding: 8px; text-align: center;">科目</th>
      <th style="padding: 8px; text-align: center;">成绩</th>
    </tr>
    <tr>
      <td style="padding: 8px; text-align: center;">数学</td>
      <td style="padding: 8px; text-align: center;">95</td>
    </tr>
    <tr>
      <td style="padding: 8px; text-align: center;">语文</td>
      <td style="padding: 8px; text-align: center;">88</td>
    </tr>
  </table>
`)
  .width('100%')
  .padding(16)
```

### 3.5 图片示例

```typescript
RichText(`
  <h3>图片展示</h3>
  <p>下面是一张图片：</p>
  <img src="https://example.com/image.jpg" style="width: 100%; max-width: 400px;" />
  <p>图片说明文字</p>
`)
  .width('100%')
  .padding(16)
```

### 3.6 内联样式示例

```typescript
RichText(`
  <h3 style="color: #007DFF; text-align: center;">带样式的标题</h3>
  <p style="font-size: 16px; line-height: 1.6; color: #333;">
    这是一段带有内联样式的段落。通过 style 属性可以直接设置元素的样式。
  </p>
  <div style="background-color: #F5F5F5; padding: 10px; margin: 10px 0;">
    带背景色的容器
  </div>
`)
  .width('100%')
  .padding(16)
```

### 3.7 嵌套结构示例

```typescript
RichText(`
  <div style="padding: 16px; background-color: #F5F5F5;">
    <h2 style="color: #333;">嵌套结构示例</h2>
    <p>这是一个段落，包含<strong>粗体</strong>和<em>斜体</em>文本。</p>
    <ul style="margin-top: 10px;">
      <li>列表项 1</li>
      <li>列表项 2</li>
    </ul>
  </div>
`)
  .width('100%')
```

### 3.8 数据绑定示例

```typescript
@ComponentV2
struct DynamicRichTextExample {
  @Local htmlContent: string = `
    <h1>动态内容</h1>
    <p>这段内容会动态更新</p>
  `

  build() {
    Column({ space: 16 }) {
      RichText(this.htmlContent)
        .width('100%')
        .height(200)
        .backgroundColor('#F5F5F5')
        .padding(16)

      Button('更新内容')
        .onClick(() => {
          this.htmlContent = `
            <h2 style="color: #007DFF;">更新后的内容</h2>
            <p>时间: ${new Date().toLocaleTimeString()}</p>
          `
        })
    }
    .width('100%')
    .padding(16)
  }
}
```

## 四、事件处理

### 4.1 生命周期事件

```typescript
RichText('<p>Hello World</p>')
  .onStart(() => {
    console.info('RichText 开始加载')
  })
  .onComplete(() => {
    console.info('RichText 加载完成')
  })
```

### 4.2 链接点击事件

```typescript
RichText('<a href="https://developer.huawei.com">华为开发者</a>')
  .onUrlClick((url: string) => {
    console.info('点击链接: ' + url)
    // 处理链接点击
  })
```

## 五、最佳实践

### 5.1 内容大小控制

```typescript
// ✅ 推荐：控制富文本内容大小
const htmlContent = `
  <h1>标题</h1>
  <p>内容...</p>
`

RichText(htmlContent)
  .width('100%')
  .maxHeight(500)

// ❌ 避免：加载过大的富文本内容
const largeContent = '...大量HTML内容...' // 几MB的HTML
RichText(largeContent) // 可能导致性能问题
```

### 5.2 样式隔离

```typescript
// ✅ 推荐：使用内联样式，避免样式冲突
RichText('<p style="color: #007DFF;">文本</p>')

// ❌ 避免：依赖外部样式表
// RichText 不支持外部样式表
```

### 5.3 安全性

```typescript
// ✅ 推荐：对用户输入进行过滤
function sanitizeHtml(html: string): string {
  // 移除 <script> 标签
  return html.replace(/<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi, '')
}

RichText(sanitizeHtml(userInput))

// ❌ 避免：直接使用未过滤的用户输入
RichText(userInput) // 可能存在 XSS 风险
```

### 5.4 错误处理

```typescript
@ComponentV2
struct SafeRichTextExample {
  @Local loadError: boolean = false

  build() {
    Column({ space: 16 }) {
      if (this.loadError) {
        Text('内容加载失败')
          .fontColor('#FF0000')
      } else {
        RichText('<p>Content</p>')
          .onError(() => {
            this.loadError = true
            console.error('RichText 加载失败')
          })
      }
    }
  }
}
```

## 六、常见问题

### Q1: RichText 显示空白？

**问题**: RichText 组件显示空白内容。

**解决方案**:
```typescript
// 检查 HTML 内容是否有效
const html = '<p>Hello</p>'
console.info('HTML content:', html)

// 确保内容不为空
RichText(html || '<p>默认内容</p>')
  .width('100%')
  .height(200) // 设置高度
```

### Q2: 样式不生效？

**问题**: 设置的 CSS 样式没有效果。

**解决方案**:
```typescript
// ✅ 使用内联样式
RichText('<p style="color: #007DFF; font-size: 18px;">文本</p>')

// ✅ 使用支持的 CSS 属性
RichText('<p style="text-align: center; color: red;">文本</p>')

// ❌ 不支持的样式会被忽略
RichText('<p style="display: flex;">文本</p>') // display 不支持
```

### Q3: 图片不显示？

**问题**: RichText 中的图片无法显示。

**解决方案**:
```typescript
// ✅ 使用完整的图片 URL
RichText('<img src="https://example.com/image.jpg" />')

// ✅ 使用 Base64 编码的图片
RichText('<img src="data:image/png;base64,iVBORw0KG..." />')

// ❌ 避免使用相对路径
RichText('<img src="/images/pic.jpg" />') // 可能无法加载
```

### Q4: 如何处理长内容？

**解决方案**:
```typescript
// 使用 Scroll 组件包裹
Scroll() {
  RichText(longHtmlContent)
    .width('100%')
}
.width('100%')
.height(500)
```

### Q5: 链接点击没有反应？

**解决方案**:
```typescript
RichText('<a href="https://example.com">Link</a>')
  .onUrlClick((url: string) => {
    console.info('点击链接:', url)
    // 在此处处理链接跳转逻辑
  })
```

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 8+ | ✅ | 基础支持 |
| API 10+ | ✅ | 增加更多 HTML 标签支持 |
| API 12+ | ✅ | 优化渲染性能 |

## 八、参考资料

- [RichText 富文本 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-richtext-V5)
- [Web 组件开发指南 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/web-component-development-V5)
