# CustomDialogController 组件 HarmonyOS 6.0 开发 Skill

## 概述

CustomDialogController 是 OpenHarmony 中用于创建自定义对话框的控制器组件。它允许开发者完全自定义对话框的内容、样式和交互逻辑，提供了比 AlertDialog 更强大的自定义能力。

## 重要说明

- **自定义内容**: 可以在对话框中放置任意 ArkUI 组件
- **生命周期**: 需要手动管理控制器的创建和销毁
- **API 变化**: API 12+ 推荐使用 @CustomDialog 装饰器
- **样式控制**: 完全控制对话框的布局、颜色、动画等
- **内存管理**: 使用完毕后需要调用控制器释放资源

## 模块信息

- **组件名称**: CustomDialogController
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [CustomDialogController - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-methods-custom-dialog-box-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// CustomDialogController 是内置组件，无需导入
// 直接使用 @CustomDialog 装饰器创建自定义对话框
```

### 1.2 基础用法

```typescript
// 1. 创建自定义对话框类
@CustomDialog
export struct MyCustomDialog {
  controller: CustomDialogController = new CustomDialogController({
    builder: MyCustomDialog
  })

  build() {
    Column() {
      Text('自定义对话框')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .padding(16)

      Button('关闭')
        .onClick(() => {
          this.controller.close()
        })
    }
    .width('80%')
    .padding(20)
    .backgroundColor(Color.White)
    .borderRadius(16)
  }
}

// 2. 在组件中使用
@ComponentV2
struct CustomDialogExample {
  dialogController: CustomDialogController = new CustomDialogController({
    builder: MyCustomDialog,
    autoCancel: true,
    alignment: DialogAlignment.Center
  })

  build() {
    Column() {
      Button('显示自定义对话框')
        .onClick(() => {
          this.dialogController.open()
        })
    }
  }
}
```

## 二、API 参数

### 2.1 CustomDialogControllerOptions 参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| `builder` | `CustomDialog` | 是 | - | 自定义对话框构造器 |
| `autoCancel` | `boolean` | 否 | true | 点击遮罩层是否自动关闭 |
| `cancel` | `() => void` | 否 | - | 对话框关闭回调 |
| `alignment` | `DialogAlignment` | 否 | DialogAlignment.Center | 对话框对齐方式 |
| `offset` | `Offset` | 否 | { dx: 0, dy: 0 } | 对话框偏移量 |
| `customStyle` | `boolean` | 否 | false | 是否自定义样式 |
| `cornerRadius` | `number` | 否 | 16 | 对话框圆角半径 |
| `maskColor` | `ResourceColor` | 否 | - | 遮罩层颜色 |
| `maskRect` | `Rectangle` | 否 | - | 遮罩层矩形区域 |
| `openAnimation` | `AnimateParam` | 否 | - | 对话框打开动画 |
| `closeAnimation` | `AnimateParam` | 否 | - | 对话框关闭动画 |
| `transition` | `TransitionEffect` | 否 | - | 对话框转场效果 |
| `showInSubWindow` | `boolean` | 否 | false | 是否在子窗口显示 |
| `isModal` | `boolean` | 否 | true | 是否为模态对话框 |

### 2.2 CustomDialog 装饰器参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| `controller` | `CustomDialogController` | 否 | - | 对话框控制器引用 |

### 2.3 控制器方法

| 方法 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `open()` | - | `void` | 打开对话框 |
| `close()` | - | `void` | 关闭对话框 |
| `dismiss()` | - | `void` | 释放对话框资源 |

### 2.4 对齐方式 (DialogAlignment)

| 值 | 描述 |
|------|------|
| `DialogAlignment.Top` | 顶部对齐 |
| `DialogAlignment.Center` | 居中对齐 |
| `DialogAlignment.Bottom` | 底部对齐 |
| `DialogAlignment.Default` | 默认位置 |
| `DialogAlignment.TopStart` | 左上角 |
| `DialogAlignment.TopEnd` | 右上角 |
| `DialogAlignment.CenterStart` | 左侧居中 |
| `DialogAlignment.CenterEnd` | 右侧居中 |
| `DialogAlignment.BottomStart` | 左下角 |
| `DialogAlignment.BottomEnd` | 右下角 |

## 三、使用示例

### 3.1 简单自定义对话框

```typescript
@CustomDialog
export struct SimpleCustomDialog {
  controller: CustomDialogController

  build() {
    Column() {
      Text('提示')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 20, bottom: 10 })

      Text('这是一个自定义对话框')
        .fontSize(16)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ left: 20, right: 20, bottom: 20 })

      Divider()

      Button('确定')
        .width('100%')
        .type(ButtonType.Normal)
        .onClick(() => {
          this.controller.close()
        })
    }
    .width('80%')
    .backgroundColor(Color.White)
    .borderRadius(16)
  }
}

@ComponentV2
export struct SimpleCustomDialogExample {
  dialogController: CustomDialogController = new CustomDialogController({
    builder: SimpleCustomDialog,
    autoCancel: true,
    alignment: DialogAlignment.Center
  })

  build() {
    Column() {
      Button('显示简单对话框')
        .onClick(() => {
          this.dialogController.open()
        })
    }
    .width('100%')
    .height('100%')
  }
}
```

### 3.2 带参数的自定义对话框

```typescript
@CustomDialog
export struct ParamCustomDialog {
  @Param title: string = ''
  @Param message: string = ''
  @Param confirmText: string = '确定'
  controller: CustomDialogController
  @Event onConfirm: () => void = () => {}

  build() {
    Column() {
      Text(this.title)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 20, bottom: 10 })

      Text(this.message)
        .fontSize(16)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ left: 20, right: 20, bottom: 20 })

      Divider()

      Row() {
        Button('取消')
          .layoutWeight(1)
          .type(ButtonType.Normal)
          .onClick(() => {
            this.controller.close()
          })

        Divider()
          .vertical(true)

        Button(this.confirmText)
          .layoutWeight(1)
          .type(ButtonType.Normal)
          .onClick(() => {
            this.onConfirm()
            this.controller.close()
          })
      }
      .width('100%')
    }
    .width('80%')
    .backgroundColor(Color.White)
    .borderRadius(16)
  }
}

@ComponentV2
export struct ParamCustomDialogExample {
  @Local dialogController?: CustomDialogController

  build() {
    Column() {
      Button('显示确认对话框')
        .onClick(() => {
          this.dialogController = new CustomDialogController({
            builder: ParamCustomDialog({
              title: '删除确认',
              message: '删除后无法恢复，确定要删除吗？',
              confirmText: '删除',
              onConfirm: () => {
                console.info('确认删除')
              }
            }),
            autoCancel: true,
            alignment: DialogAlignment.Center
          })
          this.dialogController.open()
        })
    }
    .width('100%')
    .height('100%')
  }
}
```

### 3.3 带输入框的自定义对话框

```typescript
@CustomDialog
export struct InputCustomDialog {
  @Local inputValue: string = ''
  @Param placeholder: string = '请输入内容'
  controller: CustomDialogController
  @Event onConfirm: (value: string) => void = () => {}

  build() {
    Column() {
      Text('输入')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 20, bottom: 10 })

      TextInput({
        placeholder: this.placeholder,
        text: this.inputValue
      })
        .onChange((value: string) => {
          this.inputValue = value
        })
        .margin({ left: 20, right: 20, bottom: 20 })

      Divider()

      Row() {
        Button('取消')
          .layoutWeight(1)
          .type(ButtonType.Normal)
          .onClick(() => {
            this.controller.close()
          })

        Divider()
          .vertical(true)

        Button('确定')
          .layoutWeight(1)
          .type(ButtonType.Normal)
          .onClick(() => {
            this.onConfirm(this.inputValue)
            this.controller.close()
          })
      }
      .width('100%')
    }
    .width('80%')
    .backgroundColor(Color.White)
    .borderRadius(16)
  }
}
```

### 3.4 带列表的自定义对话框

```typescript
@CustomDialog
export struct ListCustomDialog {
  @Param items: string[] = []
  @Param title: string = '请选择'
  @Local selectedIndex: number = -1
  controller: CustomDialogController
  @Event onSelect: (index: number, item: string) => void = () => {}

  build() {
    Column() {
      Text(this.title)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 20, bottom: 10 })

      Divider()

      List() {
        ForEach(this.items, (item: string, index: number) => {
          ListItem() {
            Row() {
              Text(item)
                .fontSize(16)
                .layoutWeight(1)

              if (this.selectedIndex === index) {
                Text('✓')
                  .fontSize(18)
                  .fontColor('#007DFF')
              }
            }
            .width('100%')
            .padding(16)
            .onClick(() => {
              this.selectedIndex = index
              this.onSelect(index, item)
              this.controller.close()
            })
          }
        })
      }
      .width('100%')
      .height(300)
      .divider({
        strokeWidth: 1,
        color: '#E0E0E0'
      })
    }
    .width('80%')
    .backgroundColor(Color.White)
    .borderRadius(16)
  }
}
```

### 3.5 自定义样式的对话框

```typescript
@CustomDialog
export struct StyledCustomDialog {
  controller: CustomDialogController

  build() {
    Column() {
      // 渐变背景标题栏
      Column() {
        Text('自定义样式对话框')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
      }
      .width('100%')
      .height(80)
      .backgroundImage($r('sys.media.ohos_ic_public_card'))
      .justifyContent(FlexAlign.Center)

      Text('对话框内容')
        .fontSize(16)
        .width('100%')
        .padding(20)

      Divider()

      Row() {
        Button('取消')
          .layoutWeight(1)
          .type(ButtonType.Normal)
          .borderRadius(0)
          .onClick(() => {
            this.controller.close()
          })

        Button('确定')
          .layoutWeight(1)
          .type(ButtonType.Normal)
          .backgroundColor('#007DFF')
          .fontColor(Color.White)
          .borderRadius(0)
          .onClick(() => {
            this.controller.close()
          })
      }
      .width('100%')
      .height(50)
    }
    .width('85%')
    .backgroundColor(Color.White)
    .borderRadius(20)
    .shadow({
      radius: 10,
      color: 'rgba(0, 0, 0, 0.3)',
      offsetX: 0,
      offsetY: 5
    })
  }
}
```

### 3.6 带动画的自定义对话框

```typescript
@CustomDialog
export struct AnimatedCustomDialog {
  @Local scale: number = 0
  controller: CustomDialogController

  aboutToAppear() {
    // 打开动画
    animateTo({
      duration: 300,
      curve: Curve.EaseOut
    }, () => {
      this.scale = 1
    })
  }

  build() {
    Column() {
      Text('动画对话框')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .padding(20)

      Button('关闭')
        .onClick(() => {
          // 关闭动画
          animateTo({
            duration: 200,
            curve: Curve.EaseIn
          }, () => {
            this.scale = 0
          })
          setTimeout(() => {
            this.controller.close()
          }, 200)
        })
    }
    .width('80%')
    .scale({ x: this.scale, y: this.scale })
    .backgroundColor(Color.White)
    .borderRadius(16)
  }
}
```

### 3.7 完整功能的自定义对话框

```typescript
@CustomDialog
export struct FullCustomDialog {
  @Param title: string = '标题'
  @Param message: string = '内容'
  @Local inputValue: string = ''
  @Param showInput: boolean = false
  @Param confirmText: string = '确定'
  @Param cancelText: string = '取消'
  controller: CustomDialogController
  @Event onConfirm: (value?: string) => void = () => {}
  @Event onCancel: () => void = () => {}

  build() {
    Column() {
      // 标题
      Text(this.title)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 20, bottom: 10 })

      // 消息
      Text(this.message)
        .fontSize(16)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ left: 20, right: 20, bottom: 10 })

      // 输入框
      if (this.showInput) {
        TextInput({
          placeholder: '请输入...',
          text: this.inputValue
        })
          .onChange((value: string) => {
            this.inputValue = value
          })
          .margin({ left: 20, right: 20, bottom: 20 })
      }

      Divider()

      // 按钮组
      Row() {
        Button(this.cancelText)
          .layoutWeight(1)
          .type(ButtonType.Normal)
          .onClick(() => {
            this.onCancel()
            this.controller.close()
          })

        Divider()
          .vertical(true)

        Button(this.confirmText)
          .layoutWeight(1)
          .type(ButtonType.Normal)
          .onClick(() => {
            if (this.showInput) {
              this.onConfirm(this.inputValue)
            } else {
              this.onConfirm()
            }
            this.controller.close()
          })
      }
      .width('100%')
    }
    .width('80%')
    .backgroundColor(Color.White)
    .borderRadius(16)
  }
}

@ComponentV2
export struct FullCustomDialogExample {
  @Local dialogController?: CustomDialogController
  @Local result: string = ''

  build() {
    Column({ space: 16 }) {
      Text(`结果: ${this.result}`)
        .fontSize(16)

      Button('显示确认对话框')
        .onClick(() => {
          this.dialogController = new CustomDialogController({
            builder: FullCustomDialog({
              title: '确认操作',
              message: '确定要继续吗？',
              showInput: false,
              onConfirm: () => {
                this.result = '已确认'
              },
              onCancel: () => {
                this.result = '已取消'
              }
            }),
            autoCancel: true,
            alignment: DialogAlignment.Center
          })
          this.dialogController.open()
        })

      Button('显示输入对话框')
        .onClick(() => {
          this.dialogController = new CustomDialogController({
            builder: FullCustomDialog({
              title: '输入内容',
              message: '请输入您的意见',
              showInput: true,
              onConfirm: (value: string) => {
                this.result = `输入: ${value}`
              }
            }),
            autoCancel: true,
            alignment: DialogAlignment.Center
          })
          this.dialogController.open()
        })
    }
    .width('100%')
    .height('100%')
  }
}
```

## 四、高级用法

### 4.1 带数据验证的对话框

```typescript
@CustomDialog
export struct ValidationCustomDialog {
  @Local username: string = ''
  @Local password: string = ''
  @Local errorMessage: string = ''
  controller: CustomDialogController
  @Event onLogin: (username: string, password: string) => void = () => {}

  validate(): boolean {
    if (this.username.length === 0) {
      this.errorMessage = '用户名不能为空'
      return false
    }

    if (this.password.length < 6) {
      this.errorMessage = '密码至少6位'
      return false
    }

    this.errorMessage = ''
    return true
  }

  build() {
    Column() {
      Text('登录')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .padding(20)

      TextInput({ placeholder: '用户名', text: this.username })
        .onChange((value: string) => {
          this.username = value
          this.errorMessage = ''
        })
        .margin({ left: 20, right: 20, bottom: 10 })

      TextInput({ placeholder: '密码', text: this.password })
        .type(InputType.Password)
        .onChange((value: string) => {
          this.password = value
          this.errorMessage = ''
        })
        .margin({ left: 20, right: 20, bottom: 10 })

      if (this.errorMessage.length > 0) {
        Text(this.errorMessage)
          .fontSize(14)
          .fontColor('#FF0000')
          .width('100%')
          .padding({ left: 20, right: 20, bottom: 10 })
      }

      Divider()

      Row() {
        Button('取消')
          .layoutWeight(1)
          .type(ButtonType.Normal)
          .onClick(() => {
            this.controller.close()
          })

        Divider()
          .vertical(true)

        Button('登录')
          .layoutWeight(1)
          .type(ButtonType.Normal)
          .onClick(() => {
            if (this.validate()) {
              this.onLogin(this.username, this.password)
              this.controller.close()
            }
          })
      }
      .width('100%')
    }
    .width('80%')
    .backgroundColor(Color.White)
    .borderRadius(16)
  }
}
```

### 4.2 可复用的对话框工具类

```typescript
// DialogUtils.ets
export class DialogUtils {
  static showConfirm(
    title: string,
    message: string,
    onConfirm: () => void
  ): CustomDialogController {
    return new CustomDialogController({
      builder: FullCustomDialog({
        title: title,
        message: message,
        onConfirm: onConfirm
      }),
      autoCancel: true,
      alignment: DialogAlignment.Center
    })
  }

  static showInput(
    title: string,
    placeholder: string,
    onConfirm: (value: string) => void
  ): CustomDialogController {
    return new CustomDialogController({
      builder: FullCustomDialog({
        title: title,
        message: placeholder,
        showInput: true,
        onConfirm: onConfirm
      }),
      autoCancel: true,
      alignment: DialogAlignment.Center
    })
  }
}

// 使用示例
@ComponentV2
export struct DialogUtilsExample {
  build() {
    Column({ space: 16 }) {
      Button('确认对话框')
        .onClick(() => {
          const dialog = DialogUtils.showConfirm(
            '删除',
            '确定要删除吗？',
            () => {
              console.info('已确认删除')
            }
          )
          dialog.open()
        })

      Button('输入对话框')
        .onClick(() => {
          const dialog = DialogUtils.showInput(
            '请输入',
            '输入内容',
            (value: string) => {
              console.info(`输入: ${value}`)
            }
          )
          dialog.open()
        })
    }
  }
}
```

### 4.3 带加载状态的对话框

```typescript
@CustomDialog
export struct LoadingCustomDialog {
  @Param message: string = '加载中...'
  @Local isLoading: boolean = true
  controller: CustomDialogController

  build() {
    Column() {
      if (this.isLoading) {
        LoadingProgress()
          .width(50)
          .height(50)
          .color('#007DFF')
          .margin(20)

        Text(this.message)
          .fontSize(16)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ left: 20, right: 20, bottom: 20 })
      } else {
        Text('完成')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .padding(20)

        Button('关闭')
          .onClick(() => {
            this.controller.close()
          })
      }
    }
    .width('80%')
    .backgroundColor(Color.White)
    .borderRadius(16)
  }

  setLoading(loading: boolean) {
    this.isLoading = loading
  }
}
```

## 五、最佳实践

### 5.1 资源管理

```typescript
// ✅ 推荐：在组件销毁时释放对话框资源
@ComponentV2
struct MyComponent {
  dialogController: CustomDialogController = new CustomDialogController({
    builder: MyCustomDialog
  })

  aboutToDisappear() {
    // 释放对话框资源
    this.dialogController.dismiss()
  }

  build() {
    Column() {
      Button('显示对话框')
        .onClick(() => {
          this.dialogController.open()
        })
    }
  }
}
```

### 5.2 参数传递

```typescript
// ✅ 推荐：使用 @Param 传递参数
@CustomDialog
export struct MyDialog {
  @Param title: string = ''  // 使用 @Param
  @Param message: string = ''
  controller: CustomDialogController

  build() {
    Column() {
      Text(this.title)
      Text(this.message)
    }
  }
}

// ❌ 避免：直接修改构造器
```

### 5.3 样式一致性

```typescript
// ✅ 推荐：统一样式配置
const DIALOG_STYLE = {
  width: '80%',
  backgroundColor: Color.White,
  cornerRadius: 16
}

@CustomDialog
export struct MyDialog {
  controller: CustomDialogController

  build() {
    Column() {
      // 内容
    }
    .width(DIALOG_STYLE.width)
    .backgroundColor(DIALOG_STYLE.backgroundColor)
    .borderRadius(DIALOG_STYLE.cornerRadius)
  }
}
```

### 5.4 回调处理

```typescript
// ✅ 推荐：明确回调职责
@CustomDialog
export struct MyDialog {
  @Event onConfirm: () => void = () => {}
  @Event onCancel: () => void = () => {}
  controller: CustomDialogController

  build() {
    Column() {
      Row() {
        Button('取消')
          .onClick(() => {
            this.onCancel()  // 取消回调
            this.controller.close()
          })

        Button('确定')
          .onClick(() => {
            this.onConfirm()  // 确认回调
            this.controller.close()
          })
      }
    }
  }
}
```

## 六、常见问题

### Q1: 对话框显示后立即关闭？

**问题**: 对话框打开后马上自动关闭。

**解决方案**:
```typescript
// 1. 确保控制器不会被垃圾回收
@ComponentV2
struct MyComponent {
  dialogController: CustomDialogController = new CustomDialogController({
    builder: MyCustomDialog,
    autoCancel: true  // 如果不希望点击遮罩关闭，设为 false
  })

  build() {
    Column() {
      Button('显示')
        .onClick(() => {
          this.dialogController.open()
        })
    }
  }
}

// 2. 确保对话框没有被重复创建
// ❌ 错误：每次点击都创建新控制器
.onClick(() => {
  const dialog = new CustomDialogController({...})  // 每次创建新的
  dialog.open()
})

// ✅ 正确：复用同一个控制器
onClick(() => {
  this.dialogController.open()  // 复用
})
```

### Q2: 如何传递动态参数？

**解决方案**:
```typescript
// 使用 @Param 装饰器
@CustomDialog
export struct DynamicDialog {
  @Param title: string = ''
  @Param items: string[] = []
  @Local selectedIndex: number = -1
  controller: CustomDialogController
  @Event onSelect: (index: number) => void = () => {}

  build() {
    Column() {
      Text(this.title)  // 使用动态标题

      ForEach(this.items, (item: string, index: number) => {
        Text(item)
          .onClick(() => {
            this.selectedIndex = index
            this.onSelect(index)
            this.controller.close()
          })
      })
    }
  }
}

// 使用时传递参数
this.dialogController = new CustomDialogController({
  builder: DynamicDialog({
    title: '动态标题',
    items: ['选项1', '选项2', '选项3'],
    onSelect: (index: number) => {
      console.info(`选择了: ${index}`)
    }
  })
})
```

### Q3: 如何自定义对话框动画？

**解决方案**:
```typescript
// 在控制器中配置动画
this.dialogController = new CustomDialogController({
  builder: MyCustomDialog,
  openAnimation: {
    duration: 300,
    curve: Curve.EaseOut
  },
  closeAnimation: {
    duration: 200,
    curve: Curve.EaseIn
  }
})

// 或在对话框内部使用 animateTo
@CustomDialog
export struct AnimatedDialog {
  @Local opacity: number = 0
  controller: CustomDialogController

  aboutToAppear() {
    animateTo({
      duration: 300
    }, () => {
      this.opacity = 1
    })
  }

  build() {
    Column() {
      // 内容
    }
    .opacity(this.opacity)
  }
}
```

### Q4: 对话框内容如何自适应高度？

**解决方案**:
```typescript
// 使用百分比或最大高度
@CustomDialog
export struct AdaptiveDialog {
  @Param content: string = ''
  controller: CustomDialogController

  build() {
    Column() {
      Text(this.content)
        .width('100%')
    }
    .width('80%')
    .maxHeight('80%')  // 最大高度
    .constraintSize({ minHeight: 100 })  // 最小高度
    .backgroundColor(Color.White)
    .borderRadius(16)
  }
}
```

### Q5: 如何实现对话框间的跳转？

**解决方案**:
```typescript
// 在一个对话框关闭时打开另一个
@CustomDialog
export struct FirstDialog {
  controller: CustomDialogController
  @Event onOpenSecond: () => void = () => {}

  build() {
    Column() {
      Button('打开第二个对话框')
        .onClick(() => {
          this.controller.close()
          this.onOpenSecond()  // 触发回调
        })
    }
  }
}

// 在父组件中处理
@ComponentV2
struct ParentComponent {
  firstDialog: CustomDialogController = new CustomDialogController({
    builder: FirstDialog({
      onOpenSecond: () => {
        // 打开第二个对话框
        this.secondDialog.open()
      }
    })
  })

  secondDialog: CustomDialogController = new CustomDialogController({
    builder: SecondDialog
  })

  build() {
    Column() {
      Button('显示对话框')
        .onClick(() => {
          this.firstDialog.open()
        })
    }
  }
}
```

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 9+ | ✅ | 基础功能支持 |
| API 10+ | ✅ | 增强了样式自定义能力 |
| API 11+ | ✅ | 增加了转场动画支持 |
| API 12+ | ✅ | 推荐使用 @CustomDialog 装饰器 |

## 八、参考资料

- [CustomDialogController 自定义对话框 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-methods-custom-dialog-box-V5)
- [@CustomDialog 装饰器 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-decorator-custom-dialog-V5)
- [对话框开发指南 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/ts-displaying-dialog-V5)
