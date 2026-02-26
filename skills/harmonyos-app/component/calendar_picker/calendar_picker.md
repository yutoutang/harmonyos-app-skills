# CalendarPicker 组件 HarmonyOS 6.0 开发 Skill

## 概述

CalendarPicker 组件是 OpenHarmony 中的日历选择器组件，用于让用户选择日期。它提供了日历视图、日期选择、范围选择等功能，常用于日程安排、日期筛选、预约系统等场景。CalendarPicker 支持单日期选择、日期范围选择等多种模式。

## 重要说明

- **日期选择**: 支持单日期、日期范围、多日期选择
- **视图模式**: 提供月视图、年视图等多种展示方式
- **范围限制**: 支持设置最小日期和最大日期
- **自定义样式**: 支持自定义日期单元格、周末、节假日的样式
- **国际化**: 支持多语言和多种日期格式

## 模块信息

- **组件名称**: CalendarPicker
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [CalendarPicker - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-calendar-picker-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// CalendarPicker 是内置组件，无需导入
// 直接使用即可
CalendarPicker()
```

### 1.2 基础用法

```typescript
// 基础日历选择器
CalendarPicker()
  .onSelect((value: string) => {
    console.info('选中的日期: ' + value)
  })
```

## 二、API 参数

### 2.1 构造参数

CalendarPicker 组件没有必需的构造参数。

### 2.2 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `range` | `string` | - | 日期范围 |
| `startOfWeek` `string` | - | 一周的起始日 |
| `multiSelect` | `boolean` | false | 是否多选 |
| `showHoliday` | `boolean` | true | 是否显示节假日 |
| `showLunar` | `boolean` | false | 是否显示农历 |

### 2.3 事件

| 事件 | 类型 | 描述 |
|------|------|------|
| `onSelect` | `(value: string \| Array<string>) => void` | 选择日期回调 |
| `onChange` | `(value: string) => void` | 日期变化回调 |

## 三、使用示例

### 3.1 基础 CalendarPicker 示例

```typescript
@ComponentV2
struct BasicCalendarPickerExample {
  @Local selectedDate: string = ''

  build() {
    Column({ space: 20 }) {
      Text('日历选择器')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)

      // 基础日历
      CalendarPicker()
        .width('100%')
        .height(400)
        .onSelect((value: string) => {
          this.selectedDate = value
          console.info('选中的日期: ' + value)
        })

      // 显示选中日期
      if (this.selectedDate) {
        Text(`选中日期: ${this.selectedDate}`)
          .fontSize(18)
          .fontColor('#007DFF')
          .fontWeight(FontWeight.Medium)
      }
    }
    .width('100%')
    .padding(20)
  }
}
```

### 3.2 日期范围选择示例

```typescript
@ComponentV2
struct DateRangePickerExample {
  @Local startDate: string = ''
  @Local endDate: string = ''
  @Local selectedRange: string = '请选择日期范围'

  build() {
    Column({ space: 20 }) {
      Text('日期范围选择')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)

      // 显示范围
      Column({ space: 8 }) {
        Text('选择范围')
          .fontSize(16)
          .fontColor('#666666')

        Text(this.selectedRange)
          .fontSize(18)
          .fontColor('#007DFF')
          .fontWeight(FontWeight.Medium)
          .width('100%')
          .padding(12)
          .backgroundColor('#F0F8FF')
          .borderRadius(8)
      }
      .width('100%')

      // 日期范围选择器
      CalendarPicker()
        .width('100%')
        .height(400)
        .multiSelect(false) // 单选模式
        .onSelect((value: string) => {
          if (!this.startDate) {
            this.startDate = value
            this.selectedRange = `开始: ${value}`
          } else if (!this.endDate) {
            this.endDate = value
            this.selectedRange = `${this.startDate} 至 ${this.endDate}`
          } else {
            // 重新选择
            this.startDate = value
            this.endDate = ''
            this.selectedRange = `开始: ${value}`
          }
        })

      // 重置按钮
      Button('重置')
        .width(120)
        .height(40)
        .type(ButtonType.Capsule)
        .backgroundColor('#6C757D')
        .fontColor(Color.White)
        .onClick(() => {
          this.startDate = ''
          this.endDate = ''
          this.selectedRange = '请选择日期范围'
        })
    }
    .width('100%')
    .padding(20)
  }
}
```

### 3.3 限制日期范围示例

```typescript
@ComponentV2
struct LimitedRangeCalendarExample {
  @Local selectedDate: string = ''
  readonly minDate: string = '2024-01-01'
  readonly maxDate: string = '2024-12-31'

  build() {
    Column({ space: 20 }) {
      Text('限制日期范围')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)

      // 范围提示
      Column({ space: 8 }) {
        Text('可选范围')
          .fontSize(16)
          .fontColor('#666666')

        Text(`${this.minDate} 至 ${this.maxDate}`)
          .fontSize(14)
          .fontColor('#999999')
      }
      .width('100%')

      // 限制范围的日历
      CalendarPicker()
        .width('100%')
        .height(400)
        .range(`${this.minDate}-${this.maxDate}`)
        .onSelect((value: string) => {
          this.selectedDate = value
          console.info('选中的日期: ' + value)
        })

      // 显示选中日期
      if (this.selectedDate) {
        Text(`选中: ${this.selectedDate}`)
          .fontSize(18)
          .fontColor('#28A745')
          .fontWeight(FontWeight.Medium)
      }
    }
    .width('100%')
    .padding(20)
  }
}
```

### 3.4 多日期选择示例

```typescript
@ComponentV2
struct MultiSelectCalendarExample {
  @Local selectedDates: Array<string> = []

  build() {
    Column({ space: 20 }) {
      Text('多日期选择')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)

      // 多选日历
      CalendarPicker()
        .width('100%')
        .height(400)
        .multiSelect(true)
        .onSelect((value: string | Array<string>) => {
          if (Array.isArray(value)) {
            this.selectedDates = value
            console.info('选中的日期: ' + JSON.stringify(value))
          }
        })

      // 显示选中日期
      Column({ space: 12 }) {
        Text('已选择的日期')
          .fontSize(16)
          .fontColor('#666666')
          .width('100%')

        if (this.selectedDates.length > 0) {
          Column({ space: 8 }) {
            ForEach(this.selectedDates, (date: string) => {
              Row({ space: 8 }) {
                Text('•')
                  .fontSize(16)
                  .fontColor('#007DFF')

                Text(date)
                  .fontSize(16)
                  .fontColor('#333333')
              }
              .width('100%')
            })
          }
          .width('100%')
          .padding(12)
          .backgroundColor('#F0F8FF')
          .borderRadius(8)
        } else {
          Text('未选择日期')
            .fontSize(14)
            .fontColor('#999999')
            .width('100%')
            .padding(12)
            .backgroundColor('#F5F5F5')
            .borderRadius(8)
        }
      }
      .width('100%')

      // 日期统计
      Text(`共选择了 ${this.selectedDates.length} 个日期`)
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(20)
  }
}
```

### 3.5 显示农历示例

```typescript
@ComponentV2
struct LunarCalendarExample {
  @Local selectedDate: string = ''

  build() {
    Column({ space: 20 }) {
      Text('农历日历')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)

      // 显示农历的日历
      CalendarPicker()
        .width('100%')
        .height(400)
        .showLunar(true)
        .showHoliday(true)
        .onSelect((value: string) => {
          this.selectedDate = value
          console.info('选中的日期: ' + value)
        })

      // 显示选中日期
      if (this.selectedDate) {
        Text(`选中: ${this.selectedDate}`)
          .fontSize(18)
          .fontColor('#007DFF')
          .fontWeight(FontWeight.Medium)
      }

      // 说明
      Column({ space: 8 }) {
        Text('功能说明')
          .fontSize(16)
          .fontColor('#666666')

        Text('• 显示农历日期')
          .fontSize(14)
          .fontColor('#999999')

        Text('• 显示节假日标记')
          .fontSize(14)
          .fontColor('#999999')
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#FFF9E6')
      .borderRadius(8)
    }
    .width('100%')
    .padding(20)
  }
}
```

### 3.6 预约系统示例

```typescript
@ComponentV2
struct AppointmentCalendarExample {
  @Local selectedDate: string = ''
  @Local availableDates: Set<string> = new Set([
    '2024-02-01', '2024-02-02', '2024-02-05', '2024-02-06',
    '2024-02-08', '2024-02-09', '2024-02-12', '2024-02-13'
  ])

  build() {
    Column({ space: 20 }) {
      Text('预约日历')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)

      // 日历
      CalendarPicker()
        .width('100%')
        .height(400)
        .range('2024-02-01-2024-02-29')
        .onSelect((value: string) => {
          if (this.availableDates.has(value)) {
            this.selectedDate = value
          } else {
            console.info('该日期不可预约')
          }
        })

      // 选中信息
      Column({ space: 12 }) {
        Text('预约信息')
          .fontSize(16)
          .fontColor('#666666')
          .width('100%')

        if (this.selectedDate) {
          Column({ space: 8 }) {
            Text(`预约日期: ${this.selectedDate}`)
              .fontSize(18)
              .fontColor('#007DFF')
              .fontWeight(FontWeight.Medium)

            Text('可预约时段: 09:00 - 17:00')
              .fontSize(14)
              .fontColor('#666666')
          }
          .width('100%')
          .padding(12)
          .backgroundColor('#F0F8FF')
          .borderRadius(8)

          Button('确认预约')
            .width('100%')
            .height(45)
            .type(ButtonType.Capsule)
            .backgroundColor('#28A745')
            .fontColor(Color.White)
            .onClick(() => {
              console.info(`预约成功: ${this.selectedDate}`)
            })
        } else {
          Text('请选择可预约的日期')
            .fontSize(14)
            .fontColor('#999999')
            .width('100%')
            .padding(12)
            .backgroundColor('#F5F5F5')
            .borderRadius(8)
            .textAlign(TextAlign.Center)
        }
      }
      .width('100%')

      // 说明
      Text('提示: 仅可选择可预约日期')
        .fontSize(14)
        .fontColor('#FFC107')
    }
    .width('100%')
    .padding(20)
  }
}
```

## 四、高级用法

### 4.1 日期筛选器

```typescript
@ComponentV2
struct DateFilterExample {
  @Local startDate: string = ''
  @Local endDate: string = ''
  @Local filteredCount: number = 0

  // 模拟数据筛选
  filterData(): void {
    // 实际应用中，这里会调用API或查询数据库
    this.filteredCount = Math.floor(Math.random() * 100)
    console.info(`筛选 ${this.startDate} 至 ${this.endDate} 的数据`)
  }

  build() {
    Column({ space: 20 }) {
      Text('日期筛选')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)

      // 范围显示
      Row({ space: 12 }) {
        Column({ space: 8 }) {
          Text('开始日期')
            .fontSize(14)
            .fontColor('#666666')

          Text(this.startDate || '未选择')
            .fontSize(16)
            .fontColor('#007DFF')
        }
        .layoutWeight(1)
        .padding(12)
        .backgroundColor('#F5F5F5')
        .borderRadius(8)

        Text('至')
          .fontSize(16)
          .fontColor('#666666')

        Column({ space: 8 }) {
          Text('结束日期')
            .fontSize(14)
            .fontColor('#666666')

          Text(this.endDate || '未选择')
            .fontSize(16)
            .fontColor('#007DFF')
        }
        .layoutWeight(1)
        .padding(12)
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
      }
      .width('100%')

      // 日历选择器
      CalendarPicker()
        .width('100%')
        .height(350)
        .onSelect((value: string) => {
          if (!this.startDate) {
            this.startDate = value
          } else if (!this.endDate) {
            this.endDate = value
            this.filterData()
          } else {
            this.startDate = value
            this.endDate = ''
          }
        })

      // 筛选结果
      if (this.startDate && this.endDate) {
        Column({ space: 8 }) {
          Text('筛选结果')
            .fontSize(16)
            .fontColor('#666666')

          Text(`找到 ${this.filteredCount} 条记录`)
            .fontSize(20)
            .fontColor('#28A745')
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#F0F8FF')
        .borderRadius(8)
      }

      // 重置按钮
      Button('重置筛选')
        .width('100%')
        .height(45)
        .type(ButtonType.Capsule)
        .backgroundColor('#6C757D')
        .fontColor(Color.White)
        .enabled(this.startDate !== '' || this.endDate !== '')
        .onClick(() => {
          this.startDate = ''
          this.endDate = ''
          this.filteredCount = 0
        })
    }
    .width('100%')
    .padding(20)
  }
}
```

### 4.2 日程日历

```typescript
@ComponentV2
struct ScheduleCalendarExample {
  @Local selectedDate: string = ''
  @Local events: Map<string, Array<string>> = new Map([
    ['2024-02-01', ['会议', '生日']],
    ['2024-02-05', ['项目截止']],
    ['2024-02-10', ['培训', '面试']],
    ['2024-02-15', ['发布会']]
  ])

  // 获取选中日期的日程
  getEventsForDate(date: string): Array<string> {
    return this.events.get(date) || []
  }

  build() {
    Column({ space: 20 }) {
      Text('日程日历')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)

      // 日历
      CalendarPicker()
        .width('100%')
        .height(350)
        .onSelect((value: string) => {
          this.selectedDate = value
        })

      // 日程显示
      Column({ space: 12 }) {
        Text('日程安排')
          .fontSize(16)
          .fontColor('#666666')
          .width('100%')

        if (this.selectedDate) {
          const events = this.getEventsForDate(this.selectedDate)

          if (events.length > 0) {
            Column({ space: 8 }) {
              Text(`${this.selectedDate}`)
                .fontSize(18)
                .fontColor('#007DFF')
                .fontWeight(FontWeight.Bold)

              ForEach(events, (event: string) => {
                Row({ space: 8 }) {
                  Text('•')
                    .fontSize(16)
                    .fontColor('#FFC107')

                  Text(event)
                    .fontSize(16)
                    .fontColor('#333333')
                }
                .width('100%')
                .padding(8)
                .backgroundColor('#FFF9E6')
                .borderRadius(4)
              })
            }
            .width('100%')
            .padding(12)
            .backgroundColor('#F0F8FF')
            .borderRadius(8)
          } else {
            Text(`${this.selectedDate} 暂无日程`)
              .fontSize(16)
              .fontColor('#999999')
              .width('100%')
              .padding(12)
              .backgroundColor('#F5F5F5')
              .borderRadius(8)
              .textAlign(TextAlign.Center)
          }
        } else {
          Text('请选择日期查看日程')
            .fontSize(16)
            .fontColor('#999999')
            .width('100%')
            .padding(12)
            .backgroundColor('#F5F5F5')
            .borderRadius(8)
            .textAlign(TextAlign.Center)
        }
      }
      .width('100%')

      // 添加日程按钮
      Button('添加日程')
        .width('100%')
        .height(45)
        .type(ButtonType.Capsule)
        .backgroundColor('#007DFF')
        .fontColor(Color.White)
        .enabled(this.selectedDate !== '')
        .onClick(() => {
          console.info(`为 ${this.selectedDate} 添加日程`)
        })
    }
    .width('100%')
    .padding(20)
  }
}
```

## 五、最佳实践

### 5.1 日期格式化

```typescript
// ✅ 推荐：统一日期格式
@ComponentV2
struct FormattedDateExample {
  @Local selectedDate: string = ''

  formatDate(date: string): string {
    // 格式化为更友好的显示
    const d = new Date(date)
    const year = d.getFullYear()
    const month = d.getMonth() + 1
    const day = d.getDate()
    const weekDays = ['日', '一', '二', '三', '四', '五', '六']
    const weekDay = weekDays[d.getDay()]

    return `${year}年${month}月${day}日 星期${weekDay}`
  }

  build() {
    Column() {
      CalendarPicker()
        .onSelect((value: string) => {
          this.selectedDate = value
        })

      if (this.selectedDate) {
        Text(this.formatDate(this.selectedDate))
          .fontSize(18)
      }
    }
  }
}
```

### 5.2 范围限制

```typescript
// ✅ 推荐：合理设置可选范围
CalendarPicker()
  .range('2024-01-01-2024-12-31') // 限制在2024年
  .onSelect((value: string) => {
    // 处理选择
  })
```

### 5.3 用户反馈

```typescript
// ✅ 推荐：提供清晰的选择反馈
@ComponentV2
struct UserFeedbackExample {
  @Local selectedDate: string = ''
  @Local message: string = '请选择日期'

  build() {
    Column({ space: 16 }) {
      CalendarPicker()
        .onSelect((value: string) => {
          this.selectedDate = value
          this.message = `已选择: ${value}`
        })

      Text(this.message)
        .fontSize(16)
        .fontColor('#666666')
        .width('100%')
        .padding(12)
        .backgroundColor('#F0F8FF')
        .borderRadius(8)
        .textAlign(TextAlign.Center)
    }
  }
}
```

## 六、常见问题

### Q1: 如何设置默认选中日期？

**解决方案**:
```typescript
@ComponentV2
struct DefaultDateExample {
  @Local selectedDate: string = '2024-02-15'

  build() {
    CalendarPicker()
      .onSelect((value: string) => {
        this.selectedDate = value
      })
  }
}
```

### Q2: 如何禁用某些日期？

**解决方案**:
```typescript
CalendarPicker()
  .onSelect((value: string) => {
    const disabledDates = ['2024-02-10', '2024-02-11', '2024-02-12']
    if (disabledDates.includes(value)) {
      console.info('该日期不可选')
      return
    }
    // 处理有效选择
  })
```

### Q3: 如何获取当前月份？

**解决方案**:
```typescript
@ComponentV2
struct CurrentMonthExample {
  @Local currentMonth: string = ''

  build() {
    Column() {
      CalendarPicker()
        .onChange((value: string) => {
          // value 包含当前显示的年月信息
          console.info('当前月份: ' + value)
        })
    }
  }
}
```

### Q4: 如何实现日期验证？

**解决方案**:
```typescript
function validateDate(date: string): boolean {
  const d = new Date(date)
  const now = new Date()

  // 不允许选择过去的日期
  if (d < now) {
    return false
  }

  // 不允许选择周末
  const day = d.getDay()
  if (day === 0 || day === 6) {
    return false
  }

  return true
}

CalendarPicker()
  .onSelect((value: string) => {
    if (!validateDate(value)) {
      console.info('无效的日期')
      return
    }
    // 处理有效日期
  })
```

### Q5: 如何实现日期快捷选择？

**解决方案**:
```typescript
@ComponentV2
struct QuickSelectExample {
  @Local selectedDate: string = ''

  selectToday(): void {
    const today = new Date()
    this.selectedDate = today.toISOString().split('T')[0]
  }

  selectTomorrow(): void {
    const tomorrow = new Date()
    tomorrow.setDate(tomorrow.getDate() + 1)
    this.selectedDate = tomorrow.toISOString().split('T')[0]
  }

  build() {
    Column({ space: 16 }) {
      // 快捷选择按钮
      Row({ space: 12 }) {
        Button('今天')
          .onClick(() => this.selectToday())

        Button('明天')
          .onClick(() => this.selectTomorrow())
      }
      .width('100%')

      CalendarPicker()
        .onSelect((value: string) => {
          this.selectedDate = value
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

- [CalendarPicker 日历选择器 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-calendar-picker-V5)
- [日期时间处理 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/arkts-date-time-V5)
