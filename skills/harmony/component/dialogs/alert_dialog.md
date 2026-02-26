# AlertDialog 组件 HarmonyOS 6.0 开发 Skill

## 概述

AlertDialog 是 OpenHarmony 中用于显示警告对话框的组件，通常用于提示用户重要信息或需要用户确认的操作。它提供了标准化的对话框样式和交互模式。

## 重要说明

- **对话框类型**: AlertDialog 是模态对话框，会阻塞用户对其他界面的操作
- **使用场景**: 用于警告、确认、通知等重要提示
- **API 变化**: API 10+ 使用 AlertDialog.show() 静态方法，API 9- 使用自定义组件
- **自动管理**: 系统自动管理对话框的显示和隐藏
- **响应式**: 支持横竖屏切换自适应

## 模块信息

- **组件名称**: AlertDialog
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [AlertDialog - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-methods-alert-dialog-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// AlertDialog 是系统内置组件，无需导入
// 直接使用 AlertDialog.show() 方法即可
```

### 1.2 基础用法

```typescript
// 显示简单对话框
AlertDialog.show({
  message: '确定要删除此项目吗？'
})

// 带标题的对话框
AlertDialog.show({
  title: '警告',
  message: '此操作不可恢复'
})
```

## 二、API 参数

### 2.1 AlertDialogParam 参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| `title` | `ResourceStr` | 否 | - | 对话框标题 |
| `subtitle` | `ResourceStr` | 否 | - | 对话框副标题 |
| `message` | `ResourceStr` | 否 | - | 对话框内容 |
| `autoCancel` | `boolean` | 否 | true | 点击遮罩层是否自动关闭对话框 |
| `cancel` | `() => void` | 否 | - | 点击遮罩层关闭回调 |
| `alignment` | `DialogAlignment` | 否 | DialogAlignment.Default | 对话框对齐方式 |
| `offset` | `Offset` | 否 | { dx: 0, dy: 0 } | 对话框相对对齐位置的偏移量 |
| `gridCount` | `number` | 否 | - | 对话框宽度占栅格数的占比 |
| `customHeight` | `Length` | 否 | - | 对话框自定义高度 |
| `showInSubWindow` | `boolean` | 否 | false | 是否在子窗口显示 |
| `isModal` | `boolean` | 否 | true | 是否为模态对话框 |

### 2.2 按钮配置

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| `primaryButton` | `AlertDialogButton` | 否 | - | 主要按钮配置 |
| `secondaryButton` | `AlertDialogButton` | 否 | - | 次要按钮配置 |
| `buttons` | `Array<AlertDialogButton>` | 否 | - | 按钮数组（支持多个按钮） |

### 2.3 AlertDialogButton 参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| `text` | `ResourceStr` | 否 | - | 按钮文本 |
| `color` | `ResourceColor` | 否 | - | 按钮文本颜色 |
| `backgroundColor` | `ResourceColor` | 否 | - | 按钮背景颜色 |
| `action` | `() => void` | 否 | - | 按钮点击回调 |
| `font` | `Font` | 否 | - | 按钮文本字体样式 |

### 2.4 样式配置

| 参数 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `backgroundColor` | `ResourceColor` | - | 对话框背景颜色 |
| `cornerRadius` | `number \| string` | - | 对话框圆角半径 |
| `textStyle` | `TextStyle` | - | 对话框文本样式 |

### 2.5 对齐方式 (DialogAlignment)

| 值 | 描述 |
|------|------|
| `DialogAlignment.Top` | 顶部对齐 |
| `DialogAlignment.Center` | 居中对齐 |
| `DialogAlignment.Bottom` | 底部对齐 |
| `DialogAlignment.Default` | 默认位置（居中） |
| `DialogAlignment.TopStart` | 左上角对齐 |
| `DialogAlignment.TopEnd` | 右上角对齐 |
| `DialogAlignment.CenterStart` | 左侧居中 |
| `DialogAlignment.CenterEnd` | 右侧居中 |
| `DialogAlignment.BottomStart` | 左下角对齐 |
| `DialogAlignment.BottomEnd` | 右下角对齐 |

## 三、使用示例

### 3.1 简单对话框

```typescript
// 显示简单消息对话框
AlertDialog.show({
  message: '操作成功'
})

// 带标题的消息对话框
AlertDialog.show({
  title: '提示',
  message: '您的操作已完成'
})
```

### 3.2 带按钮的对话框

```typescript
// 单按钮对话框
AlertDialog.show({
  title: '确认',
  message: '确定要执行此操作吗？',
  primaryButton: {
    value: '确定',
    action: () => {
      console.info('点击了确定按钮')
    }
  }
})

// 双按钮对话框（确认和取消）
AlertDialog.show({
  title: '删除确认',
  message: '删除后无法恢复，确定要删除吗？',
  primaryButton: {
    value: '删除',
    action: () => {
      console.info('确认删除')
    }
  },
  secondaryButton: {
    value: '取消',
    action: () => {
      console.info('取消删除')
    }
  }
})
```

### 3.3 自定义按钮样式

```typescript
AlertDialog.show({
  title: '警告',
  message: '此操作存在风险',
  primaryButton: {
    value: '继续',
    font: {
      size: 16,
      weight: FontWeight.Medium
    },
    backgroundColor: '#FF0000',
    action: () => {
      console.info('继续操作')
    }
  },
  secondaryButton: {
    value: '返回',
    font: {
      size: 16
    },
    action: () => {
      console.info('返回')
    }
  }
})
```

### 3.4 多按钮对话框

```typescript
AlertDialog.show({
  title: '选择操作',
  message: '请选择您要执行的操作',
  buttons: [
    {
      text: '选项1',
      action: () => {
        console.info('选择了选项1')
      }
    },
    {
      text: '选项2',
      action: () => {
        console.info('选择了选项2')
      }
    },
    {
      text: '选项3',
      action: () => {
        console.info('选择了选项3')
      }
    }
  ]
})
```

### 3.5 自定义位置对话框

```typescript
// 顶部对话框
AlertDialog.show({
  title: '顶部提示',
  message: '这是一个顶部显示的对话框',
  alignment: DialogAlignment.Top
})

// 底部对话框
AlertDialog.show({
  title: '底部提示',
  message: '这是一个底部显示的对话框',
  alignment: DialogAlignment.Bottom
})

// 自定义偏移量
AlertDialog.show({
  title: '自定义位置',
  message: '对话框位置可以自定义偏移',
  alignment: DialogAlignment.Center,
  offset: { dx: 0, dy: -50 }
})
```

### 3.6 自定义大小对话框

```typescript
// 指定栅格宽度
AlertDialog.show({
  title: '自定义宽度',
  message: '对话框宽度占屏幕栅格数',
  gridCount: 8  // 1-12 之间的值
})

// 自定义高度
AlertDialog.show({
  title: '自定义高度',
  message: '对话框可以设置固定高度或百分比高度',
  customHeight: 300
})

// 同时设置宽度和高度
AlertDialog.show({
  title: '自定义大小',
  message: '可以同时设置宽度和高度',
  gridCount: 10,
  customHeight: 400
})
```

### 3.7 完整配置对话框

```typescript
AlertDialog.show({
  title: '完整配置示例',
  subtitle: '这是副标题',
  message: '这是一个包含所有配置项的对话框示例',
  autoCancel: true,
  alignment: DialogAlignment.Center,
  offset: { dx: 0, dy: 0 },
  gridCount: 8,
  backgroundColor: '#FFFFFF',
  cornerRadius: 16,
  primaryButton: {
    text: '主要按钮',
    font: {
      size: 16,
      weight: FontWeight.Medium
    },
    action: () => {
      console.info('点击主要按钮')
    }
  },
  secondaryButton: {
    text: '次要按钮',
    action: () => {
      console.info('点击次要按钮')
    }
  },
  cancel: () => {
    console.info('对话框被取消')
  }
})
```

### 3.8 在组件中使用

```typescript
@ComponentV2
export struct AlertDialogExample {
  @Local message: string = '点击按钮显示对话框'

  build() {
    Column({ space: 16 }) {
      Text(this.message)
        .fontSize(16)

      Button('显示简单对话框')
        .onClick(() => {
          AlertDialog.show({
            message: '这是一个简单的对话框'
          })
        })

      Button('显示确认对话框')
        .onClick(() => {
          AlertDialog.show({
            title: '确认操作',
            message: '确定要继续吗？',
            primaryButton: {
              value: '确定',
              action: () => {
                this.message = '已确认操作'
              }
            },
            secondaryButton: {
              value: '取消',
              action: () => {
                this.message = '已取消操作'
              }
            }
          })
        })
    }
    .width('100%')
    .padding(16)
  }
}
```

## 四、高级用法

### 4.1 异步操作对话框

```typescript
@ComponentV2
struct AsyncDialogExample {
  @Local isLoading: boolean = false

  async performAsyncOperation() {
    this.isLoading = true

    try {
      // 执行异步操作
      await someAsyncTask()

      AlertDialog.show({
        title: '成功',
        message: '操作已完成',
        primaryButton: {
          value: '确定',
          action: () => {
            console.info('用户已确认')
          }
        }
      })
    } catch (error) {
      AlertDialog.show({
        title: '错误',
        message: '操作失败: ' + error.message,
        primaryButton: {
          value: '重试',
          action: () => {
            this.performAsyncOperation()
          }
        },
        secondaryButton: {
          value: '取消',
          action: () => {
            console.info('用户取消重试')
          }
        }
      })
    } finally {
      this.isLoading = false
    }
  }

  build() {
    Button('执行异步操作')
      .enabled(!this.isLoading)
      .onClick(() => {
        this.performAsyncOperation()
      })
  }
}
```

### 4.2 表单验证对话框

```typescript
@ComponentV2
struct FormValidationDialog {
  @Local inputValue: string = ''

  validateInput(): boolean {
    if (this.inputValue.length === 0) {
      AlertDialog.show({
        title: '验证失败',
        message: '输入内容不能为空',
        primaryButton: {
          value: '确定'
        }
      })
      return false
    }

    if (this.inputValue.length < 6) {
      AlertDialog.show({
        title: '验证失败',
        message: '输入内容至少需要6个字符',
        primaryButton: {
          value: '确定'
        }
      })
      return false
    }

    return true
  }

  build() {
    Column({ space: 16 }) {
      TextInput({ placeholder: '请输入内容' })
        .onChange((value: string) => {
          this.inputValue = value
        })

      Button('提交')
        .onClick(() => {
          if (this.validateInput()) {
            AlertDialog.show({
              title: '成功',
              message: '验证通过',
              primaryButton: {
                value: '确定',
                action: () => {
                  console.info('提交成功')
                }
              }
            })
          }
        })
    }
  }
}
```

### 4.3 带副标题的对话框

```typescript
AlertDialog.show({
  title: '系统更新',
  subtitle: '版本 2.0.1',
  message: '发现新版本，建议立即更新以获得更好的体验',
  primaryButton: {
    value: '立即更新',
    action: () => {
      console.info('开始更新')
    }
  },
  secondaryButton: {
    value: '稍后提醒',
    action: () => {
      console.info('稍后更新')
    }
  }
})
```

## 五、最佳实践

### 5.1 对话框使用场景

```typescript
// ✅ 推荐：用于重要确认操作
AlertDialog.show({
  title: '删除确认',
  message: '删除后无法恢复',
  primaryButton: {
    value: '删除',
    action: () => {
      // 执行删除操作
    }
  },
  secondaryButton: {
    value: '取消'
  }
})

// ✅ 推荐：用于警告提示
AlertDialog.show({
  title: '警告',
  message: '此操作存在风险，请谨慎操作',
  primaryButton: {
    value: '知道了'
  }
})

// ❌ 避免：用于简单的提示信息
// 应该使用 Toast 或 Snackbar
AlertDialog.show({
  message: '操作成功'  // 太简单了
})
```

### 5.2 按钮文本规范

```typescript
// ✅ 推荐：使用明确的操作文本
AlertDialog.show({
  title: '删除确认',
  message: '确定要删除吗？',
  primaryButton: {
    value: '删除',  // 明确的操作
    action: () => {
      // 删除操作
    }
  },
  secondaryButton: {
    value: '取消'  // 明确的取消
  }
})

// ❌ 避免：使用模糊的文本
AlertDialog.show({
  title: '删除确认',
  message: '确定要删除吗？',
  primaryButton: {
    value: '好的',  // 不够明确
    action: () => {
      // 删除操作
    }
  },
  secondaryButton: {
    value: '关闭'  // 不够明确
  }
})
```

### 5.3 消息文本长度

```typescript
// ✅ 推荐：简洁明了的消息
AlertDialog.show({
  title: '删除确认',
  message: '删除后无法恢复',  // 简洁
  primaryButton: {
    value: '确定'
  }
})

// ❌ 避免：过长的消息文本
AlertDialog.show({
  title: '删除确认',
  message: '您即将删除此项目，此操作是不可逆的，删除后所有相关数据都将被永久删除，无法恢复，请谨慎操作...',  // 太长
  primaryButton: {
    value: '确定'
  }
})
```

### 5.4 响应式设计

```typescript
// ✅ 推荐：考虑不同屏幕尺寸
AlertDialog.show({
  title: '响应式对话框',
  message: '对话框会根据屏幕大小自动调整',
  gridCount: isSmallScreen() ? 12 : 8,  // 小屏幕使用更宽的对话框
  alignment: DialogAlignment.Center
})

// ✅ 推荐：使用相对单位
AlertDialog.show({
  title: '适配不同设备',
  message: '对话框在不同设备上都能正常显示',
  customHeight: '40%'  // 使用百分比而非固定像素
})
```

## 六、常见问题

### Q1: AlertDialog 不显示？

**问题**: 调用 AlertDialog.show() 后对话框没有显示。

**解决方案**:
```typescript
// 1. 检查是否在 UI 线程调用
// ✅ 正确：在 UI 事件中调用
Button('显示对话框')
  .onClick(() => {
    AlertDialog.show({
      message: '对话框'
    })
  })

// 2. 检查是否在有效的生命周期内
// ✅ 正确：在组件生命周期的适当时机调用
@ComponentV2
struct MyComponent {
  aboutToAppear() {
    // 可以在这里显示对话框
  }

  build() {
    Button('显示对话框')
      .onClick(() => {
        AlertDialog.show({
          message: '对话框'
        })
      })
  }
}
```

### Q2: 如何防止对话框被误触关闭？

**解决方案**:
```typescript
AlertDialog.show({
  title: '重要提示',
  message: '此对话框必须主动关闭',
  autoCancel: false,  // 禁止点击遮罩层关闭
  primaryButton: {
    value: '我已知晓',
    action: () => {
      console.info('用户确认')
    }
  }
})
```

### Q3: 如何自定义对话框样式？

**解决方案**:
```typescript
// AlertDialog 支持有限的样式自定义
// 如需完全自定义样式，建议使用 CustomDialog

AlertDialog.show({
  title: '自定义样式',
  message: '对话框',
  backgroundColor: '#F5F5F5',  // 背景颜色
  cornerRadius: 20,  // 圆角
  primaryButton: {
    text: '确定',
    color: '#007DFF',  // 文字颜色
    backgroundColor: '#FFFFFF',  // 按钮背景
    font: {
      size: 16,
      weight: FontWeight.Medium
    }
  }
})
```

### Q4: 对话框位置不符合预期？

**解决方案**:
```typescript
// 使用精确的对齐方式和偏移量
AlertDialog.show({
  title: '精确定位',
  message: '对话框',
  alignment: DialogAlignment.Center,
  offset: { dx: 0, dy: -100 }  // 向上偏移 100vp
})

// 或使用具体的对齐位置
AlertDialog.show({
  title: '顶部对齐',
  message: '对话框',
  alignment: DialogAlignment.TopStart  // 左上角
})
```

### Q5: 如何在对话框关闭后执行操作？

**解决方案**:
```typescript
// 在按钮回调中执行操作
AlertDialog.show({
  title: '操作确认',
  message: '确定要执行此操作吗？',
  primaryButton: {
    value: '确定',
    action: () => {
      // 对话框关闭后执行
      console.info('用户已确认，执行后续操作')
      performNextAction()
    }
  },
  secondaryButton: {
    value: '取消',
    action: () => {
      // 用户取消后的操作
      console.info('用户已取消')
    }
  },
  cancel: () => {
    // 点击遮罩层关闭后的操作
    console.info('对话框被取消')
  }
})
```

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 9+ | ✅ | 基础功能支持 |
| API 10+ | ✅ | 增加了 subtitle, buttons, customHeight 等属性 |
| API 11+ | ✅ | 增加了 textStyle, showInSubWindow 等属性 |
| API 12+ | ✅ | 增强了样式自定义能力 |

## 八、参考资料

- [AlertDialog 对话框 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-methods-alert-dialog-V5)
- [弹窗组件 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/ts-displaying-alert-dialog-V5)
- [对话框设计规范 - HarmonyOS 设计指南](https://developer.huawei.com/consumer/cn/design/harmonyos-/guidelines/dialog.html)
