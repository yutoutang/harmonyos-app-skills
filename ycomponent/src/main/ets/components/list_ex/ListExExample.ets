/**
 * List Extended Components Examples
 * OpenHarmony ListItem, ListItemGroup, GridItem, ScrollBar, SideBarContainer Component Examples
 *
 * 展示列表和网格相关组件的各种用法，包括：
 * - ListItem: 列表项组件
 * - ListItemGroup: 列表分组组件
 * - GridItem: 网格项组件
 * - ScrollBar: 滚动条组件
 * - SideBarContainer: 侧边栏容器组件
 */

/**
 * ListItem 基础示例
 * 展示 ListItem 的基本用法和自定义样式
 */
@ComponentV2
export struct ListItemBasicExample {
  @Local items: string[] = ['Apple', 'Banana', 'Orange', 'Grape', 'Mango', 'Peach']

  build() {
    Column({ space: 12 }) {
      Text('ListItem Basic')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      List({ space: 8 }) {
        ForEach(this.items, (item: string) => {
          ListItem() {
            Row({ space: 12 }) {
              Text(item[0])
                .width(40)
                .height(40)
                .fontSize(20)
                .fontColor(Color.White)
                .backgroundColor('#007DFF')
                .borderRadius(20)
                .textAlign(TextAlign.Center)

              Text(item)
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')
                .layoutWeight(1)
            }
            .width('100%')
            .height(60)
            .padding({ left: 16, right: 16 })
            .backgroundColor(Color.White)
            .borderRadius(8)
            .shadow({ radius: 2, color: '#E0E0E0', offsetX: 0, offsetY: 1 })
          }
        })
      }
      .width('100%')
      .height(300)
      .padding({ left: 16, right: 16 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * ListItem 分组示例
 * 展示分组列表的基本用法
 */
@ComponentV2
export struct ListItemGroupedExample {
  @Local sections: SectionData[] = [
    { title: 'A', items: ['Apple', 'Apricot', 'Avocado'] },
    { title: 'B', items: ['Banana', 'Blueberry', 'Blackberry'] },
    { title: 'C', items: ['Cherry', 'Coconut', 'Cranberry'] }
  ]

  build() {
    Column({ space: 12 }) {
      Text('ListItem Grouped')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      List() {
        ForEach(this.sections, (section: SectionData) => {
          // 分组标题
          ListItem() {
            Text(section.title)
              .width('100%')
              .height(40)
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .padding({ left: 16 })
              .backgroundColor('#E3F2FD')
              .fontColor('#007DFF')
          }

          // 列表项
          ForEach(section.items, (item: string) => {
            ListItem() {
              Text(item)
                .width('100%')
                .height(50)
                .fontSize(16)
                .padding({ left: 16 })
                .backgroundColor(Color.White)
            }
          })
        })
      }
      .width('100%')
      .height(350)
      .divider({ strokeWidth: 1, color: '#EEEEEE', startMargin: 16, endMargin: 16 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

interface SectionData {
  title: string
  items: string[]
}

/**
 * ListItemGroup 基础示例
 * 展示分组列表的基本用法
 */
@ComponentV2
export struct ListItemGroupBasicExample {
  @Local groups: GroupData[] = [
    {
      title: 'Fruits',
      items: ['Apple', 'Banana', 'Orange']
    },
    {
      title: 'Vegetables',
      items: ['Carrot', 'Broccoli', 'Spinach']
    }
  ]

  build() {
    Column({ space: 12 }) {
      Text('ListItemGroup Basic')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      List({ space: 16 }) {
        ForEach(this.groups, (group: GroupData) => {
          ListItemGroup({ header: this.groupHeader(group.title), space: 8 }) {
            ForEach(group.items, (item: string) => {
              ListItem() {
                Text(item)
                  .width('100%')
                  .height(50)
                  .fontSize(16)
                  .padding({ left: 16 })
                  .backgroundColor(Color.White)
                  .borderRadius(4)
              }
            })
          }
          .backgroundColor('#FAFAFA')
          .borderRadius(8)
        })
      }
      .width('100%')
      .height(400)
      .padding({ left: 16, right: 16 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }

  @Builder groupHeader(title: string) {
    Text(title)
      .width('100%')
      .height(40)
      .fontSize(16)
      .fontWeight(FontWeight.Bold)
      .padding({ left: 12 })
      .backgroundColor('#E3F2FD')
      .fontColor('#007DFF')
      .borderRadius({ topLeft: 8, topRight: 8 })
  }
}

interface GroupData {
  title: string
  items: string[]
}

/**
 * ListItemGroup 可折叠示例
 * 展示可折叠的分组列表
 */
@ComponentV2
export struct ListItemGroupCollapsibleExample {
  @Local expandedGroups: Set<string> = new Set(['1'])

  build() {
    Column({ space: 12 }) {
      Text('ListItemGroup Collapsible')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      List({ space: 16 }) {
        ForEach(this.getGroupData(), (group: CollapsibleGroup) => {
          ListItemGroup({
            header: this.collapsibleHeader(group),
            space: 8
          }) {
            if (this.expandedGroups.has(group.id)) {
              ForEach(group.items, (item: string) => {
                ListItem() {
                  Text(item)
                    .width('100%')
                    .height(50)
                    .fontSize(16)
                    .padding({ left: 16 })
                    .backgroundColor(Color.White)
                    .borderRadius(4)
                }
              })
            }
          }
          .backgroundColor('#F5F5F5')
          .borderRadius(8)
        })
      }
      .width('100%')
      .height(450)
      .padding({ left: 16, right: 16 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }

  @Builder collapsibleHeader(group: CollapsibleGroup) {
    Row() {
      Text(group.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333333')
        .layoutWeight(1)

      Text(this.expandedGroups.has(group.id) ? '▼' : '▶')
        .fontSize(16)
        .fontColor('#666666')
    }
    .width('100%')
    .height(45)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#FFFFFF')
    .borderRadius(8)
    .onClick(() => {
      this.toggleGroup(group.id)
    })
  }

  private toggleGroup(groupId: string) {
    if (this.expandedGroups.has(groupId)) {
      this.expandedGroups.delete(groupId)
    } else {
      this.expandedGroups.add(groupId)
    }
    this.expandedGroups = new Set(this.expandedGroups)
  }

  private getGroupData(): CollapsibleGroup[] {
    return [
      { id: '1', title: '🔧 Settings', items: ['General', 'Display', 'Sound'] },
      { id: '2', title: '👤 Account', items: ['Profile', 'Security', 'Privacy'] },
      { id: '3', title: '💬 Support', items: ['Help Center', 'Contact Us', 'FAQ'] }
    ]
  }
}

interface CollapsibleGroup {
  id: string
  title: string
  items: string[]
}

/**
 * GridItem 基础示例
 * 展示 GridItem 的基本用法
 */
@ComponentV2
export struct GridItemBasicExample {
  @Local items: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9]

  build() {
    Column({ space: 12 }) {
      Text('GridItem Basic')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Grid() {
        ForEach(this.items, (item: number) => {
          GridItem() {
            Text(`${item}`)
              .width('100%')
              .height('100%')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Center)
              .backgroundColor('#E3F2FD')
              .fontColor('#007DFF')
              .borderRadius(8)
          }
        })
      }
      .columnsTemplate('1fr 1fr 1fr')
      .rowsGap(12)
      .columnsGap(12)
      .width('100%')
      .height(280)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * GridItem 跨列跨行示例
 * 展示 GridItem 的跨度控制
 */
@ComponentV2
export struct GridItemSpanningExample {
  build() {
    Column({ space: 12 }) {
      Text('GridItem Spanning')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Grid() {
        // 标准项
        GridItem() {
          Text('1x1')
            .width('100%')
            .height('100%')
            .fontSize(18)
            .textAlign(TextAlign.Center)
            .backgroundColor('#E3F2FD')
            .borderRadius(8)
        }

        // 跨2列
        GridItem() {
          Text('2x1')
            .width('100%')
            .height('100%')
            .fontSize(18)
            .textAlign(TextAlign.Center)
            .backgroundColor('#E8F5E9')
            .borderRadius(8)
        }
        .columnStart(1)
        .columnEnd(2)

        // 跨2行
        GridItem() {
          Text('1x2')
            .width('100%')
            .height('100%')
            .fontSize(18)
            .textAlign(TextAlign.Center)
            .backgroundColor('#FFF8E1')
            .borderRadius(8)
        }
        .rowStart(1)
        .rowEnd(2)

        // 跨2列2行
        GridItem() {
          Text('2x2')
            .width('100%')
            .height('100%')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Center)
            .backgroundColor('#FCE4EC')
            .borderRadius(8)
        }
        .columnStart(1)
        .columnEnd(2)
        .rowStart(1)
        .rowEnd(2)
      }
      .columnsTemplate('1fr 1fr 1fr')
      .rowsTemplate('1fr 1fr 1fr')
      .rowsGap(12)
      .columnsGap(12)
      .width('100%')
      .height(280)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * GridItem 自定义样式示例
 * 展示 GridItem 的自定义布局
 */
@ComponentV2
export struct GridItemCustomExample {
  @Local icons: IconData[] = [
    { name: 'Home', symbol: '🏠', color: '#007DFF' },
    { name: 'Search', symbol: '🔍', color: '#28A745' },
    { name: 'Settings', symbol: '⚙️', color: '#FFC107' },
    { name: 'Profile', symbol: '👤', color: '#FF5252' },
    { name: 'Messages', symbol: '💬', color: '#9C27B0' },
    { name: 'Gallery', symbol: '🖼️', color: '#FF9800' }
  ]

  build() {
    Column({ space: 12 }) {
      Text('GridItem Custom Style')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Grid() {
        ForEach(this.icons, (icon: IconData) => {
          GridItem() {
            Column({ space: 8 }) {
              Text(icon.symbol)
                .fontSize(32)
                .width(60)
                .height(60)
                .backgroundColor(icon.color)
                .borderRadius(30)
                .textAlign(TextAlign.Center)

              Text(icon.name)
                .fontSize(14)
                .fontColor('#333333')
                .fontWeight(FontWeight.Medium)
            }
            .width('100%')
            .height('100%')
            .padding(12)
            .backgroundColor(Color.White)
            .borderRadius(12)
            .shadow({ radius: 4, color: '#E0E0E0', offsetX: 0, offsetY: 2 })
          }
        })
      }
      .columnsTemplate('repeat(3, 1fr)')
      .rowsGap(16)
      .columnsGap(16)
      .width('100%')
      .height(320)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

interface IconData {
  name: string
  symbol: string
  color: string
}

/**
 * ScrollBar 基础示例
 * 展示 ScrollBar 的基本用法
 */
@ComponentV2
export struct ScrollBarBasicExample {
  private scroller: Scroller = new Scroller()
  @Local items: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]

  build() {
    Column({ space: 12 }) {
      Text('ScrollBar Basic')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Stack({ alignContent: Alignment.End }) {
        List({ space: 8 }) {
          ForEach(this.items, (item: number) => {
            ListItem() {
              Text(`Item ${item}`)
                .width('100%')
                .height(50)
                .fontSize(16)
                .padding({ left: 16 })
                .backgroundColor('#F5F5F5')
                .borderRadius(8)
            }
          })
        }
        .width('100%')
        .height('100%')
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)

        ScrollBar({
          scroller: this.scroller,
          direction: ScrollBarDirection.Vertical,
          state: BarState.Auto
        }) {
          Text()
            .width(6)
            .backgroundColor('#CCCCCC')
            .borderRadius(3)
        }
        .width(6)
      }
      .width('100%')
      .height(300)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * ScrollBar 自定义样式示例
 * 展示自定义样式的滚动条
 */
@ComponentV2
export struct ScrollBarCustomExample {
  private scroller: Scroller = new Scroller()
  @Local items: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25]

  build() {
    Column({ space: 12 }) {
      Text('ScrollBar Custom Style')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Stack({ alignContent: Alignment.End }) {
        Scroll(this.scroller) {
          Column({ space: 12 }) {
            ForEach(this.items, (item: number) => {
              Row() {
                Text(`Content ${item}`)
                  .fontSize(16)
                  .fontColor('#333333')
                  .layoutWeight(1)
              }
              .width('100%')
              .height(60)
              .padding(16)
              .backgroundColor(Color.White)
              .borderRadius(8)
            })
          }
          .width('100%')
          .padding(12)
        }
        .width('100%')
        .height('100%')
        .scrollBar(BarState.Off)

        ScrollBar({
          scroller: this.scroller,
          direction: ScrollBarDirection.Vertical,
          state: BarState.On
        }) {
          Text()
            .width(10)
            .backgroundColor('rgba(0, 125, 255, 0.6)')
            .borderRadius(5)
        }
        .width(10)
        .margin({ right: 6 })
      }
      .width('100%')
      .height(350)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * SideBarContainer 基础示例
 * 展示侧边栏容器的基本用法
 */
@ComponentV2
export struct SideBarContainerBasicExample {
  @Local isSideBarVisible: boolean = true

  build() {
    Column({ space: 12 }) {
      Text('SideBarContainer Basic')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      SideBarContainer() {
        // 侧边栏
        Column({ space: 16 }) {
          Text('Menu')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')

          ForEach(['Home', 'Profile', 'Settings', 'Help'], (item: string) => {
            Text(item)
              .width('100%')
              .height(44)
              .fontSize(16)
              .padding({ left: 16 })
              .backgroundColor('#F5F5F5')
              .borderRadius(8)
              .onClick(() => {
                console.info(`Clicked: ${item}`)
              })
          })
        }
        .width('100%')
        .height('100%')
        .padding(16)
        .backgroundColor('#FFFFFF')

        // 主内容区
        Column() {
          Text('Main Content')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')

          Text(this.isSideBarVisible ? 'Sidebar is shown' : 'Sidebar is hidden')
            .fontSize(16)
            .fontColor('#666666')
            .margin({ top: 16 })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#E3F2FD')
      }
      .width('100%')
      .height(400)
      .sideBarWidth(180)
      .onChange((value: boolean) => {
        this.isSideBarVisible = value
      })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * SideBarContainer 文件管理器示例
 * 展示文件管理器布局
 */
@ComponentV2
export struct SideBarContainerFileManagerExample {
  @Local selectedPath: string = 'Home'
  @Local folders: FolderItem[] = [
    { name: 'Home', icon: '🏠', count: 12 },
    { name: 'Documents', icon: '📄', count: 25 },
    { name: 'Downloads', icon: '⬇️', count: 8 },
    { name: 'Pictures', icon: '🖼️', count: 15 }
  ]

  build() {
    Column({ space: 12 }) {
      Text('SideBarContainer File Manager')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      SideBarContainer(SideBarContainerType.Embed) {
        // 侧边栏：文件夹
        Column({ space: 8 }) {
          Text('Folders')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .padding(16)

          ForEach(this.folders, (folder: FolderItem) => {
            Row({ space: 8 }) {
              Text(folder.icon)
                .fontSize(20)

              Text(folder.name)
                .fontSize(14)
                .fontColor(this.selectedPath === folder.name ? '#007DFF' : '#333333')
                .fontWeight(
                  this.selectedPath === folder.name ? FontWeight.Bold : FontWeight.Normal
                )
                .layoutWeight(1)
            }
            .width('100%')
            .height(44)
            .padding({ left: 12, right: 12 })
            .backgroundColor(this.selectedPath === folder.name ? '#E3F2FD' : 'transparent')
            .borderRadius(6)
            .onClick(() => {
              this.selectedPath = folder.name
            })
          })
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#FFFFFF')

        // 主内容区：文件列表
        Column({ space: 8 }) {
          Text(this.selectedPath)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')

          ForEach([1, 2, 3, 4, 5], (item: number) => {
            Row({ space: 12 }) {
              Text('📄')
                .fontSize(28)

              Column({ space: 4 }) {
                Text(`File ${item}.txt`)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#333333')

                Text('2.5 KB')
                  .fontSize(12)
                  .fontColor('#999999')
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)
            }
            .width('100%')
            .height(64)
            .padding(12)
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
          })
        }
        .width('100%')
        .height('100%')
        .padding(16)
        .backgroundColor('#F5F5F5')
      }
      .width('100%')
      .height(450)
      .sideBarWidth(200)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

interface FolderItem {
  name: string
  icon: string
  count: number
}

/**
 * 完整的列表扩展示例页面
 * 集成所有列表扩展组件示例
 */
@ComponentV2
export struct ListExExamplePage {
  build() {
    Scroll() {
      Column({ space: 20 }) {
        Text('List Extended Components Examples')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .padding({ left: 16, right: 16, top: 16, bottom: 8 })

        // ListItem 示例
        ListItemBasicExample()
        ListItemGroupedExample()

        // ListItemGroup 示例
        ListItemGroupBasicExample()
        ListItemGroupCollapsibleExample()

        // GridItem 示例
        GridItemBasicExample()
        GridItemSpanningExample()
        GridItemCustomExample()

        // ScrollBar 示例
        ScrollBarBasicExample()
        ScrollBarCustomExample()

        // SideBarContainer 示例
        SideBarContainerBasicExample()
        SideBarContainerFileManagerExample()
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
