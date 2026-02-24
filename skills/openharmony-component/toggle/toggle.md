# Toggle 组件 HarmonyOS 6.0 开发 Skill

## 概述

Toggle 组件是 OpenHarmony 中的开关组件，用于在两种状态（开/关）之间进行切换。它提供了多种样式类型，包括 Checkbox（复选框）、Switch（开关）、Radio（单选按钮）和 Button（按钮）样式。

## 重要说明

- **基础组件**: Toggle 是 ArkUI 的基础内置组件，无需导入
- **状态管理**: 使用 isOn 属性控制开关状态
- **样式类型**: 支持 Checkbox、Switch、Radio、Button 四种类型
- **响应式**: 配合 @State/@Local 使用实现响应式更新
- **选中颜色**: 支持自定义选中状态的背景色

## 模块信息

- **组件名称**: Toggle
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [Toggle - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-toggle-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// Toggle 是内置组件，无需导入
// 直接使用即可
Toggle({ type: ToggleType.Switch, isOn: false })
```

### 1.2 基础用法

```typescript
// Switch 样式
Toggle({ type: ToggleType.Switch, isOn: true })
  .onChange((isOn: boolean) => {
    console.info('Toggle state: ' + isOn)
  })

// Checkbox 样式
Toggle({ type: ToggleType.Checkbox, isOn: false })

// Radio 样式
Toggle({ type: ToggleType.Radio, isOn: true })

// Button 样式
Toggle({ type: ToggleType.Button, isOn: false }) {
  Text('按钮开关')
}
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| type | `ToggleType` | 是 | - | 开关样式类型 |
| isOn | `boolean` | 是 | - | 开关状态 |

### 2.2 ToggleType 枚举

| 值 | 描述 | 使用场景 |
|----|------|----------|
| `ToggleType.Checkbox` | 复选框样式 | 多选场景 |
| `ToggleType.Switch` | 开关样式 | 二状态切换 |
| `ToggleType.Radio` | 单选按钮样式 | 单选场景 |
| `ToggleType.Button` | 按钮样式 | 自定义内容 |

### 2.3 样式属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `selectedColor` | `ResourceColor` | - | 选中状态背景色 |
| `switchPointColor` | `ResourceColor` | - | Switch 类型滑块颜色 |
| `backgroundColor` | `ResourceColor` | - | 背景色 |

### 2.4 交互属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `onChange` | `(isOn: boolean) => void` | - | 状态变化回调 |

## 三、使用示例

### 3.1 Switch 开关示例

```typescript
@ComponentV2
struct SwitchExample {
  @Local isSwitchOn: boolean = false

  build() {
    Column({ space: 16 }) {
      Text('Switch 开关')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 基础 Switch
      Toggle({ type: ToggleType.Switch, isOn: this.isSwitchOn })
        .onChange((isOn: boolean) => {
          this.isSwitchOn = isOn
          console.info('Switch state: ' + isOn)
        })

      // 自定义选中颜色
      Toggle({ type: ToggleType.Switch, isOn: true })
        .selectedColor('#007DFF')

      // 自定义滑块颜色
      Toggle({ type: ToggleType.Switch, isOn: false })
        .switchPointColor('#FFC107')
        .selectedColor('#28A745')

      // 禁用状态
      Toggle({ type: ToggleType.Switch, isOn: true })
        .enabled(false)
    }
    .padding(16)
  }
}
```

### 3.2 Checkbox 复选框示例

```typescript
@ComponentV2
struct CheckboxExample {
  @Local checkedItems: Set<number> = new Set()

  build() {
    Column({ space: 16 }) {
      Text('Checkbox 复选框')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 单个复选框
      Toggle({ type: ToggleType.Checkbox, isOn: false })
        .selectedColor('#007DFF')

      // 复选框组
      ForEach([1, 2, 3], (item: number) => {
        Row({ space: 8 }) {
          Toggle({ type: ToggleType.Checkbox, isOn: this.checkedItems.has(item) })
            .selectedColor('#007DFF')
            .onChange((isOn: boolean) => {
              if (isOn) {
                this.checkedItems.add(item)
              } else {
                this.checkedItems.delete(item)
              }
            })

          Text(`选项 ${item}`)
            .fontSize(16)
        }
      })
    }
    .padding(16)
  }
}
```

### 3.3 Radio 单选按钮示例

```typescript
@ComponentV2
struct RadioExample {
  @Local selectedOption: number = 1

  build() {
    Column({ space: 16 }) {
      Text('Radio 单选按钮')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 单选按钮组
      ForEach([1, 2, 3], (item: number) => {
        Row({ space: 8 }) {
          Toggle({
            type: ToggleType.Radio,
            isOn: this.selectedOption === item
          })
            .selectedColor('#007DFF')
            .onChange((isOn: boolean) => {
              if (isOn) {
                this.selectedOption = item
              }
            })

          Text(`选项 ${item}`)
            .fontSize(16)
        }
      })

      Text(`当前选择: 选项 ${this.selectedOption}`)
        .fontSize(14)
        .fontColor('#666666')
    }
    .padding(16)
  }
}
```

### 3.4 Button 按钮开关示例

```typescript
@ComponentV2
struct ButtonToggleExample {
  @Local isButtonOn: boolean = false

  build() {
    Column({ space: 16 }) {
      Text('Button 按钮开关')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 自定义按钮内容
      Toggle({ type: ToggleType.Button, isOn: this.isButtonOn }) {
        Row() {
          Text(this.isButtonOn ? '已开启' : '已关闭')
            .fontSize(16)
            .fontColor(Color.White)
        }
        .width(100)
        .height(40)
        .justifyContent(FlexAlign.Center)
      }
      .selectedColor('#007DFF')
      .onChange((isOn: boolean) => {
        this.isButtonOn = isOn
      })

      // 带图标的按钮开关
      Toggle({ type: ToggleType.Button, isOn: false }) {
        Row({ space: 8 }) {
          Text('\uE641') // 图标
            .fontSize(20)
            .fontColor(Color.White)
          Text('启用')
            .fontSize(16)
            .fontColor(Color.White)
        }
      }
      .selectedColor('#28A745')
    }
    .padding(16)
  }
}
```

### 3.5 实际应用场景示例

```typescript
@ComponentV2
struct SettingsPage {
  @Local notificationsEnabled: boolean = true
  @Local darkModeEnabled: boolean = false
  @Local autoUpdateEnabled: boolean = true

  build() {
    Column({ space: 20 }) {
      Text('设置')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)

      // 通知开关
      Row() {
        Column({ space: 4 }) {
          Text('推送通知')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
          Text('接收应用推送通知')
            .fontSize(14)
            .fontColor('#666666')
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
          .selectedColor('#007DFF')
          .onChange((isOn: boolean) => {
            this.notificationsEnabled = isOn
          })
      }
      .width('100%')

      // 深色模式开关
      Row() {
        Column({ space: 4 }) {
          Text('深色模式')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
          Text('使用深色主题')
            .fontSize(14)
            .fontColor('#666666')
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: this.darkModeEnabled })
          .selectedColor('#007DFF')
          .onChange((isOn: boolean) => {
            this.darkModeEnabled = isOn
          })
      }
      .width('100%')

      // 自动更新开关
      Row() {
        Column({ space: 4 }) {
          Text('自动更新')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
          Text('自动检查并安装更新')
            .fontSize(14)
            .fontColor('#666666')
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: this.autoUpdateEnabled })
          .selectedColor('#007DFF')
          .onChange((isOn: boolean) => {
            this.autoUpdateEnabled = isOn
          })
      }
      .width('100%')
    }
    .padding(16)
  }
}
```

## 四、高级用法

### 4.1 条件禁用

```typescript
@ComponentV2
struct ConditionalToggle {
  @Local isParentEnabled: boolean = false
  @Local isChildEnabled: boolean = false

  build() {
    Column({ space: 16 }) {
      // 父开关
      Row({ space: 8 }) {
        Toggle({ type: ToggleType.Switch, isOn: this.isParentEnabled })
          .onChange((isOn: boolean) => {
            this.isParentEnabled = isOn
            if (!isOn) {
              this.isChildEnabled = false
            }
          })

        Text('启用子选项')
      }

      // 子开关（依赖父开关）
      Row({ space: 8 }) {
        Toggle({
          type: ToggleType.Switch,
          isOn: this.isChildEnabled
        })
          .enabled(this.isParentEnabled) // 父开关启用时才可用
          .onChange((isOn: boolean) => {
            this.isChildEnabled = isOn
          })

        Text('子选项')
      }
    }
  }
}
```

### 4.2 全选/反选

```typescript
@ComponentV2
struct SelectAllExample {
  @Local allChecked: boolean = false
  @Local checkedItems: boolean[] = [false, false, false]

  build() {
    Column({ space: 16 }) {
      // 全选复选框
      Row({ space: 8 }) {
        Toggle({ type: ToggleType.Checkbox, isOn: this.allChecked })
          .onChange((isOn: boolean) => {
            this.allChecked = isOn
            this.checkedItems = this.checkedItems.map(() => isOn)
          })

        Text('全选')
          .fontSize(16)
      }

      // 子项复选框
      ForEach([0, 1, 2], (index: number) => {
        Row({ space: 8 }) {
          Toggle({ type: ToggleType.Checkbox, isOn: this.checkedItems[index] })
            .onChange((isOn: boolean) => {
              this.checkedItems[index] = isOn
              // 更新全选状态
              this.allChecked = this.checkedItems.every(item => item)
            })

          Text(`选项 ${index + 1}`)
            .fontSize(16)
        }
      })
    }
  }
}
```

## 五、最佳实践

### 5.1 状态管理

```typescript
// ✅ 推荐：使用 @Local 管理状态
@ComponentV2
struct GoodToggle {
  @Local isOn: boolean = false

  build() {
    Toggle({ type: ToggleType.Switch, isOn: this.isOn })
      .onChange((isOn: boolean) => {
        this.isOn = isOn
      })
  }
}

// ❌ 避免：直接修改状态
@ComponentV2
struct BadToggle {
  @Local isOn: boolean = false

  build() {
    Toggle({ type: ToggleType.Switch, isOn: this.isOn })
      .onChange(() => {
        this.isOn = !this.isOn // 不可靠
      })
  }
}
```

### 5.2 颜色选择

```typescript
// ✅ 推荐：使用主题色
Toggle({ type: ToggleType.Switch, isOn: true })
  .selectedColor($r('app.color.primary'))

// ✅ 推荐：为不同状态使用不同颜色
Toggle({ type: ToggleType.Switch, isOn: true })
  .selectedColor('#28A745') // 绿色表示启用
  .backgroundColor('#DC3545') // 红色表示禁用
```

### 5.3 性能优化

```typescript
// ✅ 推荐：使用 ForEach 的 keyGenerator
ForEach(items, (item: Item) => {
  Toggle({ type: ToggleType.Checkbox, isOn: item.checked })
    .onChange((isOn: boolean) => {
      item.checked = isOn
    })
}, (item: Item) => item.id.toString())
```

## 六、常见问题

### Q1: Toggle 状态不更新？

**问题**: 修改状态后 UI 不刷新。

**解决方案**:
```typescript
// 确保使用 @Local 或 @State
@ComponentV2
struct CorrectToggle {
  @Local isOn: boolean = false // 使用响应式状态

  build() {
    Toggle({ type: ToggleType.Switch, isOn: this.isOn })
      .onChange((isOn: boolean) => {
        this.isOn = isOn // 直接使用回调参数
      })
  }
}
```

### Q2: Radio 组无法实现单选？

**问题**: 多个 Radio 可以同时选中。

**解决方案**:
```typescript
// ✅ 正确：共享同一个状态变量
@ComponentV2
struct CorrectRadio {
  @Local selectedId: number = 1

  build() {
    Column() {
      ForEach([1, 2, 3], (id: number) => {
        Toggle({
          type: ToggleType.Radio,
          isOn: this.selectedId === id // 共享状态
        })
          .onChange((isOn: boolean) => {
            if (isOn) {
              this.selectedId = id
            }
          })
      })
    }
  }
}
```

### Q3: 如何实现禁用状态？

**解决方案**:
```typescript
Toggle({ type: ToggleType.Switch, isOn: true })
  .enabled(false) // 设置为禁用
```

### Q4: Switch 滑块颜色不生效？

**问题**: 设置 switchPointColor 后颜色没变化。

**解决方案**:
```typescript
// switchPointColor 只对 Switch 类型有效
Toggle({ type: ToggleType.Switch, isOn: false })
  .switchPointColor('#FFC107') // 滑块颜色
  .selectedColor('#007DFF') // 选中背景色
```

### Q5: 如何实现三态复选框？

**解决方案**:
```typescript
// Toggle 组件本身不支持三态
// 需要使用其他方式实现
@ComponentV2
struct TristateCheckbox {
  @Local state: 'unchecked' | 'indeterminate' | 'checked' = 'unchecked'

  build() {
    // 自定义实现三态
    Button(this.getStateIcon())
      .onClick(() => {
        this.cycleState()
      })
  }

  getStateIcon(): string {
    switch (this.state) {
      case 'unchecked': return '☐'
      case 'indeterminate': return '▢'
      case 'checked': return '☑'
    }
  }

  cycleState() {
    if (this.state === 'unchecked') {
      this.state = 'indeterminate'
    } else if (this.state === 'indeterminate') {
      this.state = 'checked'
    } else {
      this.state = 'unchecked'
    }
  }
}
```

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 9+ | ✅ | 完全支持 |
| API 10+ | ✅ | 增加了更多样式选项 |
| API 12+ | ✅ | 性能优化 |

## 八、参考资料

- [Toggle 组件 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-toggle-V5)
- [通用属性 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-universal-attributes-size-V5)
