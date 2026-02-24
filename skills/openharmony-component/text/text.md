# Text 组件 HarmonyOS 6.0 开发 Skill

## 概述

Text 组件是 OpenHarmony 中最基础的文本显示组件，用于在界面上显示一段文本内容。它支持丰富的文本样式设置，包括字体、颜色、对齐方式、行高、字间距等多种属性。

## 重要说明

- **基础组件**: Text 是 ArkUI 的基础内置组件，无需导入
- **默认字体**: HarmonyOS Sans
- **默认字体大小**: 16fp (可穿戴设备为 15fp)
- **默认字体颜色**: '#e6182431' (可穿戴设备为 '#c5ffffff')
- **自适应**: 支持字体大小自适应布局
- **复制功能**: 支持 copyOption 设置文本复制选项

## 模块信息

- **组件名称**: Text
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [Text 文本 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-text-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// Text 是内置组件，无需导入
// 直接使用即可
Text('Hello World')
```

### 1.2 基础用法

```typescript
// 简单文本显示
Text('Hello World')

// 使用资源引用
Text($r('app.string.app_name'))

// 设置文本颜色
Text('Hello World')
  .fontColor('#007DFF')

// 设置字体大小
Text('Hello World')
  .fontSize(20)

// 多个样式组合
Text('Hello World')
  .fontSize(18)
  .fontColor('#333333')
  .fontWeight(FontWeight.Bold)
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| content | `string \| Resource` | 否 | ' ' | 文本内容，可以是字符串或资源引用 |
| options | `TextOptions` | 否 | - | 文本选项，如 controller |

### 2.2 字体属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `fontColor` | `ResourceColor` | '#e6182431' | 字体颜色 |
| `fontSize` | `number \| string \| Resource` | 16fp | 字体大小 |
| `fontStyle` | `FontStyle` | FontStyle.Normal | 字体样式（正常/斜体） |
| `fontWeight` | `number \| FontWeight \| string` | FontWeight.Normal | 字体粗细（100-900） |
| `fontFamily` | `string \| Resource` | 'HarmonyOS Sans' | 字体列表 |

### 2.3 字体适配属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `minFontSize` | `number \| string \| Resource` | - | 最小字体大小，需配合 maxLines 使用 |
| `maxFontSize` | `number \| string \| Resource` | - | 最大字体大小，需配合 maxLines 使用 |
| `minFontScale` | `number \| Resource` | - | 最小字体缩放比例 [0, 1] |
| `maxFontScale` | `number \| Resource` | - | 最大字体缩放比例 [1, +∞] |
| `heightAdaptivePolicy` | `TextHeightAdaptivePolicy` | MAX_LINES_FIRST | 字体高度自适应策略 |

### 2.4 文本对齐属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `textAlign` | `TextAlign` | TextAlign.Start | 文本水平对齐方式 |
| `textVerticalAlign` | `TextVerticalAlign` | BASELINE | 文本垂直对齐方式 |
| `textContentAlign` | `TextContentAlign` | CENTER | 文本整体垂直对齐方式 |

### 2.5 文本布局属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `lineHeight` | `number \| string \| Resource` | - | 文本行高 |
| `lineSpacing` | `LengthMetrics` | 0 | 文本行间距 |
| `maxLines` | `number` | - | 最大文本行数 |
| `textOverflow` | `TextOverflowOptions` | - | 文本超长时的显示方式 |
| `wordBreak` | `WordBreak` | BREAK_WORD | 断行类型 |
| `lineBreakStrategy` | `LineBreakStrategy` | GREEDY | 断行策略 |

### 2.6 文本装饰属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `decoration` | `DecorationStyleInterface` | {type: None} | 文本装饰线（下划线、删除线等） |
| `letterSpacing` | `number \| string` | 0 | 字符间距 |
| `textCase` | `TextCase` | TextCase.Normal | 文本大小写转换 |
| `baselineOffset` | `number \| string` | 0 | 基线偏移量 |
| `textIndent` | `Length` | 0 | 首行缩进 |

### 2.7 文本交互属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `copyOption` | `CopyOptions` | CopyOptions.None | 文本复制选项 |
| `draggable` | `boolean` | false | 是否可拖拽选中文本 |
| `textSelectable` | `TextSelectableMode` | SELECTABLE_UNFOCUSABLE | 文本可选模式 |

### 2.8 文本效果属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `textShadow` | `ShadowOptions \| Array<ShadowOptions>` | - | 文本阴影 |
| `textBackground` | `TextStyleOptions` | - | 文本背景样式 |
| `shaderStyle` | `ShaderStyle` | - | 文本着色样式 |

### 2.9 文本选择属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `selection` | `(selectionStart: number, selectionEnd: number)` | - | 文本选择范围 |
| `caretColor` | `ResourceColor` | - | 选择文本光标颜色 |
| `selectedBackgroundColor` | `ResourceColor` | - | 选中文本背景色 |

### 2.10 省略号属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `ellipsisMode` | `EllipsisMode` | EllipsisMode.END | 省略号位置 |

### 2.11 文本控制器

| 属性 | 类型 | 描述 |
|------|------|------|
| `controller` | `TextController` | Text 组件控制器，用于关闭选择菜单等操作 |

## 三、使用示例

### 3.1 基础文本示例

```typescript
// 简单文本
Text('Hello World')
  .fontSize(20)
  .fontColor('#333333')

// 使用资源引用
Text($r('app.string.app_name'))
  .fontSize(18)
  .fontColor($r('app.color.primary'))

// 多行文本
Text('这是一段很长的文本内容，它会自动换行显示。Text 组件支持多行文本显示，当内容超出容器宽度时会自动换行。')
  .fontSize(16)
  .fontColor('#666666')
  .width('100%')
```

### 3.2 字体样式示例

```typescript
// 粗体文本
Text('粗体文本')
  .fontSize(20)
  .fontWeight(FontWeight.Bold)

// 斜体文本
Text('斜体文本')
  .fontSize(20)
  .fontStyle(FontStyle.Italic)

// 自定义字重 (100-900)
Text('自定义字重')
  .fontSize(20)
  .fontWeight(700)

// 组合样式
Text('组合样式')
  .fontSize(22)
  .fontWeight(FontWeight.Bold)
  .fontStyle(FontStyle.Italic)
  .fontColor('#007DFF')
  .fontFamily('HarmonyOS Sans')
```

### 3.3 文本对齐示例

```typescript
// 居中对齐
Text('居中文本')
  .width('100%')
  .textAlign(TextAlign.Center)
  .fontSize(18)

// 左对齐
Text('左对齐文本')
  .width('100%')
  .textAlign(TextAlign.Start)
  .fontSize(18)

// 右对齐
Text('右对齐文本')
  .width('100%')
  .textAlign(TextAlign.End)
  .fontSize(18)

// 两端对齐
Text('两端对齐文本需要配合 wordBreak 使用，文本会在容器内两端对齐显示效果更好。')
  .width('100%')
  .textAlign(TextAlign.JUSTIFY)
  .wordBreak(WordBreak.BREAK_ALL)
  .fontSize(16)
```

### 3.4 文本溢出示例

```typescript
// 单行省略
Text('这是一段很长的文本内容，超出的部分会显示省略号。')
  .width(200)
  .maxLines(1)
  .textOverflow({ overflow: TextOverflow.Ellipsis })
  .fontSize(16)

// 多行省略
Text('这是一段很长的文本内容，超出两行的部分会显示省略号。Text 组件支持多行文本溢出显示，当内容超出指定的行数时会自动显示省略号。')
  .width(200)
  .maxLines(2)
  .textOverflow({ overflow: TextOverflow.Ellipsis })
  .fontSize(16)

// 跑马灯效果
Text('这是一段滚动显示的文本内容，会自动滚动显示。')
  .width(200)
  .textOverflow({ overflow: TextOverflow.MARQUEE })
  .fontSize(16)
```

### 3.5 文本装饰示例

```typescript
// 下划线
Text('下划线文本')
  .fontSize(20)
  .decoration({
    type: TextDecorationType.Underline,
    color: '#007DFF'
  })

// 删除线
Text('删除线文本')
  .fontSize(20)
  .decoration({
    type: TextDecorationType.LineThrough,
    color: '#FF0000'
  })

// 顶划线
Text('顶划线文本')
  .fontSize(20)
  .decoration({
    type: TextDecorationType.Overline,
    color: '#00FF00'
  })
```

### 3.6 文本阴影示例

```typescript
// 简单阴影
Text('文本阴影')
  .fontSize(24)
  .fontColor('#FFFFFF')
  .textShadow({
    radius: 10,
    color: '#007DFF',
    offsetX: 2,
    offsetY: 2
  })

// 多重阴影
Text('多重阴影效果')
  .fontSize(24)
  .fontColor('#FFFFFF')
  .textShadow([
    { radius: 5, color: '#007DFF', offsetX: 2, offsetY: 2 },
    { radius: 10, color: '#FFC107', offsetX: -2, offsetY: -2 }
  ])
```

### 3.7 自适应字体大小示例

```typescript
// 字体大小自适应
Text('自适应文本大小')
  .width(200)
  .height(60)
  .maxLines(1)
  .minFontSize(12)
  .maxFontSize(24)
  .textOverflow({ overflow: TextOverflow.Ellipsis })
  .backgroundColor('#F5F5F5')

// 使用自适应策略
Text('自适应策略文本')
  .width(200)
  .height(60)
  .maxLines(1)
  .minFontSize(12)
  .maxFontSize(24)
  .heightAdaptivePolicy(TextHeightAdaptivePolicy.MIN_FONT_SIZE_FIRST)
  .backgroundColor('#F5F5F5')
```

### 3.8 文本复制示例

```typescript
// 允许复制
Text('长按可复制的文本')
  .fontSize(16)
  .copyOption(CopyOptions.InApp)

// 跨设备复制
Text('可跨设备复制的文本')
  .fontSize(16)
  .copyOption(CopyOptions.LocalDevice)
  .draggable(true)

// 监听复制事件
Text('监听复制事件')
  .fontSize(16)
  .copyOption(CopyOptions.InApp)
  .onCopy((value: string) => {
    console.info('复制的文本: ' + value)
  })
```

### 3.9 首行缩进示例

```typescript
// 首行缩进
Text('首行缩进的文本效果。这是第二行文本，不会缩进显示。这是第三行文本，同样不会缩进。')
  .width('100%')
  .fontSize(16)
  .textIndent(32)
```

### 3.10 文本控制器示例

```typescript
@ComponentV2
struct TextControllerExample {
  textController: TextController = new TextController()

  build() {
    Column({ space: 16 }) {
      Text('带控制器的文本')
        .fontSize(18)
        .copyOption(CopyOptions.InApp)
        .controller(this.textController)

      Button('关闭选择菜单')
        .onClick(() => {
          this.textController.closeSelectionMenu()
        })
    }
  }
}
```

## 四、高级用法

### 4.1 RichText 混合文本

Text 组件可以包含 Span 子组件，实现富文本效果：

```typescript
Text() {
  Span('红色')
    .fontColor('#FF0000')
  Span('和')
    .fontColor('#000000')
  Span('蓝色')
    .fontColor('#0000FF')
  Span('的混合文本')
    .fontColor('#000000')
}
.fontSize(20)
```

### 4.2 动态文本更新

```typescript
@ComponentV2
struct DynamicTextExample {
  @Local message: string = '初始文本'

  build() {
    Column({ space: 16 }) {
      Text(this.message)
        .fontSize(20)

      Button('更新文本')
        .onClick(() => {
          this.message = '更新后的文本内容'
        })
    }
  }
}
```

### 4.3 数据检测器

```typescript
// 自动识别并高亮显示实体
Text('联系电话：10086，邮箱：example@huawei.com')
  .fontSize(16)
  .enableDataDetector(true)
  .dataDetectorConfig({
    types: [DataDetectorType.PHONE_NUMBER, DataDetectorType.EMAIL]
  })
```

### 4.4 自定义选择菜单

```typescript
@Builder
function CustomMenu() {
  Menu() {
    MenuItem({ content: '自定义选项1' })
    MenuItem({ content: '自定义选项2' })
  }
}

Text('带自定义菜单的文本')
  .fontSize(16)
  .copyOption(CopyOptions.InApp)
  .bindSelectionMenu(TextSpanType.TEXT, CustomMenu(), TextResponseType.LONG_PRESS)
```

## 五、最佳实践

### 5.1 字体大小选择

```typescript
// ✅ 推荐：使用 fp 单位适配不同屏幕
Text('推荐文本')
  .fontSize(16)

// ❌ 避免：使用 px 单位（无法适配）
Text('不推荐文本')
  .fontSize(16)
```

### 5.2 文本溢出处理

```typescript
// ✅ 推荐：设置 maxLines 配合 textOverflow
Text('这是一段很长的文本内容')
  .maxLines(2)
  .textOverflow({ overflow: TextOverflow.Ellipsis })

// ❌ 避免：只设置 maxLines 而不处理溢出
Text('这是一段很长的文本内容')
  .maxLines(2)  // 文本可能被截断
```

### 5.3 字体族设置

```typescript
// ✅ 推荐：指定字体列表，包含备选字体
Text('字体示例')
  .fontFamily('HarmonyOS Sans, sans-serif')

// ❌ 避免：只指定单一字体
Text('字体示例')
  .fontFamily('CustomFont')  // 字体不存在时无法显示
```

### 5.4 文本复制

```typescript
// ✅ 推荐：需要复制的文本明确设置 copyOption
Text('可复制的文本')
  .copyOption(CopyOptions.InApp)

// ❌ 避免：所有文本都启用复制
Text('不需要复制的文本')
  .copyOption(CopyOptions.InApp)  // 用户可能误操作
```

### 5.5 性能优化

```typescript
// ✅ 推荐：静态文本使用常量
const STATIC_TEXT = '静态文本内容'
Text(STATIC_TEXT)

// ❌ 避免：重复创建相同文本
Text('每次都创建的文本内容')  // 在循环或频繁刷新中
```

## 六、常见问题

### Q1: Text 组件显示不全？

**问题**: 设置了固定宽度和高度，但文本被截断。

**解决方案**:
```typescript
// 方案 1: 设置 textOverflow 和 maxLines
Text('很长的文本内容')
  .width(200)
  .maxLines(2)
  .textOverflow({ overflow: TextOverflow.Ellipsis })

// 方案 2: 使用自适应字体大小
Text('很长的文本内容')
  .width(200)
  .height(60)
  .minFontSize(12)
  .maxFontSize(24)
  .maxLines(1)
```

### Q2: 如何让文本垂直居中？

**问题**: Text 组件在容器中无法垂直居中。

**解决方案**:
```typescript
// 使用 align 属性配合容器
Column() {
  Text('垂直居中文本')
    .fontSize(20)
}
.width('100%')
.height('100%')
.alignItems(HorizontalAlign.Center)
.justifyContent(FlexAlign.Center)
```

### Q3: textAlign 不生效？

**问题**: 设置了 textAlign 但文本没有对齐。

**解决方案**:
```typescript
// ❌ 错误：没有设置宽度
Text('居中文本')
  .textAlign(TextAlign.Center)

// ✅ 正确：需要设置宽度
Text('居中文本')
  .width('100%')  // 必须设置宽度
  .textAlign(TextAlign.Center)
```

### Q4: 如何实现文本跑马灯效果？

**解决方案**:
```typescript
Text('跑马灯效果文本，会自动滚动显示')
  .width(200)
  .textOverflow({ overflow: TextOverflow.MARQUEE })
```

### Q5: 字体大小在某些设备上显示不一致？

**解决方案**:
```typescript
// ✅ 使用 fp 单位（自适应屏幕密度）
Text('文本')
  .fontSize(16)  // 默认单位是 fp

// ✅ 使用资源引用
Text('文本')
  .fontSize($r('app.float.text_size'))
```

### Q6: 如何同时设置多种文本装饰？

**解决方案**:
```typescript
// Text 组件不支持多种装饰同时设置
// 如需多种效果，使用嵌套结构
Column({ space: 0 }) {
  Text('删除线和下划线')
    .decoration({
      type: TextDecorationType.LineThrough,
      color: '#FF0000'
    })
  Text('删除线和下划线')
    .decoration({
      type: TextDecorationType.Underline,
      color: '#007DFF'
    })
    .position({ x: 0, y: 0 })
}
```

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 9+ | ✅ | 完全支持 |
| API 11+ | ✅ | 增加了 textVerticalAlign, fontFeature 等属性 |
| API 12+ | ✅ | 增加了 lineSpacing, textSelectable 等属性 |
| API 18+ | ✅ | 增加了 textOverflow 支持对象参数 |
| API 20+ | ✅ | 增加了 textContentAlign, shaderStyle 等属性 |

## 八、参考资料

- [Text 文本 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-text-V5)
- [通用属性 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-universal-attributes-size-V5)
- [Text 组件实例 - 华为开发者社区](https://developer.huawei.com/consumer/cn/doc/harmonyos-samples-V5/text-component-V5)
