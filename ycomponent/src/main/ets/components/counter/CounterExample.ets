/**
 * Counter Component Examples
 * OpenHarmony 计数器组件使用示例
 */

/**
 * 基础 Counter 示例
 */
@ComponentV2
export struct BasicCounterExample {
  @Local count: number = 1

  build() {
    Column({ space: 16 }) {
      Text('基础 Counter')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 基础计数器
      Counter() {
        Text(`${this.count}`)
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
      }
      .height(40)
      .onInc(() => {
        this.count++
      })
      .onDec(() => {
        if (this.count > 1) {
          this.count--
        }
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
 */
@ComponentV2
export struct ProductCounterExample {
  @Local quantity: number = 1
  readonly price: number = 99
  readonly maxQuantity: number = 10

  // 计算总价
  getTotalPrice(): number {
    return this.quantity * this.price
  }

  build() {
    Column({ space: 20 }) {
      Text('商品数量选择')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)

      // 商品信息
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

      // 总价显示
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
 * 带范围限制的 Counter
 */
@ComponentV2
export struct RangedCounterExample {
  @Local count: number = 5
  readonly minValue: number = 0
  readonly maxValue: number = 100

  build() {
    Column({ space: 16 }) {
      Text('范围限制 Counter')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 显示范围
      Text(`范围: ${this.minValue} - ${this.maxValue}`)
        .fontSize(14)
        .fontColor('#666666')

      Counter() {
        Text(`${this.count}`)
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .width(60)
          .textAlign(TextAlign.Center)
      }
      .height(45)
      .onInc(() => {
        if (this.count < this.maxValue) {
          this.count++
        }
      })
      .onDec(() => {
        if (this.count > this.minValue) {
          this.count--
        }
      })

      // 进度条显示
      Progress({
        value: this.count,
        total: this.maxValue,
        type: ProgressType.Linear
      })
        .width('100%')
        .color('#007DFF')

      Text(`当前值: ${this.count}`)
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
 * 自定义样式 Counter
 */
@ComponentV2
export struct CustomStyleCounterExample {
  @Local count1: number = 1
  @Local count2: number = 10
  @Local count3: number = 5

  build() {
    Column({ space: 20 }) {
      Text('自定义样式 Counter')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 小尺寸
      Column({ space: 8 }) {
        Text('小尺寸')
          .fontSize(14)
          .fontColor('#666666')

        Counter() {
          Text(`${this.count1}`)
            .fontSize(16)
            .width(30)
            .textAlign(TextAlign.Center)
        }
        .height(32)
        .onInc(() => {
          this.count1++
        })
        .onDec(() => {
          if (this.count1 > 1) {
            this.count1--
          }
        })
      }
      .alignItems(HorizontalAlign.Start)

      // 大尺寸
      Column({ space: 8 }) {
        Text('大尺寸')
          .fontSize(14)
          .fontColor('#666666')

        Counter() {
          Text(`${this.count2}`)
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width(50)
            .textAlign(TextAlign.Center)
        }
        .height(50)
        .backgroundColor('#E3F2FD')
        .onInc(() => {
          this.count2++
        })
        .onDec(() => {
          if (this.count2 > 0) {
            this.count2--
          }
        })
      }
      .alignItems(HorizontalAlign.Start)

      // 带背景色
      Column({ space: 8 }) {
        Text('自定义背景色')
          .fontSize(14)
          .fontColor('#666666')

        Counter() {
          Text(`${this.count3}`)
            .fontSize(18)
            .width(40)
            .textAlign(TextAlign.Center)
        }
        .height(40)
        .backgroundColor('#FFF3E0')
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 步长设置示例
 */
@ComponentV2
export struct StepSizeCounterExample {
  @Local count1: number = 0
  @Local count2: number = 0
  @Local count3: number = 0

  build() {
    Column({ space: 20 }) {
      Text('步长设置 Counter')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 步长 1
      Column({ space: 8 }) {
        Text('步长: 1')
          .fontSize(14)
          .fontColor('#666666')

        Counter() {
          Text(`${this.count1}`)
            .fontSize(18)
            .width(40)
            .textAlign(TextAlign.Center)
        }
        .height(40)
        .onInc(() => {
          this.count1 += 1
        })
        .onDec(() => {
          this.count1 = Math.max(0, this.count1 - 1)
        })
      }
      .alignItems(HorizontalAlign.Start)

      // 步长 5
      Column({ space: 8 }) {
        Text('步长: 5')
          .fontSize(14)
          .fontColor('#666666')

        Counter() {
          Text(`${this.count2}`)
            .fontSize(18)
            .width(40)
            .textAlign(TextAlign.Center)
        }
        .height(40)
        .onInc(() => {
          this.count2 += 5
        })
        .onDec(() => {
          this.count2 = Math.max(0, this.count2 - 5)
        })
      }
      .alignItems(HorizontalAlign.Start)

      // 步长 10
      Column({ space: 8 }) {
        Text('步长: 10')
          .fontSize(14)
          .fontColor('#666666')

        Counter() {
          Text(`${this.count3}`)
            .fontSize(18)
            .width(40)
            .textAlign(TextAlign.Center)
        }
        .height(40)
        .onInc(() => {
          this.count3 += 10
        })
        .onDec(() => {
          this.count3 = Math.max(0, this.count3 - 10)
        })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 购物车商品数量管理
 */
@ComponentV2
export struct CartItemCounter {
  @Local quantity: number = 1
  @Param productName: string = '商品名称'
  @Param price: number = 0
  @Param stock: number = 100

  build() {
    Row({ space: 12 }) {
      Column({ space: 4 }) {
        Text(this.productName)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)

        Text(`库存 ${this.stock} 件`)
          .fontSize(12)
          .fontColor('#999999')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Column({ space: 8 }) {
        Text(`¥${this.price}`)
          .fontSize(16)
          .fontColor('#FF5722')
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .textAlign(TextAlign.End)

        Counter() {
          Text(`${this.quantity}`)
            .fontSize(14)
            .width(30)
            .textAlign(TextAlign.Center)
        }
        .height(32)
        .backgroundColor('#F5F5F5')
        .enabled(this.stock > 0)
        .onInc(() => {
          if (this.quantity < this.stock) {
            this.quantity++
          }
        })
        .onDec(() => {
          if (this.quantity > 1) {
            this.quantity--
          }
        })
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#FAFAFA')
    .borderRadius(8)
  }
}

/**
 * 时间调整 Counter
 */
@ComponentV2
export struct TimeAdjustCounter {
  @Local hours: number = 0
  @Local minutes: number = 0
  @Local seconds: number = 0

  // 格式化时间
  formatTime(): string {
    const h = this.hours.toString().padStart(2, '0')
    const m = this.minutes.toString().padStart(2, '0')
    const s = this.seconds.toString().padStart(2, '0')
    return `${h}:${m}:${s}`
  }

  build() {
    Column({ space: 20 }) {
      Text('时间调整')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 时间显示
      Text(this.formatTime())
        .fontSize(36)
        .fontWeight(FontWeight.Bold)
        .fontFamily('monospace')

      // 小时调整
      Row({ space: 12 }) {
        Text('小时')
          .fontSize(16)
          .width(60)

        Counter() {
          Text(`${this.hours}`)
            .fontSize(18)
            .width(40)
            .textAlign(TextAlign.Center)
        }
        .height(36)
        .onInc(() => {
          this.hours = (this.hours + 1) % 24
        })
        .onDec(() => {
          this.hours = (this.hours + 23) % 24
        })
      }
      .width('100%')

      // 分钟调整
      Row({ space: 12 }) {
        Text('分钟')
          .fontSize(16)
          .width(60)

        Counter() {
          Text(`${this.minutes}`)
            .fontSize(18)
            .width(40)
            .textAlign(TextAlign.Center)
        }
        .height(36)
        .onInc(() => {
          this.minutes = (this.minutes + 1) % 60
        })
        .onDec(() => {
          this.minutes = (this.minutes + 59) % 60
        })
      }
      .width('100%')

      // 秒钟调整
      Row({ space: 12 }) {
        Text('秒钟')
          .fontSize(16)
          .width(60)

        Counter() {
          Text(`${this.seconds}`)
            .fontSize(18)
            .width(40)
            .textAlign(TextAlign.Center)
        }
        .height(36)
        .onInc(() => {
          this.seconds = (this.seconds + 1) % 60
        })
        .onDec(() => {
          this.seconds = (this.seconds + 59) % 60
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
 * 主页面
 */
@ComponentV2
export struct CounterExamplePage {
  build() {
    Scroll() {
      Column({ space: 20 }) {
        Text('Counter Component Examples')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .padding({ left: 16, right: 16, top: 16, bottom: 8 })

        BasicCounterExample()
        ProductCounterExample()
        RangedCounterExample()
        CustomStyleCounterExample()
        StepSizeCounterExample()

        Text('购物车商品管理')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .padding({ left: 16 })

        CartItemCounter({ productName: '苹果手机', price: 5999, stock: 10 })
        CartItemCounter({ productName: '笔记本电脑', price: 7999, stock: 5 })

        TimeAdjustCounter()
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
