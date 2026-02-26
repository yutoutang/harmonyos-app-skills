# MenuItem 组件 HarmonyOS 6.0 开发 Skill

## 概述

MenuItem 是 OpenHarmony 中的菜单项组件,用于在 Menu 菜单中显示单个选项。每个 MenuItem 可以包含文本、图标、标签信息等,并支持点击事件处理。MenuItem 通常作为 Menu 或 MenuItemGroup 的子组件使用,是构建菜单交互的基本单元。

## 重要说明

- **子组件**: MenuItem 必须作为 Menu 或 MenuItemGroup 的子组件使用
- **点击事件**: 通过 onClick 事件处理用户选择
- **图标支持**: 支持起始图标(startIcon)、结束图标(endIcon)和符号图标(SymbolGlyph)
- **子菜单**: 支持 builder 属性创建子菜单
- **灵活布局**: 支持自定义内容布局和样式

## 模块信息

- **组件名称**: MenuItem
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [MenuItem 菜单项 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-menuitem-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// MenuItem 是内置组件,无需导入
// 直接使用即可
MenuItem({ content: '菜单项' })
```

### 1.2 基础用法

```typescript
Menu() {
  MenuItem({ content: '新建文件' })
  MenuItem({ content: '打开文件' })
  MenuItem({ content: '保存文件' })
}
```

## 二、API 参数

### 2.1 构造参数 (MenuItemOptions)

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| `content` | `ResourceStr` | 否 | - | 菜单项文本内容 |
| `startIcon` | `ResourceStr` | 否 | - | 起始图标(图片路径或资源) |
| `symbolStartIcon` | `SymbolGlyphModifier` | 否 | - | 起始符号图标(API 12+) |
| `endIcon` | `ResourceStr` | 否 | - | 结束图标(图片路径或资源) |
| `symbolEndIcon` | `SymbolGlyphModifier` | 否 | - | 结束符号图标(API 20+) |
| `labelInfo` | `ResourceStr` | 否 | - | 结尾标签信息(如快捷键提示) |
| `builder` | `CustomBuilder` | 否 | - | 子菜单构建器 |

### 2.2 构造方法签名

```typescript
// 基础用法
MenuItem(value?: MenuItemOptions): MenuItemAttribute

// 快捷方式(仅内容)
MenuItem(content: ResourceStr): MenuItemAttribute
```

## 三、属性方法

### 3.1 通用属性

MenuItem 继承自 CommonMethod,支持以下通用属性:

| 属性 | 类型 | 描述 |
|------|------|------|
| `width` | `Length` | 组件宽度 |
| `height` | `Length` | 组件高度 |
| `backgroundColor` | `ResourceColor` | 背景颜色 |
| `enabled` | `boolean` | 是否启用 |
| `visible` | `boolean` | 是否可见 |

### 3.2 MenuItem 特有属性

| 属性 | 类型 | 描述 |
|------|------|------|
| `content` | `ResourceStr` | 菜单项内容 |
| `startIcon` | `ResourceStr` | 起始图标 |
| `endIcon` | `ResourceStr` | 结束图标 |
| `labelInfo` | `ResourceStr` | 标签信息 |
| `selected` | `boolean` | 是否选中状态 |

## 四、事件方法

### 4.1 onClick 事件

```typescript
MenuItem({ content: '保存' })
  .onClick(() => {
    console.info('保存被点击')
  })
```

### 4.2 onAppear 事件

```typescript
MenuItem({ content: '选项' })
  .onAppear(() => {
    console.info('菜单项显示')
  })
```

## 五、常用场景

### 5.1 基础菜单项

```typescript
@ComponentV2
struct BasicMenuItemExample {
  @Local selectedItem: string = '未选择'

  build() {
    Column({ space: 16 }) {
      Button('显示菜单')
        .onClick(() => this.showMenu = true)
        .bindMenu(this.showMenu, this.basicMenu())

      Text(`已选择: ${this.selectedItem}`)
    }
  }

  @Builder
  basicMenu() {
    Menu() {
      MenuItem({ content: '新建' })
        .onClick(() => {
          this.selectedItem = '新建'
        })
      MenuItem({ content: '打开' })
        .onClick(() => {
          this.selectedItem = '打开'
        })
      MenuItem({ content: '保存' })
        .onClick(() => {
          this.selectedItem = '保存'
        })
    }
  }
}
```

### 5.2 带图标的菜单项

```typescript
@ComponentV2
struct IconMenuItemExample {
  @Local showMenu: boolean = false

  build() {
    Button('显示图标菜单')
      .onClick(() => this.showMenu = true)
      .bindMenu(this.showMenu, this.iconMenu())
  }

  @Builder
  iconMenu() {
    Menu() {
      MenuItem({
        content: '新建文件',
        startIcon: $r('app.media.ic_add')
      })
      MenuItem({
        content: '编辑文件',
        startIcon: $r('app.media.ic_edit')
      })
      MenuItem({
        content: '删除文件',
        startIcon: $r('app.media.ic_delete')
      })
      MenuItem({
        content: '分享',
        endIcon: $r('app.media.ic_share')
      })
    }
  }
}
```

### 5.3 带快捷键的菜单项

```typescript
@ComponentV2
struct ShortcutMenuItemExample {
  @Local showMenu: boolean = false

  build() {
    Button('显示快捷键菜单')
      .onClick(() => this.showMenu = true)
      .bindMenu(this.showMenu, this.shortcutMenu())
  }

  @Builder
  shortcutMenu() {
    Menu() {
      MenuItem({
        content: '新建',
        labelInfo: 'Ctrl+N'
      })
      MenuItem({
        content: '打开',
        labelInfo: 'Ctrl+O'
      })
      MenuItem({
        content: '保存',
        labelInfo: 'Ctrl+S'
      })
      MenuItem({
        content: '打印',
        labelInfo: 'Ctrl+P'
      })
      MenuItem({
        content: '退出',
        labelInfo: 'Alt+F4'
      })
    }
  }
}
```

### 5.4 带选中状态的菜单项

```typescript
@ComponentV2
struct SelectedMenuItemExample {
  @Local showMenu: boolean = false
  @Local selectedView: string = '列表视图'

  build() {
    Column({ space: 16 }) {
      Text(`当前视图: ${this.selectedView}`)

      Button('切换视图')
        .onClick(() => this.showMenu = true)
        .bindMenu(this.showMenu, this.viewMenu())
    }
  }

  @Builder
  viewMenu() {
    Menu() {
      MenuItem({
        content: '列表视图',
        startIcon: this.selectedView === '列表视图'
          ? $r('app.media.ic_check')
          : undefined
      })
        .onClick(() => {
          this.selectedView = '列表视图'
        })

      MenuItem({
        content: '网格视图',
        startIcon: this.selectedView === '网格视图'
          ? $r('app.media.ic_check')
          : undefined
      })
        .onClick(() => {
          this.selectedView = '网格视图'
        })

      MenuItem({
        content: '详情视图',
        startIcon: this.selectedView === '详情视图'
          ? $r('app.media.ic_check')
          : undefined
      })
        .onClick(() => {
          this.selectedView = '详情视图'
        })
    }
  }
}
```

### 5.5 带子菜单的菜单项

```typescript
@ComponentV2
struct SubMenuItemExample {
  @Local showMenu: boolean = false

  build() {
    Button('显示子菜单')
      .onClick(() => this.showMenu = true)
      .bindMenu(this.showMenu, this.subMenu())
  }

  @Builder
  subMenu() {
    Menu() {
      MenuItem({
        content: '新建',
        builder: this.newSubMenu()
      })
      MenuItem({ content: '打开' })
      MenuItem({ content: '保存' })
    }
  }

  @Builder
  newSubMenu() {
    Menu() {
      MenuItem({ content: '文本文档' })
        .onClick(() => {
          console.info('新建文本文档')
        })
      MenuItem({ content: '电子表格' })
        .onClick(() => {
          console.info('新建电子表格')
        })
      MenuItem({ content: '演示文稿' })
        .onClick(() => {
          console.info('新建演示文稿')
        })
    }
  }
}
```

### 5.6 使用 SymbolGlyph 图标

```typescript
@ComponentV2
struct SymbolMenuItemExample {
  @Local showMenu: boolean = false

  build() {
    Button('显示符号图标菜单')
      .onClick(() => this.showMenu = true)
      .bindMenu(this.showMenu, this.symbolMenu())
  }

  @Builder
  symbolMenu() {
    Menu() {
      MenuItem({
        content: 'WiFi',
        symbolStartIcon: this.symbolGlyphBuilder('wifi')
      })
      MenuItem({
        content: '蓝牙',
        symbolStartIcon: this.symbolGlyphBuilder('bluetooth')
      })
      MenuItem({
        content: '飞行模式',
        symbolStartIcon: this.symbolGlyphBuilder('airplane')
      })
    }
  }

  @Builder
  symbolGlyphBuilder(iconName: string) {
    SymbolGlyphModifier()
      .effectSymbolGlyphEffect(ContentIntensity.NONE, ContentEffect.NONE)
      .fontSize(24)
  }
}
```

### 5.7 禁用状态的菜单项

```typescript
@ComponentV2
struct DisabledMenuItemExample {
  @Local showMenu: boolean = false
  @Local hasSelection: boolean = false

  build() {
    Column({ space: 16 }) {
      Toggle({ type: ToggleType.Switch, isOn: this.hasSelection })
        .onChange((isOn: boolean) => {
          this.hasSelection = isOn
        })

      Button('显示上下文菜单')
        .onClick(() => this.showMenu = true)
        .bindMenu(this.showMenu, this.contextMenu())
    }
  }

  @Builder
  contextMenu() {
    Menu() {
      MenuItem({ content: '复制' })
        .enabled(this.hasSelection)
        .onClick(() => {
          if (this.hasSelection) {
            console.info('复制内容')
          }
        })

      MenuItem({ content: '剪切' })
        .enabled(this.hasSelection)
        .onClick(() => {
          if (this.hasSelection) {
            console.info('剪切内容')
          }
        })

      MenuItem({ content: '粘贴' })
        .onClick(() => {
          console.info('粘贴内容')
        })
    }
  }
}
```

## 六、高级特性

### 6.1 动态菜单项

```typescript
@ComponentV2
struct DynamicMenuItemExample {
  @Local showMenu: boolean = false
  @Local recentFiles: Array<string> = [
    'document1.txt',
    'document2.txt',
    'document3.txt'
  ]

  build() {
    Button('最近文件')
      .onClick(() => this.showMenu = true)
      .bindMenu(this.showMenu, this.dynamicMenu())
  }

  @Builder
  dynamicMenu() {
    Menu() {
      MenuItem({ content: '新建文档' })

      // 分组头
      MenuItemGroup({ header: '最近打开' }) {
        ForEach(this.recentFiles, (file: string) => {
          MenuItem({ content: file })
            .onClick(() => {
              console.info(`打开文件: ${file}`)
            })
        }, (file: string) => file)
      }
    }
  }
}
```

### 6.2 自定义内容菜单项

```typescript
@ComponentV2
struct CustomMenuItemExample {
  @Local showMenu: boolean = false
  @Local volume: number = 50

  build() {
    Button('音量设置')
      .onClick(() => this.showMenu = true)
      .bindMenu(this.showMenu, this.customMenu())
  }

  @Builder
  customMenu() {
    Menu() {
      MenuItem({ content: '静音' })
        .onClick(() => {
          this.volume = 0
        })

      // 自定义内容
      MenuItem() {
        Column() {
          Text('音量调节')
            .fontSize(14)

          Slider({
            value: this.volume,
            min: 0,
            max: 100
          })
            .onChange((value: number) => {
              this.volume = value
            })

          Text(`${this.volume}%`)
            .fontSize(12)
            .fontColor('#666666')
        }
        .padding(12)
      }
    }
  }
}
```

### 6.3 带徽标的菜单项

```typescript
@ComponentV2
struct BadgeMenuItemExample {
  @Local showMenu: boolean = false
  @Local unreadCount: number = 5

  build() {
    Button('消息菜单')
      .onClick(() => this.showMenu = true)
      .bindMenu(this.showMenu, this.badgeMenu())
  }

  @Builder
  badgeMenu() {
    Menu() {
      MenuItem() {
        Row({ space: 8 }) {
          Text('收件箱')
            .fontSize(16)

          if (this.unreadCount > 0) {
            Text(`${this.unreadCount}`)
              .fontSize(12)
              .fontColor('#FFFFFF')
              .backgroundColor('#FF0000')
              .borderRadius(10)
              .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          }
        }
      }
      MenuItem({ content: '已发送' })
      MenuItem({ content: '草稿箱' })
    }
  }
}
```

### 6.4 分隔菜单项

```typescript
@ComponentV2
struct SeparatorMenuItemExample {
  @Local showMenu: boolean = false

  build() {
    Button('显示菜单')
      .onClick(() => this.showMenu = true)
      .bindMenu(this.showMenu, this.separatorMenu())
  }

  @Builder
  separatorMenu() {
    Menu() {
      MenuItemGroup({ header: '文件操作' }) {
        MenuItem({ content: '新建' })
        MenuItem({ content: '打开' })
        MenuItem({ content: '保存' })
      }

      // 自动添加分隔线

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

## 七、事件处理

### 7.1 点击事件处理

```typescript
MenuItem({ content: '删除' })
  .onClick(() => {
    // 简单点击处理
    console.info('删除操作')
  })
```

### 7.2 带参数的点击事件

```typescript
@ComponentV2
struct ParameterizedMenuItemExample {
  @Local selectedItem: string = ''

  build() {
    Button('选择操作')
      .onClick(() => this.showMenu = true)
      .bindMenu(this.showMenu, this.parameterizedMenu())
  }

  @Builder
  parameterizedMenu() {
    Menu() {
      MenuItem({ content: '选项1' })
        .onClick(() => {
          this.handleItemClick('选项1')
        })
      MenuItem({ content: '选项2' })
        .onClick(() => {
          this.handleItemClick('选项2')
        })
      MenuItem({ content: '选项3' })
        .onClick(() => {
          this.handleItemClick('选项3')
        })
    }
  }

  handleItemClick(item: string) {
    this.selectedItem = item
    console.info(`选择了: ${item}`)
  }
}
```

### 7.3 异步操作处理

```typescript
@ComponentV2
struct AsyncMenuItemExample {
  @Local showMenu: boolean = false
  @Local isSaving: boolean = false

  build() {
    Button('文件操作')
      .onClick(() => this.showMenu = true)
      .bindMenu(this.showMenu, this.asyncMenu())
  }

  @Builder
  asyncMenu() {
    Menu() {
      MenuItem({ content: '保存' })
        .enabled(!this.isSaving)
        .onClick(async () => {
          this.isSaving = true
          await this.saveFile()
          this.isSaving = false
        })

      if (this.isSaving) {
        MenuItem({ content: '保存中...' })
          .enabled(false)
      }
    }
  }

  async saveFile() {
    // 模拟异步保存操作
    return new Promise<void>((resolve) => {
      setTimeout(() => {
        console.info('文件保存完成')
        resolve()
      }, 2000)
    })
  }
}
```

## 八、最佳实践

### 8.1 菜单项命名

```typescript
// ✅ GOOD: 清晰、简洁的名称
MenuItem({ content: '新建文档' })
MenuItem({ content: '保存' })
MenuItem({ content: '退出' })

// ❌ BAD: 模糊、冗长的名称
MenuItem({ content: '点击这里新建一个新文档' })
MenuItem({ content: '保存当前文件到磁盘' })
```

### 8.2 图标使用

```typescript
// ✅ GOOD: 语义化图标
MenuItem({
  content: '删除',
  startIcon: $r('app.media.ic_delete')
})
MenuItem({
  content: '分享',
  endIcon: $r('app.media.ic_share')
})

// ❌ BAD: 不相关或无意义的图标
MenuItem({
  content: '保存',
  startIcon: $r('app.media.ic_wifi') // 图标与内容无关
})
```

### 8.3 菜单项分组

```typescript
// ✅ GOOD: 使用 MenuItemGroup 分组
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
  }
}

// ❌ BAD: 平铺所有菜单项
Menu() {
  MenuItem({ content: '新建' })
  MenuItem({ content: '打开' })
  MenuItem({ content: '保存' })
  MenuItem({ content: '撤销' })
  MenuItem({ content: '重做' })
  MenuItem({ content: '剪切' })
  // ...更多菜单项,难以组织
}
```

### 8.4 菜单项数量

```typescript
// ✅ GOOD: 合理的菜单项数量
Menu() {
  MenuItem({ content: '新建' })
  MenuItem({ content: '打开' })
  MenuItem({ content: '保存' })
  MenuItem({ content: '导出' })
  MenuItem({ content: '设置' })
}

// ❌ BAD: 菜单项过多(超过 7 个建议分组或使用子菜单)
Menu() {
  MenuItem({ content: '选项1' })
  MenuItem({ content: '选项2' })
  MenuItem({ content: '选项3' })
  MenuItem({ content: '选项4' })
  MenuItem({ content: '选项5' })
  MenuItem({ content: '选项6' })
  MenuItem({ content: '选项7' })
  MenuItem({ content: '选项8' })
  // 继续添加...
}
```

### 8.5 禁用状态处理

```typescript
// ✅ GOOD: 根据上下文动态设置禁用状态
MenuItem({ content: '粘贴' })
  .enabled(this.clipboardContent !== '')
  .onClick(() => {
    this.pasteContent()
  })

// ❌ BAD: 不处理禁用状态,在点击时才提示
MenuItem({ content: '粘贴' })
  .onClick(() => {
    if (this.clipboardContent === '') {
      // 提示剪贴板为空
      console.info('剪贴板为空')
    } else {
      this.pasteContent()
    }
  })
```

## 九、注意事项

### 9.1 兼容性

- **API 版本**: MenuItem 从 API 9 开始支持
- **SymbolGlyph**: symbolStartIcon 从 API 12 开始支持
- **symbolEndIcon**: 从 API 20 开始支持

### 9.2 限制

1. **父容器**: MenuItem 必须作为 Menu 或 MenuItemGroup 的子组件
2. **内容长度**: 菜单项文本过长会自动截断,建议控制在 20 字以内
3. **图标大小**: 图标建议使用 24x24 vp 尺寸

### 9.3 常见问题

**Q: MenuItem 不显示?**
A: 检查 MenuItem 是否正确添加到 Menu 或 MenuItemGroup 中

**Q: onClick 事件不触发?**
A: 确保 MenuItem 的 enabled 属性为 true

**Q: 图标不显示?**
A: 检查图标资源路径是否正确,确保图片资源存在

**Q: 子菜单不显示?**
A: 确保使用 builder 属性并返回有效的 Menu 组件

## 十、完整示例

```typescript
@Entry
@ComponentV2
struct MenuItemCompleteExample {
  @Local showMenu: boolean = false
  @Local showContextMenu: boolean = false
  @Local selectedTheme: string = '浅色'
  @Local autoSave: boolean = true
  @Local fontSize: number = 16
  @Local lastAction: string = '无'

  build() {
    Column({ space: 20 }) {
      Text('MenuItem 菜单项完整示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)

      // 显示当前设置
      Column({ space: 12 }) {
        Text(`主题: ${this.selectedTheme}`)
        Text(`自动保存: ${this.autoSave ? '开启' : '关闭'}`)
        Text(`字体大小: ${this.fontSize}`)
        Text(`最后操作: ${this.lastAction}`)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      // 文件菜单
      Button('文件菜单')
        .width('100%')
        .onClick(() => this.showMenu = true)
        .bindMenu(this.showMenu, this.fileMenu())

      // 上下文菜单
      Text('右键点击此区域')
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
      MenuItemGroup({ header: '文件操作' }) {
        MenuItem({
          content: '新建文档',
          startIcon: $r('app.media.ic_add'),
          labelInfo: 'Ctrl+N'
        })
          .onClick(() => {
            this.lastAction = '新建文档'
          })

        MenuItem({
          content: '打开',
          startIcon: $r('app.media.ic_folder'),
          labelInfo: 'Ctrl+O'
        })
          .onClick(() => {
            this.lastAction = '打开文件'
          })

        MenuItem({
          content: '保存',
          startIcon: $r('app.media.ic_save'),
          labelInfo: 'Ctrl+S'
        })
          .onClick(() => {
            this.lastAction = '保存文件'
          })
      }

      MenuItemGroup({ header: '视图设置' }) {
        MenuItem({
          content: '主题设置',
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
            this.lastAction = `自动保存: ${this.autoSave ? '开启' : '关闭'}`
          })
      }
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
          this.lastAction = '切换到浅色主题'
        })

      MenuItem({
        content: '深色',
        startIcon: this.selectedTheme === '深色'
          ? $r('app.media.ic_check')
          : undefined
      })
        .onClick(() => {
          this.selectedTheme = '深色'
          this.lastAction = '切换到深色主题'
        })

      MenuItem({
        content: '跟随系统',
        startIcon: this.selectedTheme === '跟随系统'
          ? $r('app.media.ic_check')
          : undefined
      })
        .onClick(() => {
          this.selectedTheme = '跟随系统'
          this.lastAction = '切换到跟随系统'
        })
    }
  }

  @Builder
  fontSubMenu() {
    Menu() {
      MenuItem({
        content: '小',
        startIcon: this.fontSize === 14
          ? $r('app.media.ic_check')
          : undefined
      })
        .onClick(() => {
          this.fontSize = 14
          this.lastAction = '字体大小: 小'
        })

      MenuItem({
        content: '中',
        startIcon: this.fontSize === 16
          ? $r('app.media.ic_check')
          : undefined
      })
        .onClick(() => {
          this.fontSize = 16
          this.lastAction = '字体大小: 中'
        })

      MenuItem({
        content: '大',
        startIcon: this.fontSize === 18
          ? $r('app.media.ic_check')
          : undefined
      })
        .onClick(() => {
          this.fontSize = 18
          this.lastAction = '字体大小: 大'
        })
    }
  }

  @Builder
  contextMenu() {
    Menu() {
      MenuItem({ content: '复制' })
        .onClick(() => {
          this.lastAction = '复制'
        })

      MenuItem({ content: '粘贴' })
        .enabled(this.clipboardAvailable)
        .onClick(() => {
          this.lastAction = '粘贴'
        })

      MenuItem({ content: '删除' })
        .onClick(() => {
          this.lastAction = '删除'
        })

      MenuItem({ content: '刷新' })
        .onClick(() => {
          this.lastAction = '刷新'
        })
    }
  }

  @Local clipboardAvailable: boolean = true
}
```

## 十一、相关组件

- **Menu**: 菜单容器组件
- **MenuItemGroup**: 菜单项分组组件
- **bindMenu**: 绑定点击菜单
- **bindContextMenu**: 绑定右键/长按菜单

## 参考资源

- [MenuItem 官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-menuitem-V5)
- [Menu 官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-menu-V5)
- [bindMenu/bindContextMenu API](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-universal-attributes-overlay-V5)
