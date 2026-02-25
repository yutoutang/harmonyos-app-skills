/**
 * Curves Component Examples
 * OpenHarmony Curves API 使用示例
 *
 * 展示 Curves API 的各种用法，包括预定义曲线、贝塞尔曲线、弹簧曲线和自定义曲线
 */

import curves from '@ohos.curves'

/**
 * 预定义曲线示例组件
 * 展示所有预定义曲线类型
 */
@ComponentV2
export struct PredefinedCurvesExample {
  @Local animatedValue: number = 0
  @Local isAnimating: boolean = false

  build() {
    Column({ space: 16 }) {
      Text('预定义曲线 (Predefined Curves)')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      Grid() {
        GridItem() {
          this.CurveButton('Linear', Curve.Linear, '#007DFF')
        }
        GridItem() {
          this.CurveButton('Ease', Curve.Ease, '#28A745')
        }
        GridItem() {
          this.CurveButton('EaseIn', Curve.EaseIn, '#17A2B8')
        }
        GridItem() {
          this.CurveButton('EaseOut', Curve.EaseOut, '#6C757D')
        }
        GridItem() {
          this.CurveButton('EaseInOut', Curve.EaseInOut, '#FFC107')
        }
        GridItem() {
          this.CurveButton('FastOutSlowIn', Curve.FastOutSlowIn, '#343A40')
        }
        GridItem() {
          this.CurveButton('Sharp', Curve.Sharp, '#E83E8C')
        }
      }
      .columnsTemplate('1fr 1fr 1fr')
      .rowsGap(12)
      .columnsGap(12)

      // 动画演示区域
      Column() {
        Text(`动画值: ${this.animatedValue.toFixed(2)}`)
          .fontSize(16)
          .margin({ bottom: 8 })

        Row() {
          Rect()
            .width(this.animatedValue * 2)
            .height(40)
            .fill('#007DFF')
            .radius(8)
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)
      }
      .width('100%')
      .height(80)
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }

  @Builder
  CurveButton(name: string, curveType: Curve, color: string) {
    Button(name)
      .width('100%')
      .height(40)
      .backgroundColor(color)
      .fontColor(Color.White)
      .onClick(() => {
        this.animateWithCurve(curveType)
      })
  }

  animateWithCurve(curveType: Curve) {
    if (this.isAnimating) return

    this.isAnimating = true
    curves.initCurve(curveType)
    this.animatedValue = 100
    setTimeout(() => {
      this.animatedValue = 0
      this.isAnimating = false
    }, 2000)
  }
}

/**
 * 贝塞尔曲线示例组件
 * 展示自定义贝塞尔曲线的创建和使用
 */
@ComponentV2
export struct BezierCurvesExample {
  @Local animatedValue: number = 0
  @Local isAnimating: boolean = false

  build() {
    Column({ space: 16 }) {
      Text('贝塞尔曲线 (Bezier Curves)')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // 预设贝塞尔曲线
      Column({ space: 12 }) {
        Text('预设贝塞尔曲线')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 8 })

        Row({ space: 12 }) {
          this.BezierCurveButton('Ease', 0.25, 0.1, 0.25, 1.0, '#007DFF')
          this.BezierCurveButton('Sharp', 0.4, 0.0, 0.6, 1.0, '#28A745')
          this.BezierCurveButton('Bounce', 0.68, -0.55, 0.265, 1.55, '#FFC107')
        }
        .width('100%')
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      // 自定义贝塞尔曲线
      Column({ space: 12 }) {
        Text('自定义贝塞尔曲线')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 8 })

        Row({ space: 12 }) {
          this.BezierCurveButton('Custom 1', 0.17, 0.67, 0.83, 0.67, '#E91E63')
          this.BezierCurveButton('Custom 2', 0.95, 0.05, 0.795, 0.035, '#9C27B0')
        }
        .width('100%')
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      // 动画演示区域
      Column() {
        Text(`动画进度: ${(this.animatedValue * 100).toFixed(0)}%`)
          .fontSize(16)
          .margin({ bottom: 8 })

        Row() {
          Rect()
            .width(this.animatedValue * 300)
            .height(40)
            .fill('#007DFF')
            .radius(8)
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)
      }
      .width('100%')
      .height(80)
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }

  @Builder
  BezierCurveButton(name: string, x1: number, y1: number, x2: number, y2: number, color: string) {
    Button(name)
      .width('100%')
      .height(40)
      .backgroundColor(color)
      .fontColor(Color.White)
      .onClick(() => {
        this.animateWithBezierCurve(x1, y1, x2, y2)
      })
  }

  animateWithBezierCurve(x1: number, y1: number, x2: number, y2: number) {
    if (this.isAnimating) return

    this.isAnimating = true
    curves.cubicBezierCurve(x1, y1, x2, y2)
    this.animatedValue = 1.0
    setTimeout(() => {
      this.animatedValue = 0
      this.isAnimating = false
    }, 1700)
  }
}

/**
 * 弹簧曲线示例组件
 * 展示物理弹簧动画效果
 */
@ComponentV2
export struct SpringCurvesExample {
  @Local scaleValue: number = 1.0
  @Local isAnimating: boolean = false

  build() {
    Column({ space: 16 }) {
      Text('弹簧曲线 (Spring Curves)')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // 弹簧动画按钮
      Column({ space: 12 }) {
        Text('弹簧动画效果')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 8 })

        Row({ space: 12 }) {
          this.SpringButton('弹性', 0.5, 1.0, 0.8, 0.6, '#007DFF')
          this.SpringButton('重物', 0.5, 3.0, 1.0, 0.8, '#28A745')
          this.SpringButton('轻物', 1.0, 0.5, 0.5, 0.7, '#FFC107')
          this.SpringButton('阻尼', 0.0, 1.0, 1.0, 1.0, '#6C757D')
        }
        .width('100%')
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      // 弹簧运动
      Column({ space: 12 }) {
        Text('弹簧运动 (Spring Motion)')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 8 })

        Row({ space: 12 }) {
          this.SpringMotionButton('响应式', 0.15, 0.86, 0.25, '#007DFF')
          this.SpringMotionButton('快速', 0.1, 0.8, 0.1, '#28A745')
          this.SpringMotionButton('慢速', 0.4, 0.9, 0.2, '#FFC107')
        }
        .width('100%')
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      // 动画演示区域
      Column() {
        Text(`缩放值: ${this.scaleValue.toFixed(2)}x`)
          .fontSize(16)
          .margin({ bottom: 8 })

        Column() {
          Circle({ width: 80, height: 80 })
            .fill('#007DFF')
            .scale({ x: this.scaleValue, y: this.scaleValue })
        }
        .width('100%')
        .height(100)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height(120)
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }

  @Builder
  SpringButton(name: string, velocity: number, mass: number, stiffness: number, damping: number, color: string) {
    Button(name)
      .width('100%')
      .height(40)
      .backgroundColor(color)
      .fontColor(Color.White)
      .onClick(() => {
        this.animateWithSpring(velocity, mass, stiffness, damping)
      })
  }

  @Builder
  SpringMotionButton(name: string, response: number, dampingFraction: number, overlapDuration: number, color: string) {
    Button(name)
      .width('100%')
      .height(40)
      .backgroundColor(color)
      .fontColor(Color.White)
      .onClick(() => {
        this.animateWithSpringMotion(response, dampingFraction, overlapDuration)
      })
  }

  animateWithSpring(velocity: number, mass: number, stiffness: number, damping: number) {
    if (this.isAnimating) return

    this.isAnimating = true
    curves.springCurve(velocity, mass, stiffness, damping)
    this.scaleValue = 1.5
    setTimeout(() => {
      this.scaleValue = 1.0
      this.isAnimating = false
    }, 2300)
  }

  animateWithSpringMotion(response: number, dampingFraction: number, overlapDuration: number) {
    if (this.isAnimating) return

    this.isAnimating = true
    curves.springMotion(response, dampingFraction, overlapDuration)
    this.scaleValue = 1.3
    setTimeout(() => {
      this.scaleValue = 1.0
      this.isAnimating = false
    }, 1200)
  }
}

/**
 * 步进曲线和自定义曲线示例组件
 */
@ComponentV2
export struct CustomCurvesExample {
  @Local animatedValue: number = 0
  @Local isAnimating: boolean = false

  build() {
    Column({ space: 16 }) {
      Text('步进和自定义曲线 (Step & Custom Curves)')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // 步进曲线
      Column({ space: 12 }) {
        Text('步进曲线')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 8 })

        Row({ space: 12 }) {
          this.StepCurveButton('2步-起点', 2, false, '#007DFF')
          this.StepCurveButton('3步-终点', 3, true, '#28A745')
          this.StepCurveButton('5步-起点', 5, false, '#FFC107')
        }
        .width('100%')
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      // 自定义曲线
      Column({ space: 12 }) {
        Text('自定义曲线')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 8 })

        Row({ space: 12 }) {
          this.CustomCurveButton('指数', (fraction: number) => Math.pow(fraction, 2), '#E91E63')
          this.CustomCurveButton('二次方', (fraction: number) => Math.pow(fraction, 0.5), '#9C27B0')
          this.CustomCurveButton('弹性', (fraction: number) => {
            return fraction < 0.5 
              ? 4 * fraction * fraction * fraction 
              : 1 - Math.pow(-2 * fraction + 2, 2)
          }, '#673AB7')
        }
        .width('100%')
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      // 动画演示区域
      Column() {
        Text(`进度: ${(this.animatedValue * 100).toFixed(0)}%`)
          .fontSize(16)
          .margin({ bottom: 8 })

        Row() {
          Rect()
            .width(this.animatedValue * 300)
            .height(40)
            .fill('#007DFF')
            .radius(8)
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)
      }
      .width('100%')
      .height(80)
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }

  @Builder
  StepCurveButton(name: string, count: number, end: boolean, color: string) {
    Button(name)
      .width('100%')
      .height(40)
      .backgroundColor(color)
      .fontColor(Color.White)
      .onClick(() => {
        this.animateWithStepCurve(count, end)
      })
  }

  @Builder
  CustomCurveButton(name: string, interpolate: (fraction: number) => number, color: string) {
    Button(name)
      .width('100%')
      .height(40)
      .backgroundColor(color)
      .fontColor(Color.White)
      .onClick(() => {
        this.animateWithCustomCurve(interpolate)
      })
  }

  animateWithStepCurve(count: number, end: boolean) {
    if (this.isAnimating) return

    this.isAnimating = true
    curves.stepsCurve(count, end)
    this.animatedValue = 1.0
    setTimeout(() => {
      this.animatedValue = 0
      this.isAnimating = false
    }, 2000)
  }

  animateWithCustomCurve(interpolate: (fraction: number) => number) {
    if (this.isAnimating) return

    this.isAnimating = true
    curves.customCurve(interpolate)
    this.animatedValue = 1.0
    setTimeout(() => {
      this.animatedValue = 0
      this.isAnimating = false
    }, 2000)
  }
}

/**
 * 完整的曲线示例页面
 * 集成所有曲线示例
 */
@ComponentV2
export struct CurvesExamplePage {
  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          Text('Curves API Examples')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .padding({ left: 16, right: 16, top: 16, bottom: 8 })

          PredefinedCurvesExample()
          BezierCurvesExample()
          SpringCurvesExample()
          CustomCurvesExample()
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
    }
    .title('Curves 曲线动画示例')
    .mode(NavDestinationMode.STANDARD)
  }
}

@Builder
export function CurvesExamplePageBuilder() {
  CurvesExamplePage()
}
