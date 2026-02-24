# StepperItem 组件 HarmonyOS 6.0 开发 Skill

## 概述

StepperItem 组件是 OpenHarmony 中 Stepper 容器的子项组件，用于定义步骤导航中的单个步骤。每个 StepperItem 代表一个独立的步骤页面，包含该步骤的内容和导航按钮（上一步、下一步）。StepperItem 必须作为 Stepper 的直接子组件使用。

## 重要说明

- **子组件**: StepperItem 必须作为 Stepper 的直接子组件使用
- **内容容器**: 每个 StepperItem 包含一个步骤的所有内容
- **按钮配置**: 支持自定义上一步和下一步按钮的文本
- **状态控制**: 通过 enabled 属性控制步骤是否可操作
- **导航控制**: 配合父组件 Stepper 实现步骤间的导航

## 模块信息

- **组件名称**: StepperItem
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [StepperItem - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-stepper-item-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// StepperItem 是内置组件，无需导入
// 作为 Stepper 的子组件使用
Stepper() {
  StepperItem() {
    // 步骤内容
  }
}
```

### 1.2 基础用法

```typescript
// 基础步骤项
Stepper() {
  StepperItem() {
    Column({ space: 16 }) {
      Text('步骤标题')
        .fontSize(24)
      Text('步骤内容')
        .fontSize(16)
    }
  }
}
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| prevLabel | `string` | 否 | '上一步' | 上一步按钮文本 |
| nextLabel | `string` | 否 | '下一步' | 下一步按钮文本 |

### 2.2 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `enabled` | `boolean` | true | 是否可操作 |

## 三、使用示例

### 3.1 基础 StepperItem 示例

```typescript
@ComponentV2
struct BasicStepperItemExample {
  @Local currentIndex: number = 0

  build() {
    Stepper({ index: this.currentIndex }) {
      // 步骤 1
      StepperItem() {
        Column({ space: 20 }) {
          Text('欢迎')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)

          Text('欢迎使用应用，点击下一步开始')
            .fontSize(16)
            .fontColor('#666666')
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .padding(20)
      }
      .nextLabel('开始')

      // 步骤 2
      StepperItem() {
        Column({ space: 20 }) {
          Text('功能介绍')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)

          Text('这里介绍应用的主要功能')
            .fontSize(16)
            .fontColor('#666666')
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .padding(20)
      }

      // 步骤 3
      StepperItem() {
        Column({ space: 20 }) {
          Text('完成')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)

          Text('设置完成，开始使用吧！')
            .fontSize(16)
            .fontColor('#666666')
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .padding(20)
      }
      .nextLabel('完成')
    }
    .onFinish(() => {
      console.info('引导完成')
    })
  }
}
```

### 3.2 自定义按钮文本示例

```typescript
@ComponentV2
struct CustomButtonLabelsExample {
  @Local currentIndex: number = 0

  build() {
    Stepper({ index: this.currentIndex }) {
      StepperItem() {
        Column({ space: 16 }) {
          Text('第一步')
            .fontSize(24)
          Text('选择您的操作')
            .fontSize(16)
        }
        .justifyContent(FlexAlign.Center)
      }
      .prevLabel('取消')
      .nextLabel('继续')

      StepperItem() {
        Column({ space: 16 }) {
          Text('第二步')
            .fontSize(24)
          Text('确认您的选择')
            .fontSize(16)
        }
        .justifyContent(FlexAlign.Center)
      }
      .prevLabel('返回')
      .nextLabel('继续')

      StepperItem() {
        Column({ space: 16 }) {
          Text('第三步')
            .fontSize(24)
          Text('完成设置')
            .fontSize(16)
        }
        .justifyContent(FlexAlign.Center)
      }
      .prevLabel('返回')
      .nextLabel('提交')
    }
  }
}
```

### 3.3 条件启用步骤示例

```typescript
@ComponentV2
struct ConditionalEnabledExample {
  @Local currentIndex: number = 0
  @Local step1Completed: boolean = false
  @Local step2Completed: boolean = false

  build() {
    Stepper({ index: this.currentIndex }) {
      StepperItem() {
        Column({ space: 20 }) {
          Text('步骤 1')
            .fontSize(24)

          TextInput({ placeholder: '输入任意内容以继续' })
            .onChange((value: string) => {
              this.step1Completed = value.length > 0
            })

          if (this.step1Completed) {
            Text('✓ 已完成')
              .fontColor('#28A745')
          }
        }
        .justifyContent(FlexAlign.Center)
      }

      StepperItem() {
        Column({ space: 20 }) {
          Text('步骤 2')
            .fontSize(24)

          TextInput({ placeholder: '输入任意内容以继续' })
            .onChange((value: string) => {
              this.step2Completed = value.length > 0
            })

          if (this.step2Completed) {
            Text('✓ 已完成')
              .fontColor('#28A745')
          }
        }
        .justifyContent(FlexAlign.Center)
      }
      .enabled(this.step1Completed) // 步骤1完成后才启用

      StepperItem() {
        Column({ space: 20 }) {
          Text('步骤 3')
            .fontSize(24)
          Text('最后一步')
            .fontSize(16)
        }
        .justifyContent(FlexAlign.Center)
      }
      .enabled(this.step2Completed) // 步骤2完成后才启用
      .nextLabel('完成')
    }
  }
}
```

### 3.4 表单步骤示例

```typescript
@ComponentV2
struct FormStepItemExample {
  @Local currentIndex: number = 0
  @Local name: string = ''
  @Local phone: string = ''
  @Local address: string = ''

  build() {
    Stepper({ index: this.currentIndex }) {
      // 步骤 1: 基本信息
      StepperItem() {
        Column({ space: 20 }) {
          Text('基本信息')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width('100%')

          Column({ space: 12 }) {
            Text('姓名')
              .fontSize(16)
              .width('100%')

            TextInput({ placeholder: '请输入姓名', text: this.name })
              .width('100%')
              .height(45)
              .onChange((value: string) => {
                this.name = value
              })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .padding(24)
      }
      .prevLabel('取消')
      .nextLabel('下一步')

      // 步骤 2: 联系方式
      StepperItem() {
        Column({ space: 20 }) {
          Text('联系方式')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width('100%')

          Column({ space: 12 }) {
            Text('电话')
              .fontSize(16)
              .width('100%')

            TextInput({ placeholder: '请输入电话号码', text: this.phone })
              .width('100%')
              .height(45)
              .type(InputType.PhoneNumber)
              .onChange((value: string) => {
                this.phone = value
              })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .padding(24)
      }
      .prevLabel('上一步')
      .nextLabel('下一步')

      // 步骤 3: 地址信息
      StepperItem() {
        Column({ space: 20 }) {
          Text('地址信息')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width('100%')

          Column({ space: 12 }) {
            Text('详细地址')
              .fontSize(16)
              .width('100%')

            TextInput({ placeholder: '请输入详细地址', text: this.address })
              .width('100%')
              .height(90)
              .type(InputType.Normal)
              .onChange((value: string) => {
                this.address = value
              })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .padding(24)
      }
      .prevLabel('上一步')
      .nextLabel('提交')
    }
    .onFinish(() => {
      console.info(`提交: ${this.name}, ${this.phone}, ${this.address}`)
    })
  }
}
```

## 四、高级用法

### 4.1 动态内容步骤

```typescript
@ComponentV2
struct DynamicContentExample {
  @Local currentIndex: number = 0
  @Local selectedOption: string = ''

  build() {
    Stepper({ index: this.currentIndex }) {
      StepperItem() {
        Column({ space: 20 }) {
          Text('选择选项')
            .fontSize(24)

          ForEach(['选项 A', '选项 B', '选项 C'], (option: string) => {
            Button(option)
              .width('100%')
              .backgroundColor(this.selectedOption === option ? '#007DFF' : '#E0E0E0')
              .fontColor(this.selectedOption === option ? Color.White : '#333333')
              .onClick(() => {
                this.selectedOption = option
              })
          })
        }
        .justifyContent(FlexAlign.Start)
      }

      StepperItem() {
        Column({ space: 20 }) {
          Text('您的选择')
            .fontSize(24)
          Text(`您选择了: ${this.selectedOption}`)
            .fontSize(18)
        }
        .justifyContent(FlexAlign.Center)
      }
    }
  }
}
```

### 4.2 图像展示步骤

```typescript
@ComponentV2
struct ImageStepExample {
  @Local currentIndex: number = 0

  build() {
    Stepper({ index: this.currentIndex }) {
      StepperItem() {
        Column({ space: 20 }) {
          Image($r('app.media.icon'))
            .width(200)
            .height(200)

          Text('功能介绍 1')
            .fontSize(24)

          Text('这是第一个功能的介绍')
            .fontSize(16)
            .fontColor('#666666')
        }
        .justifyContent(FlexAlign.Center)
      }
      .nextLabel('继续')

      StepperItem() {
        Column({ space: 20 }) {
          Image($r('app.media.icon'))
            .width(200)
            .height(200)

          Text('功能介绍 2')
            .fontSize(24)

          Text('这是第二个功能的介绍')
            .fontSize(16)
            .fontColor('#666666')
        }
        .justifyContent(FlexAlign.Center)
      }
      .nextLabel('继续')

      StepperItem() {
        Column({ space: 20 }) {
          Image($r('app.media.icon'))
            .width(200)
            .height(200)

          Text('功能介绍 3')
            .fontSize(24)

          Text('这是第三个功能的介绍')
            .fontSize(16)
            .fontColor('#666666')
        }
        .justifyContent(FlexAlign.Center)
      }
      .nextLabel('完成')
    }
  }
}
```

## 五、最佳实践

### 5.1 内容布局

```typescript
// ✅ 推荐：使用 Column 居中布局
StepperItem() {
  Column({ space: 20 }) {
    Text('标题')
      .fontSize(24)
      .fontWeight(FontWeight.Bold)

    // 内容...

    Blank()

    Text('提示信息')
      .fontSize(14)
      .fontColor('#666666')
  }
  .width('100%')
  .height('100%')
  .padding(20)
  .justifyContent(FlexAlign.Center)
}
```

### 5.2 按钮文本规范

```typescript
// ✅ 推荐：使用清晰的按钮文本
StepperItem() {
  Column() { /* ... */ }
}
.prevLabel('返回')    // 明确的返回操作
.nextLabel('继续')    // 明确的继续操作

// ✅ 最后一步
StepperItem() {
  Column() { /* ... */ }
}
.prevLabel('返回')
.nextLabel('完成')    // 明确的完成操作
```

### 5.3 步骤验证

```typescript
// ✅ 推荐：在步骤内容中添加验证提示
@ComponentV2
struct ValidatedStepItem {
  @Local inputValid: boolean = false
  @Local inputText: string = ''

  build() {
    Stepper() {
      StepperItem() {
        Column({ space: 16 }) {
          Text('输入信息')
            .fontSize(24)

          TextInput({ text: this.inputText })
            .onChange((value: string) => {
              this.inputText = value
              this.inputValid = value.length >= 6
            })

          if (this.inputText.length > 0 && !this.inputValid) {
            Text('至少输入6个字符')
              .fontSize(14)
              .fontColor('#DC3545')
          }
        }
      }
      .enabled(this.inputValid) // 验证通过后才可下一步
    }
  }
}
```

## 六、常见问题

### Q1: 如何隐藏第一步的"上一步"按钮？

**说明**: 第一步的"上一步"按钮默认不显示，无需额外处理。

### Q2: 如何修改最后一步的按钮文本？

**解决方案**:
```typescript
StepperItem() {
  Column() {
    Text('最后一步')
  }
}
.prevLabel('返回')
.nextLabel('提交完成')  // 自定义最后一步的按钮文本
```

### Q3: 如何实现步骤间的数据传递？

**解决方案**:
```typescript
@ComponentV2
struct DataPassingExample {
  @Local currentIndex: number = 0
  @Local sharedData: string = ''

  build() {
    Stepper({ index: this.currentIndex }) {
      StepperItem() {
        TextInput()
          .onChange((value: string) => {
            this.sharedData = value // 在步骤1收集数据
          })
      }

      StepperItem() {
        Text(`步骤1的数据: ${this.sharedData}`) // 在步骤2使用数据
      }
    }
  }
}
```

### Q4: 如何禁用某个步骤？

**解决方案**:
```typescript
StepperItem() {
  Column() {
    Text('此步骤已禁用')
  }
}
.enabled(false) // 禁用该步骤
```

### Q5: 如何实现步骤的完全自定义？

**解决方案**:
```typescript
// ✅ 推荐：在 StepperItem 中使用自定义布局
StepperItem() {
  Column() {
    // 自定义头部
    Row() {
      Text('步骤 1/3')
        .fontSize(14)
        .fontColor('#666666')

      Progress({ value: 1, total: 3 })
        .width(100)
    }
    .width('100%')

    // 自定义内容区域
    Scroll() {
      Column({ space: 16 }) {
        // 内容...
      }
    }
    .layoutWeight(1)

    // 自定义底部
    Row() {
      Text('提示信息')
        .fontSize(12)
        .fontColor('#999999')
    }
  }
  .width('100%')
  .height('100%')
}
```

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 9+ | ✅ | 完全支持 |
| API 10+ | ✅ | 性能优化 |
| API 12+ | ✅ | 增加了更多自定义选项 |

## 八、参考资料

- [StepperItem - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-stepper-item-V5)
- [Stepper 步骤条 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-stepper-V5)
