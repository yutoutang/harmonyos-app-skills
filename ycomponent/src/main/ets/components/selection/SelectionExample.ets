/**
 * Selection Component Examples
 * OpenHarmony 选择组件使用示例
 */

/**
 * Toggle 示例
 */
@ComponentV2
export struct ToggleExample {
  @Local isOn: boolean = false

  build() {
    Column({ space: 16 }) {
      Text('Toggle 示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Toggle({ type: ToggleType.Switch, isOn: this.isOn })
        .onChange((isOn: boolean) => {
          this.isOn = isOn
        })

      Text(this.isOn ? '开启' : '关闭')
        .fontSize(14)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * Slider 示例
 */
@ComponentV2
export struct SliderExample {
  @Local value: number = 50

  build() {
    Column({ space: 16 }) {
      Text('Slider 示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Slider({
        value: this.value,
        min: 0,
        max: 100,
        step: 1
      })
        .blockColor('#007DFF')
        .trackColor('#E0E0E0')
        .selectedColor('#007DFF')
        .showSteps(true)
        .onChange((value: number) => {
          this.value = value
        })

      Text(`值: ${this.value}`)
        .fontSize(14)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * Rating 示例
 */
@ComponentV2
export struct RatingExample {
  @Local rating: number = 3

  build() {
    Column({ space: 16 }) {
      Text('Rating 示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Rating({
        rating: this.rating,
        indicator: false
      })
        .stars(5)
        .stepSize(1)
        .onChange((value: number) => {
          this.rating = value
        })

      Text(`评分: ${this.rating}`)
        .fontSize(14)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * Progress 示例
 */
@ComponentV2
export struct ProgressExample {
  @Local progress: number = 60

  build() {
    Column({ space: 16 }) {
      Text('Progress 示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Progress({ value: this.progress, total: 100 })
        .width('100%')
        .color('#007DFF')

      Text(`进度: ${this.progress}%`)
        .fontSize(14)
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
export struct SelectionExamplePage {
  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          Text('Selection Component Examples')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .padding({ left: 16, right: 16, top: 16, bottom: 8 })

          ToggleExample()
          SliderExample()
          RatingExample()
          ProgressExample()
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
    }
    .title('Selection 选择组件示例')
    .mode(NavDestinationMode.STANDARD)
  }
}

@Builder
export function SelectionExamplePageBuilder() {
  SelectionExamplePage()
}
