/**
 * XComponent Component Examples
 * OpenHarmony XComponent Component 使用示例
 *
 * XComponent 是嵌入式原生组件，用于加载 C++ 绘制的内容
 * 适用于游戏开发、OpenGL/Vulkan 渲染、视频处理等场景
 */

/**
 * 基础 XComponent 示例
 * 展示 XComponent 的基本用法
 */
@ComponentV2
export struct BasicXComponentExample {
  @Local xComponentId: string = 'xcomponent_surface'
  @Local surfaceWidth: number = 0
  @Local surfaceHeight: number = 0
  @Local isInitialized: boolean = false

  build() {
    Column({ space: 12 }) {
      Text('基础 XComponent')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')

      // 尺寸信息
      if (this.isInitialized) {
        Row({ space: 12 }) {
          Row({ space: 4 }) {
            Text('宽度:')
              .fontSize(12)
              .fontColor('#666666')
            Text(`${this.surfaceWidth}px`)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
          }

          Row({ space: 4 }) {
            Text('高度:')
              .fontSize(12)
              .fontColor('#666666')
            Text(`${this.surfaceHeight}px`)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
          }
        }
        .width('100%')
        .padding(8)
        .backgroundColor('#E8F5E9')
        .borderRadius(6)
      }

      // XComponent 占位符
      Column() {
        Text('XComponent 容器区域')
          .fontSize(14)
          .fontColor('#999999')
          .textAlign(TextAlign.Center)
        Text('需要配置 native C++ 项目')
          .fontSize(12)
          .fontColor('#CCCCCC')
          .margin({ top: 4 })
      }
      .width('100%')
      .height(200)
      .justifyContent(FlexAlign.Center)
      .padding(32)
      .border({ width: 2, color: '#DDDDDD', style: BorderStyle.Dashed })
      .borderRadius(8)
      .backgroundColor('#FAFAFA')

      // 说明文本
      Column({ space: 8 }) {
        Text('⚠ 需要配置:')
          .fontSize(13)
          .fontWeight(FontWeight.Medium)
          .fontColor('#F57C00')
        Text('• CMakeLists.txt')
          .fontSize(12)
          .fontColor('#666666')
        Text('• .so 动态库')
          .fontSize(12)
          .fontColor('#666666')
        Text('• build-profile.json5')
          .fontSize(12)
          .fontColor('#666666')
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#FFF3E0')
      .borderRadius(8)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .margin({ bottom: 8 })
  }
}

/**
 * 可调整大小 XComponent 示例
 * 展示如何动态调整 XComponent 尺寸
 */
@ComponentV2
export struct ResizableXComponentExample {
  @Local componentHeight: number = 250

  build() {
    Column({ space: 12 }) {
      Text('可调整大小')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')

      // 控制按钮
      Row({ space: 12 }) {
        Button('放大')
          .fontSize(14)
          .onClick(() => {
            if (this.componentHeight < 500) {
              this.componentHeight += 50
            }
          })

        Text(`${this.componentHeight}px`)
          .fontSize(14)
          .fontColor('#666666')
          .width(70)
          .textAlign(TextAlign.Center)

        Button('缩小')
          .fontSize(14)
          .onClick(() => {
            if (this.componentHeight > 150) {
              this.componentHeight -= 50
            }
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      // XComponent 占位符
      Column() {
        Text('XComponent 容器')
          .fontSize(14)
          .fontColor('#999999')
      }
      .width('100%')
      .height(this.componentHeight)
      .justifyContent(FlexAlign.Center)
      .border({ width: 2, color: '#DDDDDD', style: BorderStyle.Dashed })
      .borderRadius(8)
      .animation({ duration: 300, curve: Curve.EaseInOut })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * 应用场景卡片
 */
@ComponentV2
export struct UseCaseCard {
  @Param title: string = ''
  @Param description: string = ''
  @Param icon: string = ''
  @Param color: string = '#2196F3'

  build() {
    Row({ space: 12 }) {
      Text(this.icon)
        .fontSize(24)
        .width(45)
        .height(45)
        .textAlign(TextAlign.Center)
        .backgroundColor(this.color)
        .fontColor(Color.White)
        .borderRadius(8)

      Column({ space: 4 }) {
        Text(this.title)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')

        Text(this.description)
          .fontSize(12)
          .fontColor('#666666')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .width('100%')
    .padding(12)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .border({ width: 1, color: '#E0E0E0' })
  }
}

/**
 * 应用场景示例
 */
@ComponentV2
export struct XComponentUseCasesExample {
  build() {
    Column({ space: 12 }) {
      Text('应用场景')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')

      Column({ space: 10 }) {
        UseCaseCard({
          title: '游戏开发',
          description: '使用 OpenGL/Vulkan 进行高性能游戏渲染',
          icon: '🎮',
          color: '#FF5722'
        })

        UseCaseCard({
          title: '视频处理',
          description: '原生视频解码、滤镜处理、编码等',
          icon: '🎬',
          color: '#E91E63'
        })

        UseCaseCard({
          title: '图形渲染',
          description: '复杂图形、图表、数据可视化等',
          icon: '📊',
          color: '#2196F3'
        })

        UseCaseCard({
          title: '音视频通话',
          description: '相机预览、音视频编解码处理',
          icon: '📹',
          color: '#4CAF50'
        })
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * 主页面组件
 */
@ComponentV2
export struct XComponentExamplePage {
  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          Text('XComponent Component Examples')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .padding({ left: 16, right: 16, top: 16, bottom: 8 })

          BasicXComponentExample()
          ResizableXComponentExample()
          XComponentUseCasesExample()
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')
    }
    .title('XComponent 原生组件')
    .mode(NavDestinationMode.STANDARD)
  }
}

@Builder
export function XComponentExamplePageBuilder() {
  XComponentExamplePage()
}
