# TimePicker 组件 HarmonyOS 6.0 开发 Skill

## 概述

TimePicker 组件是 OpenHarmony 中的时间选择器组件，用于让用户选择小时、分钟、秒。它提供了多种显示模式和配置选项，支持自定义时间范围、格式和样式。

## 重要说明

- **基础组件**: TimePicker 是 ArkUI 的基础内置组件，无需导入
- **时间格式**: 支持 12 小时制和 24 小时制
- **响应式**: 配合 @State/@Local 使用实现响应式更新
- **选择对象**: 返回包含 hour、minute 的对象

## 模块信息

- **组件名称**: TimePicker
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [TimePicker - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-timepicker-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// TimePicker 是内置组件，无需导入
// 直接使用即可
TimePicker({ selected: new Date() })
```

### 1.2 基础用法

```typescript
// 简单的时间选择器（24小时制）
TimePicker({ selected: new Date() })
  .onChange((value: TimePickerResult) => {
    console.info('Hour: ' + value.hour)
    console.info('Minute: ' + value.minute)
  })
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| selected | `Date` | 是 | - | 选中的时间 |

### 2.2 TimePickerResult 接口

| 属性 | 类型 | 描述 |
|------|------|------|
| hour | `number` | 选中的小时（0-23） |
| minute | `number` | 选中的分钟（0-59） |

### 2.3 TimePicker 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `format` | `TimeFormat` | TimeFormat.H24 | 时间格式（12/24小时制） |
| `disappearTextStyle` | `TimePickerTextStyle` | - | 不可选时间文本样式 |
| `textStyle` | `TimePickerTextStyle` | - | 可选时间文本样式 |
| `selectedTextStyle` | `TimePickerTextStyle` | - | 选中时间文本样式 |
| `gradient` | `boolean` | false | 是否启用渐变效果 |

### 2.4 TimeFormat 枚举

| 值 | 描述 |
|----|------|
| `TimeFormat.H12` | 12小时制（显示 AM/PM） |
| `TimeFormat.H24` | 24小时制 |

### 2.5 TimePickerTextStyle 接口

| 属性 | 类型 | 描述 |
|------|------|------|
| color | `ResourceColor` | 文本颜色 |
| font | `Font` | 字体样式 |
| weight | `number \| FontWeight` | 字体粗细 |

## 三、使用示例

### 3.1 基础时间选择器示例（24小时制）

```typescript
@ComponentV2
struct BasicTimePickerExample {
  @Local selectedTime: Date = new Date()

  build() {
    Column({ space: 16 }) {
      Text('24小时制时间选择')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      TimePicker({ selected: this.selectedTime })
        .onChange((value: TimePickerResult) => {
          this.selectedTime = new Date()
          this.selectedTime.setHours(value.hour)
          this.selectedTime.setMinutes(value.minute)
          console.info('Selected: ' + this.selectedTime.toTimeString())
        })

      Text(`选中时间: ${this.selectedTime.getHours().toString().padStart(2, '0')}:${this.selectedTime.getMinutes().toString().padStart(2, '0')}`)
        .fontSize(16)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.2 12小时制时间选择器示例

```typescript
@ComponentV2
struct Hour12TimePickerExample {
  @Local selectedTime: Date = new Date()

  build() {
    Column({ space: 16 }) {
      Text('12小时制时间选择')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      TimePicker({ selected: this.selectedTime })
        .format(TimeFormat.H12)
        .onChange((value: TimePickerResult) => {
          this.selectedTime = new Date()
          this.selectedTime.setHours(value.hour)
          this.selectedTime.setMinutes(value.minute)
        })

      Text(`选中时间: ${this.selectedTime.toLocaleTimeString()}`)
        .fontSize(16)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.3 自定义样式示例

```typescript
@ComponentV2
struct CustomStyleTimePickerExample {
  @Local selectedTime: Date = new Date()

  build() {
    Column({ space: 16 }) {
      Text('自定义样式')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      TimePicker({ selected: this.selectedTime })
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
        .onChange((value: TimePickerResult) => {
          this.selectedTime = new Date()
          this.selectedTime.setHours(value.hour)
          this.selectedTime.setMinutes(value.minute)
        })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.4 渐变效果示例

```typescript
@ComponentV2
struct GradientTimePickerExample {
  @Local selectedTime: Date = new Date()

  build() {
    Column({ space: 16 }) {
      Text('渐变效果')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      TimePicker({ selected: this.selectedTime })
        .gradient(true)
        .onChange((value: TimePickerResult) => {
          this.selectedTime = new Date()
          this.selectedTime.setHours(value.hour)
          this.selectedTime.setMinutes(value.minute)
        })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.5 闹钟时间选择器示例

```typescript
@ComponentV2
struct AlarmTimePickerExample {
  @Local alarmTime: Date = new Date()
  @Local alarmEnabled: boolean = true

  build() {
    Column({ space: 16 }) {
      Text('设置闹钟')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      TimePicker({ selected: this.alarmTime })
        .onChange((value: TimePickerResult) => {
          this.alarmTime = new Date()
          this.alarmTime.setHours(value.hour)
          this.alarmTime.setMinutes(value.minute)
        })

      Row({ space: 12 }) {
        Toggle({ type: ToggleType.Switch, isOn: this.alarmEnabled })
          .onChange((isOn: boolean) => {
            this.alarmEnabled = isOn
          })

        Text('启用闹钟')
          .fontSize(16)
      }
      .margin({ top: 8 })

      Text(`闹钟时间: ${this.alarmTime.getHours().toString().padStart(2, '0')}:${this.alarmTime.getMinutes().toString().padStart(2, '0')}`)
        .fontSize(16)
        .fontColor(this.alarmEnabled ? '#333333' : '#CCCCCC')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.6 工作时间选择器示例

```typescript
@ComponentV2
struct WorkTimePickerExample {
  @Local startTime: Date = new Date()
  @Local endTime: Date = new Date()

  aboutToAppear() {
    // 设置默认工作时间：9:00 - 18:00
    this.startTime.setHours(9, 0, 0)
    this.endTime.setHours(18, 0, 0)
  }

  build() {
    Column({ space: 16 }) {
      Text('设置工作时间')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 开始时间
      Column({ space: 8 }) {
        Text('开始时间')
          .fontSize(14)
          .fontColor('#666666')
        TimePicker({ selected: this.startTime })
          .onChange((value: TimePickerResult) => {
            this.startTime = new Date()
            this.startTime.setHours(value.hour)
            this.startTime.setMinutes(value.minute)
          })
      }

      // 结束时间
      Column({ space: 8 }) {
        Text('结束时间')
          .fontSize(14)
          .fontColor('#666666')
        TimePicker({ selected: this.endTime })
          .onChange((value: TimePickerResult) => {
            this.endTime = new Date()
            this.endTime.setHours(value.hour)
            this.endTime.setMinutes(value.minute)
          })
      }

      Text(`工作时段: ${this.startTime.getHours().toString().padStart(2, '0')}:${this.startTime.getMinutes().toString().padStart(2, '0')} - ${this.endTime.getHours().toString().padStart(2, '0')}:${this.endTime.getMinutes().toString().padStart(2, '0')}`)
        .fontSize(16)
        .margin({ top: 8 })

      // 计算工作时长
      let workMinutes = (this.endTime.getHours() - this.startTime.getHours()) * 60 +
                        (this.endTime.getMinutes() - this.startTime.getMinutes())
      Text(`工作时长: ${Math.floor(workMinutes / 60)} 小时 ${workMinutes % 60} 分钟`)
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.7 预约时间选择器示例

```typescript
@ComponentV2
struct AppointmentTimePickerExample {
  @Local appointmentTime: Date = new Date()

  build() {
    Column({ space: 16 }) {
      Text('选择预约时间')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Text('营业时间: 09:00 - 21:00')
        .fontSize(14)
        .fontColor('#666666')

      TimePicker({ selected: this.appointmentTime })
        .onChange((value: TimePickerResult) => {
          // 验证时间范围
          if (value.hour >= 9 && value.hour < 21) {
            this.appointmentTime = new Date()
            this.appointmentTime.setHours(value.hour)
            this.appointmentTime.setMinutes(value.minute)
          } else {
            console.info('时间超出营业范围')
          }
        })

      Text(`预约时间: ${this.appointmentTime.getHours().toString().padStart(2, '0')}:${this.appointmentTime.getMinutes().toString().padStart(2, '0')}`)
        .fontSize(16)
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(16)
  }
}
```

## 四、高级用法

### 4.1 时间格式化显示

```typescript
@ComponentV2
struct FormattedTimePickerExample {
  @Local selectedTime: Date = new Date()

  build() {
    Column({ space: 16 }) {
      TimePicker({ selected: this.selectedTime })
        .onChange((value: TimePickerResult) => {
          this.selectedTime = new Date()
          this.selectedTime.setHours(value.hour)
          this.selectedTime.setMinutes(value.minute)
        })

      Column({ space: 8 }) {
        Text('24小时制:')
          .fontSize(14)
          .fontColor('#666666')
        Text(`${this.selectedTime.getHours().toString().padStart(2, '0')}:${this.selectedTime.getMinutes().toString().padStart(2, '0')}`)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)

        Text('12小时制:')
          .fontSize(14)
          .fontColor('#666666')
        Text(this.selectedTime.toLocaleTimeString())
          .fontSize(18)

        Text('带秒数:')
          .fontSize(14)
          .fontColor('#666666')
        Text(`${this.selectedTime.getHours().toString().padStart(2, '0')}:${this.selectedTime.getMinutes().toString().padStart(2, '0')}:${this.selectedTime.getSeconds().toString().padStart(2, '0')}`)
          .fontSize(16)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 4.2 时间验证

```typescript
@ComponentV2
struct ValidatedTimePickerExample {
  @Local selectedTime: Date = new Date()
  @Local errorMessage: string = ''

  build() {
    Column({ space: 16 }) {
      Text('选择时间')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Text('营业时间: 10:00 - 20:00')
        .fontSize(14)
        .fontColor('#666666')

      TimePicker({ selected: this.selectedTime })
        .onChange((value: TimePickerResult) => {
          this.validateTime(value.hour, value.minute)
        })

      if (this.errorMessage) {
        Text(this.errorMessage)
          .fontSize(14)
          .fontColor('#FF0000')
      }

      Text(`选中: ${this.selectedTime.getHours().toString().padStart(2, '0')}:${this.selectedTime.getMinutes().toString().padStart(2, '0')}`)
        .fontSize(16)
    }
    .width('100%')
    .padding(16)
  }

  validateTime(hour: number, minute: number) {
    // 示例：只允许营业时间
    if (hour < 10 || hour >= 20) {
      this.errorMessage = '时间超出营业范围（10:00-20:00）'
    } else {
      this.errorMessage = ''
      this.selectedTime = new Date()
      this.selectedTime.setHours(hour, minute)
    }
  }
}
```

### 4.3 多个时间选择器联动

```typescript
@ComponentV2
struct LinkedTimePickersExample {
  @Local startTime: Date = new Date()
  @Local endTime: Date = new Date()

  aboutToAppear() {
    this.startTime.setHours(9, 0)
    this.endTime.setHours(17, 0)
  }

  build() {
    Column({ space: 16 }) {
      Text('时间范围')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 开始时间
      Column({ space: 8 }) {
        Text('开始时间')
          .fontSize(14)
          .fontColor('#666666')
        TimePicker({ selected: this.startTime })
          .onChange((value: TimePickerResult) => {
            this.startTime = new Date()
            this.startTime.setHours(value.hour, value.minute)

            // 确保结束时间晚于开始时间
            if (this.endTime <= this.startTime) {
              this.endTime = new Date(this.startTime)
              this.endTime.setHours(this.startTime.getHours() + 1)
            }
          })
      }

      // 结束时间
      Column({ space: 8 }) {
        Text('结束时间')
          .fontSize(14)
          .fontColor('#666666')
        TimePicker({ selected: this.endTime })
          .onChange((value: TimePickerResult) => {
            const newEndTime = new Date()
            newEndTime.setHours(value.hour, value.minute)

            // 确保结束时间晚于开始时间
            if (newEndTime > this.startTime) {
              this.endTime = newEndTime
            }
          })
      }

      Text(`时段: ${this.startTime.getHours().toString().padStart(2, '0')}:${this.startTime.getMinutes().toString().padStart(2, '0')} - ${this.endTime.getHours().toString().padStart(2, '0')}:${this.endTime.getMinutes().toString().padStart(2, '0')}`)
        .fontSize(16)
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(16)
  }
}
```

## 五、最佳实践

### 5.1 时间格式选择

```typescript
// ✅ 推荐：根据场景选择合适的时间格式
// 军事、交通、国际场景使用24小时制
TimePicker({ selected: this.selectedTime })
  .format(TimeFormat.H24)

// 日常生活、提醒使用12小时制
TimePicker({ selected: this.selectedTime })
  .format(TimeFormat.H12)
```

### 5.2 样式一致性

```typescript
// ✅ 推荐：统一样式风格
TimePicker({ selected: this.selectedTime })
  .selectedTextStyle({
    color: $r('app.color.primary'),
    font: { size: 22, weight: FontWeight.Bold }
  })
  .textStyle({
    color: $r('app.color.text_primary'),
    font: { size: 18 }
  })
```

### 5.3 时间验证

```typescript
// ✅ 推荐：在 onChange 中验证时间
.onChange((value: TimePickerResult) => {
  if (this.isValidTime(value.hour, value.minute)) {
    this.selectedTime = new Date()
    this.selectedTime.setHours(value.hour, value.minute)
  }
})
```

## 六、常见问题

### Q1: TimePicker 如何设置默认时间？

**解决方案**:
```typescript
@Local selectedTime: Date = new Date()

aboutToAppear() {
  // 设置默认时间为 09:30
  this.selectedTime.setHours(9, 30, 0)
}

build() {
  TimePicker({ selected: this.selectedTime })
}
```

### Q2: 如何限制时间范围？

**解决方案**:
```typescript
.onChange((value: TimePickerResult) => {
  // 只允许工作时间 9:00-18:00
  if (value.hour >= 9 && value.hour < 18) {
    this.selectedTime = new Date()
    this.selectedTime.setHours(value.hour, value.minute)
  } else {
    console.info('时间超出允许范围')
  }
})
```

### Q3: 12小时制和24小时制如何切换？

**解决方案**:
```typescript
// 12小时制
TimePicker({ selected: this.selectedTime })
  .format(TimeFormat.H12)

// 24小时制
TimePicker({ selected: this.selectedTime })
  .format(TimeFormat.H24)
```

### Q4: 如何格式化时间显示？

**解决方案**:
```typescript
const time = new Date()

// 24小时制
const h24Format = `${time.getHours().toString().padStart(2, '0')}:${time.getMinutes().toString().padStart(2, '0')}`

// 12小时制
const h12Format = time.toLocaleTimeString()

// 自定义格式
const customFormat = `${time.getHours()}:${time.getMinutes().toString().padStart(2, '0')}`
```

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 9+ | ✅ | 完全支持 |
| API 10+ | ✅ | 增加了更多样式选项 |
| API 12+ | ✅ | 性能优化 |

## 八、参考资料

- [TimePicker 组件 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-timepicker-V5)
