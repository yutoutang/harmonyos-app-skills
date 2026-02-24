# DatePicker 组件 HarmonyOS 6.0 开发 Skill

## 概述

DatePicker 组件是 OpenHarmony 中的日期选择器组件，用于让用户选择年、月、日。它提供了多种显示模式和配置选项，支持自定义日期范围、格式和样式。

## 重要说明

- **基础组件**: DatePicker 是 ArkUI 的基础内置组件，无需导入
- **数据类型**: 使用 Date 对象存储选中的日期
- **响应式**: 配合 @State/@Local 使用实现响应式更新
- **范围限制**: 支持设置最小和最大可选日期

## 模块信息

- **组件名称**: DatePicker
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [DatePicker - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-datepicker-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// DatePicker 是内置组件，无需导入
// 直接使用即可
DatePicker({
  start: new Date('2000-01-01'),
  end: new Date('2030-12-31'),
  selected: new Date()
})
```

### 1.2 基础用法

```typescript
// 简单的日期选择器
DatePicker({
  start: new Date('2000-01-01'),
  end: new Date('2030-12-31'),
  selected: new Date()
})
.onChange((value: DatePickerResult) => {
  console.info('Year: ' + value.year)
  console.info('Month: ' + value.month)
  console.info('Day: ' + value.day)
})
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| start | `Date` | 否 | new Date('1970-1-1') | 起始日期 |
| end | `Date` | 否 | new Date('2100-12-31') | 结束日期 |
| selected | `Date` | 否 | 当前日期 | 选中的日期 |

### 2.2 DatePickerResult 接口

| 属性 | 类型 | 描述 |
|------|------|------|
| year | `number` | 选中的年份 |
| month | `number` | 选中的月份（1-12） |
| day | `number` | 选中的日期 |

### 2.3 DatePicker 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `lunar` | `boolean` | false | 是否显示农历 |
| `disappearTextStyle` | `DatePickerTextStyle` | - | 不可选日期文本样式 |
| `textStyle` | `DatePickerTextStyle` | - | 可选日期文本样式 |
| `selectedTextStyle` | `DatePickerTextStyle` | - | 选中日期文本样式 |
| `gradient` | `boolean` | false | 是否启用渐变效果 |

### 2.4 DatePickerTextStyle 接口

| 属性 | 类型 | 描述 |
|------|------|------|
| color | `ResourceColor` | 文本颜色 |
| font | `Font` | 字体样式 |
| weight | `number \| FontWeight` | 字体粗细 |

## 三、使用示例

### 3.1 基础日期选择器示例

```typescript
@ComponentV2
struct BasicDatePickerExample {
  @Local selectedDate: Date = new Date()

  build() {
    Column({ space: 16 }) {
      Text('基础日期选择器')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      DatePicker({
        start: new Date('2000-01-01'),
        end: new Date('2030-12-31'),
        selected: this.selectedDate
      })
        .onChange((value: DatePickerResult) => {
          this.selectedDate = new Date(value.year, value.month - 1, value.day)
          console.info('Selected: ' + this.selectedDate.toISOString())
        })

      Text(`选中日期: ${this.selectedDate.toLocaleDateString()}`)
        .fontSize(16)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.2 限制日期范围示例

```typescript
@ComponentV2
struct DateRangePickerExample {
  @Local selectedDate: Date = new Date()

  build() {
    Column({ space: 16 }) {
      Text('限制日期范围')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      DatePicker({
        start: new Date('2020-01-01'),
        end: new Date('2025-12-31'),
        selected: this.selectedDate
      })
        .onChange((value: DatePickerResult) => {
          this.selectedDate = new Date(value.year, value.month - 1, value.day)
        })

      Text('范围: 2020-01-01 至 2025-12-31')
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.3 自定义样式示例

```typescript
@ComponentV2
struct CustomStyleDatePickerExample {
  @Local selectedDate: Date = new Date()

  build() {
    Column({ space: 16 }) {
      Text('自定义样式')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      DatePicker({
        start: new Date('2000-01-01'),
        end: new Date('2030-12-31'),
        selected: this.selectedDate
      })
        .selectedTextStyle({
          color: '#007DFF',
          font: { size: 22, weight: FontWeight.Bold }
        })
        .textStyle({
          color: '#333333',
          font: { size: 18 }
        })
        .disappearTextStyle({
          color: '#CCCCCC',
          font: { size: 14 }
        })
        .onChange((value: DatePickerResult) => {
          this.selectedDate = new Date(value.year, value.month - 1, value.day)
        })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.4 农历日期选择器示例

```typescript
@ComponentV2
struct LunarDatePickerExample {
  @Local selectedDate: Date = new Date()

  build() {
    Column({ space: 16 }) {
      Text('农历日期选择')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      DatePicker({
        start: new Date('2000-01-01'),
        end: new Date('2030-12-31'),
        selected: this.selectedDate
      })
        .lunar(true)
        .onChange((value: DatePickerResult) => {
          this.selectedDate = new Date(value.year, value.month - 1, value.day)
        })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.5 渐变效果示例

```typescript
@ComponentV2
struct GradientDatePickerExample {
  @Local selectedDate: Date = new Date()

  build() {
    Column({ space: 16 }) {
      Text('渐变效果')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      DatePicker({
        start: new Date('2000-01-01'),
        end: new Date('2030-12-31'),
        selected: this.selectedDate
      })
        .gradient(true)
        .onChange((value: DatePickerResult) => {
          this.selectedDate = new Date(value.year, value.month - 1, value.day)
        })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.6 生日选择器示例

```typescript
@ComponentV2
struct BirthdayDatePickerExample {
  @Local birthday: Date = new Date('2000-01-01')

  build() {
    Column({ space: 16 }) {
      Text('选择生日')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      DatePicker({
        start: new Date('1900-01-01'),
        end: new Date(),
        selected: this.birthday
      })
        .onChange((value: DatePickerResult) => {
          this.birthday = new Date(value.year, value.month - 1, value.day)
        })

      Text(`生日: ${this.birthday.toLocaleDateString()}`)
        .fontSize(16)
        .margin({ top: 8 })

      // 计算年龄
      Text(`年龄: ${new Date().getFullYear() - this.birthday.getFullYear()} 岁`)
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.7 预约日期选择器示例

```typescript
@ComponentV2
struct AppointmentDatePickerExample {
  @Local appointmentDate: Date = new Date()
  @Local minDate: Date = new Date()

  build() {
    Column({ space: 16 }) {
      Text('选择预约日期')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      DatePicker({
        start: this.minDate, // 不能选择过去的日期
        end: new Date('2026-12-31'),
        selected: this.appointmentDate
      })
        .onChange((value: DatePickerResult) => {
          this.appointmentDate = new Date(value.year, value.month - 1, value.day)
        })

      Text(`预约日期: ${this.appointmentDate.toLocaleDateString()}`)
        .fontSize(16)
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(16)
  }
}
```

## 四、高级用法

### 4.1 日期格式化显示

```typescript
@ComponentV2
struct FormattedDatePickerExample {
  @Local selectedDate: Date = new Date()

  build() {
    Column({ space: 16 }) {
      DatePicker({
        start: new Date('2000-01-01'),
        end: new Date('2030-12-31'),
        selected: this.selectedDate
      })
        .onChange((value: DatePickerResult) => {
          this.selectedDate = new Date(value.year, value.month - 1, value.day)
        })

      // 格式化显示
      Column({ space: 8 }) {
        Text('中文格式:')
          .fontSize(14)
          .fontColor('#666666')
        Text(`${this.selectedDate.getFullYear()}年${this.selectedDate.getMonth() + 1}月${this.selectedDate.getDate()}日`)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)

        Text('ISO 格式:')
          .fontSize(14)
          .fontColor('#666666')
        Text(this.selectedDate.toISOString())
          .fontSize(14)

        Text('自定义格式:')
          .fontSize(14)
          .fontColor('#666666')
        Text(`${this.selectedDate.getFullYear()}-${String(this.selectedDate.getMonth() + 1).padStart(2, '0')}-${String(this.selectedDate.getDate()).padStart(2, '0')}`)
          .fontSize(16)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 4.2 日期验证

```typescript
@ComponentV2
struct ValidatedDatePickerExample {
  @Local selectedDate: Date = new Date()
  @Local errorMessage: string = ''

  build() {
    Column({ space: 16 }) {
      Text('选择日期')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      DatePicker({
        start: new Date('2000-01-01'),
        end: new Date('2030-12-31'),
        selected: this.selectedDate
      })
        .onChange((value: DatePickerResult) => {
          const newDate = new Date(value.year, value.month - 1, value.day)
          this.validateDate(newDate)
        })

      if (this.errorMessage) {
        Text(this.errorMessage)
          .fontSize(14)
          .fontColor('#FF0000')
      }

      Text(`选中: ${this.selectedDate.toLocaleDateString()}`)
        .fontSize(16)
    }
    .width('100%')
    .padding(16)
  }

  validateDate(date: Date) {
    // 示例：不允许选择周末
    const dayOfWeek = date.getDay()
    if (dayOfWeek === 0 || dayOfWeek === 6) {
      this.errorMessage = '不能选择周末'
    } else {
      this.errorMessage = ''
      this.selectedDate = date
    }
  }
}
```

### 4.3 多个日期选择器联动

```typescript
@ComponentV2
struct LinkedDatePickersExample {
  @Local startDate: Date = new Date()
  @Local endDate: Date = new Date()

  build() {
    Column({ space: 16 }) {
      Text('日期范围')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 开始日期
      Column({ space: 8 }) {
        Text('开始日期')
          .fontSize(14)
          .fontColor('#666666')
        DatePicker({
          start: new Date('2000-01-01'),
          end: this.endDate, // 不能晚于结束日期
          selected: this.startDate
        })
          .onChange((value: DatePickerResult) => {
            this.startDate = new Date(value.year, value.month - 1, value.day)
          })
      }

      // 结束日期
      Column({ space: 8 }) {
        Text('结束日期')
          .fontSize(14)
          .fontColor('#666666')
        DatePicker({
          start: this.startDate, // 不能早于开始日期
          end: new Date('2030-12-31'),
          selected: this.endDate
        })
          .onChange((value: DatePickerResult) => {
            this.endDate = new Date(value.year, value.month - 1, value.day)
          })
      }

      Text(`范围: ${this.startDate.toLocaleDateString()} - ${this.endDate.toLocaleDateString()}`)
        .fontSize(16)
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(16)
  }
}
```

## 五、最佳实践

### 5.1 日期范围设置

```typescript
// ✅ 推荐：根据业务场景设置合理的范围
DatePicker({
  start: new Date('1900-01-01'), // 生日选择器
  end: new Date(),
  selected: new Date()
})

// ✅ 推荐：预约类应用限制未来日期
DatePicker({
  start: new Date(),
  end: new Date('2026-12-31'),
  selected: new Date()
})
```

### 5.2 样式一致性

```typescript
// ✅ 推荐：统一样式风格
DatePicker({
  start: new Date('2000-01-01'),
  end: new Date('2030-12-31'),
  selected: this.selectedDate
})
  .selectedTextStyle({
    color: $r('app.color.primary'),
    font: { size: 22, weight: FontWeight.Bold }
  })
  .textStyle({
    color: $r('app.color.text_primary'),
    font: { size: 18 }
  })
```

### 5.3 数据验证

```typescript
// ✅ 推荐：在 onChange 中验证数据
.onChange((value: DatePickerResult) => {
  const date = new Date(value.year, value.month - 1, value.day)

  // 验证逻辑
  if (this.isValidDate(date)) {
    this.selectedDate = date
  }
})
```

## 六、常见问题

### Q1: DatePicker 显示的月份不正确？

**问题**: 设置的日期和显示的不一致。

**解决方案**:
```typescript
// 注意：Date 的月份是从 0 开始的
const date = new Date(2024, 0, 1) // 1月
const date2 = new Date(2024, 11, 1) // 12月

// DatePicker 返回的月份是 1-12
.onChange((value: DatePickerResult) => {
  // value.month 是 1-12
  const date = new Date(value.year, value.month - 1, value.day)
})
```

### Q2: 如何限制工作日选择？

**解决方案**:
```typescript
.onChange((value: DatePickerResult) => {
  const date = new Date(value.year, value.month - 1, value.day)
  const dayOfWeek = date.getDay()

  // 0=周日, 6=周六
  if (dayOfWeek !== 0 && dayOfWeek !== 6) {
    this.selectedDate = date
  }
})
```

### Q3: 如何禁用过去的日期？

**解决方案**:
```typescript
DatePicker({
  start: new Date(), // 从今天开始
  end: new Date('2030-12-31'),
  selected: this.selectedDate
})
```

### Q4: 如何格式化日期显示？

**解决方案**:
```typescript
const date = new Date()

// 中文格式
const cnFormat = `${date.getFullYear()}年${date.getMonth() + 1}月${date.getDate()}日`

// 标准格式
const isoFormat = date.toISOString()

// 自定义格式
const customFormat = `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}-${String(date.getDate()).padStart(2, '0')}`
```

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 9+ | ✅ | 完全支持 |
| API 10+ | ✅ | 增加了更多样式选项 |
| API 12+ | ✅ | 性能优化 |

## 八、参考资料

- [DatePicker 组件 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-datepicker-V5)
