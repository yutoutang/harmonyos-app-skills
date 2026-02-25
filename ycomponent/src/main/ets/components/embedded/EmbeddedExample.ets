/**
 * EmbeddedComponent/XComponent Component Examples
 * OpenHarmony 嵌入式组件使用示例
 *
 * 本示例展示如何使用 EmbeddedComponent 和 XComponent 组件
 * 注意：这些组件需要特殊的 native 配置和权限设置
 */

import { Want } from '@kit.AbilityKit';

/**
 * 嵌入组件项接口
 */
interface EmbeddedItem {
  name: string
  want: Want
}

/**
 * 用例卡片参数接口
 */
interface UseCaseCardParams {
  title: string
  description: string
  icon: string
  color: string
}

/**
 * 基础 EmbeddedComponent 示例
 * 演示如何嵌入其他 Ability 或组件
 */
@ComponentV2
export struct EmbeddedComponentExample {
  @Local embeddedWant: Want = {
    bundleName: 'com.example.embedded',
    abilityName: 'EmbeddedAbility',
    moduleName: 'entry'
  }
  @Local isLoaded: boolean = false
  @Local errorMessage: string = ''
  @Local componentName: string = ''

  build() {
    Column({ space: 12 }) {
      // 标题和描述
      this.buildHeader()

      // 状态显示
      if (this.isLoaded) {
        this.buildSuccessStatus()
      } else if (this.errorMessage) {
        this.buildErrorStatus()
      }

      // EmbeddedComponent 容器
      this.buildEmbeddedComponent()

      // 说明文本
      this.buildDescription()
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }

  @Builder
  buildHeader() {
    Column({ space: 4 }) {
      Text('EmbeddedComponent 示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Text('用于在应用中嵌入其他组件或应用')
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  buildSuccessStatus() {
    Row({ space: 8 }) {
      Text('✓')
        .fontSize(16)
        .fontColor(Color.Green)

      Text(`已加载: ${this.componentName}`)
        .fontSize(14)
        .fontColor(Color.Green)
        .layoutWeight(1)
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#E8F5E9')
    .borderRadius(8)
  }

  @Builder
  buildErrorStatus() {
    Row({ space: 8 }) {
      Text('✗')
        .fontSize(16)
        .fontColor(Color.Red)

      Text(`错误: ${this.errorMessage}`)
        .fontSize(14)
        .fontColor(Color.Red)
        .layoutWeight(1)
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#FFEBEE')
    .borderRadius(8)
  }

  @Builder
  buildEmbeddedComponent() {
    Column() {
      // 注意：这里使用占位符，实际使用时需要配置有效的 Want
      Text('EmbeddedComponent 容器区域')
        .fontSize(16)
        .fontColor('#999999')
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding(48)
        .border({ width: 2, color: '#DDDDDD', style: BorderStyle.Dashed })
        .borderRadius(8)
        .backgroundColor('#FAFAFA')

      // 实际使用示例（注释掉的代码）:
      /*
      EmbeddedComponent({
        want: this.embeddedWant,
        moduleName: 'entry',
        onLoad: (event) => {
          this.isLoaded = true
          this.componentName = event.componentName || 'Unknown'
          this.errorMessage = ''
        },
        onError: (event) => {
          this.isLoaded = false
          this.errorMessage = event.errorMsg || 'Unknown error'
        }
      })
      .width('100%')
      .height(200)
      .border({ width: 1, color: Color.Gray, radius: 8 })
      */
    }
    .width('100%')
  }

  @Builder
  buildDescription() {
    Column({ space: 8 }) {
      this.buildNoteItem('⚠', '需要配置有效的 Want 对象（bundleName, abilityName）')
      this.buildNoteItem('⚠', '目标 Ability 的 exported 属性必须为 true')
      this.buildNoteItem('⚠', '需要相应的权限配置')
      this.buildNoteItem('ℹ', '示例中使用占位符，实际使用时取消注释')
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#FFF3E0')
    .borderRadius(8)
  }

  @Builder
  buildNoteItem(icon: string, text: string) {
    Row({ space: 8 }) {
      Text(icon)
        .fontSize(14)

      Text(text)
        .fontSize(12)
        .fontColor('#666666')
        .layoutWeight(1)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }
}

/**
 * 动态切换嵌入组件示例
 * 演示如何在多个嵌入组件之间切换
 */
@ComponentV2
export struct DynamicEmbeddedExample {
  @Local currentIndex: number = 0
  @Local embeddedList: EmbeddedItem[] = [
    {
      name: '组件 1',
      want: {
        bundleName: 'com.example.app1',
        abilityName: 'Component1Ability',
        moduleName: 'entry'
      }
    },
    {
      name: '组件 2',
      want: {
        bundleName: 'com.example.app2',
        abilityName: 'Component2Ability',
        moduleName: 'entry'
      }
    },
    {
      name: '组件 3',
      want: {
        bundleName: 'com.example.app3',
        abilityName: 'Component3Ability',
        moduleName: 'entry'
      }
    }
  ]

  build() {
    Column({ space: 12 }) {
      // 标题
      Text('动态切换示例')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')

      // 导航按钮
      Row({ space: 12 }) {
        Button('上一个')
          .enabled(this.currentIndex > 0)
          .onClick(() => {
            if (this.currentIndex > 0) {
              this.currentIndex--
            }
          })

        Text(`${this.currentIndex + 1} / ${this.embeddedList.length}`)
          .fontSize(14)
          .fontColor('#666666')
          .textAlign(TextAlign.Center)
          .width(60)

        Button('下一个')
          .enabled(this.currentIndex < this.embeddedList.length - 1)
          .onClick(() => {
            if (this.currentIndex < this.embeddedList.length - 1) {
              this.currentIndex++
            }
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      // 当前组件信息
      Text(`当前: ${this.embeddedList[this.currentIndex].name}`)
        .fontSize(14)
        .fontColor('#333333')
        .width('100%')
        .padding(8)
        .backgroundColor('#E3F2FD')
        .borderRadius(6)

      // 嵌入组件占位符
      Column() {
        Text('EmbeddedComponent 容器')
          .fontSize(14)
          .fontColor('#999999')
          .padding(32)
          .border({ width: 2, color: '#DDDDDD', style: BorderStyle.Dashed })
          .borderRadius(8)
      }
      .width('100%')
      .height(180)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 基础 XComponent 示例
 * 演示如何使用 XComponent 嵌入 Native C++ 渲染内容
 */
@ComponentV2
export struct XComponentExample {
  @Local xComponentId: string = 'xcomponent_surface'
  @Local surfaceWidth: number = 0
  @Local surfaceHeight: number = 0
  @Local isInitialized: boolean = false

  build() {
    Column({ space: 12 }) {
      // 标题和描述
      this.buildHeader()

      // 尺寸信息
      if (this.isInitialized) {
        this.buildSizeInfo()
      }

      // XComponent 容器
      this.buildXComponent()

      // 说明文本
      this.buildDescription()
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }

  @Builder
  buildHeader() {
    Column({ space: 4 }) {
      Text('XComponent 示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Text('用于嵌入原生 C++ 绘制内容')
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  buildSizeInfo() {
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

  @Builder
  buildXComponent() {
    Column() {
      // 占位符显示
      Text('XComponent 容器区域')
        .fontSize(16)
        .fontColor('#999999')
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding(48)
        .border({ width: 2, color: '#DDDDDD', style: BorderStyle.Dashed })
        .borderRadius(8)
        .backgroundColor('#FAFAFA')

      // 实际使用示例（注释掉的代码）:
      /*
      XComponent({
        id: this.xComponentId,
        type: 'surface',
        libraryname: 'xcomponentdemo',
        onload: (context) => {
          this.isInitialized = true
          this.surfaceWidth = context.xComponentWidth
          this.surfaceHeight = context.xComponentHeight
          console.info('XComponent loaded:', context.xComponentId)
        },
        onDestroy: () => {
          this.isInitialized = false
          console.info('XComponent destroyed')
        }
      })
      .width('100%')
      .height(200)
      .border({ width: 1, color: Color.Gray, radius: 8 })
      */
    }
    .width('100%')
  }

  @Builder
  buildDescription() {
    Column({ space: 8 }) {
      this.buildNoteItem('⚠', '需要 native 项目配置（CMakeLists.txt）')
      this.buildNoteItem('⚠', '需要编译 .so 动态库文件')
      this.buildNoteItem('⚠', '需要配置 build-profile.json5 启用 C++ 支持')
      this.buildNoteItem('ℹ', '适用于 OpenGL/Vulkan 渲染、游戏、视频处理等场景')
      this.buildNoteItem('ℹ', '示例中使用占位符，实际使用时取消注释')
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#FFF3E0')
    .borderRadius(8)
  }

  @Builder
  buildNoteItem(icon: string, text: string) {
    Row({ space: 8 }) {
      Text(icon)
        .fontSize(14)

      Text(text)
        .fontSize(12)
        .fontColor('#666666')
        .layoutWeight(1)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }
}

/**
 * 可调整大小的 XComponent 示例
 * 演示动态调整 XComponent 尺寸
 */
@ComponentV2
export struct ResizableXComponentExample {
  @Local componentHeight: number = 300
  @Local context: object | null = null

  build() {
    Column({ space: 12 }) {
      // 标题
      Text('可调整大小示例')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')

      // 控制按钮
      Row({ space: 12 }) {
        Button('放大')
          .onClick(() => {
            if (this.componentHeight < 600) {
              this.componentHeight += 50
            }
          })

        Text(`${this.componentHeight}px`)
          .fontSize(14)
          .fontColor('#666666')
          .width(80)
          .textAlign(TextAlign.Center)

        Button('缩小')
          .onClick(() => {
            if (this.componentHeight > 150) {
              this.componentHeight -= 50
            }
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      // XComponent 容器
      Column() {
        Text('XComponent 容器')
          .fontSize(14)
          .fontColor('#999999')
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding(32)
          .border({ width: 2, color: '#DDDDDD', style: BorderStyle.Dashed })
          .borderRadius(8)
      }
      .width('100%')
      .height(this.componentHeight)
      .justifyContent(FlexAlign.Center)
      .animation({ duration: 300, curve: Curve.EaseInOut })

      // 说明
      Text('提示: 实际使用时，Native 层需要响应尺寸变化')
        .fontSize(12)
        .fontColor('#999999')
        .width('100%')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 应用场景示例卡片
 */
@ComponentV2
export struct UseCaseCard {
  @Param title: string = ''
  @Param description: string = ''
  @Param icon: string = ''
  @Param color: string = '#2196F3'

  build() {
    Row({ space: 12 }) {
      // 图标
      Text(this.icon)
        .fontSize(32)
        .width(50)
        .height(50)
        .textAlign(TextAlign.Center)
        .backgroundColor(this.color)
        .fontColor(Color.White)
        .borderRadius(8)

      // 内容
      Column({ space: 4 }) {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')

        Text(this.description)
          .fontSize(13)
          .fontColor('#666666')
          .lineHeight(18)
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
export struct UseCasesExample {
  build() {
    Column({ space: 16 }) {
      // 标题
      Text('应用场景')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      // XComponent 应用场景
      Column({ space: 12 }) {
        Text('XComponent 应用场景')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2196F3')
          .width('100%')

        UseCaseCard({
          title: '游戏开发',
          description: '使用 OpenGL/Vulkan 进行高性能游戏渲染',
          icon: '🎮',
          color: '#FF5722'
        })

        UseCaseCard({
          title: '视频处理',
          description: '视频播放、滤镜、特效处理',
          icon: '🎬',
          color: '#E91E63'
        })

        UseCaseCard({
          title: '相机预览',
          description: '实时相机预览和图像处理',
          icon: '📷',
          color: '#9C27B0'
        })

        UseCaseCard({
          title: '图形渲染',
          description: '复杂的 2D/3D 图形和可视化',
          icon: '🎨',
          color: '#673AB7'
        })
      }
      .width('100%')

      // EmbeddedComponent 应用场景
      Column({ space: 12 }) {
        Text('EmbeddedComponent 应用场景')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#4CAF50')
          .width('100%')

        UseCaseCard({
          title: '组件复用',
          description: '嵌入其他应用的功能组件',
          icon: '🔄',
          color: '#4CAF50'
        })

        UseCaseCard({
          title: '能力集成',
          description: '集成其他 Ability 的能力',
          icon: '🔗',
          color: '#009688'
        })

        UseCaseCard({
          title: '插件化架构',
          description: '实现插件化和模块化',
          icon: '🧩',
          color: '#3F51B5'
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
 * 主页面 - 嵌入式组件示例集合
 */
@ComponentV2
export struct EmbeddedExamplePage {
  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          // 页面标题
          Text('Embedded Component Examples')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .padding({
              left: 16,
              right: 16,
              top: 16,
              bottom: 8
            })

          // EmbeddedComponent 基础示例
          EmbeddedComponentExample()

          // 动态切换示例
          DynamicEmbeddedExample()

          // XComponent 基础示例
          XComponentExample()

          // 可调整大小示例
          ResizableXComponentExample()

          // 应用场景
          UseCasesExample()

          // 底部说明
          this.buildFooter()
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
      .scrollBar(BarState.Auto)
    }
    .title('Embedded 嵌入组件')
    .mode(NavDestinationMode.STANDARD)
  }

  @Builder
  buildFooter() {
    Column({ space: 12 }) {
      Text('重要提示')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#F57C00')
        .width('100%')

      Column({ space: 8 }) {
        this.buildFooterItem('EmbeddedComponent 和 XComponent 都需要特殊的配置')
        this.buildFooterItem('EmbeddedComponent 需要 target Ability 的 exported=true')
        this.buildFooterItem('XComponent 需要 native 项目配置和 .so 文件')
        this.buildFooterItem('请参考技能文档了解详细配置步骤')
        this.buildFooterItem('示例中使用占位符，实际使用时需要取消注释并配置')
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#FFF3E0')
      .borderRadius(8)
    }
    .width('100%')
    .padding(16)
  }

  @Builder
  buildFooterItem(text: string) {
    Row({ space: 8 }) {
      Text('•')
        .fontSize(14)
        .fontColor('#F57C00')

      Text(text)
        .fontSize(13)
        .fontColor('#666666')
        .layoutWeight(1)
    }
    .width('100%')
  }
}

@Builder
export function EmbeddedExamplePageBuilder() {
  EmbeddedExamplePage()
}
