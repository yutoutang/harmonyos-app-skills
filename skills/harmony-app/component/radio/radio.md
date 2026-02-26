# Radio 组件 HarmonyOS 6.0 开发 Skill

## 概述

Radio 组件是 OpenHarmony 中用于实现单选功能的组件。它提供了一种简单的方式来让用户在一组选项中选择一个。Radio 通常用于性别选择、支付方式、配送方式等互斥选择场景。

## 重要说明

- **基础组件**: Radio 是 ArkUI 的基础内置组件，无需导入
- **互斥选择**: 同一 RadioGroup 内只能选中一个 Radio
- **分组使用**: 必须配合 RadioGroup 使用以实现互斥
- **值匹配**: 通过 value 属性标识，与 RadioGroup 的 groupValue 对比确定选中状态
- **自定义样式**: 支持选中颜色、形状等自定义

## 模块信息

- **组件名称**: Radio
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [Radio 单选框 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-radio-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// Radio 是内置组件，无需导入
// 直接使用即可
Radio({ value: 'male', group: 'genderGroup' })
```

### 1.2 基础用法

```typescript
// 单选框
Radio({ value: 'option1', group: 'myGroup' })
  .checked(false)

// 设置为选中
Radio({ value: 'option2', group: 'myGroup' })
  .checked(true)

// 监听状态变化
Radio({ value: 'option3', group: 'myGroup' })
  .onChange((isChecked: boolean) => {
    console.info('选中状态: ' + isChecked)
  })
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| value | `string` | 是 | - | 单选框的值，用于标识当前选项 |
| group | `string` | 是 | - | 单选框所属组的名称 |

### 2.2 常用属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `checked` | `boolean` | false | 设置是否选中 |
| `radioStyle` | `RadioStyle` | - | 自定义单选框样式 |

### 2.3 RadioStyle 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `checkedBackgroundColor` | `ResourceColor` | '#007DFF' | 选中状态的背景颜色 |
| `checkColor` | `ResourceColor` | '#FFFFFF' | 选中标志的颜色 |

### 2.4 事件

| 事件 | 类型 | 描述 |
|------|------|------|
| `onChange` | `(isChecked: boolean) => void` | 单选框选中状态改变时触发 |

## 三、使用示例

### 3.1 基础单选框

```typescript
@ComponentV2
struct BasicRadioExample {
  @Local selectedValue: string = 'option1'

  build() {
    Column({ space: 16 }) {
      Text('基础单选框')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Column({ space: 12 }) {
        Row({ space: 8 }) {
          Radio({ value: 'option1', group: 'myGroup' })
            .checked(this.selectedValue === 'option1')
            .onChange((isChecked: boolean) => {
              if (isChecked) {
                this.selectedValue = 'option1'
              }
            })

          Text('选项 1')
            .fontSize(16)
        }

        Row({ space: 8 }) {
          Radio({ value: 'option2', group: 'myGroup' })
            .checked(this.selectedValue === 'option2')
            .onChange((isChecked: boolean) => {
              if (isChecked) {
                this.selectedValue = 'option2'
              }
            })

          Text('选项 2')
            .fontSize(16)
        }

        Row({ space: 8 }) {
          Radio({ value: 'option3', group: 'myGroup' })
            .checked(this.selectedValue === 'option3')
            .onChange((isChecked: boolean) => {
              if (isChecked) {
                this.selectedValue = 'option3'
              }
            })

          Text('选项 3')
            .fontSize(16)
        }
      }

      Text(`选中值: ${this.selectedValue}`)
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.2 自定义颜色

```typescript
@ComponentV2
struct CustomColorExample {
  @Local selectedValue: string = 'red'

  build() {
    Column({ space: 16 }) {
      Text('自定义颜色')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Column({ space: 12 }) {
        Row({ space: 8 }) {
          Radio({ value: 'red', group: 'colorGroup' })
            .checked(this.selectedValue === 'red')
            .radioStyle({
              checkedBackgroundColor: '#FF0000'
            })
            .onChange((isChecked: boolean) => {
              if (isChecked) this.selectedValue = 'red'
            })

          Text('红色')
            .fontSize(16)
        }

        Row({ space: 8 }) {
          Radio({ value: 'green', group: 'colorGroup' })
            .checked(this.selectedValue === 'green')
            .radioStyle({
              checkedBackgroundColor: '#28A745'
            })
            .onChange((isChecked: boolean) => {
              if (isChecked) this.selectedValue = 'green'
            })

          Text('绿色')
            .fontSize(16)
        }

        Row({ space: 8 }) {
          Radio({ value: 'blue', group: 'colorGroup' })
            .checked(this.selectedValue === 'blue')
            .radioStyle({
              checkedBackgroundColor: '#007DFF'
            })
            .onChange((isChecked: boolean) => {
              if (isChecked) this.selectedValue = 'blue'
            })

          Text('蓝色')
            .fontSize(16)
        }
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.3 性别选择

```typescript
@ComponentV2
struct GenderSelectionExample {
  @Local gender: string = 'male'

  build() {
    Column({ space: 16 }) {
      Text('性别选择')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Column({ space: 12 }) {
        Row({ space: 8 }) {
          Radio({ value: 'male', group: 'gender' })
            .checked(this.gender === 'male')
            .onChange((isChecked: boolean) => {
              if (isChecked) this.gender = 'male'
            })

          Text('男')
            .fontSize(16)
        }

        Row({ space: 8 }) {
          Radio({ value: 'female', group: 'gender' })
            .checked(this.gender === 'female')
            .onChange((isChecked: boolean) => {
              if (isChecked) this.gender = 'female'
            })

          Text('女')
            .fontSize(16)
        }

        Row({ space: 8 }) {
          Radio({ value: 'other', group: 'gender' })
            .checked(this.gender === 'other')
            .onChange((isChecked: boolean) => {
              if (isChecked) this.gender = 'other'
            })

          Text('其他')
            .fontSize(16)
        }
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.4 支付方式选择

```typescript
@ComponentV2
struct PaymentMethodExample {
  @Local paymentMethod: string = 'wechat'

  private paymentMethods: Array<{ value: string, label: string, icon: string, color: string }> = [
    { value: 'wechat', label: '微信支付', icon: '\uE641', color: '#07C160' },
    { value: 'alipay', label: '支付宝', icon: '\uE8EF', color: '#1677FF' },
    { value: 'card', label: '银行卡', icon: '\uE6D9', color: '#FF6B6B' }
  ]

  build() {
    Column({ space: 16 }) {
      Text('选择支付方式')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Column({ space: 12 }) {
        ForEach(this.paymentMethods, (method: { value: string, label: string, icon: string, color: string }) => {
          Row({ space: 12 }) {
            Radio({ value: method.value, group: 'payment' })
              .checked(this.paymentMethod === method.value)
              .radioStyle({
                checkedBackgroundColor: method.color
              })
              .onChange((isChecked: boolean) => {
                if (isChecked) this.paymentMethod = method.value
              })

            Text(method.icon)
              .fontSize(24)

            Text(method.label)
              .fontSize(16)
              .layoutWeight(1)
          }
          .width('100%')
          .padding(12)
          .backgroundColor(this.paymentMethod === method.value ? '#F0F8FF' : '#F5F5F5')
          .border({
            width: 2,
            color: this.paymentMethod === method.value ? method.color : 'transparent'
          })
          .borderRadius(8)
        })
      }
      .width('100%')

      Button('确认支付')
        .width('100%')
        .backgroundColor('#007DFF')
        .onClick(() => {
          console.info('使用支付方式: ' + this.paymentMethod)
        })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.5 配送方式选择

```typescript
@ComponentV2
struct DeliveryMethodExample {
  @Local deliveryMethod: string = 'standard'

  private deliveryOptions: Array<{ value: string, name: string, time: string, price: string }> = [
    { value: 'standard', name: '标准配送', time: '预计3-5天送达', price: '免费' },
    { value: 'express', name: '快速配送', time: '预计1-2天送达', price: '¥10' },
    { value: 'sameDay', name: '当日达', time: '今日送达', price: '¥20' }
  ]

  build() {
    Column({ space: 16 }) {
      Text('选择配送方式')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Column({ space: 12 }) {
        ForEach(this.deliveryOptions, (option: { value: string, name: string, time: string, price: string }) => {
          Row({ space: 12 }) {
            Radio({ value: option.value, group: 'delivery' })
              .checked(this.deliveryMethod === option.value)
              .onChange((isChecked: boolean) => {
                if (isChecked) this.deliveryMethod = option.value
              })

            Column({ space: 4 }) {
              Text(option.name)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)

              Text(option.time)
                .fontSize(12)
                .fontColor('#666666')
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            Text(option.price)
              .fontSize(16)
              .fontColor('#FF6B6B')
              .fontWeight(FontWeight.Bold)
          }
          .width('100%')
          .padding(12)
          .backgroundColor(this.deliveryMethod === option.value ? '#E8F5E9' : '#F5F5F5')
          .border({
            width: 2,
            color: this.deliveryMethod === option.value ? '#28A745' : 'transparent'
          })
          .borderRadius(8)
        })
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.6 问卷单选题

```typescript
@ComponentV2
struct SurveyRadioExample {
  @Local answer: string = ''

  private question: string = '您对我们的产品满意度如何？'
  private options: Array<{ value: string, label: string, emoji: string }> = [
    { value: 'very_satisfied', label: '非常满意', emoji: '😊' },
    { value: 'satisfied', label: '满意', emoji: '🙂' },
    { value: 'neutral', label: '一般', emoji: '😐' },
    { value: 'dissatisfied', label: '不满意', emoji: '😞' },
    { value: 'very_dissatisfied', label: '非常不满意', emoji: '😠' }
  ]

  build() {
    Column({ space: 16 }) {
      Text(this.question)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Column({ space: 12 }) {
        ForEach(this.options, (option: { value: string, label: string, emoji: string }) => {
          Row({ space: 12 }) {
            Radio({ value: option.value, group: 'satisfaction' })
              .checked(this.answer === option.value)
              .onChange((isChecked: boolean) => {
                if (isChecked) this.answer = option.value
              })

            Text(option.emoji)
              .fontSize(24)

            Text(option.label)
              .fontSize(16)
              .layoutWeight(1)
          }
          .width('100%')
          .padding(12)
          .backgroundColor(this.answer === option.value ? '#FFF3E0' : '#F5F5F5')
          .borderRadius(8)
        })
      }
      .width('100%')

      Button('提交')
        .width('100%')
        .enabled(this.answer.length > 0)
        .backgroundColor(this.answer.length > 0 ? '#007DFF' : '#CCCCCC')
        .onClick(() => {
          console.info('提交答案: ' + this.answer)
        })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.7 尺寸选择

```typescript
@ComponentV2
struct SizeSelectionExample {
  @Local selectedSize: string = 'M'

  private sizes: Array<{ value: string, label: string }> = [
    { value: 'S', label: 'S (小码)' },
    { value: 'M', label: 'M (中码)' },
    { value: 'L', label: 'L (大码)' },
    { value: 'XL', label: 'XL (特大码)' }
  ]

  build() {
    Column({ space: 16 }) {
      Text('选择尺寸')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Flex({ wrap: FlexWrap.Wrap, space: { main: 12, cross: 8 } }) {
        ForEach(this.sizes, (size: { value: string, label: string }) => {
          Row({ space: 8 }) {
            Radio({ value: size.value, group: 'size' })
              .checked(this.selectedSize === size.value)
              .onChange((isChecked: boolean) => {
                if (isChecked) this.selectedSize = size.value
              })

            Text(size.label)
              .fontSize(14)
          }
          .padding({ left: 16, right: 16, top: 12, bottom: 12 })
          .backgroundColor(this.selectedSize === size.value ? '#007DFF' : '#F5F5F5')
          .borderRadius(8)
        })
      }
      .width('100%')

      Text(`已选: ${this.selectedSize}`)
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.8 语言选择

```typescript
@ComponentV2
struct LanguageSelectionExample {
  @Local selectedLanguage: string = 'zh'

  private languages: Array<{ value: string, name: string, native: string }> = [
    { value: 'zh', name: '简体中文', native: '中文' },
    { value: 'en', name: 'English', native: 'English' },
    { value: 'ja', name: '日本語', native: '日语' },
    { value: 'ko', name: '한국어', native: '韩语' }
  ]

  build() {
    Column({ space: 16 }) {
      Text('选择语言 / Select Language')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Column({ space: 12 }) {
        ForEach(this.languages, (lang: { value: string, name: string, native: string }) => {
          Row({ space: 12 }) {
            Radio({ value: lang.value, group: 'language' })
              .checked(this.selectedLanguage === lang.value)
              .radioStyle({
                checkedBackgroundColor: '#007DFF'
              })
              .onChange((isChecked: boolean) => {
                if (isChecked) this.selectedLanguage = lang.value
              })

            Column({ space: 4 }) {
              Text(lang.name)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)

              Text(lang.native)
                .fontSize(12)
                .fontColor('#999999')
            }
            .alignItems(HorizontalAlign.Start)

            Spacer()
          }
          .width('100%')
          .padding(12)
          .backgroundColor(this.selectedLanguage === lang.value ? '#E3F2FD' : '#FFFFFF')
          .border({ width: 1, color: '#E0E0E0' })
          .borderRadius(8)
        })
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.9 会员套餐选择

```typescript
@ComponentV2
struct MembershipPlanExample {
  @Local selectedPlan: string = 'monthly'

  private plans: Array<{ value: string, name: string, price: string, originalPrice: string, save: string }> = [
    { value: 'monthly', name: '月度会员', price: '¥18/月', originalPrice: '', save: '' },
    { value: 'quarterly', name: '季度会员', price: '¥45/季', originalPrice: '¥54', save: '省¥9' },
    { value: 'yearly', name: '年度会员', price: '¥148/年', originalPrice: '¥216', save: '省¥68' }
  ]

  build() {
    Column({ space: 16 }) {
      Text('选择会员套餐')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Column({ space: 12 }) {
        ForEach(this.plans, (plan: { value: string, name: string, price: string, originalPrice: string, save: string }) => {
          Row({ space: 12 }) {
            Radio({ value: plan.value, group: 'membership' })
              .checked(this.selectedPlan === plan.value)
              .radioStyle({
                checkedBackgroundColor: '#FFD700'
              })
              .onChange((isChecked: boolean) => {
                if (isChecked) this.selectedPlan = plan.value
              })

            Column({ space: 4 }) {
              Row({ space: 8 }) {
                Text(plan.name)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)

                if (plan.save) {
                  Text(plan.save)
                    .fontSize(12)
                    .fontColor('#FF6B6B')
                    .padding({ left: 8, right: 8, top: 2, bottom: 2 })
                    .backgroundColor('#FFE0E0')
                    .borderRadius(4)
                }
              }

              Row({ space: 8 }) {
                Text(plan.price)
                  .fontSize(18)
                  .fontColor('#FF6B6B')
                  .fontWeight(FontWeight.Bold)

                if (plan.originalPrice) {
                  Text(plan.originalPrice)
                    .fontSize(14)
                    .fontColor('#999999')
                    .decoration({ type: TextDecorationType.LineThrough })
                }
              }
            }
            .alignItems(HorizontalAlign.Start)

            Spacer()
          }
          .width('100%')
          .padding(16)
          .backgroundColor(this.selectedPlan === plan.value ? '#FFF9E6' : '#F5F5F5')
          .border({
            width: 2,
            color: this.selectedPlan === plan.value ? '#FFD700' : 'transparent'
          })
          .borderRadius(12)
        })
      }
      .width('100%')

      Button('立即开通')
        .width('100%')
        .backgroundColor('#FFD700')
        .onClick(() => {
          console.info('开通套餐: ' + this.selectedPlan)
        })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.10 主题选择

```typescript
@ComponentV2
struct ThemeSelectionExample {
  @Local selectedTheme: string = 'light'

  private themes: Array<{ value: string, name: string, color: string, icon: string }> = [
    { value: 'light', name: '浅色模式', color: '#FFFFFF', icon: '☀️' },
    { value: 'dark', name: '深色模式', color: '#1F1F1F', icon: '🌙' },
    { value: 'auto', name: '跟随系统', color: '#F5F5F5', icon: '🔄' }
  ]

  build() {
    Column({ space: 16 }) {
      Text('选择主题')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Column({ space: 12 }) {
        ForEach(this.themes, (theme: { value: string, name: string, color: string, icon: string }) => {
          Row({ space: 12 }) {
            Radio({ value: theme.value, group: 'theme' })
              .checked(this.selectedTheme === theme.value)
              .onChange((isChecked: boolean) => {
                if (isChecked) this.selectedTheme = theme.value
              })

            Text(theme.icon)
              .fontSize(24)

            Text(theme.name)
              .fontSize(16)
              .layoutWeight(1)

            // 颜色预览
            Circle()
              .width(24)
              .height(24)
              .fill(theme.color)
              .border({ width: 1, color: '#E0E0E0' })
          }
          .width('100%')
          .padding(12)
          .backgroundColor('#F5F5F5')
          .borderRadius(8)
        })
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
  }
}
```

## 四、最佳实践

### 4.1 默认值设置

```typescript
// ✅ 推荐：设置合理的默认值
@Local selectedValue: string = 'standard'  // 默认标准配送

// ❌ 避免：没有默认值
@Local selectedValue: string = ''  // 用户可能会困惑
```

### 4.2 清晰的标签

```typescript
// ✅ 推荐：提供清晰的选项说明
Row({ space: 8 }) {
  Radio({ value: 'express', group: 'delivery' })
  Column({ space: 4 }) {
    Text('快速配送')
    Text('1-2天送达，加急处理')
      .fontSize(12)
      .fontColor('#666666')
  }
}

// ❌ 避免：标签过于简单
Row({ space: 8 }) {
  Radio({ value: 'express', group: 'delivery' })
  Text('快')
}
```

### 4.3 选中状态反馈

```typescript
// ✅ 推荐：提供明显的选中状态
Row() {
  Radio({ value: 'option1', group: 'group' })
  // ...
}
.backgroundColor(this.selectedValue === 'option1' ? '#E3F2FD' : '#F5F5F5')
.border({ width: 2, color: this.selectedValue === 'option1' ? '#007DFF' : 'transparent' })
```

### 4.4 值的命名

```typescript
// ✅ 推荐：使用有意义的值
Radio({ value: 'male', group: 'gender' })
Radio({ value: 'wechat_pay', group: 'payment' })
Radio({ value: 'standard_delivery', group: 'delivery' })

// ❌ 避免：使用无意义的值
Radio({ value: '1', group: 'gender' })
Radio({ value: '2', group: 'payment' })
Radio({ value: '3', group: 'delivery' })
```

## 五、常见问题

### Q1: Radio 如何实现互斥？

**答案**: Radio 通过 group 属性实现互斥，同一 group 内只能选中一个。

```typescript
// 同一组内的 Radio 会互斥
Radio({ value: 'option1', group: 'myGroup' })
Radio({ value: 'option2', group: 'myGroup' })
Radio({ value: 'option3', group: 'myGroup' })
```

### Q2: 如何获取当前选中的 Radio？

**解决方案**:
```typescript
@ComponentV2
struct GetSelectedExample {
  @Local selectedValue: string = ''

  build() {
    Radio({ value: 'option1', group: 'myGroup' })
      .onChange((isChecked: boolean) => {
        if (isChecked) {
          this.selectedValue = 'option1'
          console.info('选中: ' + this.selectedValue)
        }
      })
  }
}
```

### Q3: 如何设置 Radio 的默认选中？

**解决方案**:
```typescript
@ComponentV2
struct DefaultSelectionExample {
  @Local selectedValue: string = 'option2'  // 默认选中 option2

  build() {
    Radio({ value: 'option2', group: 'myGroup' })
      .checked(this.selectedValue === 'option2')
  }
}
```

## 六、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 9+ | ✅ | 完全支持 |
| API 11+ | ✅ | 增加了 radioStyle 属性 |
| API 12+ | ✅ | 优化了选中动画 |

## 七、参考资料

- [Radio 单选框 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-radio-V5)
- [RadioGroup 单选框组 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-radiogroup-V5)
- [通用属性 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-universal-attributes-size-V5)
