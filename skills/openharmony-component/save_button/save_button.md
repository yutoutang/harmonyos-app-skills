# SaveButton 保存按钮组件

## 组件概述

**SaveButton** 是 OpenHarmony 提供的系统保存按钮组件,用于保存文件、数据或状态。该组件提供了一致的保存体验和系统级的存储管理。

### 核心特性

- **系统集成**: 与系统存储深度集成
- **多种样式**: 支持图标、文本、图标+文本等多种显示模式
- **自动状态管理**: 自动处理保存中、保存成功、保存失败等状态
- **权限管理**: 自动处理存储权限申请
- **回调机制**: 通过回调函数处理保存结果

## 基本语法

```typescript
SaveButton(options?: {
  icon?: SaveIconStyle,
  text?: string | Resource,
  buttonType?: ButtonType
})
```

### 参数说明

| 参数名 | 类型 | 必填 | 默认值 | 说明 |
|--------|------|------|--------|------|
| icon | SaveIconStyle | 否 | SaveIconStyle.FULL_FILLED | 图标样式 |
| text | string\|Resource | 否 | SaveDescription.SAVE | 按钮文本 |
| buttonType | ButtonType | 否 | ButtonType.Capsule | 按钮类型 |

## SaveIconStyle 枚举

```typescript
enum SaveIconStyle {
  FULL_FILLED,  // 填充图标
  LINES         // 线性图标
}
```

## SaveDescription 预定义文本

```typescript
SaveDescription.SAVE              // "保存"
SaveDescription.SAVE_TO_GALLERY   // "保存到相册"
SaveDescription.DOWNLOAD          // "下载"
// ... 更多预定义文本
```

## 事件回调

```typescript
.onClick(event: (event: ClickEvent, result: SaveButtonOnClickResult) => void)
```

### SaveButtonOnClickResult 枚举

```typescript
enum SaveButtonOnClickResult {
  SUCCESS,    // 保存成功
  FAILURE     // 保存失败
}
```

**重要**: SaveButton 点击成功后,会有 **10 秒钟**的时间窗口可以调用存储相关 API 而无需权限弹窗。

## 使用示例

### 基础保存按钮

```typescript
import { photoAccessHelper } from '@kit.MediaLibraryKit';

@ComponentV2
struct BasicSaveButtonExample {
  @Local saveStatus: string = '未保存'
  @Local savedUri: string = ''

  build() {
    Column({ space: 20 }) {
      Text('保存状态: ' + this.saveStatus)
        .fontSize(16)

      if (this.savedUri) {
        Text('保存路径: ' + this.savedUri)
          .fontSize(14)
          .fontColor('#666666')
      }

      SaveButton({
        icon: SaveIconStyle.FULL_FILLED,
        text: SaveDescription.SAVE,
        buttonType: ButtonType.Capsule
      })
        .onClick(async (event: ClickEvent, result: SaveButtonOnClickResult) => {
          if (result === SaveButtonOnClickResult.SUCCESS) {
            try {
              const helper = photoAccessHelper.getPhotoAccessHelper(getContext(this))
              const uri = await helper.createAsset(
                photoAccessHelper.PhotoType.IMAGE,
                'jpg'
              )
              this.saveStatus = '保存成功'
              this.savedUri = uri
              console.info('文件已保存: ' + uri)
            } catch (error) {
              this.saveStatus = '保存失败'
              console.error('保存失败: ' + JSON.stringify(error))
            }
          }
        })
    }
    .width('100%')
    .padding(20)
  }
}
```

### 文本编辑器保存

```typescript
@ComponentV2
struct TextEditorSaveExample {
  @Local editorContent: string = ''
  @Local fileName: string = ''
  @Local isSaving: boolean = false
  @Local lastSaveTime: string = ''

  build() {
    Column({ space: 16 }) {
      // 文件名输入
      Row({ space: 12 }) {
        Text('文件名:')
          .fontSize(14)
          .width(60)

        TextInput({ placeholder: '请输入文件名', text: this.fileName })
          .layoutWeight(1)
          .onChange((value: string) => {
            this.fileName = value
          })
      }
      .width('100%')

      // 文本编辑区
      TextArea({ placeholder: '输入内容...', text: this.editorContent })
        .width('100%')
        .height(200)
        .onChange((value: string) => {
          this.editorContent = value
        })

      // 保存按钮和状态
      Row({ space: 12 }) {
        SaveButton({
          iconStyle: IconStyle.ICON_TEXT,
          text: '保存',
          buttonType: ButtonType.Normal,
          callback: (result: SaveResult) => {
            this.isSaving = false
            if (result.success) {
              this.lastSaveTime = new Date().toLocaleString()
              console.info('保存成功: ' + result.uri)
            } else {
              console.error('保存失败: ' + result.errorMessage)
            }
          }
        })
          .enabled(!this.isSaving && this.fileName.length > 0 && this.editorContent.length > 0)
          .opacity((this.isSaving || this.fileName.length === 0 || this.editorContent.length === 0) ? 0.5 : 1)
          .onClick(() => {
            this.isSaving = true
          })

        if (this.isSaving) {
          LoadingProgress()
            .width(24)
            .height(24)
        }

        if (this.lastSaveTime) {
          Text('上次保存: ' + this.lastSaveTime)
            .fontSize(12)
            .fontColor('#999999')
        }
      }
      .width('100%')
    }
    .width('100%')
    .padding(20)
  }
}
```

### 图片保存功能

```typescript
@ComponentV2
struct ImageSaveExample {
  @Local imageUrl: string = 'https://example.com/image.jpg'
  @Local saveStatus: string = ''

  build() {
    Column({ space: 20 }) {
      // 图片预览
      Image(this.imageUrl)
        .width(200)
        .height(200)
        .objectFit(ImageFit.Cover)
        .borderRadius(8)

      // 保存按钮
      SaveButton({
        iconStyle: IconStyle.ICON,
        buttonType: ButtonType.Circle,
        callback: (result: SaveResult) => {
          if (result.success) {
            this.saveStatus = '图片已保存到相册'
            console.info('图片保存成功: ' + result.uri)
          } else {
            this.saveStatus = '保存失败: ' + (result.errorMessage || '未知错误')
          }
        }
      })
        .width(50)
        .height(50)

      // 状态提示
      if (this.saveStatus) {
        Text(this.saveStatus)
          .fontSize(14)
          .fontColor(this.saveStatus.includes('成功') ? '#4CAF50' : '#F44336')
          .padding(8)
          .backgroundColor(this.saveStatus.includes('成功') ? '#E8F5E9' : '#FFEBEE')
          .borderRadius(4)
      }
    }
    .width('100%')
    .padding(20)
  }
}
```

### 自定义样式保存按钮

```typescript
@ComponentV2
struct CustomSaveButtonExample {
  @Local clickCount: number = 0

  build() {
    Column({ space: 20 }) {
      Text('自定义样式保存按钮')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      // 仅图标
      SaveButton({
        iconStyle: IconStyle.ICON,
        buttonType: ButtonType.Circle,
        callback: (result: SaveResult) => {
          this.clickCount++
          console.info('图标按钮点击次数: ' + this.clickCount)
        }
      })
        .width(60)
        .height(60)
        .fontSize(28)
        .backgroundColor('#4CAF50')

      // 仅文本
      SaveButton({
        iconStyle: IconStyle.TEXT,
        text: '保存到云端',
        buttonType: ButtonType.Capsule,
        callback: (result: SaveResult) => {
          console.info('文本按钮点击')
        }
      })
        .width(140)
        .height(40)
        .fontSize(16)
        .backgroundColor('#2196F3')

      // 图标+文本
      SaveButton({
        iconStyle: IconStyle.ICON_TEXT,
        text: '保存',
        buttonType: ButtonType.Normal,
        callback: (result: SaveResult) => {
          console.info('图标文本按钮点击')
        }
      })
        .width(100)
        .height(44)
        .fontSize(18)
        .backgroundColor('#FF9800')

      // 圆角样式
      SaveButton({
        iconStyle: IconStyle.ICON_TEXT,
        text: '保存文档',
        buttonType: ButtonType.Capsule,
        callback: (result: SaveResult) => {
          console.info('圆角按钮点击')
        }
      })
        .width(120)
        .height(36)
        .fontSize(14)
        .backgroundColor('#9C27B0')
        .borderRadius(18)
    }
    .width('100%')
    .padding(20)
  }
}
```

### 批量保存功能

```typescript
@ComponentV2
struct BatchSaveExample {
  @Local files: Array<{ name: string, content: string, status: string }> = []
  @Local saveAllInProgress: boolean = false
  @Local savedCount: number = 0

  aboutToAppear(): void {
    // 初始化示例文件
    this.files = [
      { name: 'document1.txt', content: '文档1内容', status: '待保存' },
      { name: 'document2.txt', content: '文档2内容', status: '待保存' },
      { name: 'document3.txt', content: '文档3内容', status: '待保存' }
    ]
  }

  build() {
    Column({ space: 16 }) {
      Text('批量保存示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      // 文件列表
      List({ space: 8 }) {
        ForEach(this.files, (file: { name: string, content: string, status: string }, index: number) => {
          ListItem() {
            Row({ space: 12 }) {
              Text(file.name)
                .fontSize(14)
                .layoutWeight(1)

              Text(file.status)
                .fontSize(12)
                .fontColor(this.getStatusColor(file.status))

              SaveButton({
                iconStyle: IconStyle.ICON,
                buttonType: ButtonType.Circle,
                callback: (result: SaveResult) => {
                  if (result.success) {
                    this.files[index].status = '已保存'
                    this.savedCount++
                  } else {
                    this.files[index].status = '保存失败'
                  }
                }
              })
                .width(36)
                .height(36)
                .fontSize(18)
            }
            .width('100%')
            .padding(12)
            .backgroundColor('#F5F5F5')
            .borderRadius(8)
          }
        })
      }
      .width('100%')
      .layoutWeight(1)

      // 批量保存按钮
      Row({ space: 12 }) {
        SaveButton({
          iconStyle: IconStyle.ICON_TEXT,
          text: '保存全部',
          buttonType: ButtonType.Capsule,
          callback: (result: SaveResult) => {
            // 这里简化处理,实际需要循环保存每个文件
            console.info('批量保存')
          }
        })
          .enabled(!this.saveAllInProgress)
          .onClick(() => {
            this.saveAllInProgress = true
            // 模拟批量保存
            setTimeout(() => {
              this.saveAllInProgress = false
              this.savedCount = this.files.length
              this.files = this.files.map(f => ({ ...f, status: '已保存' }))
            }, 2000)
          })

        if (this.saveAllInProgress) {
          LoadingProgress()
            .width(24)
            .height(24)
        }

        Text(`已保存: ${this.savedCount}/${this.files.length}`)
          .fontSize(14)
          .fontColor('#666666')
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .padding(20)
  }

  private getStatusColor(status: string): string {
    switch (status) {
      case '已保存':
        return '#4CAF50'
      case '保存失败':
        return '#F44336'
      case '保存中...':
        return '#FF9800'
      default:
        return '#999999'
    }
  }
}
```

### 自动保存功能

```typescript
@ComponentV2
struct AutoSaveExample {
  @Local content: string = ''
  @Local lastSaveTime: Date | null = null
  @Local autoSaveEnabled: boolean = true
  @Local saveTimer: number | null = null
  private readonly AUTO_SAVE_INTERVAL = 5000 // 5秒自动保存

  build() {
    Column({ space: 16 }) {
      // 工具栏
      Row({ space: 12 }) {
        Text('自动保存')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)

        Toggle({ type: ToggleType.Switch, isOn: this.autoSaveEnabled })
          .onChange((isOn: boolean) => {
            this.autoSaveEnabled = isOn
            if (isOn) {
              this.startAutoSave()
            } else {
              this.stopAutoSave()
            }
          })

        Blank()

        SaveButton({
          iconStyle: IconStyle.ICON,
          buttonType: ButtonType.Circle,
          callback: (result: SaveResult) => {
            if (result.success) {
              this.lastSaveTime = new Date()
              console.info('手动保存成功')
            }
          }
        })
          .width(40)
          .height(40)
          .fontSize(20)
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#F0F0F0')
      .borderRadius(8)

      // 编辑区域
      TextArea({ placeholder: '输入内容...', text: this.content })
        .width('100%')
        .height(200)
        .onChange((value: string) => {
          this.content = value
          // 内容变化时重置定时器
          if (this.autoSaveEnabled) {
            this.resetAutoSaveTimer()
          }
        })

      // 状态显示
      if (this.lastSaveTime) {
        Row({ space: 8 }) {
          Text('✓')
            .fontColor('#4CAF50')
          Text('上次保存: ' + this.lastSaveTime.toLocaleTimeString())
            .fontSize(12)
            .fontColor('#666666')
        }
      }

      if (this.autoSaveEnabled) {
        Text('自动保存已启用(每5秒)')
          .fontSize(12)
          .fontColor('#999999')
      }
    }
    .width('100%')
    .padding(20)
  }

  private startAutoSave(): void {
    this.saveTimer = setInterval(() => {
      this.performAutoSave()
    }, this.AUTO_SAVE_INTERVAL) as unknown as number
  }

  private stopAutoSave(): void {
    if (this.saveTimer !== null) {
      clearInterval(this.saveTimer)
      this.saveTimer = null
    }
  }

  private resetAutoSaveTimer(): void {
    this.stopAutoSave()
    this.startAutoSave()
  }

  private performAutoSave(): void {
    if (this.content.length > 0) {
      // 这里应该调用实际的保存逻辑
      this.lastSaveTime = new Date()
      console.info('自动保存成功')
    }
  }

  aboutToDisappear(): void {
    this.stopAutoSave()
  }
}
```

## 常见问题

### 1. 如何处理保存失败?

在 callback 回调中检查 `result.success`:

```typescript
callback: (result: SaveResult) => {
  if (result.success) {
    // 保存成功
  } else {
    // 显示错误信息
    console.error(result.errorMessage)
  }
}
```

### 2. 如何实现保存前验证?

在触发保存前进行验证,禁用不符合条件的按钮:

```typescript
SaveButton({
  callback: (result: SaveResult) => { }
})
  .enabled(this.isValidContent())
```

### 3. 如何显示保存进度?

结合 LoadingProgress 组件:

```typescript
if (this.isSaving) {
  LoadingProgress()
    .width(24)
    .height(24)
}
```

### 4. 如何实现另存为功能?

在 callback 中处理 URI:

```typescript
callback: (result: SaveResult) => {
  if (result.success && result.uri) {
    console.info('文件另存为: ' + result.uri)
  }
}
```

## 最佳实践

1. **状态反馈**: 保存时显示加载状态,保存后显示结果
2. **条件禁用**: 内容为空或格式不正确时禁用保存按钮
3. **错误处理**: 妥善处理保存失败情况,显示友好提示
4. **自动保存**: 对于重要内容,实现自动保存功能
5. **保存确认**: 对于覆盖操作,可以添加确认对话框

### 性能优化建议

1. **防抖处理**: 避免短时间内多次保存
2. **增量保存**: 对于大文件,考虑增量保存
3. **异步处理**: 保存操作使用异步处理,避免阻塞 UI

```typescript
callback: (result: SaveResult) => {
  // 异步处理保存后的操作
  setTimeout(() => {
    this.processAfterSave()
  }, 0)
}
```

## 安全建议

1. **权限说明**: 首次保存时向用户说明为什么需要存储权限
2. **敏感数据**: 对于敏感数据,考虑加密后保存
3. **路径验证**: 验证保存路径的合法性,防止路径遍历攻击

## 相关组件

- **Button**: 普通按钮组件
- **PasteButton**: 粘贴按钮组件
- **TextInput**: 文本输入组件
- **LoadingProgress**: 加载进度组件

## API 参考版本

- **最低支持版本**: API Level 10
- **稳定版本**: API Level 21+
