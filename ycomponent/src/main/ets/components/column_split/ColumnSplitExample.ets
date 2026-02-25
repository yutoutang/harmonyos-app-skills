/**
 * ColumnSplit Component Examples
 * OpenHarmony ColumnSplit Component 使用示例
 *
 * 展示 ColumnSplit 组件的各种用法,包括不同布局模式、样式和交互
 */

/**
 * 基础分割布局示例
 * 展示最简单的 ColumnSplit 用法
 */
@ComponentV2
export struct BasicColumnSplitExample {
  build() {
    Column({ space: 16 }) {
      Text('ColumnSplit 基础示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      ColumnSplit() {
        Column() {
          Text('区域 1')
            .fontSize(16)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#E3F2FD')
        .justifyContent(FlexAlign.Center)

        Column() {
          Text('区域 2')
            .fontSize(16)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#BBDEFB')
        .justifyContent(FlexAlign.Center)

        Column() {
          Text('区域 3')
            .fontSize(16)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#90CAF9')
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height(200)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * 固定比例分割示例
 * 展示如何使用 layoutWeight 设置固定比例
 */
@ComponentV2
export struct FixedRatioColumnSplitExample {
  build() {
    Column({ space: 16 }) {
      Text('固定比例分割')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      Text('比例 1:2:1')
        .fontSize(14)
        .fontColor('#666666')
        .width('100%')

      ColumnSplit() {
        Column() {
          Text('25%')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#F44336')
        .justifyContent(FlexAlign.Center)
        .layoutWeight(1)

        Column() {
          Text('50%')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#2196F3')
        .justifyContent(FlexAlign.Center)
        .layoutWeight(2)

        Column() {
          Text('25%')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#4CAF50')
        .justifyContent(FlexAlign.Center)
        .layoutWeight(1)
      }
      .width('100%')
      .height(200)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 禁用拖动示例
 * 展示如何禁用分割线拖动功能
 */
@ComponentV2
export struct NoResizeColumnSplitExample {
  build() {
    Column({ space: 16 }) {
      Text('禁用拖动调整')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      Text('分割线不可拖动,固定比例 1:3')
        .fontSize(14)
        .fontColor('#666666')
        .width('100%')

      ColumnSplit() {
        Column() {
          Text('侧边栏')
            .fontSize(16)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#ECEFF1')
        .justifyContent(FlexAlign.Center)
        .layoutWeight(1)

        Column() {
          Text('主内容区')
            .fontSize(16)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#FFFFFF')
        .justifyContent(FlexAlign.Center)
        .layoutWeight(3)
      }
      .width('100%')
      .height(200)
      .resizeable(false)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * 自定义分割线样式示例
 * 展示不同的分割线样式
 */
@ComponentV2
export struct CustomDividerColumnSplitExample {
  build() {
    Column({ space: 16 }) {
      Text('自定义分割线样式')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // 粗分割线
      Text('粗分割线 (4px)')
        .fontSize(14)
        .fontColor('#666666')

      ColumnSplit() {
        Column() {
          Text('区域 1')
            .fontSize(16)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#FFF3E0')
        .justifyContent(FlexAlign.Center)

        Column() {
          Text('区域 2')
            .fontSize(16)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#FFE0B2')
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height(150)
      .margin({ bottom: 16 })

      // 带边距的分割线
      Text('带边距的分割线 (20px)')
        .fontSize(14)
        .fontColor('#666666')

      ColumnSplit() {
        Column() {
          Text('区域 A')
            .fontSize(16)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#F3E5F5')
        .justifyContent(FlexAlign.Center)

        Column() {
          Text('区域 B')
            .fontSize(16)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#E1BEE7')
        .justifyContent(FlexAlign.Center)

        Column() {
          Text('区域 C')
            .fontSize(16)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#CE93D8')
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height(150)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * 动态调整示例
 * 展示如何动态显示/隐藏子组件
 */
@ComponentV2
export struct DynamicColumnSplitExample {
  @Local showPanel: boolean = true

  build() {
    Column({ space: 16 }) {
      Row() {
        Button(this.showPanel ? '隐藏侧边栏' : '显示侧边栏')
          .onClick(() => {
            this.showPanel = !this.showPanel
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)

      ColumnSplit() {
        if (this.showPanel) {
          Column() {
            Text('侧边面板')
              .fontSize(16)
          }
          .width('100%')
          .height('100%')
          .backgroundColor('#E8EAF6')
          .justifyContent(FlexAlign.Center)
          .layoutWeight(1)
        }

        Column() {
          Text('主内容区')
            .fontSize(16)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#FFFFFF')
        .justifyContent(FlexAlign.Center)
        .layoutWeight(3)
      }
      .width('100%')
      .height(250)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 三栏布局示例
 * 展示经典的左中右三栏布局
 */
@ComponentV2
export struct ThreeColumnLayoutExample {
  build() {
    Column({ space: 16 }) {
      Text('三栏布局')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      Text('比例 1:4:1,适合典型应用布局')
        .fontSize(14)
        .fontColor('#666666')
        .width('100%')

      ColumnSplit() {
        // 左侧导航栏
        Column() {
          Text('导航')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#263238')
        .justifyContent(FlexAlign.Center)
        .layoutWeight(1)

        // 中间内容区
        Column() {
          Text('内容')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#FFFFFF')
        .justifyContent(FlexAlign.Center)
        .layoutWeight(4)

        // 右侧工具栏
        Column() {
          Text('工具')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#ECEFF1')
        .justifyContent(FlexAlign.Center)
        .layoutWeight(1)
      }
      .width('100%')
      .height(250)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 代码编辑器布局示例
 * 展示类似 IDE 的复杂布局
 */
@ComponentV2
export struct CodeEditorLayoutExample {
  build() {
    Column({ space: 0 }) {
      // 顶部工具栏
      Row() {
        Text('代码编辑器')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
      }
      .width('100%')
      .height(50)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#37474F')

      // 分割区域
      ColumnSplit() {
        // 文件树
        Column() {
          Text('文件树')
            .fontSize(16)
            .fontColor(Color.White)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#263238')
        .justifyContent(FlexAlign.Center)
        .layoutWeight(1)

        // 代码编辑区
        Column() {
          Text('代码编辑区')
            .fontSize(16)
            .fontColor(Color.White)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#212121')
        .justifyContent(FlexAlign.Center)
        .layoutWeight(3)

        // 预览区
        Column() {
          Text('预览')
            .fontSize(16)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#FFFFFF')
        .justifyContent(FlexAlign.Center)
        .layoutWeight(2)
      }
      .width('100%')
      .height(300)
    }
    .width('100%')
    .height(400)
    .borderRadius(12)
    .clip(true)
  }
}

/**
 * 完整的 ColumnSplit 示例页面
 * 集成所有 ColumnSplit 示例
 */
@ComponentV2
export struct ColumnSplitExamplePage {
  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          Text('ColumnSplit Component Examples')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .padding({ left: 16, right: 16, top: 16, bottom: 8 })

          BasicColumnSplitExample()
          FixedRatioColumnSplitExample()
          NoResizeColumnSplitExample()
          CustomDividerColumnSplitExample()
          DynamicColumnSplitExample()
          ThreeColumnLayoutExample()
          CodeEditorLayoutExample()
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
    }
    .title('ColumnSplit 分割容器')
    .mode(NavDestinationMode.STANDARD)
  }
}

@Builder
export function ColumnSplitExamplePageBuilder() {
  ColumnSplitExamplePage()
}
