/**
 * Menu/ContextMenu Component Examples
 * OpenHarmony 菜单组件使用示例
 *
 * 展示各种菜单组件的使用方法：
 * - bindMenu: 点击触发的菜单
 * - bindContextMenu: 右键/长按触发的上下文菜单
 * - MenuItem: 菜单项组件
 * - MenuItemGroup: 菜单项分组组件
 */

/**
 * 基础 Menu 示例组件
 * 展示 bindMenu 的基本用法
 */
@ComponentV2
export struct BasicMenuExample {
  @Local showMenu1: boolean = false
  @Local selectedItem: string = '未选择'

  build() {
    Column({ space: 12 }) {
      Text('基础 bindMenu 示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Button('显示菜单')
        .width('100%')
        .onClick(() => {
          this.selectedItem = '未选择'
          this.showMenu1 = true
        })
        .bindMenu(this.showMenu1, this.menuBuilder1())

      if (this.selectedItem !== '未选择') {
        Text(`已选择: ${this.selectedItem}`)
          .fontSize(14)
          .fontColor('#007DFF')
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }

  @Builder
  menuBuilder1() {
    Menu() {
      MenuItem({ content: '新建文档' })
        .onClick(() => {
          this.selectedItem = '新建文档'
        })
      MenuItem({ content: '打开文件' })
        .onClick(() => {
          this.selectedItem = '打开文件'
        })
      MenuItem({ content: '保存文件' })
        .onClick(() => {
          this.selectedItem = '保存文件'
        })
    }
  }
}

/**
 * 带图标的 Menu 示例组件
 * 展示带图标和快捷键的菜单
 */
@ComponentV2
export struct IconMenuExample {
  @Local showMenu2: boolean = false
  @Local selectedAction: string = ''

  build() {
    Column({ space: 12 }) {
      Text('带图标的 Menu 示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Button('显示图标菜单')
        .width('100%')
        .onClick(() => {
          this.selectedAction = ''
          this.showMenu2 = true
        })
        .bindMenu(this.showMenu2, this.iconMenuBuilder())

      if (this.selectedAction !== '') {
        Text(`已选择: ${this.selectedAction}`)
          .fontSize(14)
          .fontColor('#007DFF')
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }

  @Builder
  iconMenuBuilder() {
    Menu() {
      MenuItemGroup({ header: '文件操作' }) {
        MenuItem({
          content: '新建',
          labelInfo: 'Ctrl+N'
        })
          .onClick(() => {
            this.selectedAction = '新建'
          })
        MenuItem({
          content: '打开',
          labelInfo: 'Ctrl+O'
        })
          .onClick(() => {
            this.selectedAction = '打开'
          })
        MenuItem({
          content: '保存',
          labelInfo: 'Ctrl+S'
        })
          .onClick(() => {
            this.selectedAction = '保存'
          })
      }

      MenuItemGroup({ header: '编辑操作' }) {
        MenuItem({
          content: '撤销',
          labelInfo: 'Ctrl+Z'
        })
          .onClick(() => {
            this.selectedAction = '撤销'
          })
        MenuItem({
          content: '重做',
          labelInfo: 'Ctrl+Y'
        })
          .onClick(() => {
            this.selectedAction = '重做'
          })
        MenuItem({
          content: '剪切',
          labelInfo: 'Ctrl+X'
        })
          .onClick(() => {
            this.selectedAction = '剪切'
          })
        MenuItem({
          content: '复制',
          labelInfo: 'Ctrl+C'
        })
          .onClick(() => {
            this.selectedAction = '复制'
          })
        MenuItem({
          content: '粘贴',
          labelInfo: 'Ctrl+V'
        })
          .onClick(() => {
            this.selectedAction = '粘贴'
          })
      }
    }
  }
}

/**
 * ContextMenu 右键菜单示例组件
 * 展示 bindContextMenu 的基本用法
 */
@ComponentV2
export struct ContextMenuExample {
  @Local showContextMenu1: boolean = false
  @Local selectedAction: string = ''

  build() {
    Column({ space: 12 }) {
      Text('ContextMenu 右键菜单示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Text('右键点击此区域(PC 端)')
        .width('100%')
        .height(100)
        .backgroundColor('#E0E0E0')
        .borderRadius(8)
        .textAlign(TextAlign.Center)
        .fontSize(16)
        .bindContextMenu(this.showContextMenu1, this.contextMenuBuilder1())

      if (this.selectedAction !== '') {
        Text(`已选择: ${this.selectedAction}`)
          .fontSize(14)
          .fontColor('#007DFF')
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }

  @Builder
  contextMenuBuilder1() {
    Menu() {
      MenuItem({ content: '复制' })
        .onClick(() => {
          this.selectedAction = '复制'
        })
      MenuItem({ content: '粘贴' })
        .onClick(() => {
          this.selectedAction = '粘贴'
        })
      MenuItem({ content: '删除' })
        .onClick(() => {
          this.selectedAction = '删除'
        })
      MenuItem({ content: '刷新' })
        .onClick(() => {
          this.selectedAction = '刷新'
        })
    }
  }
}

/**
 * 带分组的 Menu 示例组件
 * 展示 MenuItemGroup 的用法
 */
@ComponentV2
export struct GroupedMenuExample {
  @Local showMenu3: boolean = false
  @Local selectedTheme: string = '浅色'
  @Local fontSize: number = 16

  build() {
    Column({ space: 12 }) {
      Text('带分组的 Menu 示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Row({ space: 12 }) {
        Text(`主题: ${this.selectedTheme}`)
          .fontSize(14)
        Text(`字体: ${this.fontSize}sp`)
          .fontSize(14)
      }
      .width('100%')

      Button('设置选项')
        .width('100%')
        .onClick(() => {
          this.showMenu3 = true
        })
        .bindMenu(this.showMenu3, this.groupedMenuBuilder())
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }

  @Builder
  groupedMenuBuilder() {
    Menu() {
      MenuItemGroup({ header: '主题设置' }) {
        MenuItem({
          content: '浅色'
        })
          .onClick(() => {
            this.selectedTheme = '浅色'
          })
        MenuItem({
          content: '深色'
        })
          .onClick(() => {
            this.selectedTheme = '深色'
          })
        MenuItem({
          content: '跟随系统'
        })
          .onClick(() => {
            this.selectedTheme = '跟随系统'
          })
      }

      MenuItemGroup({ header: '字体大小' }) {
        MenuItem({
          content: '小 (14sp)'
        })
          .onClick(() => {
            this.fontSize = 14
          })
        MenuItem({
          content: '中 (16sp)'
        })
          .onClick(() => {
            this.fontSize = 16
          })
        MenuItem({
          content: '大 (18sp)'
        })
          .onClick(() => {
            this.fontSize = 18
          })
      }
    }
  }
}

/**
 * 列表项上下文菜单示例
 * 展示在列表中使用 ContextMenu
 */
class FileItem {
  name: string = ''
  size: string = ''

  constructor(name: string, size: string) {
    this.name = name
    this.size = size
  }
}

@ComponentV2
export struct ListItemContextMenuExample {
  @Local showContextMenu3: boolean = false
  @Local items: Array<FileItem> = [
    new FileItem('document.txt', '2.5 MB'),
    new FileItem('image.jpg', '1.8 MB'),
    new FileItem('report.pdf', '3.2 MB'),
    new FileItem('data.xlsx', '500 KB')
  ]
  @Local selectedAction: string = ''
  @Local selectedItem: string = ''

  build() {
    Column({ space: 12 }) {
      Text('列表项上下文菜单示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      List({ space: 8 }) {
        ForEach(this.items, (item: FileItem, index: number) => {
          ListItem() {
            Row({ space: 12 }) {
              Text('📁')
                .fontSize(24)

              Column({ space: 4 }) {
                Text(item.name)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                Text(item.size)
                  .fontSize(14)
                  .fontColor('#999999')
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)
            }
            .width('100%')
            .padding(12)
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
          }
          .bindContextMenu(this.showContextMenu3, this.itemMenuBuilder(item))
        }, (item: FileItem, index: number) => `${index}_${item.name}`)
      }
      .width('100%')
      .height(200)
      .padding(8)

      if (this.selectedItem !== '') {
        Text(`${this.selectedAction}: ${this.selectedItem}`)
          .fontSize(14)
          .fontColor('#007DFF')
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }

  @Builder
  itemMenuBuilder(item: FileItem) {
    Menu() {
      MenuItemGroup({ header: '文件操作' }) {
        MenuItem({ content: '打开' })
          .onClick(() => {
            this.selectedAction = '打开'
            this.selectedItem = item.name
          })
        MenuItem({ content: '重命名' })
          .onClick(() => {
            this.selectedAction = '重命名'
            this.selectedItem = item.name
          })
        MenuItem({ content: '复制' })
          .onClick(() => {
            this.selectedAction = '复制'
            this.selectedItem = item.name
          })
        MenuItem({ content: '删除' })
          .onClick(() => {
            this.selectedAction = '删除'
            this.selectedItem = item.name
          })
      }
    }
  }
}

/**
 * 文本编辑器上下文菜单示例
 * 展示文本编辑相关的菜单操作
 */
@ComponentV2
export struct TextEditorContextMenuExample {
  @Local showContextMenu4: boolean = false
  @Local textContent: string = '这是一段示例文本,可以右键或长按显示编辑菜单'
  @Local selectedAction: string = ''
  @Local hasSelection: boolean = false

  build() {
    Column({ space: 12 }) {
      Text('文本编辑器上下文菜单示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Text(this.textContent)
        .width('100%')
        .height(120)
        .backgroundColor('#E0E0E0')
        .borderRadius(8)
        .padding(16)
        .maxLines(8)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .bindContextMenu(this.showContextMenu4, this.editorMenuBuilder())

      if (this.selectedAction !== '') {
        Text(`操作: ${this.selectedAction}`)
          .fontSize(14)
          .fontColor('#007DFF')
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }

  @Builder
  editorMenuBuilder() {
    Menu() {
      MenuItemGroup({ header: '编辑操作' }) {
        MenuItem({ content: '撤销', labelInfo: 'Ctrl+Z' })
          .onClick(() => {
            this.selectedAction = '撤销'
          })
        MenuItem({ content: '重做', labelInfo: 'Ctrl+Y' })
          .onClick(() => {
            this.selectedAction = '重做'
          })
      }

      MenuItemGroup({ header: '剪贴板' }) {
        MenuItem({ content: '剪切', labelInfo: 'Ctrl+X' })
          .enabled(this.hasSelection)
          .onClick(() => {
            this.selectedAction = '剪切'
          })
        MenuItem({ content: '复制', labelInfo: 'Ctrl+C' })
          .enabled(this.hasSelection)
          .onClick(() => {
            this.selectedAction = '复制'
            this.hasSelection = true
          })
        MenuItem({ content: '粘贴', labelInfo: 'Ctrl+V' })
          .onClick(() => {
            this.selectedAction = '粘贴'
          })
      }

      MenuItemGroup({ header: '选择' }) {
        MenuItem({ content: '全选', labelInfo: 'Ctrl+A' })
          .onClick(() => {
            this.selectedAction = '全选'
            this.hasSelection = true
          })
      }
    }
  }
}

/**
 * 带子菜单的 Menu 示例
 * 展示多级菜单的使用
 */
@ComponentV2
export struct SubMenuExample {
  @Local showMenu4: boolean = false
  @Local selectedAction: string = ''

  build() {
    Column({ space: 12 }) {
      Text('子菜单示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Button('显示子菜单')
        .width('100%')
        .onClick(() => {
          this.selectedAction = ''
          this.showMenu4 = true
        })
        .bindMenu(this.showMenu4, this.subMenuBuilder())

      if (this.selectedAction !== '') {
        Text(`已选择: ${this.selectedAction}`)
          .fontSize(14)
          .fontColor('#007DFF')
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }

  @Builder
  subMenuBuilder() {
    Menu() {
      MenuItem({
        content: '新建',
        builder: this.newSubMenu()
      })
      MenuItem({ content: '打开' })
        .onClick(() => {
          this.selectedAction = '打开'
        })
      MenuItem({ content: '保存' })
        .onClick(() => {
          this.selectedAction = '保存'
        })
    }
  }

  @Builder
  newSubMenu() {
    Menu() {
      MenuItem({ content: '文本文档' })
        .onClick(() => {
          this.selectedAction = '新建 - 文本文档'
        })
      MenuItem({ content: '电子表格' })
        .onClick(() => {
          this.selectedAction = '新建 - 电子表格'
        })
      MenuItem({ content: '演示文稿' })
        .onClick(() => {
          this.selectedAction = '新建 - 演示文稿'
        })
      MenuItem({ content: '绘图' })
        .onClick(() => {
          this.selectedAction = '新建 - 绘图'
        })
    }
  }
}

/**
 * 手动控制菜单示例
 * 展示通过状态变量控制菜单显示
 */
@ComponentV2
export struct ManualControlMenuExample {
  @Local showMenu5: boolean = false
  @Local selectedAction: string = ''

  build() {
    Column({ space: 12 }) {
      Text('手动控制菜单示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Row({ space: 12 }) {
        Button('显示菜单')
          .onClick(() => {
            this.showMenu5 = true
          })

        Button('隐藏菜单')
          .onClick(() => {
            this.showMenu5 = false
          })
      }

      Text('右键点击或使用按钮')
        .width('100%')
        .height(80)
        .backgroundColor('#E0E0E0')
        .borderRadius(8)
        .textAlign(TextAlign.Center)
        .fontSize(16)
        .bindContextMenu(this.showMenu5, this.manualMenuBuilder())

      if (this.selectedAction !== '') {
        Text(`已选择: ${this.selectedAction}`)
          .fontSize(14)
          .fontColor('#007DFF')
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }

  @Builder
  manualMenuBuilder() {
    Menu() {
      MenuItem({ content: '选项1' })
        .onClick(() => {
          this.selectedAction = '选项1'
        })
      MenuItem({ content: '选项2' })
        .onClick(() => {
          this.selectedAction = '选项2'
        })
      MenuItem({ content: '选项3' })
        .onClick(() => {
          this.selectedAction = '选项3'
        })
    }
  }
}

/**
 * Menu 菜单示例主页面
 * 汇总所有菜单示例
 */
@Entry
@ComponentV2
export struct MenuExamplePage {
  build() {
    Scroll() {
      Column({ space: 20 }) {
        Text('Menu Component Examples')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .padding({ left: 16, right: 16, top: 16, bottom: 8 })

        BasicMenuExample()
        IconMenuExample()
        ContextMenuExample()
        GroupedMenuExample()
        ListItemContextMenuExample()
        TextEditorContextMenuExample()
        SubMenuExample()
        ManualControlMenuExample()
      }
      .width('100%')
      .padding({ left: 16, right: 16, bottom: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
    .scrollBar(BarState.Auto)
  }
}
