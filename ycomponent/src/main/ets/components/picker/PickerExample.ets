/**
 * Picker Components Examples
 * OpenHarmony DatePicker, TimePicker, TextPicker Component 使用示例
 *
 * 展示 DatePicker、TimePicker、TextPicker 组件的各种用法
 */

/**
 * 基础日期选择器示例
 */
@ComponentV2
export struct BasicDatePickerExample {
  @Local selectedDate: Date = new Date()

  build() {
    Column({ space: 16 }) {
      Text('基础日期选择')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      DatePicker({
        start: new Date('2000-01-01'),
        end: new Date('2030-12-31'),
        selected: this.selectedDate
      })
        .onChange((value: DatePickerResult) => {
          const month = value.month !== undefined ? value.month : 1
          this.selectedDate = new Date(value.year ?? 2000, month - 1, value.day ?? 1)
          console.info('Selected: ' + this.selectedDate.toISOString())
        })

      Text(`选中: ${this.selectedDate.getFullYear()}年${this.selectedDate.getMonth() + 1}月${this.selectedDate.getDate()}日`)
        .fontSize(16)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 生日选择器示例
 */
@ComponentV2
export struct BirthdayDatePickerExample {
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
          const month = value.month !== undefined ? value.month : 1
          this.birthday = new Date(value.year ?? 2000, month - 1, value.day ?? 1)
        })

      Text(`生日: ${this.birthday.toLocaleDateString()}`)
        .fontSize(16)
        .margin({ top: 8 })

      Text(`年龄: ${new Date().getFullYear() - this.birthday.getFullYear()} 岁`)
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 自定义样式日期选择器示例
 */
@ComponentV2
export struct CustomStyleDatePickerExample {
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
          const month = value.month !== undefined ? value.month : 1
          this.selectedDate = new Date(value.year ?? 2000, month - 1, value.day ?? 1)
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 农历日期选择器示例
 */
@ComponentV2
export struct LunarDatePickerExample {
  @Local selectedDate: Date = new Date()

  build() {
    Column({ space: 16 }) {
      Text('农历日期')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      DatePicker({
        start: new Date('2000-01-01'),
        end: new Date('2030-12-31'),
        selected: this.selectedDate
      })
        .lunar(true)
        .onChange((value: DatePickerResult) => {
          const month = value.month !== undefined ? value.month : 1
          this.selectedDate = new Date(value.year ?? 2000, month - 1, value.day ?? 1)
        })

      Text(`选中: ${this.selectedDate.toLocaleDateString()}`)
        .fontSize(16)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 基础时间选择器示例（24小时制）
 */
@ComponentV2
export struct BasicTimePickerExample {
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
        })

      Text(`选中: ${this.selectedTime.getHours().toString().padStart(2, '0')}:${this.selectedTime.getMinutes().toString().padStart(2, '0')}`)
        .fontSize(16)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 12小时制时间选择器示例
 */
@ComponentV2
export struct Hour12TimePickerExample {
  @Local selectedTime: Date = new Date()

  build() {
    Column({ space: 16 }) {
      Text('12小时制时间选择')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      TimePicker({ selected: this.selectedTime })
        .onChange((value: TimePickerResult) => {
          this.selectedTime = new Date()
          this.selectedTime.setHours(value.hour ?? 0)
          this.selectedTime.setMinutes(value.minute ?? 0)
        })

      Text(`选中: ${this.selectedTime.toLocaleTimeString()}`)
        .fontSize(16)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 闹钟时间选择器示例
 */
@ComponentV2
export struct AlarmTimePickerExample {
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

      Text(`闹钟: ${this.alarmTime.getHours().toString().padStart(2, '0')}:${this.alarmTime.getMinutes().toString().padStart(2, '0')}`)
        .fontSize(16)
        .fontColor(this.alarmEnabled ? '#333333' : '#CCCCCC')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 自定义样式时间选择器示例
 */
@ComponentV2
export struct CustomStyleTimePickerExample {
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
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 基础文本选择器示例
 */
@ComponentV2
export struct BasicTextPickerExample {
  @Local selectedIdx: number = 0
  @Local fruits: string[] = ['苹果', '香蕉', '橙子', '葡萄', '西瓜']

  build() {
    Column({ space: 16 }) {
      Text('选择水果')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      TextPicker({ range: this.fruits, selected: this.selectedIdx })
        .onChange((value: string | string[], index: number | number[]) => {
          this.selectedIdx = index as number
          console.info('Selected: ' + (value as string))
        })

      Text(`选中: ${this.fruits[this.selectedIdx]}`)
        .fontSize(16)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 城市选择器示例
 */
@ComponentV2
export struct CityPickerExample {
  @Local selectedCity: string = '北京'
  @Local cities: string[] = ['北京', '上海', '广州', '深圳', '杭州', '南京', '成都', '重庆']

  build() {
    Column({ space: 16 }) {
      Text('选择城市')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      TextPicker({ range: this.cities, selected: 0 })
        .onChange((value: string | string[], index: number | number[]) => {
          this.selectedCity = (value as string) ?? this.cities[0]
        })

      Row({ space: 8 }) {
        Text('当前城市:')
          .fontSize(14)
          .fontColor('#666666')
        Text(this.selectedCity)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#007DFF')
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 年龄选择器示例
 */
@ComponentV2
export struct AgePickerExample {
  @Local selectedAge: number = 25
  @Local ageOptions: string[] = []

  aboutToAppear() {
    // Initialize age options
    for (let i = 1; i <= 100; i++) {
      this.ageOptions.push(`${i}岁`)
    }
  }

  build() {
    Column({ space: 16 }) {
      Text('选择年龄')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      TextPicker({ range: this.ageOptions, selected: this.selectedAge - 1 })
        .onChange((value: string | string[], index: number | number[]) => {
          this.selectedAge = (index as number) + 1
        })

      Text(`年龄: ${this.selectedAge} 岁`)
        .fontSize(16)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 循环滚动文本选择器示例
 */
@ComponentV2
export struct CanLoopTextPickerExample {
  @Local selectedIdx: number = 0
  @Local weekdays: string[] = ['周一', '周二', '周三', '周四', '周五', '周六', '周日']

  build() {
    Column({ space: 16 }) {
      Text('选择星期（循环）')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      TextPicker({ range: this.weekdays, selected: this.selectedIdx })
        .canLoop(true)
        .onChange((value: string | string[], index: number | number[]) => {
          this.selectedIdx = index as number
        })

      Text(`选中: ${this.weekdays[this.selectedIdx]}`)
        .fontSize(16)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 自定义样式文本选择器示例
 */
@ComponentV2
export struct CustomStyleTextPickerExample {
  @Local selectedIdx: number = 0
  @Local options: string[] = ['选项1', '选项2', '选项3', '选项4', '选项5']

  build() {
    Column({ space: 16 }) {
      Text('自定义样式')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      TextPicker({ range: this.options, selected: this.selectedIdx })
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
        .onChange((value: string | string[], index: number | number[]) => {
          this.selectedIdx = index as number
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 日期时间组合选择器示例
 */
@ComponentV2
export struct DateTimePickerExample {
  @Local selectedDate: Date = new Date()
  @Local selectedTime: Date = new Date()

  build() {
    Column({ space: 16 }) {
      Text('选择日期和时间')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 日期选择
      Column({ space: 8 }) {
        Text('日期')
          .fontSize(14)
          .fontColor('#666666')
        DatePicker({
          start: new Date('2000-01-01'),
          end: new Date('2030-12-31'),
          selected: this.selectedDate
        })
          .onChange((value: DatePickerResult) => {
            const month = value.month !== undefined ? value.month : 1
            this.selectedDate = new Date(value.year ?? 2000, month - 1, value.day ?? 1)
          })
      }

      // 时间选择
      Column({ space: 8 }) {
        Text('时间')
          .fontSize(14)
          .fontColor('#666666')
        TimePicker({ selected: this.selectedTime })
          .onChange((value: TimePickerResult) => {
            this.selectedTime = new Date()
            this.selectedTime.setHours(value.hour)
            this.selectedTime.setMinutes(value.minute)
          })
      }

      Text(`选择: ${this.selectedDate.toLocaleDateString()} ${this.selectedTime.getHours().toString().padStart(2, '0')}:${this.selectedTime.getMinutes().toString().padStart(2, '0')}`)
        .fontSize(16)
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 完整的 Picker 示例页面
 * 集成所有 DatePicker、TimePicker、TextPicker 示例
 */
@ComponentV2
export struct PickerExamplePage {
  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          Text('Picker Components Examples')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .padding({ left: 16, right: 16, top: 16, bottom: 8 })

          // DatePicker 示例
          Text('DatePicker - 日期选择器')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .width('100%')
            .padding({ left: 16, right: 16 })
          BasicDatePickerExample()
          BirthdayDatePickerExample()
          CustomStyleDatePickerExample()
          LunarDatePickerExample()

          // TimePicker 示例
          Text('TimePicker - 时间选择器')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .width('100%')
            .padding({ left: 16, right: 16 })
          BasicTimePickerExample()
          Hour12TimePickerExample()
          AlarmTimePickerExample()
          CustomStyleTimePickerExample()

          // TextPicker 示例
          Text('TextPicker - 文本选择器')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .width('100%')
            .padding({ left: 16, right: 16 })
          BasicTextPickerExample()
          CityPickerExample()
          AgePickerExample()
          CanLoopTextPickerExample()
          CustomStyleTextPickerExample()

          // 组合示例
          Text('组合示例')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .width('100%')
            .padding({ left: 16, right: 16 })
          DateTimePickerExample()
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
    }
    .title('Picker 选择器')
    .mode(NavDestinationMode.STANDARD)
  }
}

@Builder
export function PickerExamplePageBuilder() {
  PickerExamplePage()
}
