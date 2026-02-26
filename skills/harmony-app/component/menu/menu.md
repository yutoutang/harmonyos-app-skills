# Menu 组件 HarmonyOS 6.0 开发 Skill

## 概述

Menu 是 OpenHarmony 中的菜单容器组件,用于显示一组菜单项(MenuItem)。Menu 通常通过 bindMenu 或 bindContextMenu 方法绑定到其他组件上,点击触发时以弹出窗口形式显示菜单选项。Menu 是实现应用导航、操作选项、上下文菜单等交互的重要组件。

## 重要说明

- **容器组件**: Menu 是菜单容器,必须包含 MenuItem 或 MenuItemGroup 子组件
- **弹出式显示**: Menu 通过绑定到其他组件实现弹出显示,不直接使用
- **绑定方式**: 使用 bindMenu (点击触发) 或 bindContextMenu (右键/长按触发)
- **自动定位**: 系统自动计算最佳显示位置,避免超出屏幕边界
- **响应式**: 支持响应式布局,菜单大小根据内容自适应
- **子菜单**: 支持多级菜单嵌套

## 模块信息

- **组件名称**: Menu
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [Menu 菜单 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-menu-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// Menu 是内置组件,无需导入
// 直接使用即可
Menu() {
  MenuItem({ content: '选项1' })
  MenuItem({ content: '选项2' })
}
```

### 1.2 基础用法

```typescript
@Entry
@ComponentV2
struct MenuExample {
  @Local showMenu: boolean = false

  build() {
    Column() {
      Button('显示菜单')
        .onClick(() => {
          this.showMenu = true
        })
        .bindMenu(this.showMenu, [
          { value: '选项1', action: () => {} },
          { value: '选项2', action: () => {} }
        ])
    }
  }
}

// 使用 CustomBuilder 方式
Button('显示菜单')
  .bindMenu(this.showMenu, this.menuBuilder())

@Builder
menuBuilder() {
  Menu() {
    MenuItem({ content: '新建' })
    MenuItem({ content: '打开' })
    MenuItem({ content: '保存' })
  }
}
```

## 二、API 参数

### 2.1 构造参数

Menu 组件没有必需的构造参数,通过子组件定义内容:

```typescript
Menu() {
  // MenuItem 子组件
}
```

### 2.2 字体属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `font` | `Font` | - | 菜单项字体样式(大小、粗细、家族) |
| `fontColor` | `ResourceColor` | - | 菜单项字体颜色 |

**注意**: fontSize 已废弃,请使用 font 属性

### 2.3 样式属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `borderRadius` | `Dimension \| BorderRadiuses` | - | 菜单圆角半径 |
| `backgroundColor` | `ResourceColor` | - | 菜单背景色 |

### 2.4 菜单选项 (MenuOptions)

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| `title` | `ResourceStr` | 否 | - | 菜单标题 |
| `subtitle` | `ResourceStr` | 否 | - | 菜单副标题 |
| `enableArrow` | `boolean` | 否 | false | 是否显示箭头(仅 bindContextMenu) |
| `arrowOffset` | `Length` | 否 | - | 箭头距离菜单边缘的距离 |
| `placement` | `Placement` | 否 | - | 菜单显示位置 |
| `offset` | `Offset` | 否 | {x: 0, y: 0} | 菜单相对于绑定组件的偏移量 |

## 三、绑定方法

### 3.1 bindMenu - 点击菜单

**方法签名**:
```typescript
// API 11+: 自动显示
bindMenu(content: Array<MenuElement> | CustomBuilder, options?: MenuOptions): T

// API 12+: 手动控制显示
bindMenu(isShow: boolean, content: Array<MenuElement> | CustomBuilder, options?: MenuOptions): T
```

**使用示例**:
```typescript
// 方式1: 使用数组语法
@Local showMenu: boolean = false

Button('点击显示菜单')
  .bindMenu(this.showMenu, [
    {
      value: '复制',
      action: () => {
        console.info('复制操作')
      }
    },
    {
      value: '粘贴',
      action: () => {
        console.info('粘贴操作')
      }
    }
  ])

// 方式2: 使用 CustomBuilder
Button('点击显示菜单')
  .bindMenu(this.showMenu, this.menuBuilder(), {
    title: '编辑操作',
    offset: { x: 10, y: 10 }
  })

@Builder
menuBuilder() {
  Menu() {
    MenuItem({ content: '新建文件' })
      .onClick(() => {
        console.info('新建文件')
      })
    MenuItem({ content: '打开文件' })
    MenuItem({ content: '保存文件' })
  }
}
```

### 3.2 bindContextMenu - 右键菜单

**方法签名**:
```typescript
// API 11: 通过触发类型控制
bindContextMenu(content: CustomBuilder, responseType: ResponseType, options?: ContextMenuOptions): T

// API 12+: 手动控制显示
bindContextMenu(isShown: boolean, content: CustomBuilder, options?: ContextMenuOptions): T
```

**ResponseType 枚举**:
- `ResponseType.LongPress`: 长按触发
- `ResponseType.RightClick`: 右键触发

**ContextMenuOptions 参数**:
| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| `preview` | `MenuPreviewMode` | 否 | NONE | 预览模式 |
| `placement` | `Placement` | 否 | - | 菜单显示位置 |
| `enableArrow` | `boolean` | 否 | false | 是否显示箭头 |
| `arrowOffset` | `Length` | 否 | - | 箭头偏移量 |
| `offset` | `Offset` | 否 | {x: 0, y: 0} | 菜单偏移量 |
| `integrationMode` | `MenuIntegrationMode` | 否 | EMBEDDED | 集成模式 |

**使用示例**:
```typescript
@Local selectedAction: string = ''

Text('右键点击此区域')
  .width('100%')
  .height(100)
  .backgroundColor('#E0E0E0')
  .bindContextMenu(this.showMenu, this.menuBuilder(), {
    responseType: ResponseType.RightClick,
    preview: MenuPreviewMode.IMAGE,
    integrationMode: MenuIntegrationMode.EMBEDDED,
    enableArrow: true,
    placement: Placement.Right
  })

@Builder
menuBuilder() {
  Menu() {
    MenuItem({ content: '复制' })
      .onClick(() => {
        this.selectedAction = '复制'
      })
    MenuItem({ content: '粘贴' })
    MenuItem({ content: '删除' })
  }
}
```

## 四、常用场景

### 4.1 下拉操作菜单

```typescript
@ComponentV2
struct DropdownMenuExample {
  @Local showMenu: boolean = false
  @Local selectedAction: string = ''

  build() {
    Column({ space: 16 }) {
      Button('更多操作')
        .onClick(() => {
          this.showMenu = true
        })
        .bindMenu(this.showMenu, this.menuBuilder())

      Text(`已选择: ${this.selectedAction}`)
    }
  }

  @Builder
  menuBuilder() {
    Menu() {
      MenuItem({ content: '编辑' })
        .onClick(() => {
          this.selectedAction = '编辑'
        })
      MenuItem({ content: '删除' })
        .onClick(() => {
          this.selectedAction = '删除'
        })
      MenuItem({ content: '分享' })
        .onClick(() => {
          this.selectedAction = '分享'
        })
    }
  }
}
```

### 4.2 工具栏菜单

```typescript
@ComponentV2
struct ToolbarMenuExample {
  @Local showMenu: boolean = false

  build() {
    Row({ space: 12 }) {
      Button('文件')
        .onClick(() => this.showMenu = true)
        .bindMenu(this.showMenu, this.fileMenuBuilder())

      Button('编辑')
        .onClick(() => this.showMenu = true)
        .bindMenu(this.showMenu, this.editMenuBuilder())

      Button('视图')
        .onClick(() => this.showMenu = true)
        .bindMenu(this.showMenu, this.viewMenuBuilder())
    }
  }

  @Builder
  fileMenuBuilder() {
    Menu() {
      MenuItem({ content: '新建' })
      MenuItem({ content: '打开' })
      MenuItem({ content: '保存' })
      MenuItem({ content: '另存为' })
    }
  }

  @Builder
  editMenuBuilder() {
    Menu() {
      MenuItem({ content: '撤销' })
      MenuItem({ content: '重做' })
      MenuItem({ content: '剪切' })
      MenuItem({ content: '复制' })
      MenuItem({ content: '粘贴' })
    }
  }

  @Builder
  viewMenuBuilder() {
    Menu() {
      MenuItem({ content: '放大' })
      MenuItem({ content: '缩小' })
      MenuItem({ content: '重置' })
    }
  }
}
```

### 4.3 带图标的菜单

```typescript
@ComponentV2
struct IconMenuExample {
  @Local showMenu: boolean = false

  build() {
    Button('显示菜单')
      .onClick(() => this.showMenu = true)
      .bindMenu(this.showMenu, this.iconMenuBuilder())

    Text(`已选择: ${this.selectedAction}`)
  }

  @Builder
  iconMenuBuilder() {
    Menu() {
      MenuItem({
        content: '新建',
        startIcon: $r('app.media.ic_add')
      })
      MenuItem({
        content: '编辑',
        startIcon: $r('app.media.ic_edit')
      })
      MenuItem({
        content: '删除',
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

### 4.4 分组菜单

```typescript
@ComponentV2
struct GroupedMenuExample {
  @Local showMenu: boolean = false

  build() {
    Button('显示分组菜单')
      .onClick(() => this.showMenu = true)
      .bindMenu(this.showMenu, this.groupedMenuBuilder())
  }

  @Builder
  groupedMenuBuilder() {
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

## 五、高级特性

### 5.1 子菜单

```typescript
@ComponentV2
struct SubMenuExample {
  @Local showMenu: boolean = false

  build() {
    Button('显示子菜单')
      .onClick(() => this.showMenu = true)
      .bindMenu(this.showMenu, this.subMenuBuilder())
  }

  @Builder
  subMenuBuilder() {
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
      MenuItem({ content: '电子表格' })
      MenuItem({ content: '演示文稿' })
    }
  }
}
```

### 5.2 动态菜单

```typescript
@ComponentV2
struct DynamicMenuExample {
  @Local showMenu: boolean = false
  @Local menuItems: Array<string> = ['选项1', '选项2', '选项3']

  build() {
    Column({ space: 16 }) {
      Button('添加选项')
        .onClick(() => {
          this.menuItems.push(`选项${this.menuItems.length + 1}`)
        })

      Button('显示动态菜单')
        .onClick(() => this.showMenu = true)
        .bindMenu(this.showMenu, this.dynamicMenuBuilder())
    }
  }

  @Builder
  dynamicMenuBuilder() {
    Menu() {
      ForEach(this.menuItems, (item: string) => {
        MenuItem({ content: item })
          .onClick(() => {
            console.info(`点击了: ${item}`)
          })
      }, (item: string) => item)
    }
  }
}
```

### 5.3 菜单位置控制

```typescript
@ComponentV2
struct MenuPositionExample {
  @Local showMenu: boolean = false

  build() {
    Button('显示菜单')
      .onClick(() => this.showMenu = true)
      .bindMenu(this.showMenu, this.menuBuilder(), {
        placement: Placement.Right,
        offset: { x: 10, y: 10 }
      })
  }

  @Builder
  menuBuilder() {
    Menu() {
      MenuItem({ content: '选项1' })
      MenuItem({ content: '选项2' })
      MenuItem({ content: '选项3' })
    }
  }
}
```

### 5.4 带快捷键的菜单

```typescript
@ComponentV2
struct ShortcutMenuExample {
  @Local showMenu: boolean = false

  build() {
    Button('显示菜单')
      .onClick(() => this.showMenu = true)
      .bindMenu(this.showMenu, this.shortcutMenuBuilder())
  }

  @Builder
  shortcutMenuBuilder() {
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
    }
  }
}
```

## 六、事件处理

### 6.1 MenuItem 点击事件

```typescript
MenuItem({ content: '选项1' })
  .onClick(() => {
    console.info('选项1被点击')
  })
```

### 6.2 菜单关闭回调

```typescript
Button('显示菜单')
  .bindMenu(this.showMenu, this.menuBuilder(), {
    onDisappear: () => {
      console.info('菜单已关闭')
      this.showMenu = false
    }
  })
```

## 七、最佳实践

### 7.1 性能优化

```typescript
// ✅ GOOD: 使用 @Builder 复用菜单
@Builder
menuBuilder() {
  Menu() {
    MenuItem({ content: '选项1' })
    MenuItem({ content: '选项2' })
  }
}

// ❌ BAD: 每次都创建新的 Menu
.bindMenu(this.showMenu, Menu() {
  MenuItem({ content: '选项1' })
  MenuItem({ content: '选项2' })
})
```

### 7.2 状态管理

```typescript
// ✅ GOOD: 使用状态变量控制显示
@Local showMenu: boolean = false

Button('显示菜单')
  .onClick(() => this.showMenu = true)
  .bindMenu(this.showMenu, this.menuBuilder())
```

### 7.3 菜单项数量

```typescript
// ✅ GOOD: 合理的菜单项数量
Menu() {
  MenuItemGroup({ header: '常用操作' }) {
    MenuItem({ content: '新建' })
    MenuItem({ content: '打开' })
    MenuItem({ content: '保存' })
  }
}

// ❌ BAD: 菜单项过多(超过 7 个)
// 建议使用分组或子菜单组织
```

### 7.4 图标使用

```typescript
// ✅ GOOD: 合理使用图标增强识别
MenuItem({
  content: '删除',
  startIcon: $r('app.media.ic_delete')
})

// ❌ BAD: 过度使用图标
MenuItem({
  content: '普通文本',
  startIcon: $r('app.media.ic_icon') // 不必要的图标
})
```

## 八、注意事项

### 8.1 兼容性

- **API 版本**: Menu 从 API 9 开始支持
- **bindMenu**: 从 API 11 开始支持自动显示
- **手动控制**: 从 API 12 开始支持 isShown 参数

### 8.2 限制

1. **子组件**: Menu 只能包含 MenuItem 和 MenuItemGroup
2. **嵌套层级**: 子菜单建议不超过 3 层
3. **显示数量**: 单个菜单建议不超过 10 个选项

### 8.3 常见问题

**Q: 菜单显示不完整?**
A: 检查菜单项数量和内容长度,考虑使用 MenuItemGroup 分组

**Q: bindMenu 不工作?**
A: 确保 isShow 状态正确更新,使用 onClick 触发状态变化

**Q: 如何关闭菜单?**
A: 点击菜单外部区域或选择菜单项后自动关闭,也可通过设置 isShow = false 手动关闭

## 九、完整示例

```typescript
@Entry
@ComponentV2
struct MenuCompleteExample {
  @Local showMenu1: boolean = false
  @Local showMenu2: boolean = false
  @Local showContextMenu: boolean = false
  @Local selectedItem: string = '未选择'

  build() {
    Column({ space: 20 }) {
      Text('Menu 菜单完整示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)

      // bindMenu 示例
      Button('显示 bindMenu')
        .onClick(() => {
          this.showMenu1 = true
        })
        .bindMenu(this.showMenu1, this.bindMenuBuilder(), {
          title: '操作菜单',
          offset: { x: 0, y: 10 }
        })

      // 带图标的菜单
      Button('显示带图标的菜单')
        .onClick(() => {
          this.showMenu2 = true
        })
        .bindMenu(this.showMenu2, this.iconMenuBuilder())

      // ContextMenu 示例
      Text('右键点击此区域')
        .width('100%')
        .height(100)
        .backgroundColor('#E0E0E0')
        .borderRadius(8)
        .textAlign(TextAlign.Center)
        .bindContextMenu(this.showContextMenu, this.contextMenuBuilder(), {
          integrationMode: MenuIntegrationMode.EMBEDDED
        })

      // 显示选择结果
      if (this.selectedItem !== '未选择') {
        Text(`已选择: ${this.selectedItem}`)
          .fontSize(16)
          .fontColor('#007DFF')
      }
    }
    .width('100%')
    .height('100%')
    .padding(20)
  }

  @Builder
  bindMenuBuilder() {
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

  @Builder
  iconMenuBuilder() {
    Menu() {
      MenuItemGroup({ header: '文件操作' }) {
        MenuItem({
          content: '新建',
          startIcon: $r('app.media.ic_add')
        })
        MenuItem({
          content: '编辑',
          startIcon: $r('app.media.ic_edit')
        })
        MenuItem({
          content: '删除',
          startIcon: $r('app.media.ic_delete')
        })
      }
    }
  }

  @Builder
  contextMenuBuilder() {
    Menu() {
      MenuItem({ content: '复制' })
        .onClick(() => {
          this.selectedItem = '复制'
        })
      MenuItem({ content: '粘贴' })
        .onClick(() => {
          this.selectedItem = '粘贴'
        })
      MenuItem({ content: '删除' })
        .onClick(() => {
          this.selectedItem = '删除'
        })
    }
  }
}
```

## 十、相关组件

- **MenuItem**: 菜单项组件
- **MenuItemGroup**: 菜单项分组组件
- **ContextMenu**: 上下文菜单(通过 bindContextMenu 绑定)
- **bindMenu**: 绑定点击菜单
- **bindContextMenu**: 绑定右键/长按菜单

## 参考资源

- [Menu 官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-menu-V5)
- [MenuItem 官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-menuitem-V5)
- [bindMenu/bindContextMenu API](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-universal-attributes-overlay-V5)
