# MenuItemGroup 组件 HarmonyOS 6.0 开发 Skill

## 概述

MenuItemGroup 是 OpenHarmony 中的菜单项分组组件,用于将相关的 MenuItem 组织在一起,提供更清晰的菜单结构。通过分组,可以在菜单中显示分组标题(header)和脚注(footer),帮助用户更好地理解和导航菜单选项。MenuItemGroup 是构建复杂菜单层次结构的重要工具。

## 重要说明

- **分组容器**: MenuItemGroup 用于组织相关的 MenuItem
- **标题脚注**: 支持 header 和 footer 显示分组信息
- **视觉分隔**: 自动在分组之间添加视觉分隔
- **灵活内容**: header 和 footer 可以是文本或自定义组件
- **嵌套限制**: MenuItemGroup 不支持嵌套,只能包含 MenuItem

## 模块信息

- **组件名称**: MenuItemGroup
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [MenuItemGroup 菜单项分组 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-menuitemgroup-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// MenuItemGroup 是内置组件,无需导入
// 直接使用即可
MenuItemGroup({ header: '文件操作' }) {
  MenuItem({ content: '新建' })
  MenuItem({ content: '打开' })
  MenuItem({ content: '保存' })
}
```

### 1.2 基础用法

```typescript
Menu() {
  MenuItemGroup({ header: '文件操作' }) {
    MenuItem({ content: '新建' })
    MenuItem({ content: '打开' })
    MenuItem({ content: '保存' })
  }

  MenuItemGroup({ header: '编辑操作' }) {
    MenuItem({ content: '撤销' })
    MenuItem({ content: '重做' })
    MenuItem({ content: '剪切' })
    MenuItem({ content: '复制' })
    MenuItem({ content: '粘贴' })
  }
}
```

## 二、API 参数

### 2.1 构造参数 (MenuItemGroupOptions)

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| `header` | `ResourceStr \| CustomBuilder` | 否 | - | 分组标题 |
| `footer` | `ResourceStr \| CustomBuilder` | 否 | - | 分组脚注 |

### 2.2 构造方法签名

```typescript
MenuItemGroup(value?: MenuItemGroupOptions): MenuItemGroupAttribute
```

## 三、属性方法

### 3.1 通用属性

MenuItemGroup 继承自 CommonMethod,支持以下通用属性:

| 属性 | 类型 | 描述 |
|------|------|------|
| `width` | `Length` | 组件宽度 |
| `height` | `Length` | 组件高度 |
| `backgroundColor` | `ResourceColor` | 背景颜色 |
| `enabled` | `boolean` | 是否启用 |
| `visible` | `boolean` | 是否可见 |

## 四、常用场景

### 4.1 基础分组

```typescript
@ComponentV2
struct BasicGroupExample {
  @Local showMenu: boolean = false

  build() {
    Button('显示分组菜单')
      .onClick(() => this.showMenu = true)
      .bindMenu(this.showMenu, this.groupedMenu())
  }

  @Builder
  groupedMenu() {
    Menu() {
      MenuItemGroup({ header: '文件操作' }) {
        MenuItem({ content: '新建' })
        MenuItem({ content: '打开' })
        MenuItem({ content: '保存' })
      }

      MenuItemGroup({ header: '编辑操作' }) {
        MenuItem({ content: '撤销' })
        MenuItem({ content: '重做' })
        MenuItem({ content: '剪切' })
        MenuItem({ content: '复制' })
        MenuItem({ content: '粘贴' })
      }
    }
  }
}
```

### 4.2 带标题和脚注的分组

```typescript
@ComponentV2
struct HeaderFooterGroupExample {
  @Local showMenu: boolean = false

  build() {
    Button('显示完整分组菜单')
      .onClick(() => this.showMenu = true)
      .bindMenu(this.showMenu, this.headerFooterMenu())
  }

  @Builder
  headerFooterMenu() {
    Menu() {
      MenuItemGroup({
        header: '常用操作',
        footer: '最近使用'
      }) {
        MenuItem({ content: '新建文档' })
        MenuItem({ content: '打开最近' })
        MenuItem({ content: '保存' })
      }

      MenuItemGroup({
        header: '高级操作',
        footer: '需要管理员权限'
      }) {
        MenuItem({ content: '系统设置' })
        MenuItem({ content: '用户管理' })
        MenuItem({ content: '权限配置' })
      }
    }
  }
}
```

### 4.3 自定义标题样式

```typescript
@ComponentV2
struct CustomHeaderGroupExample {
  @Local showMenu: boolean = false

  build() {
    Button('显示自定义标题菜单')
      .onClick(() => this.showMenu = true)
      .bindMenu(this.showMenu, this.customHeaderMenu())
  }

  @Builder
  customHeaderMenu() {
    Menu() {
      MenuItemGroup({
        header: this.customHeader('文件', $r('app.media.ic_file'))
      }) {
        MenuItem({ content: '新建' })
        MenuItem({ content: '打开' })
        MenuItem({ content: '保存' })
      }

      MenuItemGroup({
        header: this.customHeader('编辑', $r('app.media.ic_edit'))
      }) {
        MenuItem({ content: '撤销' })
        MenuItem({ content: '重做' })
        MenuItem({ content: '剪切' })
        MenuItem({ content: '复制' })
        MenuItem({ content: '粘贴' })
      }
    }
  }

  @Builder
  customHeader(title: string, icon: Resource) {
    Row({ space: 8 }) {
      Image(icon)
        .width(16)
        .height(16)
      Text(title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#666666')
    }
  }
}
```

### 4.4 动态分组

```typescript
@ComponentV2
struct DynamicGroupExample {
  @Local showMenu: boolean = false
  @Local recentFiles: Array<string> = [
    'document1.txt',
    'document2.txt',
    'document3.txt'
  ]
  @Local favoriteFiles: Array<string> = [
    'important.pdf',
    'project.ets'
  ]

  build() {
    Button('显示动态分组菜单')
      .onClick(() => this.showMenu = true)
      .bindMenu(this.showMenu, this.dynamicMenu())
  }

  @Builder
  dynamicMenu() {
    Menu() {
      // 收藏文件分组
      if (this.favoriteFiles.length > 0) {
        MenuItemGroup({ header: '收藏' }) {
          ForEach(this.favoriteFiles, (file: string) => {
            MenuItem({ content: file })
              .onClick(() => {
                console.info(`打开收藏: ${file}`)
              })
          }, (file: string) => file)
        }
      }

      // 最近文件分组
      if (this.recentFiles.length > 0) {
        MenuItemGroup({ header: '最近打开' }) {
          ForEach(this.recentFiles, (file: string) => {
            MenuItem({ content: file })
              .onClick(() => {
                console.info(`打开最近: ${file}`)
              })
          }, (file: string) => file)
        }
      }

      // 其他操作分组
      MenuItemGroup({ header: '其他操作' }) {
        MenuItem({ content: '清除历史' })
        MenuItem({ content: '刷新列表' })
      }
    }
  }
}
```

### 4.5 带图标的分组菜单

```typescript
@ComponentV2
struct IconGroupExample {
  @Local showMenu: boolean = false

  build() {
    Button('显示图标分组菜单')
      .onClick(() => this.showMenu = true)
      .bindMenu(this.showMenu, this.iconGroupMenu())
  }

  @Builder
  iconGroupMenu() {
    Menu() {
      MenuItemGroup({ header: '文件操作' }) {
        MenuItem({
          content: '新建',
          startIcon: $r('app.media.ic_add')
        })
        MenuItem({
          content: '打开',
          startIcon: $r('app.media.ic_folder')
        })
        MenuItem({
          content: '保存',
          startIcon: $r('app.media.ic_save')
        })
      }

      MenuItemGroup({ header: '编辑操作' }) {
        MenuItem({
          content: '撤销',
          startIcon: $r('app.media.ic_undo')
        })
        MenuItem({
          content: '重做',
          startIcon: $r('app.media.ic_redo')
        })
        MenuItem({
          content: '剪切',
          startIcon: $r('app.media.ic_cut')
        })
        MenuItem({
          content: '复制',
          startIcon: $r('app.media.ic_copy')
        })
        MenuItem({
          content: '粘贴',
          startIcon: $r('app.media.ic_paste')
        })
      }
    }
  }
}
```

### 4.6 条件显示分组

```typescript
@ComponentV2
struct ConditionalGroupExample {
  @Local showMenu: boolean = false
  @Local isLoggedIn: boolean = false
  @Local isAdmin: boolean = false

  build() {
    Column({ space: 16 }) {
      Toggle({ type: ToggleType.Switch, isOn: this.isLoggedIn })
        .onChange((isOn: boolean) => {
          this.isLoggedIn = isOn
        })
      Text('登录状态')

      Toggle({ type: ToggleType.Switch, isOn: this.isAdmin })
        .onChange((isOn: boolean) => {
          this.isAdmin = isOn
        })
      Text('管理员')

      Button('显示菜单')
        .onClick(() => this.showMenu = true)
        .bindMenu(this.showMenu, this.conditionalMenu())
    }
  }

  @Builder
  conditionalMenu() {
    Menu() {
      // 所有用户可见的分组
      MenuItemGroup({ header: '通用操作' }) {
        MenuItem({ content: '首页' })
        MenuItem({ content: '设置' })
        MenuItem({ content: '帮助' })
      }

      // 登录后可见的分组
      if (this.isLoggedIn) {
        MenuItemGroup({ header: '个人中心' }) {
          MenuItem({ content: '我的文件' })
          MenuItem({ content: '收藏夹' })
          MenuItem({ content: '历史记录' })
        }
      }

      // 管理员可见的分组
      if (this.isLoggedIn && this.isAdmin) {
        MenuItemGroup({
          header: '管理员功能',
          footer: '需要管理员权限'
        }) {
          MenuItem({ content: '用户管理' })
          MenuItem({ content: '系统配置' })
          MenuItem({ content: '日志查看' })
        }
      }

      // 未登录时显示
      if (!this.isLoggedIn) {
        MenuItemGroup({ header: '账户' }) {
          MenuItem({ content: '登录' })
          MenuItem({ content: '注册' })
        }
      }
    }
  }
}
```

### 4.7 长菜单分组优化

```typescript
@ComponentV2
struct LongMenuGroupExample {
  @Local showMenu: boolean = false

  build() {
    Button('显示长菜单')
      .onClick(() => this.showMenu = true)
      .bindMenu(this.showMenu, this.longMenu())
  }

  @Builder
  longMenu() {
    Menu() {
      // 将长菜单分为多个逻辑分组
      MenuItemGroup({ header: '基础操作' }) {
        MenuItem({ content: '新建', labelInfo: 'Ctrl+N' })
        MenuItem({ content: '打开', labelInfo: 'Ctrl+O' })
        MenuItem({ content: '保存', labelInfo: 'Ctrl+S' })
        MenuItem({ content: '另存为', labelInfo: 'Ctrl+Shift+S' })
      }

      MenuItemGroup({ header: '编辑工具' }) {
        MenuItem({ content: '撤销', labelInfo: 'Ctrl+Z' })
        MenuItem({ content: '重做', labelInfo: 'Ctrl+Y' })
        MenuItem({ content: '剪切', labelInfo: 'Ctrl+X' })
        MenuItem({ content: '复制', labelInfo: 'Ctrl+C' })
        MenuItem({ content: '粘贴', labelInfo: 'Ctrl+V' })
      }

      MenuItemGroup({ header: '视图选项' }) {
        MenuItem({ content: '放大', labelInfo: 'Ctrl++' })
        MenuItem({ content: '缩小', labelInfo: 'Ctrl+-' })
        MenuItem({ content: '重置', labelInfo: 'Ctrl+0' })
        MenuItem({ content: '全屏', labelInfo: 'F11' })
      }

      MenuItemGroup({ header: '其他' }) {
        MenuItem({ content: '设置', labelInfo: 'Ctrl+,' })
        MenuItem({ content: '帮助', labelInfo: 'F1' })
        MenuItem({ content: '关于' })
      }
    }
  }
}
```

### 4.8 分组与子菜单结合

```typescript
@ComponentV2
struct GroupWithSubMenuExample {
  @Local showMenu: boolean = false

  build() {
    Button('显示复合菜单')
      .onClick(() => this.showMenu = true)
      .bindMenu(this.showMenu, this.compositeMenu())
  }

  @Builder
  compositeMenu() {
    Menu() {
      MenuItemGroup({ header: '文件操作' }) {
        MenuItem({
          content: '新建',
          builder: this.newSubMenu()
        })
        MenuItem({ content: '打开' })
        MenuItem({ content: '保存' })
        MenuItem({ content: '导出', builder: this.exportSubMenu() })
      }

      MenuItemGroup({ header: '编辑操作' }) {
        MenuItem({ content: '撤销' })
        MenuItem({ content: '重做' })
        MenuItem({ content: '查找', builder: this.findSubMenu() })
      }
    }
  }

  @Builder
  newSubMenu() {
    Menu() {
      MenuItem({ content: '文本文档' })
      MenuItem({ content: '电子表格' })
      MenuItem({ content: '演示文稿' })
      MenuItem({ content: '绘图' })
    }
  }

  @Builder
  exportSubMenu() {
    Menu() {
      MenuItem({ content: '导出为 PDF' })
      MenuItem({ content: '导出为 Word' })
      MenuItem({ content: '导出为 Excel' })
      MenuItem({ content: '导出为图片' })
    }
  }

  @Builder
  findSubMenu() {
    Menu() {
      MenuItem({ content: '查找' })
      MenuItem({ content: '替换' })
      MenuItem({ content: '查找下一个' })
      MenuItem({ content: '查找上一个' })
    }
  }
}
```

## 五、高级特性

### 5.1 使用 CustomBuilder 创建复杂标题

```typescript
@ComponentV2
struct ComplexHeaderExample {
  @Local showMenu: boolean = false
  @Local fileCount: number = 15
  @Lobal editCount: number = 8

  build() {
    Button('显示复杂标题菜单')
      .onClick(() => this.showMenu = true)
      .bindMenu(this.showMenu, this.complexHeaderMenu())
  }

  @Builder
  complexHeaderMenu() {
    Menu() {
      MenuItemGroup({
        header: this.countHeader('文件操作', this.fileCount)
      }) {
        MenuItem({ content: '新建' })
        MenuItem({ content: '打开' })
        MenuItem({ content: '保存' })
      }

      MenuItemGroup({
        header: this.countHeader('编辑操作', this.editCount)
      }) {
        MenuItem({ content: '撤销' })
        MenuItem({ content: '重做' })
        MenuItem({ content: '剪切' })
      }
    }
  }

  @Builder
  countHeader(title: string, count: number) {
    Row({ space: 8 }) {
      Text(title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)

      Text(`${count}`)
        .fontSize(12)
        .fontColor('#FFFFFF')
        .backgroundColor('#007DFF')
        .borderRadius(10)
        .padding({ left: 6, right: 6, top: 2, bottom: 2 })
    }
  }
}
```

### 5.2 可折叠分组

```typescript
@ComponentV2
struct CollapsibleGroupExample {
  @Local showMenu: boolean = false
  @Local expandedGroups: Set<string> = new Set(['文件操作'])

  build() {
    Button('显示可折叠菜单')
      .onClick(() => this.showMenu = true)
      .bindMenu(this.showMenu, this.collapsibleMenu())
  }

  @Builder
  collapsibleMenu() {
    Menu() {
      MenuItemGroup({
        header: this.expandableHeader('文件操作', '文件操作')
      }) {
        if (this.expandedGroups.has('文件操作')) {
          MenuItem({ content: '新建' })
          MenuItem({ content: '打开' })
          MenuItem({ content: '保存' })
        }
      }

      MenuItemGroup({
        header: this.expandableHeader('编辑操作', '编辑操作')
      }) {
        if (this.expandedGroups.has('编辑操作')) {
          MenuItem({ content: '撤销' })
          MenuItem({ content: '重做' })
          MenuItem({ content: '剪切' })
          MenuItem({ content: '复制' })
          MenuItem({ content: '粘贴' })
        }
      }
    }
  }

  @Builder
  expandableHeader(title: string, groupKey: string) {
    Row({ space: 8 }) {
      Text(title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)

      Image(
        this.expandedGroups.has(groupKey)
          ? $r('app.media.ic_arrow_up')
          : $r('app.media.ic_arrow_down')
      )
        .width(16)
        .height(16)
    }
    .onClick(() => {
      if (this.expandedGroups.has(groupKey)) {
        this.expandedGroups.delete(groupKey)
      } else {
        this.expandedGroups.add(groupKey)
      }
    })
  }
}
```

### 5.3 分组统计信息

```typescript
@ComponentV2
struct GroupStatsExample {
  @Local showMenu: boolean = false
  @Local completedTasks: number = 5
  @Local totalTasks: number = 10
  @Local completedProjects: number = 2
  @Local totalProjects: number = 3

  build() {
    Button('显示统计菜单')
      .onClick(() => this.showMenu = true)
      .bindMenu(this.showMenu, this.statsMenu())
  }

  @Builder
  statsMenu() {
    Menu() {
      MenuItemGroup({
        header: '任务管理',
        footer: this.progressFooter(this.completedTasks, this.totalTasks)
      }) {
        MenuItem({ content: '查看任务' })
        MenuItem({ content: '添加任务' })
        MenuItem({ content: '任务统计' })
      }

      MenuItemGroup({
        header: '项目管理',
        footer: this.progressFooter(this.completedProjects, this.totalProjects)
      }) {
        MenuItem({ content: '查看项目' })
        MenuItem({ content: '创建项目' })
        MenuItem({ content: '项目报表' })
      }
    }
  }

  @Builder
  progressFooter(completed: number, total: number) {
    Column() {
      Row({ space: 8 }) {
        Text('进度:')
          .fontSize(12)
          .fontColor('#999999')

        Text(`${completed}/${total}`)
          .fontSize(12)
          .fontColor('#666666')

        Text(`${Math.round(completed / total * 100)}%`)
          .fontSize(12)
          .fontColor('#007DFF')
      }

      Progress({
        value: completed,
        total: total
      })
        .width('100%')
        .height(4)
        .color('#007DFF')
    }
    .width('100%')
    .padding(12)
  }
}
```

## 六、最佳实践

### 6.1 分组命名

```typescript
// ✅ GOOD: 清晰、描述性的分组名称
MenuItemGroup({ header: '文件操作' }) {
  MenuItem({ content: '新建' })
  MenuItem({ content: '打开' })
  MenuItem({ content: '保存' })
}

// ❌ BAD: 模糊或无意义的分组名称
MenuItemGroup({ header: '选项' }) {
  MenuItem({ content: '新建' })
  MenuItem({ content: '打开' })
  MenuItem({ content: '保存' })
}
```

### 6.2 分组大小

```typescript
// ✅ GOOD: 合理的分组大小(3-7 个菜单项)
MenuItemGroup({ header: '文件操作' }) {
  MenuItem({ content: '新建' })
  MenuItem({ content: '打开' })
  MenuItem({ content: '保存' })
  MenuItem({ content: '另存为' })
}

// ❌ BAD: 分组过大或过小
MenuItemGroup({ header: '操作' }) {
  MenuItem({ content: '选项1' })
  MenuItem({ content: '选项2' })
  MenuItem({ content: '选项3' })
  MenuItem({ content: '选项4' })
  MenuItem({ content: '选项5' })
  MenuItem({ content: '选项6' })
  MenuItem({ content: '选项7' })
  MenuItem({ content: '选项8' })
  MenuItem({ content: '选项9' })
  MenuItem({ content: '选项10' })
  // ...过多菜单项
}
```

### 6.3 层次结构

```typescript
// ✅ GOOD: 清晰的层次结构
Menu() {
  MenuItemGroup({ header: '一级分类: 文件' }) {
    MenuItem({ content: '新建' })
    MenuItem({ content: '打开' })
    MenuItem({ content: '保存' })
  }

  MenuItemGroup({ header: '一级分类: 编辑' }) {
    MenuItem({ content: '撤销' })
    MenuItem({ content: '重做' })
    MenuItem({ content: '剪切' })
  }
}

// ❌ BAD: 混乱的层次结构
Menu() {
  MenuItemGroup({ header: '操作' }) {
    MenuItem({ content: '新建' })
    MenuItem({ content: '撤销' }) // 跨类别
    MenuItem({ content: '打开' })
    MenuItem({ content: '重做' }) // 跨类别
  }
}
```

### 6.4 Footer 使用

```typescript
// ✅ GOOD: Footer 提供补充信息
MenuItemGroup({
  header: '管理员功能',
  footer: '需要管理员权限'
}) {
  MenuItem({ content: '用户管理' })
  MenuItem({ content: '系统配置' })
}

// ❌ BAD: Footer 信息冗余或无意义
MenuItemGroup({
  header: '文件操作',
  footer: '文件操作相关功能' // 冗余
}) {
  MenuItem({ content: '新建' })
  MenuItem({ content: '打开' })
}
```

## 七、注意事项

### 7.1 兼容性

- **API 版本**: MenuItemGroup 从 API 9 开始支持
- **CustomBuilder**: header 和 footer 的 CustomBuilder 从 API 9 开始支持

### 7.2 限制

1. **嵌套限制**: MenuItemGroup 不支持嵌套,只能包含 MenuItem
2. **父容器**: MenuItemGroup 必须作为 Menu 的子组件
3. **子组件**: 只能包含 MenuItem,不能包含其他组件类型

### 7.3 常见问题

**Q: MenuItemGroup 不显示标题?**
A: 确保 header 参数正确设置,检查文本资源是否有效

**Q: 分组之间没有分隔?**
A: Menu 组件会自动在 MenuItemGroup 之间添加分隔,如需自定义样式使用 CustomBuilder

**Q: 可以嵌套 MenuItemGroup 吗?**
A: 不支持,MenuItemGroup 只能包含 MenuItem,如需多级结构使用子菜单(builder)

## 八、完整示例

```typescript
@Entry
@ComponentV2
struct MenuItemGroupCompleteExample {
  @Local showMenu: boolean = false
  @Local showContextMenu: boolean = false
  @Local selectedTheme: string = '浅色'
  @Local autoSave: boolean = true
  @Local fontSize: number = 16

  build() {
    Column({ space: 20 }) {
      Text('MenuItemGroup 菜单分组完整示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)

      // 文件菜单
      Button('文件菜单(带分组)')
        .width('100%')
        .onClick(() => this.showMenu = true)
        .bindMenu(this.showMenu, this.fileMenu())

      // 上下文菜单(带分组)
      Text('右键点击此区域(带分组)')
        .width('100%')
        .height(100)
        .backgroundColor('#E0E0E0')
        .borderRadius(8)
        .textAlign(TextAlign.Center)
        .bindContextMenu(this.showContextMenu, this.contextMenu(), {
          responseType: ResponseType.RightClick
        })
    }
    .width('100%')
    .height('100%')
    .padding(20)
  }

  @Builder
  fileMenu() {
    Menu() {
      // 基础操作分组
      MenuItemGroup({
        header: '基础操作'
      }) {
        MenuItem({
          content: '新建',
          startIcon: $r('app.media.ic_add'),
          labelInfo: 'Ctrl+N'
        })
        MenuItem({
          content: '打开',
          startIcon: $r('app.media.ic_folder'),
          labelInfo: 'Ctrl+O'
        })
        MenuItem({
          content: '保存',
          startIcon: $r('app.media.ic_save'),
          labelInfo: 'Ctrl+S'
        })
      }

      // 高级操作分组
      MenuItemGroup({
        header: '高级操作',
        footer: '需要额外权限'
      }) {
        MenuItem({
          content: '另存为',
          labelInfo: 'Ctrl+Shift+S'
        })
        MenuItem({
          content: '导出',
          builder: this.exportSubMenu()
        })
        MenuItem({
          content: '打印',
          labelInfo: 'Ctrl+P'
        })
      }

      // 视图设置分组
      MenuItemGroup({
        header: '视图设置'
      }) {
        MenuItem({
          content: '主题',
          endIcon: $r('app.media.ic_arrow_right'),
          builder: this.themeSubMenu()
        })
        MenuItem({
          content: '字体大小',
          endIcon: $r('app.media.ic_arrow_right'),
          builder: this.fontSubMenu()
        })
        MenuItem({
          content: '自动保存',
          startIcon: this.autoSave
            ? $r('app.media.ic_check')
            : undefined
        })
          .onClick(() => {
            this.autoSave = !this.autoSave
          })
      }
    }
  }

  @Builder
  exportSubMenu() {
    Menu() {
      MenuItem({ content: '导出为 PDF' })
      MenuItem({ content: '导出为 Word' })
      MenuItem({ content: '导出为 Excel' })
      MenuItem({ content: '导出为图片' })
    }
  }

  @Builder
  themeSubMenu() {
    Menu() {
      MenuItem({
        content: '浅色',
        startIcon: this.selectedTheme === '浅色'
          ? $r('app.media.ic_check')
          : undefined
      })
        .onClick(() => {
          this.selectedTheme = '浅色'
        })

      MenuItem({
        content: '深色',
        startIcon: this.selectedTheme === '深色'
          ? $r('app.media.ic_check')
          : undefined
      })
        .onClick(() => {
          this.selectedTheme = '深色'
        })

      MenuItem({
        content: '跟随系统',
        startIcon: this.selectedTheme === '跟随系统'
          ? $r('app.media.ic_check')
          : undefined
      })
        .onClick(() => {
          this.selectedTheme = '跟随系统'
        })
    }
  }

  @Builder
  fontSubMenu() {
    Menu() {
      MenuItem({
        content: '小 (14sp)',
        startIcon: this.fontSize === 14
          ? $r('app.media.ic_check')
          : undefined
      })
        .onClick(() => {
          this.fontSize = 14
        })

      MenuItem({
        content: '中 (16sp)',
        startIcon: this.fontSize === 16
          ? $r('app.media.ic_check')
          : undefined
      })
        .onClick(() => {
          this.fontSize = 16
        })

      MenuItem({
        content: '大 (18sp)',
        startIcon: this.fontSize === 18
          ? $r('app.media.ic_check')
          : undefined
      })
        .onClick(() => {
          this.fontSize = 18
        })
    }
  }

  @Builder
  contextMenu() {
    Menu() {
      // 常用操作分组
      MenuItemGroup({ header: '常用操作' }) {
        MenuItem({ content: '复制' })
        MenuItem({ content: '粘贴' })
        MenuItem({ content: '删除' })
      }

      // 高级操作分组
      MenuItemGroup({
        header: '高级操作',
        footer: '慎用'
      }) {
        MenuItem({ content: '强制刷新' })
        MenuItem({ content: '清除缓存' })
        MenuItem({ content: '重置设置' })
      }
    }
  }
}
```

## 九、相关组件

- **Menu**: 菜单容器组件
- **MenuItem**: 菜单项组件
- **bindMenu**: 绑定点击菜单
- **bindContextMenu**: 绑定右键/长按菜单

## 参考资源

- [MenuItemGroup 官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-menuitemgroup-V5)
- [Menu 官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-menu-V5)
- [MenuItem 官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-menuitem-V5)
