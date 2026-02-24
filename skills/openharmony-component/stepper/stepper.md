# Stepper 组件 HarmonyOS 6.0 开发 Skill

## 概述

Stepper 组件是 OpenHarmony 中的步骤导航组件，用于引导用户完成一系列步骤。它通常包含多个 StepperItem 子组件，每个代表一个步骤。Stepper 提供了清晰的进度指示和步骤间导航功能，常用于向导式流程、表单分步填写、设置向导等场景。

## 重要说明

- **容器组件**: Stepper 是容器组件，必须配合 StepperItem 使用
- **步骤管理**: 通过 StepperItem 定义每个步骤的内容和属性
- **导航控制**: 支持上一步、下一步按钮和索引跳转
- **状态指示**: 支持显示当前步骤、已完成步骤等状态
- **响应式**: 配合 @Local 使用实现步骤状态管理

## 模块信息

- **组件名称**: Stepper
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [Stepper - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-stepper-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// Stepper 是内置组件，无需导入
// 直接使用即可
Stepper() {
  StepperItem() {
    // 步骤内容
  }
}
```

### 1.2 基础用法

```typescript
// 基础步骤条
Stepper() {
  StepperItem() {
    Text('步骤 1')
  }
  StepperItem() {
    Text('步骤 2')
  }
  StepperItem() {
    Text('步骤 3')
  }
}
.onFinish(() => {
  console.info('完成所有步骤')
})
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| index | `number` | 否 | 0 | 当前步骤索引 |

### 2.2 Stepper 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `onChange` | `(prevIndex: number, currentIndex: number) => void` | - | 步骤变化回调 |
| `onFinish` | `() => void` | - | 完成所有步骤回调 |
| `onSkip` | `(index: number) => void` | - | 跳过步骤回调 |

### 2.3 StepperItem 参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| prevLabel | `string` | 否 | '上一步' | 上一步按钮文本 |
| nextLabel | `string` | 否 | '下一步' | 下一步按钮文本 |

### 2.4 StepperItem 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `enabled` | `boolean` | true | 是否可操作 |

## 三、使用示例

### 3.1 基础 Stepper 示例

```typescript
@ComponentV2
struct BasicStepperExample {
  @Local currentIndex: number = 0

  build() {
    Column() {
      Stepper({ index: this.currentIndex }) {
        StepperItem() {
          Column({ space: 16 }) {
            Text('步骤 1')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
            Text('这是第一步的内容')
              .fontSize(16)
              .fontColor('#666666')
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
        }

        StepperItem() {
          Column({ space: 16 }) {
            Text('步骤 2')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
            Text('这是第二步的内容')
              .fontSize(16)
              .fontColor('#666666')
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
        }

        StepperItem() {
          Column({ space: 16 }) {
            Text('步骤 3')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
            Text('这是第三步的内容')
              .fontSize(16)
              .fontColor('#666666')
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
        }
      }
      .onChange((prevIndex: number, currentIndex: number) => {
        this.currentIndex = currentIndex
        console.info(`从步骤 ${prevIndex} 到步骤 ${currentIndex}`)
      })
      .onFinish(() => {
        console.info('完成所有步骤')
      })
    }
    .width('100%')
    .height('100%')
  }
}
```

### 3.2 自定义按钮文本示例

```typescript
@ComponentV2
struct CustomLabelsStepperExample {
  @Local currentIndex: number = 0

  build() {
    Stepper({ index: this.currentIndex }) {
      StepperItem() {
        Column({ space: 16 }) {
          Text('个人信息')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
      }
      .prevLabel('返回')
      .nextLabel('继续')

      StepperItem() {
        Column({ space: 16 }) {
          Text('账号设置')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
      }
      .prevLabel('返回')
      .nextLabel('继续')

      StepperItem() {
        Column({ space: 16 }) {
          Text('完成')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
      }
      .prevLabel('返回')
      .nextLabel('提交')
    }
    .onFinish(() => {
      console.info('提交完成')
    })
  }
}
```

### 3.3 表单向导示例

```typescript
@ComponentV2
struct FormWizardExample {
  @Local currentIndex: number = 0
  @Local username: string = ''
  @Local password: string = ''
  @Local email: string = ''
  @Local agreed: boolean = false

  build() {
    Stepper({ index: this.currentIndex }) {
      // 步骤 1: 用户名
      StepperItem() {
        Column({ space: 20 }) {
          Text('创建账号')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)

          Column({ space: 8 }) {
            Text('用户名')
              .fontSize(16)
              .width('100%')

            TextInput({ placeholder: '请输入用户名', text: this.username })
              .width('100%')
              .height(45)
              .onChange((value: string) => {
                this.username = value
              })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .padding(20)
        .justifyContent(FlexAlign.Center)
      }

      // 步骤 2: 密码
      StepperItem() {
        Column({ space: 20 }) {
          Text('设置密码')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)

          Column({ space: 8 }) {
            Text('密码')
              .fontSize(16)
              .width('100%')

            TextInput({ placeholder: '请输入密码', text: this.password })
              .width('100%')
              .height(45)
              .type(InputType.Password)
              .onChange((value: string) => {
                this.password = value
              })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .padding(20)
        .justifyContent(FlexAlign.Center)
      }

      // 步骤 3: 邮箱
      StepperItem() {
        Column({ space: 20 }) {
          Text('联系信息')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)

          Column({ space: 8 }) {
            Text('邮箱')
              .fontSize(16)
              .width('100%')

            TextInput({ placeholder: '请输入邮箱', text: this.email })
              .width('100%')
              .height(45)
              .type(InputType.Email)
              .onChange((value: string) => {
                this.email = value
              })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .padding(20)
        .justifyContent(FlexAlign.Center)
      }

      // 步骤 4: 确认
      StepperItem() {
        Column({ space: 20 }) {
          Text('确认信息')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)

          Column({ space: 12 }) {
            Text(`用户名: ${this.username}`)
              .fontSize(16)
            Text(`邮箱: ${this.email}`)
              .fontSize(16)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)

          Row({ space: 8 }) {
            Checkbox({ name: 'agree' })
              .select(this.agreed)
              .onChange((value: boolean) => {
                this.agreed = value
              })

            Text('我同意服务条款')
              .fontSize(14)
          }
        }
        .width('100%')
        .padding(20)
        .justifyContent(FlexAlign.Center)
      }
      .nextLabel('完成')
    }
    .onFinish(() => {
      console.info('注册完成')
      console.info(`用户名: ${this.username}, 邮箱: ${this.email}`)
    })
  }
}
```

## 四、高级用法

### 4.1 条件禁用步骤

```typescript
@ComponentV2
struct ConditionalStepperExample {
  @Local currentIndex: number = 0
  @Local step1Valid: boolean = false
  @Local step2Valid: boolean = false

  build() {
    Stepper({ index: this.currentIndex }) {
      StepperItem() {
        Column({ space: 16 }) {
          Text('步骤 1')
            .fontSize(24)

          TextInput({ placeholder: '输入内容以启用下一步' })
            .onChange((value: string) => {
              this.step1Valid = value.length > 0
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
      }

      StepperItem() {
        Column({ space: 16 }) {
          Text('步骤 2')
            .fontSize(24)

          TextInput({ placeholder: '输入内容以启用下一步' })
            .onChange((value: string) => {
              this.step2Valid = value.length > 0
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
      }
      .enabled(this.step1Valid) // 步骤1完成后才能操作

      StepperItem() {
        Column({ space: 16 }) {
          Text('步骤 3')
            .fontSize(24)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
      }
      .enabled(this.step2Valid) // 步骤2完成后才能操作
    }
  }
}
```

### 4.2 步骤验证

```typescript
@ComponentV2
struct ValidatedStepperExample {
  @Local currentIndex: number = 0

  // 验证当前步骤
  validateStep(index: number): boolean {
    switch (index) {
      case 0:
        // 验证步骤1
        return true
      case 1:
        // 验证步骤2
        return true
      default:
        return true
    }
  }

  build() {
    Stepper({ index: this.currentIndex }) {
      StepperItem() {
        Text('步骤 1')
          .fontSize(24)
      }
      .nextLabel('下一步')

      StepperItem() {
        Text('步骤 2')
          .fontSize(24)
      }
      .nextLabel('下一步')

      StepperItem() {
        Text('步骤 3')
          .fontSize(24)
      }
      .nextLabel('完成')
    }
    .onChange((prevIndex: number, currentIndex: number) => {
      // 在进入下一步前验证
      if (!this.validateStep(prevIndex)) {
        // 验证失败，阻止跳转
      }
    })
  }
}
```

## 五、最佳实践

### 5.1 步骤数量控制

```typescript
// ✅ 推荐：步骤数量控制在 3-7 个
Stepper() {
  StepperItem() { /* 步骤1 */ }
  StepperItem() { /* 步骤2 */ }
  StepperItem() { /* 步骤3 */ }
  StepperItem() { /* 步骤4 */ }
  StepperItem() { /* 步骤5 */ }
}

// ❌ 避免：步骤过多导致用户体验差
Stepper() {
  // 10+ 个步骤
}
```

### 5.2 清晰的步骤标题

```typescript
// ✅ 推荐：使用清晰的标题
StepperItem() {
  Column({ space: 8 }) {
    Text('步骤 1: 个人信息')
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
    // 内容...
  }
}

// ✅ 推荐：添加进度指示
Column({ space: 16 }) {
  Text(`步骤 ${currentIndex + 1} / ${totalSteps}`)
    .fontSize(14)
    .fontColor('#666666')

  Progress({ value: currentIndex + 1, total: totalSteps })
    .width('100%')
}
```

### 5.3 数据收集

```typescript
// ✅ 推荐：在每个步骤收集必要信息
@ComponentV2
struct DataCollectionStepper {
  @Local formData: Record<string, string> = {}

  updateFormData(field: string, value: string) {
    this.formData = {
      ...this.formData,
      [field]: value
    }
  }

  build() {
    Stepper() {
      StepperItem() {
        TextInput()
          .onChange((value: string) => {
            this.updateFormData('username', value)
          })
      }
    }
    .onFinish(() => {
      // 提交所有收集的数据
      console.info('Form data:', JSON.stringify(this.formData))
    })
  }
}
```

## 六、常见问题

### Q1: 如何跳过某个步骤？

**解决方案**:
```typescript
@ComponentV2
struct SkippableStepper {
  @Local currentIndex: number = 0
  @Local skipStep2: boolean = false

  build() {
    Stepper({ index: this.currentIndex }) {
      StepperItem() {
        Text('步骤 1')
      }

      StepperItem() {
        Column({ space: 16 }) {
          Text('步骤 2')
          Button('跳过此步骤')
            .onClick(() => {
              this.skipStep2 = true
              // 跳到下一步
            })
        }
      }

      StepperItem() {
        Text('步骤 3')
      }
    }
  }
}
```

### Q2: 如何实现步骤进度指示？

**解决方案**:
```typescript
@ComponentV2
struct ProgressStepper {
  @Local currentIndex: number = 0
  readonly totalSteps: number = 3

  build() {
    Column() {
      // 进度指示
      Row({ space: 8 }) {
        ForEach([0, 1, 2], (index: number) => {
          Column()
            .width(60)
            .height(4)
            .backgroundColor(index <= this.currentIndex ? '#007DFF' : '#E0E0E0')
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)

      // Stepper
      Stepper({ index: this.currentIndex }) {
        // steps...
      }
    }
  }
}
```

### Q3: 如何动态添加步骤？

**解决方案**:
```typescript
@ComponentV2
struct DynamicStepper {
  @Local currentIndex: number = 0
  @Local steps: string[] = ['步骤1', '步骤2', '步骤3']

  build() {
    Stepper({ index: this.currentIndex }) {
      ForEach(this.steps, (step: string, index: number) => {
        StepperItem() {
          Text(step)
            .fontSize(24)
        }
      })
    }
  }
}
```

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 9+ | ✅ | 完全支持 |
| API 10+ | ✅ | 性能优化 |
| API 12+ | ✅ | 增加了更多自定义选项 |

## 八、参考资料

- [Stepper 步骤条 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-stepper-V5)
- [StepperItem - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-stepper-item-V5)
