# Panel 组件 HarmonyOS 6.0 开发 Skill

## 概述

Panel 是 OpenHarmony 中的面板组件，用于在页面底部或侧边弹出可交互的面板。它支持半屏、全屏等多种显示模式，适用于从底部弹出的菜单、设置面板等场景。

## 重要说明

- **基础组件**: Panel 是 ArkUI 的内置容器组件，无需导入
- **显示位置**: 支持从底部、顶部、左侧、右侧弹出
- **显示模式**: 支持半屏、全屏、弹窗等多种模式
- **交互: 支持手势滑动关闭

## 模块信息

- **组件名称**: Panel
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [Panel 面板 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-panel-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// Panel 是内置组件，无需导入
// 直接使用即可
Panel() {
  Text('Panel Content')
}
.mode(PanelMode.Half)
.type(PanelType.Foldable)
```

### 1.2 基础用法

```typescript
@State isOpen: boolean = false

Button('Show Panel')
  .onClick(() => {
    this.isOpen = true
  })

Panel() {
  Column() {
    Text('Panel Content')
      .fontSize(18)
    Text('Swipe down to close')
      .fontSize(14)
      .fontColor('#666666')
      .margin({ top: 8 })
  }
  .width('100%')
  .height('100%')
  .padding(16)
}
.mode(PanelMode.Half)
.type(PanelType.Foldable)
.show(this.isOpen)
.onChange((value: boolean) => {
  this.isOpen = value
})
```

## 二、API 参数

### 2.1 Panel 构造参数

Panel 组件不需要构造参数，直接通过属性配置。

### 2.2 Panel 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `mode` | `PanelMode` | PanelMode.Half | 面板显示模式 |
| `type` | `PanelType` | PanelType.Foldable | 面板类型 |
| `show` | `boolean` | false | 是否显示面板 |
| `backgroundMask` | `ResourceColor` | - | 背景遮罩颜色 |
| `dragBar` | `boolean` | true | 是否显示拖拽栏 |
| `height` | `number \| string` | - | 面板高度（Half 模式） |
| `customHeight` | `number \| string` | - | 自定义高度 |

### 2.3 PanelMode 显示模式

| 值 | 描述 |
|------|------|
| `PanelMode.Min` | 最小模式（仅拖拽栏） |
| `PanelMode.Half` | 半屏模式（默认） |
| `PanelMode.Full` | 全屏模式 |

### 2.4 PanelType 面板类型

| 值 | 描述 |
|------|------|
| `PanelType.Foldable` | 可折叠（默认） |
| `PanelType.Temp` | 临时面板 |
| `PanelType.Popover` | 气泡面板 |

### 2.5 Panel 事件

| 事件 | 类型 | 描述 |
|------|------|------|
| `onChange` | `(value: boolean) => void` | 面板显示/隐藏状态变化时触发 |

## 三、使用示例

### 3.1 基础面板

```typescript
@State isOpen: boolean = false

Column() {
  Button('Open Panel')
    .onClick(() => {
      this.isOpen = true
    })

  Panel() {
    Column() {
      Text('Panel Content')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
      Text('This is a half-screen panel')
        .fontSize(16)
        .fontColor('#666666')
        .margin({ top: 8 })
    }
    .width('100%')
    .height('100%')
    .padding(20)
  }
  .mode(PanelMode.Half)
  .type(PanelType.Foldable)
  .show(this.isOpen)
  .onChange((value: boolean) => {
    this.isOpen = value
  })
}
.width('100%')
.height('100%')
```

### 3.2 全屏面板

```typescript
@State isOpen: boolean = false

Button('Open Full Screen')
  .onClick(() => {
    this.isOpen = true
  })

Panel() {
  Column() {
    Text('Full Screen Panel')
      .fontSize(24)
      .fontWeight(FontWeight.Bold)

    ForEach([1, 2, 3, 4, 5], (item: number) => {
      Text(`Item ${item}`)
        .fontSize(16)
        .width('100%')
        .height(60)
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
        .textAlign(TextAlign.Center)
        .margin({ top: 12 })
    })
  }
  .width('100%')
  .height('100%')
  .padding(20)
}
.mode(PanelMode.Full)
.type(PanelType.Foldable)
.show(this.isOpen)
.onChange((value: boolean) => {
  this.isOpen = value
})
```

### 3.3 设置面板

```typescript
@State isOpen: boolean = false
@State selectedValue: string = 'Option 1'

Button('Show Settings')
  .onClick(() => {
    this.isOpen = true
  })

Panel() {
  Column() {
    Text('Settings')
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
      .width('100%')
      .margin({ bottom: 20 })

    ForEach(['Option 1', 'Option 2', 'Option 3'], (option: string) => {
      Row() {
        Text(option)
          .fontSize(16)
          .layoutWeight(1)

        if (this.selectedValue === option) {
          Text('✓')
            .fontSize(20)
            .fontColor('#007DFF')
        }
      }
      .width('100%')
      .height(50)
      .backgroundColor(this.selectedValue === option ? '#E3F2FD' : '#F5F5F5')
      .borderRadius(8)
      .padding({ left: 16, right: 16 })
      .onClick(() => {
        this.selectedValue = option
        this.isOpen = false
      })
    })
  }
  .width('100%')
  .height('100%')
  .padding(20)
}
.mode(PanelMode.Half)
.type(PanelType.Foldable)
.dragBar(true)
.show(this.isOpen)
.onChange((value: boolean) => {
  this.isOpen = value
})
```

### 3.4 自定义高度面板

```typescript
@State isOpen: boolean = false

Button('Open Custom Panel')
  .onClick(() => {
    this.isOpen = true
  })

Panel() {
  Column() {
    Text('Custom Height Panel')
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
    Text('Height: 300vp')
      .fontSize(16)
      .fontColor('#666666')
      .margin({ top: 8 })
  }
  .width('100%')
  .height('100%')
  .padding(20)
}
.mode(PanelMode.Half)
.type(PanelType.Foldable)
.customHeight(300)
.show(this.isOpen)
.onChange((value: boolean) => {
  this.isOpen = value
})
```

### 3.5 带背景遮罩的面板

```typescript
@State isOpen: boolean = false

Button('Open with Mask')
  .onClick(() => {
    this.isOpen = true
  })

Panel() {
  Column() {
    Text('Panel with Background Mask')
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
    Text('Background mask color: rgba(0, 0, 0, 0.5)')
      .fontSize(14)
      .fontColor('#666666')
      .margin({ top: 8 })
  }
  .width('100%')
  .height('100%')
  .padding(20)
}
.mode(PanelMode.Half)
.type(PanelType.Foldable)
.backgroundMask('rgba(0, 0, 0, 0.5)')
.show(this.isOpen)
.onChange((value: boolean) => {
  this.isOpen = value
})
```

### 3.6 最小模式面板

```typescript
@State panelMode: PanelMode = PanelMode.Min

Button('Toggle Panel Mode')
  .onClick(() => {
    this.panelMode = this.panelMode === PanelMode.Min ? PanelMode.Half : PanelMode.Min
  })

Panel() {
  Column() {
    Text('Panel Mode: ' + (this.panelMode === PanelMode.Min ? 'Min' : 'Half'))
      .fontSize(18)
      .fontWeight(FontWeight.Bold)

    ForEach([1, 2, 3, 4, 5], (item: number) => {
      Text(`Item ${item}`)
        .fontSize(16)
        .width('100%')
        .height(60)
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
        .textAlign(TextAlign.Center)
        .margin({ top: 12 })
    })
  }
  .width('100%')
  .height('100%')
  .padding(20)
}
.mode(this.panelMode)
.type(PanelType.Foldable)
.dragBar(true)
.show(true)
```

## 四、最佳实践

### 4.1 使用状态控制显示

```typescript
// ✅ 推荐：使用状态变量控制
@State isOpen: boolean = false

Panel() {
  Text('Content')
}
.show(this.isOpen)
.onChange((value: boolean) => {
  this.isOpen = value
})

// ❌ 避免：硬编码状态
Panel() {
  Text('Content')
}
.show(true)  // 始终显示
```

### 4.2 设置合适的模式

```typescript
// ✅ 推荐：根据内容选择合适的模式
// 少量内容：使用 Half 模式
Panel() {
  Text('Short content')
}
.mode(PanelMode.Half)

// 大量内容：使用 Full 模式
Panel() {
  Column() {
    ForEach(largeDataSet, (item) => {
      Text(item)
    })
  }
}
.mode(PanelMode.Full)
```

### 4.3 添加背景遮罩

```typescript
// ✅ 推荐：添加半透明背景遮罩
Panel() {
  Text('Content')
}
.backgroundMask('rgba(0, 0, 0, 0.5)')
.show(this.isOpen)
```

## 五、常见问题

### Q1: 面板不显示？

**解决方案**:
```typescript
// 确保 show 属性设置为 true
@State isOpen: boolean = false

Panel() {
  Text('Content')
}
.show(this.isOpen)  // 必须设置为 true

Button('Show Panel')
  .onClick(() => {
    this.isOpen = true
  })
```

### Q2: 如何关闭面板？

**解决方案**:
```typescript
// 方式 1：通过 onChange 事件
Panel() {
  Text('Content')
}
.show(this.isOpen)
.onChange((value: boolean) => {
  this.isOpen = value  // 用户滑动面板时自动更新
})

// 方式 2：通过按钮关闭
Panel() {
  Column() {
    Button('Close')
      .onClick(() => {
        this.isOpen = false
      })
  }
}
.show(this.isOpen)
```

### Q3: 如何自定义面板高度？

**解决方案**:
```typescript
// 使用 customHeight 属性
Panel() {
  Text('Content')
}
.mode(PanelMode.Half)
.customHeight(300)  // 自定义高度为 300vp
```

## 六、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 12+ | ✅ | 完全支持 |

## 七、参考资料

- [Panel 面板 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-panel-V5)
- [通用属性 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-universal-attributes-size-V5)
