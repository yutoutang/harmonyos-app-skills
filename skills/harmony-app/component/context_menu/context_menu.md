# ContextMenu 右键菜单 HarmonyOS 6.0 开发 Skill

## 概述

ContextMenu(上下文菜单)是 OpenHarmony 中通过 bindContextMenu 方法绑定的右键或长按触发的菜单。ContextMenu 与普通 Menu 的主要区别在于触发方式:ContextMenu 通过右键点击(PC 端)或长按(移动端)触发,而普通 Menu 通过点击触发。ContextMenu 常用于提供与当前上下文相关的操作选项。

## 重要说明

- **触发方式**: 右键点击(PC)或长按(移动设备)
- **上下文相关**: 菜单项与当前操作的组件或内容相关
- **API 变更**: API 12+ 支持手动控制显示(isShown 参数)
- **预览模式**: 支持长按时显示内容预览
- **箭头指示**: 可选显示箭头指向触发区域

## 模块信息

- **组件名称**: ContextMenu (通过 bindContextMenu 绑定)
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [bindContextMenu - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-universal-attributes-overlay-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// ContextMenu 通过 bindContextMenu 方法绑定
// 无需额外导入,使用 Menu 组件定义内容
@ComponentV2
struct ContextMenuExample {
  @Local showMenu: boolean = false

  build() {
    Text('右键点击我')
      .bindContextMenu(this.showMenu, this.menuBuilder(), {
        responseType: ResponseType.RightClick
      })
  }

  @Builder
  menuBuilder() {
    Menu() {
      MenuItem({ content: '复制' })
      MenuItem({ content: '粘贴' })
    }
  }
}
```

### 1.2 基础用法

```typescript
// API 11: 通过 responseType 控制触发方式
Text('右键或长按')
  .bindContextMenu(this.menuBuilder(), ResponseType.LongPress, {
    preview: MenuPreviewMode.NONE
  })

// API 12+: 手动控制显示
Text('手动控制')
  .bindContextMenu(this.showMenu, this.menuBuilder(), {
    integrationMode: MenuIntegrationMode.EMBEDDED
  })
```

## 二、API 参数

### 2.1 bindContextMenu 方法签名

**API 11**:
```typescript
bindContextMenu(
  content: CustomBuilder,
  responseType: ResponseType,
  options?: ContextMenuOptions
): T
```

**API 12+**:
```typescript
bindContextMenu(
  isShown: boolean,
  content: CustomBuilder,
  options?: ContextMenuOptions
): T
```

### 2.2 ResponseType 枚举

| 值 | 描述 | 适用场景 |
|------|------|----------|
| `ResponseType.LongPress` | 长按触发 | 移动设备、触摸屏 |
| `ResponseType.RightClick` | 右键触发 | PC 端鼠标操作 |

### 2.3 ContextMenuOptions 参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| `preview` | `MenuPreviewMode` | 否 | NONE | 预览模式 |
| `placement` | `Placement` | 否 | - | 菜单显示位置 |
| `enableArrow` | `boolean` | 否 | false | 是否显示箭头 |
| `arrowOffset` | `Length` | 否 | - | 箭头偏移量 |
| `offset` | `Offset` | 否 | {x: 0, y: 0} | 菜单偏移量 |
| `integrationMode` | `MenuIntegrationMode` | 否 | EMBEDDED | 集成模式 |

### 2.4 MenuPreviewMode 枚举

| 值 | 描述 |
|------|------|
| `MenuPreviewMode.NONE` | 不显示预览 |
| `MenuPreviewMode.IMAGE` | 图片预览 |
| `MenuPreviewMode.TEXT` | 文本预览 |

### 2.5 MenuIntegrationMode 枚举

| 值 | 描述 |
|------|------|
| `MenuIntegrationMode.EMBEDDED` | 嵌入模式 |
| `MenuIntegrationMode.FLOATING` | 浮动模式 |

## 三、常用场景

### 3.1 右键菜单(PC 端)

```typescript
@ComponentV2
struct RightClickMenuExample {
  @Local showMenu: boolean = false
  @Local selectedAction: string = ''

  build() {
    Column({ space: 16 }) {
      Text('右键点击此文本')
        .width('100%')
        .height(100)
        .backgroundColor('#E0E0E0')
        .borderRadius(8)
        .textAlign(TextAlign.Center)
        .fontSize(16)
        .bindContextMenu(this.showMenu, this.menuBuilder(), {
          responseType: ResponseType.RightClick
        })

      if (this.selectedAction !== '') {
        Text(`已选择: ${this.selectedAction}`)
          .fontSize(14)
          .fontColor('#007DFF')
      }
    }
    .padding(16)
  }

  @Builder
  menuBuilder() {
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
    }
  }
}
```

### 3.2 长按菜单(移动端)

```typescript
@ComponentV2
struct LongPressMenuExample {
  @Local showMenu: boolean = false
  @Local selectedAction: string = ''

  build() {
    Column({ space: 16 }) {
      Text('长按此文本')
        .width('100%')
        .height(100)
        .backgroundColor('#E0E0E0')
        .borderRadius(8)
        .textAlign(TextAlign.Center)
        .fontSize(16)
        .bindContextMenu(this.showMenu, this.menuBuilder(), {
          responseType: ResponseType.LongPress,
          preview: MenuPreviewMode.TEXT
        })

      if (this.selectedAction !== '') {
        Text(`已选择: ${this.selectedAction}`)
          .fontSize(14)
          .fontColor('#007DFF')
      }
    }
    .padding(16)
  }

  @Builder
  menuBuilder() {
    Menu() {
      MenuItem({ content: '选择' })
        .onClick(() => {
          this.selectedAction = '选择'
        })
      MenuItem({ content: '全选' })
        .onClick(() => {
          this.selectedAction = '全选'
        })
      MenuItem({ content: '复制' })
        .onClick(() => {
          this.selectedAction = '复制'
        })
    }
  }
}
```

### 3.3 图片上下文菜单

```typescript
@ComponentV2
struct ImageContextMenuExample {
  @Local showMenu: boolean = false
  @Local selectedAction: string = ''

  build() {
    Column({ space: 16 }) {
      Image($r('app.media.app_icon'))
        .width(200)
        .height(200)
        .bindContextMenu(this.showMenu, this.imageMenuBuilder(), {
          responseType: ResponseType.RightClick,
          preview: MenuPreviewMode.IMAGE,
          enableArrow: true
        })

      if (this.selectedAction !== '') {
        Text(`已选择: ${this.selectedAction}`)
          .fontSize(14)
          .fontColor('#007DFF')
      }
    }
    .padding(16)
  }

  @Builder
  imageMenuBuilder() {
    Menu() {
      MenuItem({ content: '查看图片' })
        .onClick(() => {
          this.selectedAction = '查看图片'
        })
      MenuItem({ content: '复制图片' })
        .onClick(() => {
          this.selectedAction = '复制图片'
        })
      MenuItem({ content: '保存图片' })
        .onClick(() => {
          this.selectedAction = '保存图片'
        })
      MenuItem({ content: '分享图片' })
        .onClick(() => {
          this.selectedAction = '分享图片'
        })
    }
  }
}
```

### 3.4 列表项上下文菜单

```typescript
@ComponentV2
struct ListItemContextMenuExample {
  @Local showMenu: boolean = false
  @Local items: Array<string> = [
    '项目1', '项目2', '项目3', '项目4', '项目5'
  ]
  @Local selectedAction: string = ''
  @Local selectedItem: string = ''

  build() {
    Column({ space: 16 }) {
      List({ space: 8 }) {
        ForEach(this.items, (item: string) => {
          ListItem() {
            Text(item)
              .width('100%')
              .height(60)
              .backgroundColor('#F5F5F5')
              .borderRadius(8)
              .textAlign(TextAlign.Center)
              .padding(12)
          }
          .bindContextMenu(this.showMenu, this.itemMenuBuilder(item), {
            responseType: ResponseType.RightClick
          })
        }, (item: string) => item)
      }
      .width('100%')
      .layoutWeight(1)

      if (this.selectedItem !== '') {
        Text(`${this.selectedAction}: ${this.selectedItem}`)
          .fontSize(14)
          .fontColor('#007DFF')
      }
    }
    .padding(16)
  }

  @Builder
  itemMenuBuilder(item: string) {
    Menu() {
      MenuItem({ content: '编辑' })
        .onClick(() => {
          this.selectedAction = '编辑'
          this.selectedItem = item
        })
      MenuItem({ content: '复制' })
        .onClick(() => {
          this.selectedAction = '复制'
          this.selectedItem = item
        })
      MenuItem({ content: '删除' })
        .onClick(() => {
          this.selectedAction = '删除'
          this.selectedItem = item
        })
    }
  }
}
```

### 3.5 文本编辑器上下文菜单

```typescript
@ComponentV2
struct TextEditorContextMenuExample {
  @Local showMenu: boolean = false
  @Local textContent: string = '这是一段示例文本,可以右键或长按显示编辑菜单'
  @Local selectedAction: string = ''
  @Local hasSelection: boolean = false

  build() {
    Column({ space: 16 }) {
      Text(this.textContent)
        .width('100%')
        .height(150)
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
        .padding(16)
        .maxLines(10)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .bindContextMenu(this.showMenu, this.editorMenuBuilder(), {
          responseType: ResponseType.RightClick,
          enableArrow: true
        })

      if (this.selectedAction !== '') {
        Text(`操作: ${this.selectedAction}`)
          .fontSize(14)
          .fontColor('#007DFF')
      }
    }
    .padding(16)
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
```

### 3.6 带图标的上下文菜单

```typescript
@ComponentV2
struct IconContextMenuExample {
  @Local showMenu: boolean = false
  @Local selectedAction: string = ''

  build() {
    Column({ space: 16 }) {
      Text('右键点击查看图标菜单')
        .width('100%')
        .height(100)
        .backgroundColor('#E0E0E0')
        .borderRadius(8)
        .textAlign(TextAlign.Center)
        .fontSize(16)
        .bindContextMenu(this.showMenu, this.iconMenuBuilder(), {
          responseType: ResponseType.RightClick,
          enableArrow: true
        })

      if (this.selectedAction !== '') {
        Text(`已选择: ${this.selectedAction}`)
          .fontSize(14)
          .fontColor('#007DFF')
      }
    }
    .padding(16)
  }

  @Builder
  iconMenuBuilder() {
    Menu() {
      MenuItem({
        content: '新建',
        startIcon: $r('app.media.ic_add')
      })
        .onClick(() => {
          this.selectedAction = '新建'
        })
      MenuItem({
        content: '编辑',
        startIcon: $r('app.media.ic_edit')
      })
        .onClick(() => {
          this.selectedAction = '编辑'
        })
      MenuItem({
        content: '删除',
        startIcon: $r('app.media.ic_delete')
      })
        .onClick(() => {
          this.selectedAction = '删除'
        })
      MenuItem({
        content: '分享',
        endIcon: $r('app.media.ic_share')
      })
        .onClick(() => {
          this.selectedAction = '分享'
        })
    }
  }
}
```

### 3.7 文件管理器上下文菜单

```typescript
@ComponentV2
struct FileContextMenuExample {
  @Local showMenu: boolean = false
  @Local selectedAction: string = ''
  @Local selectedFile: string = ''

  build() {
    Column({ space: 16 }) {
      Row({ space: 12 }) {
        Image($r('app.media.ic_file'))
          .width(48)
          .height(48)

        Column({ space: 4 }) {
          Text('document.txt')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
          Text('2.5 MB')
            .fontSize(14)
            .fontColor('#999999')
        }
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)
      .bindContextMenu(this.showMenu, this.fileMenuBuilder('document.txt'), {
        responseType: ResponseType.RightClick,
        preview: MenuPreviewMode.TEXT
      })

      if (this.selectedFile !== '') {
        Text(`${this.selectedAction}: ${this.selectedFile}`)
          .fontSize(14)
          .fontColor('#007DFF')
      }
    }
    .padding(16)
  }

  @Builder
  fileMenuBuilder(fileName: string) {
    Menu() {
      MenuItemGroup({ header: '文件操作' }) {
        MenuItem({
          content: '打开',
          startIcon: $r('app.media.ic_open')
        })
          .onClick(() => {
            this.selectedAction = '打开'
            this.selectedFile = fileName
          })
        MenuItem({
          content: '重命名',
          startIcon: $r('app.media.ic_edit')
        })
          .onClick(() => {
            this.selectedAction = '重命名'
            this.selectedFile = fileName
          })
        MenuItem({
          content: '复制',
          startIcon: $r('app.media.ic_copy')
        })
          .onClick(() => {
            this.selectedAction = '复制'
            this.selectedFile = fileName
          })
        MenuItem({
          content: '删除',
          startIcon: $r('app.media.ic_delete')
        })
          .onClick(() => {
            this.selectedAction = '删除'
            this.selectedFile = fileName
          })
      }

      MenuItemGroup({ header: '其他操作' }) {
        MenuItem({
          content: '属性',
          endIcon: $r('app.media.ic_arrow_right')
        })
          .onClick(() => {
            this.selectedAction = '查看属性'
            this.selectedFile = fileName
          })
        MenuItem({
          content: '分享',
          endIcon: $r('app.media.ic_share')
        })
          .onClick(() => {
            this.selectedAction = '分享'
            this.selectedFile = fileName
          })
      }
    }
  }
}
```

## 四、高级特性

### 4.1 手动控制显示(API 12+)

```typescript
@ComponentV2
struct ManualContextMenuExample {
  @Local showMenu: boolean = false
  @Local selectedAction: string = ''

  build() {
    Column({ space: 16 }) {
      Row({ space: 12 }) {
        Button('显示菜单')
          .onClick(() => {
            this.showMenu = true
          })

        Button('隐藏菜单')
          .onClick(() => {
            this.showMenu = false
          })
      }

      Text('右键或点击按钮')
        .width('100%')
        .height(100)
        .backgroundColor('#E0E0E0')
        .borderRadius(8)
        .textAlign(TextAlign.Center)
        .fontSize(16)
        .bindContextMenu(this.showMenu, this.menuBuilder(), {
          integrationMode: MenuIntegrationMode.EMBEDDED
        })

      if (this.selectedAction !== '') {
        Text(`已选择: ${this.selectedAction}`)
          .fontSize(14)
          .fontColor('#007DFF')
      }
    }
    .padding(16)
  }

  @Builder
  menuBuilder() {
    Menu() {
      MenuItem({ content: '选项1' })
        .onClick(() => {
          this.selectedAction = '选项1'
        })
      MenuItem({ content: '选项2' })
        .onClick(() => {
          this.selectedAction = '选项2'
        })
    }
  }
}
```

### 4.2 自定义菜单位置

```typescript
@ComponentV2
struct CustomPositionContextMenuExample {
  @Local showMenu: boolean = false

  build() {
    Column({ space: 16 }) {
      Text('右键点击')
        .width('100%')
        .height(100)
        .backgroundColor('#E0E0E0')
        .borderRadius(8)
        .textAlign(TextAlign.Center)
        .fontSize(16)
        .bindContextMenu(this.showMenu, this.menuBuilder(), {
          responseType: ResponseType.RightClick,
          placement: Placement.Right,
          offset: { x: 10, y: 10 },
          enableArrow: true,
          arrowOffset: 20
        })
    }
    .padding(16)
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

### 4.3 带预览的上下文菜单

```typescript
@ComponentV2
struct PreviewContextMenuExample {
  @Local showMenu: boolean = false

  build() {
    Column({ space: 16 }) {
      Text('长按查看预览')
        .width('100%')
        .height(100)
        .backgroundColor('#E0E0E0')
        .borderRadius(8)
        .textAlign(TextAlign.Center)
        .fontSize(16)
        .bindContextMenu(this.showMenu, this.previewMenuBuilder(), {
          responseType: ResponseType.LongPress,
          preview: MenuPreviewMode.TEXT
        })
    }
    .padding(16)
  }

  @Builder
  previewMenuBuilder() {
    Menu() {
      MenuItem({ content: '编辑' })
      MenuItem({ content: '删除' })
      MenuItem({ content: '分享' })
    }
  }
}
```

## 五、最佳实践

### 5.1 菜单项组织

```typescript
// ✅ GOOD: 使用分组组织相关菜单项
@Builder
contextMenuBuilder() {
  Menu() {
    MenuItemGroup({ header: '常用操作' }) {
      MenuItem({ content: '复制' })
      MenuItem({ content: '粘贴' })
    }

    MenuItemGroup({ header: '高级操作' }) {
      MenuItem({ content: '删除' })
      MenuItem({ content: '重命名' })
    }
  }
}

// ❌ BAD: 所有菜单项平铺
@Builder
contextMenuBuilder() {
  Menu() {
    MenuItem({ content: '复制' })
    MenuItem({ content: '粘贴' })
    MenuItem({ content: '删除' })
    MenuItem({ content: '重命名' })
    MenuItem({ content: '属性' })
    MenuItem({ content: '分享' })
    // ...更多菜单项
  }
}
```

### 5.2 触发方式选择

```typescript
// ✅ GOOD: 根据平台选择合适的触发方式
Text('右键或长按')
  .bindContextMenu(this.showMenu, this.menuBuilder(), {
    responseType: ResponseType.RightClick  // PC 端
  })

Text('右键或长按')
  .bindContextMenu(this.showMenu, this.menuBuilder(), {
    responseType: ResponseType.LongPress  // 移动端
  })
```

### 5.3 菜单项数量

```typescript
// ✅ GOOD: 合理的菜单项数量(建议 3-7 个)
@Builder
contextMenuBuilder() {
  Menu() {
    MenuItem({ content: '复制' })
    MenuItem({ content: '粘贴' })
    MenuItem({ content: '删除' })
    MenuItem({ content: '重命名' })
    MenuItem({ content: '属性' })
  }
}

// ❌ BAD: 菜单项过多
@Builder
contextMenuBuilder() {
  Menu() {
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
  }
}
```

### 5.4 上下文相关性

```typescript
// ✅ GOOD: 菜单项与上下文相关
ListItem() {
  Text('文件.txt')
}
.bindContextMenu(this.showMenu, this.fileMenuBuilder(), {
  responseType: ResponseType.RightClick
})

@Builder
fileMenuBuilder() {
  Menu() {
    MenuItem({ content: '打开' })      // 文件相关
    MenuItem({ content: '重命名' })    // 文件相关
    MenuItem({ content: '删除' })      // 文件相关
  }
}

// ❌ BAD: 菜单项与上下文无关
ListItem() {
  Text('文件.txt')
}
.bindContextMenu(this.showMenu, this.unrelatedMenuBuilder(), {
  responseType: ResponseType.RightClick
})

@Builder
unrelatedMenuBuilder() {
  Menu() {
    MenuItem({ content: '系统设置' })  // 与文件无关
    MenuItem({ content: '用户管理' })  // 与文件无关
    MenuItem({ content: '网络配置' })  // 与文件无关
  }
}
```

## 六、注意事项

### 6.1 兼容性

- **API 版本**: bindContextMenu 从 API 8 开始支持
- **手动控制**: isShown 参数从 API 12 开始支持
- **预览模式**: 部分预览模式可能在某些设备上不可用

### 6.2 限制

1. **CustomBuilder**: content 参数必须是 CustomBuilder 类型
2. **响应类型**: responseType 参数在 API 12+ 可以省略(使用 isShown)
3. **预览限制**: 预览功能仅在 responseType 为 LongPress 时有效

### 6.3 常见问题

**Q: ContextMenu 不显示?**
A: 检查 isShow 或 isShown 状态是否正确,确保触发方式适合当前平台

**Q: 预览不显示?**
A: 确保使用 ResponseType.LongPress 且设置了 preview 参数

**Q: 菜单位置不正确?**
A: 使用 placement 和 offset 参数调整菜单位置

## 七、完整示例

```typescript
@Entry
@ComponentV2
struct ContextMenuCompleteExample {
  @Local showMenu: boolean = false
  @Local selectedAction: string = ''
  @Local selectedFile: string = ''
  @Local hasSelection: boolean = false

  build() {
    Scroll() {
      Column({ space: 20 }) {
        Text('ContextMenu 右键菜单完整示例')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .width('100%')

        // 基础上下文菜单
        this.BasicContextMenuCard()

        // 图片上下文菜单
        this.ImageContextMenuCard()

        // 文件上下文菜单
        this.FileContextMenuCard()

        // 文本编辑器上下文菜单
        this.TextEditorContextMenuCard()

        // 显示选择结果
        if (this.selectedAction !== '') {
          Column() {
            Text('操作结果')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)

            Text(`${this.selectedAction}${this.selectedFile ? ': ' + this.selectedFile : ''}`)
              .fontSize(14)
              .fontColor('#007DFF')
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#F0F0F0')
          .borderRadius(8)
        }
      }
      .width('100%')
      .padding(20)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  @Builder
  BasicContextMenuCard() {
    Column({ space: 12 }) {
      Text('基础上下文菜单')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Text('右键或长按此区域')
        .width('100%')
        .height(100)
        .backgroundColor('#E0E0E0')
        .borderRadius(8)
        .textAlign(TextAlign.Center)
        .fontSize(16)
        .bindContextMenu(this.showMenu, this.basicMenuBuilder(), {
          responseType: ResponseType.RightClick,
          enableArrow: true
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }

  @Builder
  basicMenuBuilder() {
    Menu() {
      MenuItemGroup({ header: '常用操作' }) {
        MenuItem({ content: '复制' })
          .onClick(() => {
            this.selectedAction = '复制'
          })
        MenuItem({ content: '粘贴' })
          .onClick(() => {
            this.selectedAction = '粘贴'
          })
      }

      MenuItemGroup({ header: '其他操作' }) {
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

  @Builder
  ImageContextMenuCard() {
    Column({ space: 12 }) {
      Text('图片上下文菜单')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Image($r('app.media.app_icon'))
        .width(120)
        .height(120)
        .bindContextMenu(this.showMenu, this.imageMenuBuilder(), {
          responseType: ResponseType.RightClick,
          preview: MenuPreviewMode.IMAGE
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }

  @Builder
  imageMenuBuilder() {
    Menu() {
      MenuItem({ content: '查看图片' })
        .onClick(() => {
          this.selectedAction = '查看图片'
        })
      MenuItem({ content: '复制图片' })
        .onClick(() => {
          this.selectedAction = '复制图片'
        })
      MenuItem({ content: '保存图片' })
        .onClick(() => {
          this.selectedAction = '保存图片'
        })
      MenuItem({ content: '分享图片' })
        .onClick(() => {
          this.selectedAction = '分享图片'
        })
    }
  }

  @Builder
  FileContextMenuCard() {
    Column({ space: 12 }) {
      Text('文件上下文菜单')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 12 }) {
        Image($r('app.media.ic_file'))
          .width(48)
          .height(48)

        Column({ space: 4 }) {
          Text('document.txt')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
          Text('2.5 MB')
            .fontSize(14)
            .fontColor('#999999')
        }
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#E0E0E0')
      .borderRadius(8)
      .bindContextMenu(this.showMenu, this.fileMenuBuilder('document.txt'), {
        responseType: ResponseType.RightClick
      })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }

  @Builder
  fileMenuBuilder(fileName: string) {
    Menu() {
      MenuItemGroup({ header: '文件操作' }) {
        MenuItem({
          content: '打开',
          startIcon: $r('app.media.ic_open')
        })
          .onClick(() => {
            this.selectedAction = '打开'
            this.selectedFile = fileName
          })
        MenuItem({
          content: '重命名',
          startIcon: $r('app.media.ic_edit')
        })
          .onClick(() => {
            this.selectedAction = '重命名'
            this.selectedFile = fileName
          })
        MenuItem({
          content: '删除',
          startIcon: $r('app.media.ic_delete')
        })
          .onClick(() => {
            this.selectedAction = '删除'
            this.selectedFile = fileName
          })
      }
    }
  }

  @Builder
  TextEditorContextMenuCard() {
    Column({ space: 12 }) {
      Text('文本编辑器上下文菜单')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Text('这是一段示例文本,可以右键或长按显示编辑菜单')
        .width('100%')
        .height(100)
        .backgroundColor('#E0E0E0')
        .borderRadius(8)
        .padding(16)
        .maxLines(5)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .bindContextMenu(this.showMenu, this.editorMenuBuilder(), {
          responseType: ResponseType.RightClick
        })
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
```

## 八、相关组件

- **Menu**: 菜单容器组件
- **MenuItem**: 菜单项组件
- **MenuItemGroup**: 菜单项分组组件
- **bindMenu**: 绑定点击菜单
- **bindContextMenu**: 绑定右键/长按菜单

## 参考资源

- [bindContextMenu 官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-universal-attributes-overlay-V5)
- [Menu 官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-menu-V5)
- [ContextMenu 官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-contextmenu-V5)
