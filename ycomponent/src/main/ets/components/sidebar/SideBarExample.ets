/**
 * SideBar/ToolBar Component Examples
 * OpenHarmony 侧边栏和工具栏使用示例
 *
 * Components demonstrated:
 * - SideBarContainer: Container with collapsible sidebar
 * - ToolBar: Toolbar for grouping action items
 * - ToolBarItem: Individual toolbar items
 */

/**
 * SideBar 示例组件
 * 演示左侧导航侧边栏的基本用法
 */
@ComponentV2
export struct SideBarExample {
  @Local selectedIndex: number = 0
  private readonly menuItems: string[] = ['首页', '发现', '消息', '我的']

  build() {
    Column({ space: 16 }) {
      // 标题
      Text('SideBar 侧边栏示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .fontColor('#333333')

      // 侧边栏容器
      SideBarContainer() {
        // 左侧边栏内容
        Column() {
          ForEach(this.menuItems, (item: string, index: number) => {
            Text(item)
              .width('100%')
              .height(50)
              .fontSize(16)
              .fontColor(this.selectedIndex === index ? '#007DFF' : '#333333')
              .backgroundColor(this.selectedIndex === index ? '#E6F0FF' : Color.Transparent)
              .textAlign(TextAlign.Center)
              .borderRadius(8)
              .margin({ top: 4, bottom: 4 })
              .onClick(() => {
                this.selectedIndex = index
              })
          })
        }
        .width('80%')
        .height('100%')
        .backgroundColor('#F8F8F8')
        .padding(12)

        // 右侧主内容区域
        Column({ space: 12 }) {
          Text('主内容区域')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)

          Column({ space: 8 }) {
            Text(`当前选中菜单: ${this.menuItems[this.selectedIndex]}`)
              .fontSize(16)
              .fontColor('#007DFF')
              .fontWeight(FontWeight.Bold)

            Text('这是侧边栏容器的主内容区域。' +
              '点击左侧菜单项可以切换不同的内容展示。')
              .fontSize(14)
              .fontColor('#666666')
              .lineHeight(22)
          }
          .padding(16)
          .backgroundColor('#FFFFFF')
          .borderRadius(8)
          .width('100%')
        }
        .width('100%')
        .height('100%')
        .padding(12)
      }
      .width('100%')
      .height(350)
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
      .shadow({ radius: 8, color: '#1F000000', offsetX: 0, offsetY: 2 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FAFAFA')
    .borderRadius(12)
  }
}

/**
 * ToolBar 示例组件
 * 演示底部工具栏的基本用法
 */
@ComponentV2
export struct ToolBarExample {
  @Local selectedTool: string = '选择工具'
  @Local clickCount: number = 0

  build() {
    Column({ space: 16 }) {
      // 标题
      Text('ToolBar 工具栏示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .fontColor('#333333')

      // 工具栏容器
      Column({ space: 12 }) {
        // 内容显示区
        Column({ space: 8 }) {
          Text('操作结果:')
            .fontSize(14)
            .fontColor('#666666')

          Text(this.selectedTool)
            .fontSize(24)
            .fontColor('#007DFF')
            .fontWeight(FontWeight.Bold)

          if (this.clickCount > 0) {
            Text(`点击次数: ${this.clickCount}`)
              .fontSize(12)
              .fontColor('#999999')
          }
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#F0F7FF')
        .borderRadius(8)
        .layoutWeight(1)

        // 底部工具栏
        Row({ space: 8 }) {
          ForEach(['编辑', '删除', '分享', '更多'], (tool: string) => {
            Column({ space: 4 }) {
              Text(this.getToolIcon(tool))
                .fontSize(20)
              Text(tool)
                .fontSize(12)
            }
            .width(60)
            .height(60)
            .backgroundColor(this.selectedTool.includes(tool) ? '#E6F0FF' : Color.Transparent)
            .borderRadius(8)
            .justifyContent(FlexAlign.Center)
            .onClick(() => {
              this.selectedTool = tool
              this.clickCount++
            })
          })
        }
        .width('100%')
        .height(70)
        .backgroundColor('#FFFFFF')
        .border({ width: { top: 1 }, color: '#E5E5E5' })
        .justifyContent(FlexAlign.SpaceEvenly)
        .padding({ left: 8, right: 8 })
      }
      .width('100%')
      .height(250)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FAFAFA')
    .borderRadius(12)
  }

  private getToolIcon(tool: string): string {
    const icons: Record<string, string> = {
      '编辑': '✏️',
      '删除': '🗑️',
      '分享': '📤',
      '更多': '⋯'
    }
    return icons[tool] || '•'
  }
}

/**
 * 右侧侧边栏示例
 */
@ComponentV2
export struct RightSideBarExample {
  @Local showInfo: boolean = true

  build() {
    Column({ space: 16 }) {
      Text('右侧边栏示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .fontColor('#333333')

      SideBarContainer() {
        // 主内容区
        Column({ space: 12 }) {
          Text('主内容区域')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)

          Text('这是一个右侧边栏示例。' +
            '侧边栏位于右侧，可以用于显示辅助信息或操作面板。')
            .fontSize(14)
            .fontColor('#666666')
            .lineHeight(22)

          Button('切换信息显示')
            .onClick(() => {
              this.showInfo = !this.showInfo
            })
        }
        .width('100%')
        .height('100%')
        .padding(16)
        .layoutWeight(1)

        // 右侧边栏内容
        Column({ space: 12 }) {
          Text('信息面板')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)

          if (this.showInfo) {
            Column({ space: 8 }) {
              InfoRow({ label: '状态', value: '运行中' })
              InfoRow({ label: '版本', value: 'v1.0.0' })
              InfoRow({ label: '用户', value: 'Admin' })
            }
          }
        }
        .width('80%')
        .height('100%')
        .padding(16)
        .backgroundColor('#F8F8F8')
      }
      .width('100%')
      .height(300)
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FAFAFA')
    .borderRadius(12)
  }
}

/**
 * 信息行辅助组件
 */
@ComponentV2
struct InfoRow {
  @Param label: string = ''
  @Param value: string = ''

  build() {
    Row() {
      Text(this.label)
        .fontSize(14)
        .fontColor('#666666')
        .width(60)

      Text(this.value)
        .fontSize(14)
        .fontColor('#333333')
        .fontWeight(FontWeight.Medium)
        .layoutWeight(1)
    }
    .width('100%')
    .padding({ top: 4, bottom: 4 })
  }
}

/**
 * 自定义工具栏示例
 */
@ComponentV2
export struct CustomToolBarExample {
  @Local activeIndex: number = 0
  @Local notificationCount: number = 3

  build() {
    Column({ space: 16 }) {
      Text('自定义工具栏示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .fontColor('#333333')

      Column({ space: 8 }) {
        Text(`当前页面: ${['首页', '消息', '发现', '我的'][this.activeIndex]}`)
          .fontSize(18)
          .fontColor('#007DFF')
          .layoutWeight(1)

        // 底部导航工具栏
        Row({ space: 8 }) {
          ForEach(['首页', '消息', '发现', '我的'], (title: string, index: number) => {
            Column({ space: 4 }) {
              Column({ space: 4 }) {
                Stack({ alignContent: Alignment.TopEnd }) {
                  Text(this.getPageIcon(index))
                    .fontSize(24)

                  // 消息徽标
                  if (index === 1 && this.notificationCount > 0) {
                    Text(this.notificationCount.toString())
                      .fontSize(10)
                      .fontColor('#FFFFFF')
                      .backgroundColor('#FF0000')
                      .borderRadius(10)
                      .padding({ left: 4, right: 4, top: 1, bottom: 1 })
                      .margin({ top: -4, right: -6 })
                  }
                }

                Text(title)
                  .fontSize(11)
                  .fontColor(this.activeIndex === index ? '#007DFF' : '#666666')
                  .fontWeight(this.activeIndex === index ? FontWeight.Bold : FontWeight.Normal)
              }
            }
            .width(80)
            .height(60)
            .justifyContent(FlexAlign.Center)
            .onClick(() => {
              this.activeIndex = index
              if (index === 1) {
                this.notificationCount = 0
              }
            })
          })
        }
        .width('100%')
        .height(60)
        .justifyContent(FlexAlign.SpaceEvenly)
        .backgroundColor('#FFFFFF')
        .border({ width: { top: 1 }, color: '#E5E5E5' })
        .padding({ left: 8, right: 8 })
      }
      .width('100%')
      .height(250)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FAFAFA')
    .borderRadius(12)
  }

  private getPageIcon(index: number): string {
    const icons = ['🏠', '💬', '🔍', '👤']
    return icons[index] || '•'
  }
}

/**
 * SideBar/ToolBar 综合示例页面
 */
@Entry
@ComponentV2
export struct SideBarExamplePage {
  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          // 页面标题
          Text('SideBar & ToolBar 组件示例')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .fontColor('#333333')
            .padding({ left: 16, right: 16, top: 16, bottom: 8 })

          // 基础侧边栏示例
          SideBarExample()

          // 基础工具栏示例
          ToolBarExample()

          // 右侧边栏示例
          RightSideBarExample()

          // 自定义工具栏示例
          CustomToolBarExample()

          // 底部说明
          Column({ space: 8 }) {
            Text('组件说明')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')

            Text('SideBarContainer: 侧边栏容器组件，支持左侧或右侧边栏')
              .fontSize(14)
              .fontColor('#666666')
              .lineHeight(22)

            Text('ToolBar: 工具栏组件，用于展示操作按钮或导航项')
              .fontSize(14)
              .fontColor('#666666')
              .lineHeight(22)

            Text('ToolBarItem: 工具栏子项组件，可自定义内容和样式')
              .fontSize(14)
              .fontColor('#666666')
              .lineHeight(22)
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#F0F7FF')
          .borderRadius(12)
          .margin({ bottom: 16 })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')
      .scrollBar(BarState.Auto)
    }
    .title('SideBar 侧边栏')
    .mode(NavDestinationMode.STANDARD)
  }
}

@Builder
export function SideBarExamplePageBuilder() {
  SideBarExamplePage()
}
