# PasteButton 粘贴按钮组件

## 组件概述

**PasteButton** 是 OpenHarmony 提供的系统粘贴按钮组件,用于快速访问剪贴板内容并进行粘贴操作。该组件提供了一致的粘贴体验和系统级的安全控制。

### 核心特性

- **系统集成**: 与系统剪贴板深度集成
- **类型过滤**: 支持按内容类型过滤(文本、图片、URI等)
- **权限管理**: 自动处理剪贴板读取权限
- **回调机制**: 通过回调函数处理粘贴内容
- **自定义样式**: 支持自定义按钮外观

## 基本语法

```typescript
PasteButton(options?: {
  icon?: PasteIconStyle,
  text?: string | Resource,
  buttonType?: ButtonType
})
```

### 参数说明

| 参数名 | 类型 | 必填 | 默认值 | 说明 |
|--------|------|------|--------|------|
| icon | PasteIconStyle | 否 | PasteIconStyle.LINES | 图标样式 |
| text | string\|Resource | 否 | PasteDescription.PASTE | 按钮文本 |
| buttonType | ButtonType | 否 | ButtonType.Capsule | 按钮类型 |

## PasteIconStyle 枚举

```typescript
enum PasteIconStyle {
  LINES,      // 线性图标
  FULL        // 填充图标
}
```

## PasteDescription 预定义文本

```typescript
PasteDescription.PASTE                        // "粘贴"
PasteDescription.PASTE_FROM_CLIPBOARD         // "从剪贴板粘贴"
PasteDescription.PASTE_VERIFICATION_CODE      // "粘贴验证码"
// ... 更多预定义文本
```

## 事件回调

```typescript
.onClick(event: (event: ClickEvent, result: PasteButtonOnClickResult) => void)
```

### PasteButtonOnClickResult 枚举

```typescript
enum PasteButtonOnClickResult {
  SUCCESS,    // 粘贴成功
  FAILURE     // 粘贴失败
}
```

## 使用示例

### 基础文本粘贴

```typescript
import { pasteboard } from '@kit.BasicServicesKit';

@ComponentV2
struct BasicPasteButtonExample {
  @Local pastedText: string = ''

  build() {
    Column({ space: 20 }) {
      Text('粘贴结果:')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)

      Text(this.pastedText)
        .width('100%')
        .height(100)
        .backgroundColor('#F5F5F5')
        .padding(12)
        .borderRadius(8)

      PasteButton({
        icon: PasteIconStyle.LINES,
        text: PasteDescription.PASTE,
        buttonType: ButtonType.Capsule
      })
        .onClick((event: ClickEvent, result: PasteButtonOnClickResult) => {
          if (result === PasteButtonOnClickResult.SUCCESS) {
            const systemPasteboard = pasteboard.getSystemPasteboard()
            systemPasteboard.getData((err: BusinessError, pasteData: pasteboard.PasteData) => {
              if (!err && pasteData) {
                this.pastedText = pasteData.getPrimaryText() || ''
                console.info('粘贴内容: ' + this.pastedText)
              }
            })
          }
        })
    }
    .width('100%')
    .padding(20)
  }
}
```

### 搜索框粘贴场景

```typescript
@ComponentV2
struct SearchPasteExample {
  @Local searchText: string = ''

  build() {
    Row({ space: 10 }) {
      Search({ placeholder: '搜索内容' })
        .searchButton('搜索')
        .width('60%')
        .onChange((value: string) => {
          this.searchText = value
        })

      PasteButton({
        type: PasteType.TEXT,
        callback: (content: string) => {
          this.searchText = content
          // 触发搜索
          this.performSearch(content)
        }
      })
        .width(40)
        .height(40)
    }
    .width('100%')
    .padding(16)
  }

  private performSearch(query: string): void {
    console.info('执行搜索: ' + query)
    // 实现搜索逻辑
  }
}
```

### 文本编辑器集成

```typescript
@ComponentV2
struct TextEditorPasteExample {
  @Local editorContent: string = ''
  @Local showPasteToast: boolean = false
  @Local pasteMessage: string = ''

  build() {
    Column({ space: 16 }) {
      // 编辑工具栏
      Row({ space: 12 }) {
        Button('复制')
          .fontSize(14)
          .onClick(() => {
            // 复制选中文本到剪贴板
            this.copyToClipboard()
          })

        PasteButton({
          type: PasteType.TEXT,
          callback: (content: string) => {
            this.insertTextAtCursor(content)
            this.showPasteSuccess('粘贴成功')
          }
        })
          .fontSize(14)
          .type(ButtonType.Normal)

        Button('清空')
          .fontSize(14)
          .onClick(() => {
            this.editorContent = ''
          })
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#F0F0F0')
      .borderRadius(8)

      // 文本编辑区
      TextArea({ placeholder: '输入或粘贴内容...', text: this.editorContent })
        .width('100%')
        .height(200)
        .onChange((value: string) => {
          this.editorContent = value
        })

      // 粘贴提示
      if (this.showPasteToast) {
        Text(this.pasteMessage)
          .fontSize(14)
          .fontColor('#4CAF50')
          .padding(8)
          .backgroundColor('#E8F5E9')
          .borderRadius(4)
          .onAppear(() => {
            setTimeout(() => {
              this.showPasteToast = false
            }, 2000)
          })
      }
    }
    .width('100%')
    .padding(16)
  }

  private copyToClipboard(): void {
    // 实现复制逻辑
  }

  private insertTextAtCursor(text: string): void {
    // 在光标位置插入文本
    this.editorContent += text
  }

  private showPasteSuccess(message: string): void {
    this.pasteMessage = message
    this.showPasteToast = true
  }
}
```

### 自定义样式粘贴按钮

```typescript
@ComponentV2
struct CustomPasteButtonExample {
  @Local pastedContent: string = ''

  build() {
    Column({ space: 20 }) {
      Text('自定义样式粘贴按钮')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      // 胶囊样式
      PasteButton({
        type: PasteType.TEXT,
        callback: (content: string) => {
          this.pastedContent = content
        }
      })
        .width(120)
        .height(40)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .backgroundColor('#007DFF')
        .borderRadius(20)

      // 圆形样式
      PasteButton({
        type: PasteType.TEXT,
        callback: (content: string) => {
          this.pastedContent = content
        }
      })
        .width(50)
        .height(50)
        .fontSize(20)
        .type(ButtonType.Circle)
        .backgroundColor('#4CAF50')

      // 图标样式
      PasteButton({
        type: PasteType.TEXT,
        callback: (content: string) => {
          this.pastedContent = content
        }
      })
        .fontSize(24)
        .type(ButtonType.Icon)
        .fontColor('#FF5722')
    }
    .width('100%')
    .padding(20)
  }
}
```

### 错误处理示例

```typescript
@ComponentV2
struct PasteWithErrorHandlingExample {
  @Local pastedText: string = ''
  @Local errorMessage: string = ''
  @Local showError: boolean = false

  build() {
    Column({ space: 20 }) {
      Text('错误处理示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Text(this.pastedText)
        .width('100%')
        .height(80)
        .backgroundColor('#F5F5F5')
        .padding(12)
        .borderRadius(8)

      PasteButton({
        type: PasteType.TEXT,
        callback: (content: string) => {
          try {
            // 验证粘贴内容
            if (!content || content.trim().length === 0) {
              throw new Error('剪贴板为空或内容无效')
            }

            // 检查内容长度
            if (content.length > 1000) {
              throw new Error('粘贴内容过长,最大支持 1000 字符')
            }

            // 验证内容格式(示例:只允许字母数字)
            const validPattern = /^[a-zA-Z0-9\s]+$/
            if (!validPattern.test(content)) {
              throw new Error('粘贴内容包含非法字符')
            }

            // 处理成功
            this.pastedText = content
            this.showError = false
            console.info('粘贴成功: ' + content)

          } catch (error) {
            // 处理错误
            this.showError = true
            this.errorMessage = error.message || '粘贴失败'
            console.error('粘贴错误: ' + this.errorMessage)

            // 显示错误提示(2秒后自动消失)
            setTimeout(() => {
              this.showError = false
            }, 2000)
          }
        }
      })
        .width('80%')

      // 错误提示
      if (this.showError) {
        Row({ space: 8 }) {
          Text('⚠️')
          Text(this.errorMessage)
            .fontSize(14)
            .fontColor('#D32F2F')
        }
        .width('100%')
        .padding(12)
        .backgroundColor('#FFEBEE')
        .borderRadius(8)
      }
    }
    .width('100%')
    .padding(20)
  }
}
```

### 多类型粘贴支持

```typescript
@ComponentV2
struct MultiTypePasteExample {
  @Local textContent: string = ''
  @Local imageContent: string = ''
  @Local uriContent: string = ''
  @Local selectedType: PasteType = PasteType.TEXT

  build() {
    Column({ space: 20 }) {
      Text('多类型粘贴示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      // 类型选择
      Row({ space: 12 }) {
        Button('文本')
          .type(this.selectedType === PasteType.TEXT ? ButtonType.Capsule : ButtonType.Normal)
          .backgroundColor(this.selectedType === PasteType.TEXT ? '#007DFF' : '#E0E0E0')
          .onClick(() => {
            this.selectedType = PasteType.TEXT
          })

        Button('图片')
          .type(this.selectedType === PasteType.IMAGE ? ButtonType.Capsule : ButtonType.Normal)
          .backgroundColor(this.selectedType === PasteType.IMAGE ? '#007DFF' : '#E0E0E0')
          .onClick(() => {
            this.selectedType = PasteType.IMAGE
          })

        Button('URI')
          .type(this.selectedType === PasteType.URI ? ButtonType.Capsule : ButtonType.Normal)
          .backgroundColor(this.selectedType === PasteType.URI ? '#007DFF' : '#E0E0E0')
          .onClick(() => {
            this.selectedType = PasteType.URI
          })
      }
      .width('100%')

      // 对应类型的粘贴按钮和显示区域
      if (this.selectedType === PasteType.TEXT) {
        this.buildTextPasteSection()
      } else if (this.selectedType === PasteType.IMAGE) {
        this.buildImagePasteSection()
      } else if (this.selectedType === PasteType.URI) {
        this.buildUriPasteSection()
      }
    }
    .width('100%')
    .padding(20)
  }

  @Builder
  buildTextPasteSection() {
    Column({ space: 12 }) {
      Text('文本内容:')
        .fontSize(14)
        .fontColor('#666666')

      Text(this.textContent)
        .width('100%')
        .height(80)
        .backgroundColor('#F5F5F5')
        .padding(12)
        .borderRadius(8)

      PasteButton({
        type: PasteType.TEXT,
        callback: (content: string) => {
          this.textContent = content
        }
      })
        .width('80%')
    }
  }

  @Builder
  buildImagePasteSection() {
    Column({ space: 12 }) {
      Text('图片路径:')
        .fontSize(14)
        .fontColor('#666666')

      Text(this.imageContent || '暂无图片')
        .width('100%')
        .height(80)
        .backgroundColor('#F5F5F5')
        .padding(12)
        .borderRadius(8)

      PasteButton({
        type: PasteType.IMAGE,
        callback: (content: string) => {
          this.imageContent = content
        }
      })
        .width('80%')
    }
  }

  @Builder
  buildUriPasteSection() {
    Column({ space: 12 }) {
      Text('URI 路径:')
        .fontSize(14)
        .fontColor('#666666')

      Text(this.uriContent || '暂无 URI')
        .width('100%')
        .height(80)
        .backgroundColor('#F5F5F5')
        .padding(12)
        .borderRadius(8)

      PasteButton({
        type: PasteType.URI,
        callback: (content: string) => {
          this.uriContent = content
        }
      })
        .width('80%')
    }
  }
}
```

## 常见问题

### 1. 如何检查剪贴板是否有内容?

PasteButton 会自动检查剪贴板,如果为空或类型不匹配,按钮会自动禁用。

### 2. 如何处理粘贴权限?

PasteButton 会自动申请和处理剪贴板读取权限,无需手动处理。

### 3. 粘贴按钮何时禁用?

在以下情况下按钮会自动禁用:
- 剪贴板为空
- 剪贴板内容类型与指定的 `PasteType` 不匹配
- 应用没有剪贴板读取权限

### 4. 如何实现粘贴后自动执行操作?

在 callback 回调中添加相应逻辑:

```typescript
PasteButton({
  type: PasteType.TEXT,
  callback: (content: string) => {
    // 更新 UI
    this.pastedText = content

    // 自动执行搜索
    this.performSearch(content)

    // 保存到历史记录
    this.saveToHistory(content)
  }
})
```

## 最佳实践

1. **类型匹配**: 根据使用场景选择正确的 `PasteType`,避免类型不匹配
2. **内容验证**: 在回调中验证粘贴内容的格式和长度
3. **错误处理**: 使用 try-catch 捕获可能的异常
4. **用户反馈**: 粘贴成功或失败时给予明确的视觉反馈
5. **自动清理**: 对于敏感数据,考虑在一段时间后自动清除

### 安全建议

1. **敏感数据处理**: 粘贴的敏感内容(如密码)应该尽快处理或清除
2. **内容过滤**: 对粘贴内容进行过滤和清理,防止恶意内容
3. **权限说明**: 在首次使用时向用户说明为什么需要剪贴板权限

## 性能优化建议

1. **避免频繁操作**: 不要在短时间内频繁触发粘贴操作
2. **异步处理**: 如果粘贴后的处理逻辑较复杂,考虑使用异步处理
3. **内容大小限制**: 对粘贴内容设置合理的大小限制

```typescript
callback: (content: string) => {
  // 使用异步处理复杂逻辑
  setTimeout(() => {
    this.processLargeContent(content)
  }, 0)
}
```

## 相关组件

- **Button**: 普通按钮组件
- **Search**: 搜索组件
- **TextArea**: 多行文本输入组件
- **TextInput**: 单行文本输入组件

## API 参考版本

- **最低支持版本**: API Level 10
- **稳定版本**: API Level 21+
