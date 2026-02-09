/**
 * Button Component Examples
 * OpenHarmony Button Component 使用示例
 *
 * 展示 Button 组件的各种用法，包括不同类型、样式、尺寸和状态
 */

/**
 * 按钮类型示例组件
 * 展示四种不同的按钮类型
 */
@ComponentV2
export struct ButtonTypesExample {
  build() {
    Column({ space: 16 }) {
      Text('Button Types')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // Capsule 按钮
      Button('Capsule Button', { type: ButtonType.Capsule })
        .width('100%')
        .height(45)
        .backgroundColor('#007DFF')
        .fontColor(Color.White)

      // Circle 按钮
      Button('OK', { type: ButtonType.Circle })
        .width(70)
        .height(70)
        .fontSize(20)
        .backgroundColor('#28A745')
        .fontColor(Color.White)

      // Normal 按钮
      Button('Normal Button', { type: ButtonType.Normal })
        .width('100%')
        .height(45)
        .backgroundColor('#6C757D')
        .fontColor(Color.White)

      // ROUNDED_RECTANGLE 按钮 (API 15+)
      Button('Rounded Rect', { type: ButtonType.ROUNDED_RECTANGLE })
        .width('100%')
        .height(45)
        .borderRadius(12)
        .backgroundColor('#FFC107')
        .fontColor(Color.White)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 按钮样式模式示例
 * 展示 NORMAL, EMPHASIZED, TEXTUAL 三种样式
 */
@ComponentV2
export struct ButtonStyleModeExample {
  build() {
    Column({ space: 16 }) {
      Text('Button Style Mode')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // NORMAL 样式
      Button('Normal Style', { buttonStyle: ButtonStyleMode.NORMAL })
        .width('100%')
        .height(45)

      // EMPHASIZED 样式（默认）
      Button('Emphasized Style', { buttonStyle: ButtonStyleMode.EMPHASIZED })
        .width('100%')
        .height(45)

      // TEXTUAL 样式
      Button('Textual Style', { buttonStyle: ButtonStyleMode.TEXTUAL })
        .width('100%')
        .height(45)
        .fontColor('#007DFF')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 按钮角色示例
 * 展示 NORMAL 和 ERROR 角色
 */
@ComponentV2
export struct ButtonRoleExample {
  build() {
    Column({ space: 16 }) {
      Text('Button Role')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // NORMAL 角色
      Button('Normal Action', { role: ButtonRole.NORMAL })
        .width('100%')
        .height(45)
        .type(ButtonType.Capsule)
        .backgroundColor('#007DFF')
        .fontColor(Color.White)

      // ERROR 角色
      Button('Delete', { role: ButtonRole.ERROR })
        .width('100%')
        .height(45)
        .type(ButtonType.Capsule)
        .fontColor(Color.White)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 控件尺寸示例
 * 展示 SMALL 和 NORMAL 两种尺寸
 */
@ComponentV2
export struct ControlSizeExample {
  build() {
    Column({ space: 16 }) {
      Text('Control Size')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // SMALL 尺寸
      Button('Small', { controlSize: ControlSize.SMALL })
        .backgroundColor('#007DFF')
        .fontColor(Color.White)

      // NORMAL 尺寸
      Button('Normal', { controlSize: ControlSize.NORMAL })
        .backgroundColor('#007DFF')
        .fontColor(Color.White)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * Label 样式示例
 * 展示不同的文本样式配置
 */
@ComponentV2
export struct LabelStyleExample {
  build() {
    Column({ space: 16 }) {
      Text('Label Style')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // 基础 label 样式
      Button('Button with Label Style')
        .labelStyle({
          overflow: TextOverflow.Ellipsis,
          maxLines: 1,
          font: {
            size: 16,
            weight: FontWeight.Medium
          }
        })
        .width('100%')
        .height(45)
        .backgroundColor('#007DFF')
        .fontColor(Color.White)

      // 多行文本
      Button('Very Long Button Text That Should Wrap to Multiple Lines')
        .labelStyle({
          maxLines: 2,
          overflow: TextOverflow.Clip,
          font: {
            size: 14
          }
        })
        .width('100%')
        .height(60)
        .backgroundColor('#28A745')
        .fontColor(Color.White)

      // 自定义字体
      Button('Custom Font')
        .labelStyle({
          font: {
            size: 18,
            weight: FontWeight.Bold,
            family: 'sans-serif'
          }
        })
        .width('100%')
        .height(45)
        .backgroundColor('#FFC107')
        .fontColor(Color.White)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 状态效果示例
 * 展示开启和关闭状态效果的对比
 */
@ComponentV2
export struct StateEffectExample {
  build() {
    Column({ space: 16 }) {
      Text('State Effect')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // 开启状态效果
      Button('With Effect', { stateEffect: true })
        .width('100%')
        .height(45)
        .type(ButtonType.Capsule)
        .backgroundColor('#007DFF')
        .fontColor(Color.White)

      // 关闭状态效果
      Button('Without Effect', { stateEffect: false })
        .width('100%')
        .height(45)
        .type(ButtonType.Capsule)
        .backgroundColor('#28A745')
        .fontColor(Color.White)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 自定义内容按钮示例
 * 展示如何创建带图标和文本的自定义按钮
 */
@ComponentV2
export struct CustomContentExample {
  @Local clickCount: number = 0

  build() {
    Column({ space: 16 }) {
      Text('Custom Content')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // 带图标和文本的按钮
      Button() {
        Row({ space: 8 }) {
          Text('\uE641') // 使用 Unicode 图标
            .fontSize(20)
            .fontColor(Color.White)
          Text('Download')
            .fontSize(16)
            .fontColor(Color.White)
        }
      }
      .width('100%')
      .height(45)
      .type(ButtonType.Capsule)
      .backgroundColor('#007DFF')
      .onClick(() => {
        this.clickCount++
        console.info(`Download clicked ${this.clickCount} times`)
      })

      // 纯图标按钮
      Button() {
        Text('\uE8EF') // 搜索图标
          .fontSize(24)
          .fontColor(Color.White)
      }
      .width(50)
      .height(50)
      .type(ButtonType.Circle)
      .backgroundColor('#28A745')

      // 自定义布局按钮
      Button() {
        Row() {
          Column({ space: 4 }) {
            Text('Click Me')
              .fontSize(14)
              .fontColor(Color.White)
            Text(`Count: ${this.clickCount}`)
              .fontSize(12)
              .fontColor(Color.White)
              .opacity(0.8)
          }
          .alignItems(HorizontalAlign.Center)
        }
      }
      .width('100%')
      .height(60)
      .type(ButtonType.Normal)
      .backgroundColor('#FFC107')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 加载状态按钮示例
 * 展示带加载状态的按钮
 */
@ComponentV2
export struct LoadingButtonExample {
  @Local isLoading: boolean = false

  build() {
    Column({ space: 16 }) {
      Text('Loading Button')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      Button() {
        if (this.isLoading) {
          Row({ space: 8 }) {
            LoadingProgress()
              .width(20)
              .height(20)
              .color(Color.White)
            Text('Loading...')
              .fontSize(16)
              .fontColor(Color.White)
          }
        } else {
          Text('Submit')
            .fontSize(16)
            .fontColor(Color.White)
        }
      }
      .width('100%')
      .height(45)
      .type(ButtonType.Capsule)
      .backgroundColor(this.isLoading ? '#CCCCCC' : '#007DFF')
      .enabled(!this.isLoading)
      .onClick(() => {
        if (!this.isLoading) {
          this.isLoading = true
          // 模拟异步操作
          setTimeout(() => {
            this.isLoading = false
            console.info('Submit completed')
          }, 2000)
        }
      })

      Text('Click to see loading state')
        .fontSize(14)
        .fontColor('#666666')
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 按钮组示例
 * 展示如何创建一组相关的按钮
 */
@ComponentV2
export struct ButtonGroupExample {
  @Local selectedIndex: number = 0

  build() {
    Column({ space: 16 }) {
      Text('Button Group')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // 时间选择按钮组
      Row({ space: 8 }) {
        ForEach(['Day', 'Week', 'Month', 'Year'], (item: string, index: number) => {
          Button(item)
            .width(65)
            .height(36)
            .type(ButtonType.Normal)
            .backgroundColor(index === this.selectedIndex ? '#007DFF' : '#E0E0E0')
            .fontColor(index === this.selectedIndex ? Color.White : '#333333')
            .onClick(() => {
              this.selectedIndex = index
              console.info(`Selected: ${item}`)
            })
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)

      // 操作按钮组
      Row({ space: 12 }) {
        Button('Cancel')
          .width('48%')
          .height(45)
          .type(ButtonType.Capsule)
          .backgroundColor('#6C757D')
          .fontColor(Color.White)

        Button('Confirm')
          .width('48%')
          .height(45)
          .type(ButtonType.Capsule)
          .backgroundColor('#007DFF')
          .fontColor(Color.White)
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 完整的按钮示例页面
 * 集成所有按钮示例
 */
@Entry
@ComponentV2
export struct ButtonExamplePage {
  build() {
    Scroll() {
      Column({ space: 20 }) {
        Text('Button Component Examples')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .padding({ left: 16, right: 16, top: 16, bottom: 8 })

        ButtonTypesExample()
        ButtonStyleModeExample()
        ButtonRoleExample()
        ControlSizeExample()
        LabelStyleExample()
        StateEffectExample()
        CustomContentExample()
        LoadingButtonExample()
        ButtonGroupExample()
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
