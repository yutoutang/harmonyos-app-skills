/**
 * Input Component Examples
 * OpenHarmony 输入组件使用示例
 */

/**
 * TextInput 示例
 */
@ComponentV2
export struct TextInputExample {
  @Local textValue: string = ''

  build() {
    Column({ space: 16 }) {
      Text('TextInput 示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      TextInput({ placeholder: '请输入文本', text: this.textValue })
        .onChange((value: string) => {
          this.textValue = value
        })

      Text(`输入内容: ${this.textValue}`)
        .fontSize(14)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * TextArea 示例
 */
@ComponentV2
export struct TextAreaExample {
  @Local textValue: string = ''

  build() {
    Column({ space: 16 }) {
      Text('TextArea 示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      TextArea({ placeholder: '请输入多行文本', text: this.textValue })
        .width('100%')
        .height(100)
        .onChange((value: string) => {
          this.textValue = value
        })

      Text(`${this.textValue.length} 字符`)
        .fontSize(14)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * Checkbox 示例
 */
@ComponentV2
export struct CheckboxExample {
  @Local isChecked: boolean = false

  build() {
    Column({ space: 16 }) {
      Text('Checkbox 示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

        Row({ space: 16 }) {
          Checkbox({ name: 'check1' })
            .select(this.isChecked)
            .selectedColor('#007DFF')
            .onChange((value: boolean) => {
              this.isChecked = value
            })

          Text(this.isChecked ? '已选中' : '未选中')
            .fontSize(16)
        }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * Radio 示例
 */
@ComponentV2
export struct RadioExample {
  @Local selected: string = 'option1'

  build() {
    Column({ space: 16 }) {
      Text('Radio 示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Row({ space: 16 }) {
        Radio({ value: 'option1', group: 'radioGroup' })
          .checked(this.selected === 'option1')
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.selected = 'option1'
            }
          })
        Text('选项 1')

        Radio({ value: 'option2', group: 'radioGroup' })
          .checked(this.selected === 'option2')
          .onChange((isChecked: boolean) => {
            if (isChecked) {
              this.selected = 'option2'
            }
          })
        Text('选项 2')
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 主页面
 */
@ComponentV2
export struct InputExamplePage {
  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          Text('Input Component Examples')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .padding({ left: 16, right: 16, top: 16, bottom: 8 })

          TextInputExample()
          TextAreaExample()
          CheckboxExample()
          RadioExample()
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
    }
    .title('Input 输入组件示例')
    .mode(NavDestinationMode.STANDARD)
  }
}

@Builder
export function InputExamplePageBuilder() {
  InputExamplePage()
}
