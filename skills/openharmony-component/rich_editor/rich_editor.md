# RichEditor 组件 HarmonyOS 6.0 开发 Skill

## 概述

RichEditor 组件是 OpenHarmony 中用于富文本编辑的组件，支持文本的插入、删除、样式修改等操作。它提供了丰富的文本编辑功能，包括文本格式化、图片插入、列表管理等。

## 重要说明

- **编辑功能**: 支持富文本内容的编辑和格式化
- **控制器**: 需要配合 RichEditorController 使用
- **样式管理**: 支持文本样式、段落样式等
- **事件监听**: 提供丰富的事件回调接口

## 模块信息

- **组件名称**: RichEditor
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [RichEditor 富文本编辑器 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-richeditor-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// RichEditor 是内置组件，无需导入
// 直接使用即可
RichEditor()
```

### 1.2 基础用法

```typescript
@ComponentV2
struct BasicRichEditorExample {
  controller: RichEditorController = new RichEditorController()

  build() {
    RichEditor({ controller: this.controller })
      .width('100%')
      .height(200)
      .backgroundColor('#F5F5F5')
  }
}
```

### 1.3 控制器使用

```typescript
@ComponentV2
struct RichEditorWithController {
  controller: RichEditorController = new RichEditorController()

  build() {
    Column({ space: 16 }) {
      RichEditor({ controller: this.controller })
        .width('100%')
        .height(200)

      Button('插入文本')
        .onClick(() => {
          this.controller
            .aboutToIMEInput(['Hello World'])
            .then(() => {
              console.info('文本插入成功')
            })
            .catch((err: Error) => {
              console.error('文本插入失败:', err.message)
            })
        })
    }
  }
}
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| options | `RichEditorOptions` | 否 | - | 富文本编辑器选项，如 controller |
| controller | `RichEditorController` | 是 | - | 控制器对象 |

### 2.2 RichEditorController 方法

| 方法 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `aboutToIMEInput` | `value: Array\<TextContentInfo\>` | `Promise\<void\>` | 插入文本内容 |
| `getSpans` | - | `Array\<TextSpanInfo\>` | 获取所有文本片段信息 |
| `getSelectedText` | - | `string` | 获取选中的文本 |
| `setSelectedText` | `text: string` | `void` | 设置选中的文本 |
| `deleteSpans` | `spans: Array\<TextSpanInfo\>` | `void` | 删除指定的文本片段 |
| `updateSpanStyle` | `span: TextSpanInfo, style: TextStyle` | `void` | 更新文本片段样式 |

### 2.3 常用属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `ready` | `boolean` | false | 编辑器是否准备就绪 |
| `backgroundColor` | `ResourceColor` | - | 背景颜色 |
| `placeholder` | `string` | - | 占位符文本 |
| `padding` | `Padding \| Length` | - | 内边距 |
| `borderRadius` | `Length` | - | 圆角半径 |

## 三、使用示例

### 3.1 基础编辑器示例

```typescript
@ComponentV2
struct BasicRichEditor {
  controller: RichEditorController = new RichEditorController()

  build() {
    Column({ space: 16 }) {
      Text('富文本编辑器')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      RichEditor({ controller: this.controller })
        .width('100%')
        .height(200)
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
        .padding(12)
        .placeholder('请输入内容...')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.2 插入文本示例

```typescript
@ComponentV2
struct InsertTextExample {
  controller: RichEditorController = new RichEditorController()

  build() {
    Column({ space: 16 }) {
      RichEditor({ controller: this.controller })
        .width('100%')
        .height(200)
        .backgroundColor('#F5F5F5')
        .padding(12)

      Row({ space: 12 }) {
        Button('插入文本')
          .onClick(() => {
            this.controller.aboutToIMEInput([{
              type: 'text',
              value: 'Hello World'
            }])
          })

        Button('插入换行')
          .onClick(() => {
            this.controller.aboutToIMEInput([{
              type: 'newline'
            }])
          })
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.3 文本样式编辑示例

```typescript
@ComponentV2
struct TextStyleExample {
  controller: RichEditorController = new RichEditorController()

  build() {
    Column({ space: 16 }) {
      RichEditor({ controller: this.controller })
        .width('100%')
        .height(200)
        .backgroundColor('#F5F5F5')
        .padding(12)

      Row({ space: 12 }) {
        Button('粗体')
          .onClick(() => {
            const spans = this.controller.getSpans()
            if (spans.length > 0) {
              // 设置粗体样式
              console.info('设置粗体')
            }
          })

        Button('斜体')
          .onClick(() => {
            const spans = this.controller.getSpans()
            if (spans.length > 0) {
              // 设置斜体样式
              console.info('设置斜体')
            }
          })

        Button('下划线')
          .onClick(() => {
            const spans = this.controller.getSpans()
            if (spans.length > 0) {
              // 设置下划线样式
              console.info('设置下划线')
            }
          })
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.4 事件监听示例

```typescript
@ComponentV2
struct RichEditorEventsExample {
  controller: RichEditorController = new RichEditorController()
  @Local textContent: string = ''

  build() {
    Column({ space: 16 }) {
      RichEditor({ controller: this.controller })
        .width('100%')
        .height(200)
        .backgroundColor('#F5F5F5')
        .padding(12)
        .onReady(() => {
          console.info('RichEditor 准备就绪')
        })
        .aboutToInput((value: string) => {
          console.info('即将输入:', value)
          this.textContent = value
        })
        .aboutToDelete((range: TextRange) => {
          console.info('即将删除:', JSON.stringify(range))
        })

      Text(`内容长度: ${this.textContent.length}`)
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.5 获取选中文本示例

```typescript
@ComponentV2
struct GetSelectedTextExample {
  controller: RichEditorController = new RichEditorController()
  @Local selectedText: string = ''

  build() {
    Column({ space: 16 }) {
      RichEditor({ controller: this.controller })
        .width('100%')
        .height(200)
        .backgroundColor('#F5F5F5')
        .padding(12)

      Button('获取选中文本')
        .onClick(() => {
          this.selectedText = this.controller.getSelectedText()
          console.info('选中的文本:', this.selectedText)
        })

      if (this.selectedText) {
        Text(`选中文本: ${this.selectedText}`)
          .fontSize(14)
          .fontColor('#007DFF')
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.6 工具栏示例

```typescript
@ComponentV2
struct RichEditorWithToolbar {
  controller: RichEditorController = new RichEditorController()

  build() {
    Column({ space: 16 }) {
      // 工具栏
      Row({ space: 8 }) {
        ForEach(['加粗', '斜体', '下划线'], (item: string) => {
          Button(item)
            .fontSize(14)
            .height(36)
            .onClick(() => {
              console.info('点击工具:', item)
            })
        })
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#FFFFFF')
      .borderRadius(8)

      RichEditor({ controller: this.controller })
        .width('100%')
        .height(200)
        .backgroundColor('#F5F5F5')
        .padding(12)
        .borderRadius(8)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
  }
}
```

## 四、事件处理

### 4.1 生命周期事件

```typescript
RichEditor({ controller: this.controller })
  .onReady(() => {
    console.info('RichEditor 准备就绪')
  })
  .onDestroy(() => {
    console.info('RichEditor 即将销毁')
  })
```

### 4.2 输入事件

```typescript
RichEditor({ controller: this.controller })
  .aboutToInput((value: string) => {
    console.info('即将输入内容:', value)
    // 返回 true 允许输入，false 阻止输入
    return true
  })
  .onInput((value: string) => {
    console.info('已输入内容:', value)
  })
```

### 4.3 删除事件

```typescript
RichEditor({ controller: this.controller })
  .aboutToDelete((range: TextRange) => {
    console.info('即将删除范围:', range.start, range.end)
    // 返回 true 允许删除，false 阻止删除
    return true
  })
  .onDelete((range: TextRange) => {
    console.info('已删除范围:', range.start, range.end)
  })
```

### 4.4 选择事件

```typescript
RichEditor({ controller: this.controller })
  .onSelect((range: TextRange) => {
    console.info('选择范围:', range.start, range.end)
  })
```

## 五、最佳实践

### 5.1 控制器管理

```typescript
// ✅ 推荐：在组件中创建控制器
@ComponentV2
struct MyComponent {
  controller: RichEditorController = new RichEditorController()

  build() {
    RichEditor({ controller: this.controller })
  }
}

// ❌ 避免：共享控制器实例
const sharedController = new RichEditorController()
// 多个组件共享同一个控制器会导致状态混乱
```

### 5.2 输入验证

```typescript
RichEditor({ controller: this.controller })
  .aboutToInput((value: string) => {
    // 验证输入内容
    if (value.length > 1000) {
      console.warn('输入内容过长')
      return false // 阻止输入
    }
    return true // 允许输入
  })
```

### 5.3 性能优化

```typescript
// ✅ 推荐：避免频繁更新
@ComponentV2
struct OptimizedRichEditor {
  controller: RichEditorController = new RichEditorController()
  @Local content: string = ''

  build() {
    RichEditor({ controller: this.controller })
      .onInput((value: string) => {
        // 使用防抖减少更新频率
        debounce(() => {
          this.content = value
        }, 300)
      })
  }
}
```

### 5.4 样式管理

```typescript
// ✅ 推荐：统一样式管理
const EDITOR_STYLE = {
  backgroundColor: '#F5F5F5',
  padding: 12,
  borderRadius: 8,
  fontSize: 16
}

RichEditor({ controller: this.controller })
  .backgroundColor(EDITOR_STYLE.backgroundColor)
  .padding(EDITOR_STYLE.padding)
  .borderRadius(EDITOR_STYLE.borderRadius)
```

## 六、常见问题

### Q1: RichEditor 无法输入内容？

**问题**: 编辑器无法输入文本。

**解决方案**:
```typescript
// 确保控制器正确绑定
@ComponentV2
struct MyComponent {
  controller: RichEditorController = new RichEditorController()

  build() {
    RichEditor({ controller: this.controller })
      .onReady(() => {
        console.info('编辑器准备就绪')
      })
  }
}
```

### Q2: 如何获取编辑器内容？

**解决方案**:
```typescript
@ComponentV2
struct GetContentExample {
  controller: RichEditorController = new RichEditorController()
  @Local content: string = ''

  build() {
    Column({ space: 16 }) {
      RichEditor({ controller: this.controller })
        .onInput((value: string) => {
          this.content = value
        })

      Button('获取内容')
        .onClick(() => {
          console.info('编辑器内容:', this.content)
        })
    }
  }
}
```

### Q3: 如何设置初始内容？

**解决方案**:
```typescript
@ComponentV2
struct InitialContentExample {
  controller: RichEditorController = new RichEditorController()
  @Local isReady: boolean = false

  build() {
    RichEditor({ controller: this.controller })
      .onReady(() => {
        this.isReady = true
        // 设置初始内容
        this.controller.aboutToIMEInput([{
          type: 'text',
          value: '初始内容'
        }])
      })
  }
}
```

### Q4: 如何实现文本格式化？

**解决方案**:
```typescript
@ComponentV2
struct FormatTextExample {
  controller: RichEditorController = new RichEditorController()

  setBold() {
    const spans = this.controller.getSpans()
    spans.forEach(span => {
      // 更新样式为粗体
      this.controller.updateSpanStyle(span, {
        fontWeight: FontWeight.Bold
      })
    })
  }

  build() {
    Column({ space: 16 }) {
      RichEditor({ controller: this.controller })
        .width('100%')
        .height(200)

      Button('设置粗体')
        .onClick(() => this.setBold())
    }
  }
}
```

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 10+ | ✅ | 基础支持 |
| API 12+ | ✅ | 增强编辑功能 |

## 八、参考资料

- [RichEditor 富文本编辑器 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-richeditor-V5)
- [文本输入 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/text-input-development-V5)
