# ContainerSpan 组件 HarmonyOS 6.0 开发 Skill

## 概述

ContainerSpan 是 OpenHarmony 中用于 RichEditor 组件内部的容器级文本片段组件。它允许在富文本编辑器中创建复杂的容器结构，支持文本、图片、混合内容的容器化显示。ContainerSpan 是实现富文本编辑器中复杂布局（如引用块、代码块、图文混排等）的核心组件。

## 重要说明

- **专属组件**: ContainerSpan 只能在 RichEditor 组件内部使用
- **容器特性**: 提供容器级别的文本组织能力
- **样式隔离**: 可以设置独立的容器样式
- **嵌套支持**: 支持多层嵌套结构
- **内容组合**: 可包含 TextSpan、ImageSpan 等多种子元素

## 模块信息

- **组件名称**: ContainerSpan
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [ContainerSpan 容器片段 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-container-span-V5)

## 一、组件基础

### 1.1 与其他 Span 组件的关系

```
RichEditor (富文本编辑器)
├── ContainerSpan (容器片段)
│   ├── TextSpan (文本片段)
│   ├── ImageSpan (图片片段)
│   ├── SymbolSpan (符号片段)
│   └── ContainerSpan (嵌套容器)
└── Text (直接文本)
```

| 组件 | 用途 | 使用位置 |
|------|------|----------|
| **ContainerSpan** | 容器级片段组织 | RichEditor 内部 |
| **TextSpan** | 纯文本片段 | RichEditor、ContainerSpan 内部 |
| **ImageSpan** | 图片片段 | RichEditor、ContainerSpan 内部 |
| **SymbolSpan** | 符号图标片段 | RichEditor、ContainerSpan 内部 |

### 1.2 基础语法

```typescript
// RichEditor 控制器
const controller: RichEditorController = new RichEditorController()

// 创建 ContainerSpan
const containerSpan = new ContainerSpan()

// 设置容器样式
containerSpan.setStyle({
  backgroundColor: '#F5F5F5',
  padding: 12,
  borderRadius: 8
})

// 添加子内容
containerSpan.append(new TextSpan('容器内的文本'))
containerSpan.append(new ImageSpan(imageRes))

// 插入到编辑器
controller.aboutToIMEInput([containerSpan])
```

### 1.3 在 RichEditor 中使用

```typescript
@ComponentV2
struct ContainerSpanBasicExample {
  controller: RichEditorController = new RichEditorController()

  insertContainerSpan() {
    const container = new ContainerSpan()

    // 设置容器样式
    container.setStyle({
      backgroundColor: '#E3F2FD',
      padding: 12,
      margin: { top: 8, bottom: 8 }
    })

    // 添加文本内容
    const textSpan = new TextSpan('这是容器中的文本')
    textSpan.setStyle({
      fontSize: 16,
      fontColor: '#007DFF'
    })
    container.append(textSpan)

    // 插入到编辑器
    this.controller.aboutToIMEInput([container])
  }

  build() {
    Column({ space: 16 }) {
      RichEditor({ controller: this.controller })
        .width('100%')
        .height(200)
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
        .padding(12)

      Button('插入容器片段')
        .onClick(() => {
          this.insertContainerSpan()
        })
    }
    .width('100%')
    .padding(16)
  }
}
```

## 二、API 参数

### 2.1 构造函数

```typescript
new ContainerSpan()
```

ContainerSpan 无需构造参数，通过方法链式调用来构建内容。

### 2.2 样式设置方法

#### setStyle(style: ContainerStyle)

设置容器样式。

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| backgroundColor | `string \| Resource` | - | 背景颜色 |
| padding | `Padding \| number` | 0 | 内边距 |
| margin | `Margin \| number` | 0 | 外边距 |
| borderRadius | `number \| BorderRadius` | 0 | 圆角半径 |
| borderWidth | `number` | 0 | 边框宽度 |
| borderColor | `string \| Resource` | - | 边框颜色 |
| width | `Length` | 内容宽度 | 容器宽度 |
| height | `Length` | 内容高度 | 容器高度 |

### 2.3 内容操作方法

#### append(span: TextSpan \| ImageSpan \| ContainerSpan)

向容器添加子片段。

| 参数 | 类型 | 描述 |
|------|------|------|
| span | `TextSpan \| ImageSpan \| ContainerSpan` | 要添加的子片段 |

#### clear()

清除容器内的所有内容。

## 三、使用示例

### 3.1 引用块示例

```typescript
@ComponentV2
struct QuoteBlockExample {
  controller: RichEditorController = new RichEditorController()

  insertQuote() {
    const container = new ContainerSpan()

    // 引用块样式
    container.setStyle({
      backgroundColor: '#F5F5F5',
      padding: 12,
      borderRadius: 8,
      borderLeft: { width: 4, color: '#007DFF' }
    })

    // 添加引用内容
    const quoteText = new TextSpan('这是一段引用文本。ContainerSpan 可以用来创建引用块、提示框等容器级的内容结构。')
    quoteText.setStyle({
      fontSize: 14,
      fontColor: '#333333',
      lineHeight: 24
    })
    container.append(quoteText)

    this.controller.aboutToIMEInput([container])
  }

  build() {
    Column({ space: 16 }) {
      Text('引用块示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      RichEditor({ controller: this.controller })
        .width('100%')
        .height(250)
        .backgroundColor('#FFFFFF')
        .borderRadius(8)
        .padding(12)

      Button('插入引用块')
        .onClick(() => {
          this.insertQuote()
        })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.2 代码块示例

```typescript
@ComponentV2
struct CodeBlockExample {
  controller: RichEditorController = new RichEditorController()

  insertCodeBlock() {
    const container = new ContainerSpan()

    // 代码块容器样式
    container.setStyle({
      backgroundColor: '#1E1E1E',
      padding: 16,
      borderRadius: 8,
      fontFamily: 'Courier New'
    })

    // 添加代码文本
    const codeText = new TextSpan(`function hello() {\n  console.log('Hello World');\n}`)
    codeText.setStyle({
      fontSize: 14,
      fontColor: '#D4D4D4',
      fontFamily: 'monospace'
    })
    container.append(codeText)

    this.controller.aboutToIMEInput([container])
  }

  build() {
    Column({ space: 16 }) {
      Text('代码块示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      RichEditor({ controller: this.controller })
        .width('100%')
        .height(250)
        .backgroundColor('#FFFFFF')
        .borderRadius(8)
        .padding(12)

      Button('插入代码块')
        .onClick(() => {
          this.insertCodeBlock()
        })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.3 提示框示例

```typescript
@ComponentV2
struct AlertBoxExample {
  controller: RichEditorController = new RichEditorController()

  insertAlert(type: 'info' | 'warning' | 'error' | 'success') {
    const container = new ContainerSpan()

    // 根据类型设置样式
    const styles = {
      info: { bg: '#E3F2FD', border: '#2196F3', icon: 'ℹ️' },
      warning: { bg: '#FFF8E1', border: '#FFC107', icon: '⚠️' },
      error: { bg: '#FFEBEE', border: '#F44336', icon: '❌' },
      success: { bg: '#E8F5E9', border: '#4CAF50', icon: '✅' }
    }

    const style = styles[type]

    container.setStyle({
      backgroundColor: style.bg,
      padding: 12,
      borderRadius: 8,
      borderLeft: { width: 4, color: style.border }
    })

    // 添加图标
    const iconSpan = new TextSpan(style.icon)
    iconSpan.setStyle({
      fontSize: 18
    })
    container.append(iconSpan)

    // 添加提示文本
    const textSpan = new TextSpan(` 这是${type === 'info' ? '信息' : type === 'warning' ? '警告' : type === 'error' ? '错误' : '成功'}提示`)
    textSpan.setStyle({
      fontSize: 14,
      fontColor: '#333333',
      marginLeft: 8
    })
    container.append(textSpan)

    this.controller.aboutToIMEInput([container])
  }

  build() {
    Column({ space: 16 }) {
      Text('提示框示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      RichEditor({ controller: this.controller })
        .width('100%')
        .height(300)
        .backgroundColor('#FFFFFF')
        .borderRadius(8)
        .padding(12)

      Row({ space: 12 }) {
        Button('信息')
          .onClick(() => this.insertAlert('info'))
        Button('警告')
          .onClick(() => this.insertAlert('warning'))
        Button('错误')
          .onClick(() => this.insertAlert('error'))
        Button('成功')
          .onClick(() => this.insertAlert('success'))
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.4 图文混排示例

```typescript
@ComponentV2
struct MixedContentExample {
  controller: RichEditorController = new RichEditorController()

  insertMixedContent() {
    const container = new ContainerSpan()

    // 容器样式
    container.setStyle({
      backgroundColor: '#FAFAFA',
      padding: 12,
      borderRadius: 8
    })

    // 添加标题
    const titleSpan = new TextSpan('图文混排示例')
    titleSpan.setStyle({
      fontSize: 18,
      fontWeight: 'bold',
      fontColor: '#333333',
      marginBottom: 8
    })
    container.append(titleSpan)

    // 添加描述文本
    const descSpan = new TextSpan('\n这是一个包含图片和文本的容器。')
    descSpan.setStyle({
      fontSize: 14,
      fontColor: '#666666'
    })
    container.append(descSpan)

    // 添加图片（示例）
    const imageSpan = new ImageSpan($r('sys.symbol.photo_fill'))
    imageSpan.setStyle({
      width: 60,
      height: 60,
      margin: { top: 8, bottom: 8 }
    })
    container.append(imageSpan)

    // 添加更多文本
    const moreTextSpan = new TextSpan('\n图片可以与文本混合排列，创建丰富的内容效果。')
    moreTextSpan.setStyle({
      fontSize: 14,
      fontColor: '#666666'
    })
    container.append(moreTextSpan)

    this.controller.aboutToIMEInput([container])
  }

  build() {
    Column({ space: 16 }) {
      Text('图文混排示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      RichEditor({ controller: this.controller })
        .width('100%')
        .height(300)
        .backgroundColor('#FFFFFF')
        .borderRadius(8)
        .padding(12)

      Button('插入图文混排')
        .onClick(() => {
          this.insertMixedContent()
        })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.5 嵌套容器示例

```typescript
@ComponentV2
struct NestedContainerExample {
  controller: RichEditorController = new RichEditorController()

  insertNestedContainer() {
    // 外层容器
    const outerContainer = new ContainerSpan()
    outerContainer.setStyle({
      backgroundColor: '#F5F5F5',
      padding: 16,
      borderRadius: 8
    })

    // 外层标题
    const outerTitle = new TextSpan('外层容器')
    outerTitle.setStyle({
      fontSize: 16,
      fontWeight: 'bold',
      fontColor: '#333333',
      marginBottom: 8
    })
    outerContainer.append(outerTitle)

    // 内层容器 1
    const innerContainer1 = new ContainerSpan()
    innerContainer1.setStyle({
      backgroundColor: '#E3F2FD',
      padding: 12,
      borderRadius: 4,
      marginTop: 8
    })

    const innerText1 = new TextSpan('内层容器 1')
    innerText1.setStyle({
      fontSize: 14,
      fontColor: '#007DFF'
    })
    innerContainer1.append(innerText1)
    outerContainer.append(innerContainer1)

    // 内层容器 2
    const innerContainer2 = new ContainerSpan()
    innerContainer2.setStyle({
      backgroundColor: '#E8F5E9',
      padding: 12,
      borderRadius: 4,
      marginTop: 8
    })

    const innerText2 = new TextSpan('内层容器 2')
    innerText2.setStyle({
      fontSize: 14,
      fontColor: '#28A745'
    })
    innerContainer2.append(innerText2)
    outerContainer.append(innerContainer2)

    this.controller.aboutToIMEInput([outerContainer])
  }

  build() {
    Column({ space: 16 }) {
      Text('嵌套容器示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      RichEditor({ controller: this.controller })
        .width('100%')
        .height(300)
        .backgroundColor('#FFFFFF')
        .borderRadius(8)
        .padding(12)

      Button('插入嵌套容器')
        .onClick(() => {
          this.insertNestedContainer()
        })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.6 列表容器示例

```typescript
@ComponentV2
struct ListContainerExample {
  controller: RichEditorController = new RichEditorController()

  insertListContainer() {
    const container = new ContainerSpan()

    container.setStyle({
      backgroundColor: '#FAFAFA',
      padding: 16,
      borderRadius: 8
    })

    // 标题
    const title = new TextSpan('待办事项列表')
    title.setStyle({
      fontSize: 16,
      fontWeight: 'bold',
      fontColor: '#333333',
      marginBottom: 12
    })
    container.append(title)

    // 列表项
    const items = [
      '完成 ContainerSpan 文档',
      '编写使用示例',
      '测试功能',
      '提交代码'
    ]

    items.forEach((item, index) => {
      const itemContainer = new ContainerSpan()
      itemContainer.setStyle({
        marginBottom: 8,
        padding: 8,
        backgroundColor: '#FFFFFF',
        borderRadius: 4
      })

      const itemText = new TextSpan(`${index + 1}. ${item}`)
      itemText.setStyle({
        fontSize: 14,
        fontColor: '#333333'
      })
      itemContainer.append(itemText)
      container.append(itemContainer)
    })

    this.controller.aboutToIMEInput([container])
  }

  build() {
    Column({ space: 16 }) {
      Text('列表容器示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      RichEditor({ controller: this.controller })
        .width('100%')
        .height(350)
        .backgroundColor('#FFFFFF')
        .borderRadius(8)
        .padding(12)

      Button('插入列表容器')
        .onClick(() => {
          this.insertListContainer()
        })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.7 完整富文本编辑器示例

```typescript
@ComponentV2
struct RichEditorWithContainerSpans {
  controller: RichEditorController = new RichEditorController()
  @Local currentFormat: string = 'text'

  insertText() {
    const textSpan = new TextSpan('普通文本内容')
    textSpan.setStyle({
      fontSize: 14,
      fontColor: '#333333'
    })
    this.controller.aboutToIMEInput([textSpan])
  }

  insertQuote() {
    const container = new ContainerSpan()
    container.setStyle({
      backgroundColor: '#F5F5F5',
      padding: 12,
      borderLeft: { width: 4, color: '#007DFF' },
      borderRadius: 4,
      margin: { top: 8, bottom: 8 }
    })

    const text = new TextSpan('引用内容')
    text.setStyle({
      fontSize: 14,
      fontColor: '#333333'
    })
    container.append(text)

    this.controller.aboutToIMEInput([container])
  }

  insertCode() {
    const container = new ContainerSpan()
    container.setStyle({
      backgroundColor: '#1E1E1E',
      padding: 16,
      borderRadius: 8,
      fontFamily: 'monospace'
    })

    const code = new TextSpan('console.log("Hello World");')
    code.setStyle({
      fontSize: 14,
      fontColor: '#D4D4D4'
    })
    container.append(code)

    this.controller.aboutToIMEInput([container])
  }

  insertAlert() {
    const container = new ContainerSpan()
    container.setStyle({
      backgroundColor: '#E3F2FD',
      padding: 12,
      borderRadius: 8,
      borderLeft: { width: 4, color: '#2196F3' }
    })

    const icon = new TextSpan('ℹ️')
    icon.setStyle({ fontSize: 16 })
    container.append(icon)

    const text = new TextSpan(' 重要信息')
    text.setStyle({
      fontSize: 14,
      fontColor: '#333333'
    })
    container.append(text)

    this.controller.aboutToIMEInput([container])
  }

  insertMixed() {
    const container = new ContainerSpan()
    container.setStyle({
      backgroundColor: '#FAFAFA',
      padding: 12,
      borderRadius: 8
    })

    const title = new TextSpan('图文混排')
    title.setStyle({
      fontSize: 16,
      fontWeight: 'bold',
      marginBottom: 8
    })
    container.append(title)

    const desc = new TextSpan('\n图片和文本混合显示')
    desc.setStyle({
      fontSize: 14,
      fontColor: '#666666'
    })
    container.append(desc)

    const image = new ImageSpan($r('sys.symbol.photo_fill'))
    image.setStyle({
      width: 50,
      height: 50,
      margin: { top: 8 }
    })
    container.append(image)

    this.controller.aboutToIMEInput([container])
  }

  build() {
    Column({ space: 16 }) {
      Text('富文本编辑器 - ContainerSpan')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      // 工具栏
      Row({ space: 8 }) {
        Button('文本')
          .fontSize(14)
          .type(this.currentFormat === 'text' ? ButtonType.Normal : ButtonType.Normal)
          .onClick(() => {
            this.insertText()
          })

        Button('引用')
          .fontSize(14)
          .onClick(() => {
            this.insertQuote()
          })

        Button('代码')
          .fontSize(14)
          .onClick(() => {
            this.insertCode()
          })

        Button('提示')
          .fontSize(14)
          .onClick(() => {
            this.insertAlert()
          })

        Button('图文')
          .fontSize(14)
          .onClick(() => {
            this.insertMixed()
          })
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      // 编辑器
      RichEditor({ controller: this.controller })
        .width('100%')
        .height(400)
        .backgroundColor('#FFFFFF')
        .borderRadius(8)
        .padding(12)
    }
    .width('100%')
    .padding(16)
  }
}
```

## 四、样式系统

### 4.1 容器样式属性

```typescript
interface ContainerStyle {
  // 背景相关
  backgroundColor?: string | Resource

  // 尺寸相关
  width?: Length
  height?: Length
  minWidth?: Length
  minHeight?: Length
  maxWidth?: Length
  maxHeight?: Length

  // 内边距
  padding?: Padding | number
  paddingTop?: number
  paddingRight?: number
  paddingBottom?: number
  paddingLeft?: number

  // 外边距
  margin?: Margin | number
  marginTop?: number
  marginRight?: number
  marginBottom?: number
  marginLeft?: number

  // 边框
  borderWidth?: number
  borderColor?: string | Resource
  borderRadius?: number | BorderRadius
  borderLeft?: { width: number, color: string | Resource }
  borderRight?: { width: number, color: string | Resource }
  borderTop?: { width: number, color: string | Resource }
  borderBottom?: { width: number, color: string | Resource }

  // 字体（继承到子元素）
  fontFamily?: string
  fontSize?: number
  fontStyle?: FontStyle
  fontWeight?: number | FontWeight

  // 阴影
  shadow?: ShadowOptions
}
```

### 4.2 样式继承

```typescript
// 容器样式会被子元素继承
const container = new ContainerSpan()
container.setStyle({
  fontSize: 16,
  fontColor: '#333333',
  fontFamily: 'Arial'
})

const textSpan = new TextSpan('继承容器样式')
// textSpan 会继承容器的 fontSize、fontColor、fontFamily

const customText = new TextSpan('自定义样式')
customText.setStyle({
  fontColor: '#007DFF'  // 覆盖继承的颜色
})
// customText 保留继承的 fontSize 和 fontFamily，但使用自定义的 fontColor
```

## 五、最佳实践

### 5.1 结构化内容

```typescript
// ✅ 推荐：使用语义化的容器结构
const articleContainer = new ContainerSpan()
articleContainer.setStyle({ padding: 16 })

// 标题
const title = new TextSpan('文章标题')
title.setStyle({ fontSize: 24, fontWeight: 'bold' })
articleContainer.append(title)

// 段落
const paragraph = new ContainerSpan()
paragraph.setStyle({ marginTop: 12 })
const text = new TextSpan('文章内容...')
paragraph.append(text)
articleContainer.append(paragraph)

// 引用
const quote = new ContainerSpan()
quote.setStyle({
  backgroundColor: '#F5F5F5',
  padding: 12,
  borderLeft: { width: 4, color: '#007DFF' },
  marginTop: 12
})
const quoteText = new TextSpan('引用内容')
quote.append(quoteText)
articleContainer.append(quote)
```

### 5.2 样式复用

```typescript
// ✅ 推荐：定义样式常量
const STYLES = {
  quoteBox: {
    backgroundColor: '#F5F5F5',
    padding: 12,
    borderRadius: 8,
    borderLeft: { width: 4, color: '#007DFF' }
  },
  codeBox: {
    backgroundColor: '#1E1E1E',
    padding: 16,
    borderRadius: 8,
    fontFamily: 'monospace'
  },
  alertBox: {
    backgroundColor: '#E3F2FD',
    padding: 12,
    borderRadius: 8,
    borderLeft: { width: 4, color: '#2196F3' }
  }
}

// 使用样式
const quoteContainer = new ContainerSpan()
quoteContainer.setStyle(STYLES.quoteBox)
```

### 5.3 内容构建器模式

```typescript
// ✅ 推荐：使用构建器模式创建复杂容器
class ContainerBuilder {
  private container: ContainerSpan = new ContainerSpan()

  static create(): ContainerBuilder {
    return new ContainerBuilder()
  }

  setStyle(style: ContainerStyle): ContainerBuilder {
    this.container.setStyle(style)
    return this
  }

  addText(content: string, style?: TextStyle): ContainerBuilder {
    const textSpan = new TextSpan(content)
    if (style) {
      textSpan.setStyle(style)
    }
    this.container.append(textSpan)
    return this
  }

  addImage(source: Resource, style?: ImageStyle): ContainerBuilder {
    const imageSpan = new ImageSpan(source)
    if (style) {
      imageSpan.setStyle(style)
    }
    this.container.append(imageSpan)
    return this
  }

  addContainer(childContainer: ContainerSpan): ContainerBuilder {
    this.container.append(childContainer)
    return this
  }

  build(): ContainerSpan {
    return this.container
  }
}

// 使用构建器
const container = ContainerBuilder.create()
  .setStyle({
    backgroundColor: '#F5F5F5',
    padding: 16
  })
  .addText('标题', { fontSize: 18, fontWeight: 'bold' })
  .addText('内容', { fontSize: 14 })
  .build()
```

## 六、常见问题

### Q1: ContainerSpan 与 TextSpan 有什么区别？

**答**:
- **ContainerSpan**: 容器级片段，可以包含多个子片段，支持独立的容器样式
- **TextSpan**: 文本级片段，只能包含纯文本，主要用于文本样式

```typescript
// ContainerSpan - 容器
const container = new ContainerSpan()
container.setStyle({ backgroundColor: '#F5F5F5', padding: 12 })
container.append(new TextSpan('文本 1'))
container.append(new TextSpan('文本 2'))

// TextSpan - 文本
const text = new TextSpan('纯文本内容')
text.setStyle({ fontColor: '#FF0000' })
```

### Q2: 如何在 ContainerSpan 中实现复杂的布局？

**解决方案**:
```typescript
// 使用嵌套容器和样式控制
const outerContainer = new ContainerSpan()
outerContainer.setStyle({ padding: 16 })

// 左右布局
const leftContainer = new ContainerSpan()
leftContainer.setStyle({
  width: '50%',
  display: 'inline-block'
})
leftContainer.append(new TextSpan('左侧内容'))

const rightContainer = new ContainerSpan()
rightContainer.setStyle({
  width: '50%',
  display: 'inline-block'
})
rightContainer.append(new TextSpan('右侧内容'))

outerContainer.append(leftContainer)
outerContainer.append(rightContainer)
```

### Q3: ContainerSpan 的性能如何优化？

**优化策略**:
```typescript
// 1. 避免过深的嵌套层级（建议不超过 3 层）
// ❌ 避免
ContainerSpan
  └── ContainerSpan
      └── ContainerSpan
          └── ContainerSpan

// 2. 避免在容器中使用大量子元素
// ✅ 推荐：拆分为多个容器
const container1 = new ContainerSpan()
// 添加少量子元素

const container2 = new ContainerSpan()
// 添加少量子元素

// 3. 复用样式对象
const COMMON_STYLE = {
  padding: 12,
  borderRadius: 8
}

const container1 = new ContainerSpan()
container1.setStyle(COMMON_STYLE)

const container2 = new ContainerSpan()
container2.setStyle(COMMON_STYLE)
```

### Q4: 如何实现可编辑的 ContainerSpan？

**解决方案**:
```typescript
@ComponentV2
struct EditableContainerSpan {
  controller: RichEditorController = new RichEditorController()

  editContainer() {
    // 获取选中的容器
    const spans = this.controller.getSpans()
    const containerSpan = spans.find(span => span instanceof ContainerSpan)

    if (containerSpan) {
      // 修改容器样式
      containerSpan.setStyle({
        ...containerSpan.getStyle(),
        backgroundColor: '#FFE0B2'
      })

      // 更新编辑器内容
      this.controller.updateSpan(containerSpan)
    }
  }

  build() {
    Column({ space: 16 }) {
      RichEditor({ controller: this.controller })

      Button('编辑选中容器')
        .onClick(() => {
          this.editContainer()
        })
    }
  }
}
```

### Q5: ContainerSpan 支持哪些样式？

**支持的样式**:
- ✅ 背景颜色、边框、圆角
- ✅ 内外边距
- ✅ 尺寸控制（width、height）
- ✅ 字体样式（可被子元素继承）
- ✅ 阴影效果

**不支持的样式**:
- ❌ 复杂的布局（Flex、Grid）
- ❌ 绝对定位
- ❌ 动画效果

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 12+ | ✅ | 初始支持 |
| API 13+ | ✅ | 增强功能 |

## 八、参考资料

- [ContainerSpan 容器片段 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-container-span-V5)
- [RichEditor 富文本编辑器 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-richeditor-V5)
- [TextSpan 文本片段 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-text-span-V5)
- [ImageSpan 图片片段 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-image-span-V5)
