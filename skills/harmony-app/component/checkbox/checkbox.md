# Checkbox 组件 HarmonyOS 6.0 开发 Skill

## 概述

Checkbox 组件是 OpenHarmony 中用于实现复选框功能的组件。它提供了一种简单的方式来让用户在两个状态（选中/未选中）之间进行选择。Checkbox 通常用于同意条款、多选选项等场景。

## 重要说明

- **基础组件**: Checkbox 是 ArkUI 的基础内置组件，无需导入
- **两种状态**: 选中（true）和未选中（false）
- **分组使用**: 多个 Checkbox 可以独立使用或通过 CheckboxGroup 进行分组
- **自定义样式**: 支持选中颜色、形状等自定义
- **名称属性**: 通过 name 属性标识，便于在 CheckboxGroup 中识别

## 模块信息

- **组件名称**: Checkbox
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [Checkbox 复选框 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-checkbox-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// Checkbox 是内置组件，无需导入
// 直接使用即可
Checkbox({ name: 'checkbox1' })
```

### 1.2 基础用法

```typescript
// 简单复选框
Checkbox({ name: 'agree' })

// 设置选中状态
Checkbox({ name: 'check1', group: 'group1' })
  .select(true)

// 监听状态变化
Checkbox({ name: 'check1' })
  .select(false)
  .onChange((isChecked: boolean) => {
    console.info('选中状态: ' + isChecked)
  })
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| name | `string` | 是 | - | 复选框名称，用于唯一标识 |
| group | `string` | 否 | - | 复选框所属组名 |

### 2.2 常用属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `select` | `boolean` | false | 设置是否选中 |
| `selectedColor` | `ResourceColor` | '#007DFF' | 选中状态的颜色 |
| `shape` | `CheckboxShape` | CheckboxShape.ROUNDED_SQUARE | 复选框形状 |
| `width` | `number \| string` | 24 | 复选框宽度 |
| `height` | `number \| string` | 24 | 复选框高度 |
| `padding` | `Padding \| Length` | - | 内边距 |

### 2.3 复选框形状

| 形状 | 描述 |
|------|------|
| `CheckboxShape.ROUNDED_SQUARE` | 圆角方形（默认） |
| `CheckboxShape.CIRCLE` | 圆形 |

### 2.4 事件

| 事件 | 类型 | 描述 |
|------|------|------|
| `onChange` | `(isChecked: boolean) => void` | 选中状态改变时触发 |

## 三、使用示例

### 3.1 基础复选框

```typescript
@ComponentV2
struct BasicCheckboxExample {
  @Local isChecked: boolean = false

  build() {
    Column({ space: 16 }) {
      Text('基础复选框')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

        Row({ space: 8 }) {
          Checkbox({ name: 'agree' })
            .select(this.isChecked)
            .onChange((ischecked: boolean) => {
              this.isChecked = ischecked
              console.info('选中状态: ' + ischecked)
            })

          Text('我同意服务条款')
            .fontSize(16)
        }
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
  @Local isChecked1: boolean = false
  @Local isChecked2: boolean = false

  build() {
    Column({ space: 16 }) {
      Text('自定义颜色')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Row({ space: 8 }) {
        Checkbox({ name: 'check1' })
          .select(this.isChecked1)
          .selectedColor('#FF0000')
          .onChange((value: boolean) => {
            this.isChecked1 = value
          })

        Text('红色复选框')
          .fontSize(16)
      }

      Row({ space: 8 }) {
        Checkbox({ name: 'check2' })
          .select(this.isChecked2)
          .selectedColor('#28A745')
          .onChange((value: boolean) => {
            this.isChecked2 = value
          })

        Text('绿色复选框')
          .fontSize(16)
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.3 不同形状

```typescript
@ComponentV2
struct ShapeExample {
  @Local isChecked1: boolean = false
  @Local isChecked2: boolean = false

  build() {
    Column({ space: 16 }) {
      Text('不同形状')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Row({ space: 8 }) {
        Checkbox({ name: 'square' })
          .select(this.isChecked1)
          .shape(CheckboxShape.ROUNDED_SQUARE)
          .onChange((value: boolean) => {
            this.isChecked1 = value
          })

        Text('圆角方形')
          .fontSize(16)
      }

      Row({ space: 8 }) {
        Checkbox({ name: 'circle' })
          .select(this.isChecked2)
          .shape(CheckboxShape.CIRCLE)
          .onChange((value: boolean) => {
            this.isChecked2 = value
          })

        Text('圆形')
          .fontSize(16)
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.4 自定义尺寸

```typescript
@ComponentV2
struct SizeExample {
  @Local isChecked: boolean = false

  build() {
    Column({ space: 16 }) {
      Text('自定义尺寸')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Row({ space: 16 }) {
        // 小尺寸
        Checkbox({ name: 'small' })
          .width(20)
          .height(20)

        // 默认尺寸
        Checkbox({ name: 'normal' })
          .width(24)
          .height(24)

        // 大尺寸
        Checkbox({ name: 'large' })
          .width(32)
          .height(32)
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.5 服务条款同意

```typescript
@ComponentV2
struct TermsAgreementExample {
  @Local agreedToTerms: boolean = false
  @Local agreedToPrivacy: boolean = false

  canSubmit(): boolean {
    return this.agreedToTerms && this.agreedToPrivacy
  }

  build() {
    Column({ space: 16 }) {
      Text('服务协议')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Column({ space: 12 }) {
        Row({ space: 8 }) {
          Checkbox({ name: 'terms' })
            .select(this.agreedToTerms)
            .selectedColor('#007DFF')
            .onChange((value: boolean) => {
              this.agreedToTerms = value
            })

          Text('我已阅读并同意《用户协议》')
            .fontSize(14)
            .fontColor('#333333')
        }

        Row({ space: 8 }) {
          Checkbox({ name: 'privacy' })
            .select(this.agreedToPrivacy)
            .selectedColor('#007DFF')
            .onChange((value: boolean) => {
              this.agreedToPrivacy = value
            })

          Text('我已阅读并同意《隐私政策》')
            .fontSize(14)
            .fontColor('#333333')
        }
      }
      .width('100%')

      Button('继续')
        .width('100%')
        .enabled(this.canSubmit())
        .backgroundColor(this.canSubmit() ? '#007DFF' : '#CCCCCC')
        .onClick(() => {
          console.info('用户已同意所有条款')
        })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.6 兴趣标签选择

```typescript
@ComponentV2
struct InterestTagsExample {
  @Local interests: Record<string, boolean> = {
    'tech': false,
    'sports': false,
    'music': false,
    'travel': false,
    'food': false,
    'reading': false
  }

  build() {
    Column({ space: 16 }) {
      Text('选择兴趣标签（多选）')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

        Flex({ wrap: FlexWrap.Wrap, space: 12 }) {
          ForEach(Object.keys(this.interests), (tag: string) => {
            Row({ space: 8 }) {
              Checkbox({ name: tag })
                .select(this.interests[tag])
                .selectedColor('#FF6B6B')
                .shape(CheckboxShape.CIRCLE)
                .onChange((value: boolean) => {
                  this.interests[tag] = value
                })

              Text(this.getTagLabel(tag))
                .fontSize(14)
            }
            .padding({ left: 12, right: 12, top: 8, bottom: 8 })
            .backgroundColor(this.interests[tag] ? '#FFE0E0' : '#F5F5F5')
            .borderRadius(20)
          })
        }
        .width('100%')

      Text(`已选择 ${Object.values(this.interests).filter(v => v).length} 个标签`)
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(16)
  }

  getTagLabel(tag: string): string {
    const labels: Record<string, string> = {
      'tech': '科技',
      'sports': '运动',
      'music': '音乐',
      'travel': '旅行',
      'food': '美食',
      'reading': '阅读'
    }
    return labels[tag] || tag
  }
}
```

### 3.7 任务清单

```typescript
@ComponentV2
struct TodoListExample {
  @Local tasks: Array<{ id: string, title: string, completed: boolean }> = [
    { id: '1', title: '完成项目文档', completed: false },
    { id: '2', title: '代码审查', completed: false },
    { id: '3', title: '团队会议', completed: false },
    { id: '4', title: '发布新版本', completed: false }
  ]

  toggleTask(id: string): void {
    const task = this.tasks.find(t => t.id === id)
    if (task) {
      task.completed = !task.completed
    }
  }

  get completedCount(): number {
    return this.tasks.filter(t => t.completed).length
  }

  build() {
    Column({ space: 16 }) {
      Text('任务清单')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Text(`进度: ${this.completedCount}/${this.tasks.length}`)
        .fontSize(14)
        .fontColor('#666666')

      Column({ space: 8 }) {
        ForEach(this.tasks, (task: { id: string, title: string, completed: boolean }) => {
          Row({ space: 12 }) {
            Checkbox({ name: task.id })
              .select(task.completed)
              .selectedColor('#28A745')
              .onChange((value: boolean) => {
                this.toggleTask(task.id)
              })

            Text(task.title)
              .fontSize(16)
              .fontColor(task.completed ? '#999999' : '#333333')
              .decoration({
                type: task.completed ? TextDecorationType.LineThrough : TextDecorationType.None
              })
              .layoutWeight(1)
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

### 3.8 全选/取消全选

```typescript
@ComponentV2
struct SelectAllExample {
  @Local items: Record<string, boolean> = {
    'item1': false,
    'item2': false,
    'item3': false,
    'item4': false
  }
  @Local allSelected: boolean = false

  toggleAll(): void {
    const newState = !this.allSelected
    this.allSelected = newState
    Object.keys(this.items).forEach(key => {
      this.items[key] = newState
    })
  }

  updateSelectionState(): void {
    const values = Object.values(this.items)
    this.allSelected = values.every(v => v)
  }

  build() {
    Column({ space: 16 }) {
      Text('全选功能')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 全选行
      Row({ space: 8 }) {
        Checkbox({ name: 'selectAll' })
          .select(this.allSelected)
          .onChange(() => {
            this.toggleAll()
          })

        Text('全选')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)

        Spacer()

        Text(`已选 ${Object.values(this.items).filter(v => v).length} 项`)
          .fontSize(14)
          .fontColor('#666666')
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      // 列表项
      Column({ space: 8 }) {
        ForEach(Object.keys(this.items), (key: string) => {
          Row({ space: 8 }) {
            Checkbox({ name: key })
              .select(this.items[key])
              .onChange((value: boolean) => {
                this.items[key] = value
                this.updateSelectionState()
              })

            Text(`选项 ${key}`)
              .fontSize(16)
              .layoutWeight(1)
          }
          .width('100%')
          .padding(12)
          .backgroundColor('#FFFFFF')
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

### 3.9 禁用状态

```typescript
@ComponentV2
struct DisabledCheckboxExample {
  @Local isChecked1: boolean = true
  @Local isChecked2: boolean = false

  build() {
    Column({ space: 16 }) {
      Text('禁用状态')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Row({ space: 8 }) {
        Checkbox({ name: 'disabled1' })
          .select(this.isChecked1)
          .enabled(false)

        Text('禁用且选中')
          .fontSize(16)
      }

      Row({ space: 8 }) {
        Checkbox({ name: 'disabled2' })
          .select(this.isChecked2)
          .enabled(false)

        Text('禁用且未选中')
          .fontSize(16)
      }

      Row({ space: 8 }) {
        Checkbox({ name: 'enabled' })
          .select(false)
          .enabled(true)

        Text('启用')
          .fontSize(16)
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.10 自定义样式复选框

```typescript
@ComponentV2
struct CustomStyledCheckboxExample {
  @Local isChecked: boolean = false

  build() {
    Column({ space: 16 }) {
      Text('自定义样式')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Row({ space: 12 }) {
        Checkbox({ name: 'custom' })
          .select(this.isChecked)
          .width(28)
          .height(28)
          .selectedColor('#FF6B6B')
          .shape(CheckboxShape.ROUNDED_SQUARE)
          .padding(4)
          .onChange((value: boolean) => {
            this.isChecked = value
          })

        Column({ space: 4 }) {
          Text('记住密码')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)

          if (this.isChecked) {
            Text('下次登录自动填充')
              .fontSize(12)
              .fontColor('#999999')
          }
        }
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#F8F9FA')
      .borderRadius(8)
    }
    .width('100%')
    .padding(16)
  }
}
```

## 四、高级用法

### 4.1 带图片的选项

```typescript
@ComponentV2
struct ImageCheckboxExample {
  @Local selectedPlan: string = ''

  plans: Array<{ id: string, name: string, price: string, icon: string }> = [
    { id: 'basic', name: '基础版', price: '¥9/月', icon: '\uE641' },
    { id: 'pro', name: '专业版', price: '¥19/月', icon: '\uE8EF' },
    { id: 'enterprise', name: '企业版', price: '¥49/月', icon: '\uE6D9' }
  ]

  build() {
    Column({ space: 16 }) {
      Text('选择套餐（可多选）')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Column({ space: 12 }) {
        ForEach(this.plans, (plan: { id: string, name: string, price: string, icon: string }) => {
          Row({ space: 12 }) {
            Checkbox({ name: plan.id })
              .select(this.selectedPlan === plan.id)
              .onChange((value: boolean) => {
                if (value) {
                  this.selectedPlan = plan.id
                } else {
                  this.selectedPlan = ''
                }
              })

            Text(plan.icon)
              .fontSize(32)

            Column({ space: 4 }) {
              Text(plan.name)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)

              Text(plan.price)
                .fontSize(14)
                .fontColor('#666666')
            }
            .alignItems(HorizontalAlign.Start)

            Spacer()
          }
          .width('100%')
          .padding(16)
          .backgroundColor(this.selectedPlan === plan.id ? '#E3F2FD' : '#F5F5F5')
          .border({
            width: 2,
            color: this.selectedPlan === plan.id ? '#007DFF' : 'transparent'
          })
          .borderRadius(12)
        })
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 4.2 树形结构复选框

```typescript
@ComponentV2
struct TreeCheckboxExample {
  @Local treeData: Record<string, { checked: boolean, children: string[] }> = {
    'frontend': { checked: false, children: ['react', 'vue', 'angular'] },
    'backend': { checked: false, children: ['nodejs', 'python', 'java'] },
    'mobile': { checked: false, children: ['ios', 'android', 'harmonyos'] }
  }

  toggleParent(parentKey: string): void {
    this.treeData[parentKey].checked = !this.treeData[parentKey].checked
  }

  build() {
    Column({ space: 16 }) {
      Text('技术栈选择')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Column({ space: 12 }) {
        // 前端
        Column({ space: 8 }) {
          Row({ space: 8 }) {
            Checkbox({ name: 'frontend' })
              .select(this.treeData['frontend'].checked)
              .onChange(() => this.toggleParent('frontend'))

            Text('前端')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
          }

          Column({ space: 8 }) {
            ForEach(this.treeData['frontend'].children, (child: string) => {
              Row({ space: 8 }) {
                Checkbox({ name: child })
                  .select(false)
                  .width(20)
                  .height(20)

                Text(child)
                  .fontSize(14)
              }
              .margin({ left: 32 })
            })
          }
        }
        .width('100%')
        .padding(12)
        .backgroundColor('#F5F5F5')
        .borderRadius(8)

        // 后端
        Column({ space: 8 }) {
          Row({ space: 8 }) {
            Checkbox({ name: 'backend' })
              .select(this.treeData['backend'].checked)
              .onChange(() => this.toggleParent('backend'))

            Text('后端')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
          }

          Column({ space: 8 }) {
            ForEach(this.treeData['backend'].children, (child: string) => {
              Row({ space: 8 }) {
                Checkbox({ name: child })
                  .select(false)
                  .width(20)
                  .height(20)

                Text(child)
                  .fontSize(14)
              }
              .margin({ left: 32 })
            })
          }
        }
        .width('100%')
        .padding(12)
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
  }
}
```

## 五、最佳实践

### 5.1 明确的标签

```typescript
// ✅ 推荐：提供清晰的文本标签
Row({ space: 8 }) {
  Checkbox({ name: 'agree' })
  Text('我已阅读并同意《用户协议》和《隐私政策》')
}

// ❌ 避免：只有复选框，没有说明
Checkbox({ name: 'agree' })
```

### 5.2 状态反馈

```typescript
// ✅ 推荐：提供视觉反馈
@ComponentV2
struct GoodFeedback {
  @Local checked: boolean = false

  build() {
    Row({ space: 8 }) {
      Checkbox({ name: 'check' })
        .select(this.checked)
        .onChange((v) => { this.checked = v })

      Text(this.checked ? '已开启' : '已关闭')
        .fontColor(this.checked ? '#28A745' : '#999999')
    }
  }
}
```

### 5.3 合理使用形状

```typescript
// ✅ 推荐：根据场景选择合适的形状
// 圆角方形 - 适用于列表、选项
Checkbox({ name: 'item' }).shape(CheckboxShape.ROUNDED_SQUARE)

// 圆形 - 适用于标签、兴趣选择
Checkbox({ name: 'tag' }).shape(CheckboxShape.CIRCLE)
```

### 5.4 选中颜色

```typescript
// ✅ 推荐：使用主题色
Checkbox({ name: 'check' })
  .selectedColor('#007DFF')  // 使用应用主题色

// ❌ 避免：使用过于鲜艳或奇怪的颜色
Checkbox({ name: 'check' })
  .selectedColor('#FF00FF')  // 不推荐
```

### 5.5 禁用状态

```typescript
// ✅ 推荐：为禁用状态提供说明
Row({ space: 8 }) {
  Checkbox({ name: 'feature' })
    .enabled(false)

  Text('高级功能（需要升级会员）')
    .fontSize(14)
    .fontColor('#999999')
}
```

## 六、常见问题

### Q1: Checkbox 如何设置默认选中？

**解决方案**:
```typescript
// 使用 select 属性
Checkbox({ name: 'check1' })
  .select(true)  // 默认选中
```

### Q2: 如何获取所有选中的 Checkbox？

**解决方案**:
```typescript
@ComponentV2
struct GetCheckedExample {
  @Local items: Record<string, boolean> = {
    'item1': false,
    'item2': false,
    'item3': false
  }

  getCheckedItems(): string[] {
    return Object.keys(this.items).filter(key => this.items[key])
  }

  build() {
    Column({ space: 12 }) {
      ForEach(Object.keys(this.items), (key: string) => {
        Row({ space: 8 }) {
          Checkbox({ name: key })
            .select(this.items[key])
            .onChange((v) => { this.items[key] = v })
          Text(key)
        }
      })

      Button('获取选中项')
        .onClick(() => {
          console.info('选中项: ' + this.getCheckedItems().join(', '))
        })
    }
  }
}
```

### Q3: Checkbox 如何实现互斥选择？

**答案**: Checkbox 本身不支持互斥，如需互斥应使用 Radio 组件。如需用 Checkbox 实现类似功能：

```typescript
@ComponentV2
struct MutuallyExclusiveExample {
  @Local selectedItem: string = ''

  build() {
    Column({ space: 12 }) {
      ForEach(['option1', 'option2', 'option3'], (option: string) => {
        Row({ space: 8 }) {
          Checkbox({ name: option })
            .select(this.selectedItem === option)
            .onChange((checked: boolean) => {
              if (checked) {
                this.selectedItem = option
              } else {
                this.selectedItem = ''
              }
            })
          Text(option)
        }
      })
    }
  }
}
```

### Q4: 如何自定义 Checkbox 的大小？

**解决方案**:
```typescript
Checkbox({ name: 'check' })
  .width(32)  // 自定义宽度
  .height(32) // 自定义高度
```

### Q5: Checkbox 的 name 属性有什么用？

**答案**: name 属性用于：
1. 在 CheckboxGroup 中标识每个复选框
2. 作为事件的唯一标识
3. 方便数据管理和查找

```typescript
// 良好的命名规范
Checkbox({ name: 'terms_agree' })      // 协议复选框
Checkbox({ name: 'newsletter_optin' }) // 订阅复选框
Checkbox({ name: 'age_verify' })       // 年龄验证复选框
```

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 9+ | ✅ | 完全支持 |
| API 10+ | ✅ | 增加了更多形状选项 |
| API 11+ | ✅ | 优化了选中动画 |
| API 12+ | ✅ | 增强了样式自定义能力 |

## 八、参考资料

- [Checkbox 复选框 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-checkbox-V5)
- [CheckboxGroup 复选框组 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-checkboxgroup-V5)
- [通用属性 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-universal-attributes-size-V5)
