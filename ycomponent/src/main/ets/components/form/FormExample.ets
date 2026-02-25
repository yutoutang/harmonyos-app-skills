/**
 * Form Component Examples
 * OpenHarmony Form Components 使用示例
 *
 * 展示表单相关组件的各种用法，包括 Stepper、StepperItem、Counter、CalendarPicker
 */

/**
 * Stepper 步骤条基础示例
 * 展示步骤导航组件的基本用法
 */
@ComponentV2
export struct BasicStepperExample {
  @Local currentIndex: number = 0

  build() {
    Column({ space: 20 }) {
      Text('Stepper 步骤条')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .width('100%')

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

      Text(`当前步骤: ${this.currentIndex + 1}`)
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
 * Counter 计数器基础示例
 * 展示数量增减组件的基本用法
 */
@ComponentV2
export struct BasicCounterExample {
  @Local count: number = 1

  build() {
    Column({ space: 16 }) {
      Text('Counter 计数器')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Counter() {
        Text(`${this.count}`)
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .width(50)
          .textAlign(TextAlign.Center)
      }
      .height(40)
      .backgroundColor('#F5F5F5')
      .onInc(() => {
        this.count++
      })
      .onDec(() => {
        this.count--
      })

      Text(`当前数量: ${this.count}`)
        .fontSize(16)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 商品数量选择示例
 * 展示 Counter 在电商场景的应用
 */
@ComponentV2
export struct ProductCounterExample {
  @Local quantity: number = 1
  readonly price: number = 99
  readonly maxQuantity: number = 10

  getTotalPrice(): number {
    return this.quantity * this.price
  }

  build() {
    Column({ space: 20 }) {
      Text('商品数量选择')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Row() {
        Column({ space: 8 }) {
          Text('精选商品')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)

          Text(`¥${this.price}`)
            .fontSize(20)
            .fontColor('#FF5722')
            .fontWeight(FontWeight.Bold)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Counter() {
          Text(`${this.quantity}`)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .width(40)
            .textAlign(TextAlign.Center)
        }
        .height(36)
        .backgroundColor('#F5F5F5')
        .onInc(() => {
          if (this.quantity < this.maxQuantity) {
            this.quantity++
          }
        })
        .onDec(() => {
          if (this.quantity > 1) {
            this.quantity--
          }
        })
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FAFAFA')
      .borderRadius(8)

      Row() {
        Text('总价:')
          .fontSize(16)
          .fontColor('#666666')

        Text(`¥${this.getTotalPrice()}`)
          .fontSize(24)
          .fontColor('#FF5722')
          .fontWeight(FontWeight.Bold)
          .margin({ left: 8 })
      }

      Text(`库存: ${this.maxQuantity} 件`)
        .fontSize(14)
        .fontColor('#999999')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}


/**
 * CalendarPicker 日历选择器基础示例
 * 展示日期选择组件的基本用法
 */
@ComponentV2
export struct BasicCalendarPickerExample {
  @Local selectedDate: Date = new Date()

  build() {
    Column({ space: 20 }) {
      Text('CalendarPicker 日历选择器')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      CalendarPicker()
        .width('100%')
        .height(350)
        .onChange((value: Date) => {
          this.selectedDate = value
          console.info('选中的日期: ' + value.toString())
        })

      if (this.selectedDate) {
        Text(`选中日期: ${this.selectedDate.toString().substring(0, 10)}`)
          .fontSize(18)
          .fontColor('#007DFF')
          .fontWeight(FontWeight.Medium)
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * CalendarPicker 简化示例
 * 展示日期选择组件的基本用法
 */
@ComponentV2
export struct SimpleCalendarPickerExample {
  @Local selectedDate: Date = new Date()

  build() {
    Column({ space: 20 }) {
      Text('CalendarPicker 日历')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      CalendarPicker()
        .width('100%')
        .height(300)
        .onChange((value: Date) => {
          this.selectedDate = value
        })

      Text(`选中日期: ${this.selectedDate.toString().substring(0, 10)}`)
        .fontSize(16)
        .fontColor('#007DFF')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 表单向导示例
 * 展示 Stepper 在表单分步填写中的应用
 */
@ComponentV2
export struct FormWizardExample {
  @Local currentIndex: number = 0
  @Local username: string = ''
  @Local password: string = ''
  @Local email: string = ''

  build() {
    Column({ space: 16 }) {
      Text('表单向导')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Stepper({ index: this.currentIndex }) {
        StepperItem() {
          Column({ space: 16 }) {
            Text('账号信息')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)

            Column({ space: 8 }) {
              Text('用户名')
                .fontSize(14)
                .width('100%')

              TextInput({ placeholder: '请输入用户名', text: this.username })
                .width('100%')
                .height(40)
                .onChange((value: string) => {
                  this.username = value
                })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding(16)
        }

        StepperItem() {
          Column({ space: 16 }) {
            Text('安全设置')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)

            Column({ space: 8 }) {
              Text('密码')
                .fontSize(14)
                .width('100%')

              TextInput({ placeholder: '请输入密码', text: this.password })
                .width('100%')
                .height(40)
                .type(InputType.Password)
                .onChange((value: string) => {
                  this.password = value
                })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding(16)
        }

        StepperItem() {
          Column({ space: 16 }) {
            Text('联系信息')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)

            Column({ space: 8 }) {
              Text('邮箱')
                .fontSize(14)
                .width('100%')

              TextInput({ placeholder: '请输入邮箱', text: this.email })
                .width('100%')
                .height(40)
                .type(InputType.Email)
                .onChange((value: string) => {
                  this.email = value
                })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding(16)
        }
        .nextLabel('完成')
      }
      .onFinish(() => {
        console.info('注册完成')
      })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 购物车计数器组示例
 * 展示多个 Counter 的使用
 */
@ComponentV2
export struct CartCountersExample {
  @Local item1Count: number = 1
  @Local item2Count: number = 1
  @Local item3Count: number = 1

  getTotal(): number {
    return this.item1Count * 99 + this.item2Count * 199 + this.item3Count * 299
  }

  build() {
    Column({ space: 16 }) {
      Text('购物车')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 商品 1
      Row({ space: 12 }) {
        Column({ space: 4 }) {
          Text('商品 A')
            .fontSize(16)
          Text('¥99')
            .fontSize(14)
            .fontColor('#FF5722')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Counter() {
          Text(`${this.item1Count}`)
            .fontSize(16)
            .width(30)
            .textAlign(TextAlign.Center)
        }
        .height(32)
        .backgroundColor('#F5F5F5')
        .onInc(() => {
          this.item1Count++
        })
        .onDec(() => {
          if (this.item1Count > 1) {
            this.item1Count--
          }
        })
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#FAFAFA')
      .borderRadius(8)

      // 商品 2
      Row({ space: 12 }) {
        Column({ space: 4 }) {
          Text('商品 B')
            .fontSize(16)
          Text('¥199')
            .fontSize(14)
            .fontColor('#FF5722')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Counter() {
          Text(`${this.item2Count}`)
            .fontSize(16)
            .width(30)
            .textAlign(TextAlign.Center)
        }
        .height(32)
        .backgroundColor('#F5F5F5')
        .onInc(() => {
          this.item2Count++
        })
        .onDec(() => {
          if (this.item2Count > 1) {
            this.item2Count--
          }
        })
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#FAFAFA')
      .borderRadius(8)

      // 总计
      Row() {
        Text('总计:')
          .fontSize(16)
          .fontColor('#666666')

        Text(`¥${this.item1Count * 99 + this.item2Count * 199}`)
          .fontSize(20)
          .fontColor('#FF5722')
          .fontWeight(FontWeight.Bold)
          .margin({ left: 8 })
      }
      .width('100%')
      .padding(12)
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}


/**
 * 简单预约示例
 * 展示日期选择在预约场景的应用
 */
@ComponentV2
export struct SimpleAppointmentExample {
  @Local selectedDate: Date = new Date()

  build() {
    Column({ space: 16 }) {
      Text('预约日历')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      CalendarPicker()
        .width('100%')
        .height(300)
        .onChange((value: Date) => {
          this.selectedDate = value
        })

      Column({ space: 12 }) {
        Text('预约信息')
          .fontSize(16)
          .fontColor('#666666')
          .width('100%')

        Column({ space: 8 }) {
          Text(`预约日期: ${this.selectedDate.toString().substring(0, 10)}`)
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
          .height(40)
          .type(ButtonType.Capsule)
          .backgroundColor('#28A745')
          .fontColor(Color.White)
          .onClick(() => {
            console.info(`预约成功: ${this.selectedDate.toString().substring(0, 10)}`)
          })
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
 * 完整的表单组件示例页面
 * 集成所有表单组件示例
 */
@ComponentV2
export struct FormExamplePage {
  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          Text('Form Component Examples')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .padding({ left: 16, right: 16, top: 16, bottom: 8 })

          BasicStepperExample()
          BasicCounterExample()
          ProductCounterExample()
          BasicCalendarPickerExample()
          SimpleCalendarPickerExample()
          FormWizardExample()
          CartCountersExample()
          SimpleAppointmentExample()
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
    }
    .title('Form 表单组件')
    .mode(NavDestinationMode.STANDARD)
  }
}

@Builder
export function FormExamplePageBuilder() {
  FormExamplePage()
}
