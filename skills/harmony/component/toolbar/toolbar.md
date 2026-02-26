# ToolBar Component

## Overview

ToolBar is a toolbar component in OpenHarmony that provides a convenient way to group and display action items, typically placed at the top or bottom of an interface.

## Basic Usage

### Simple ToolBar

```typescript
Column() {
  // Main content
  Text('内容区域')
    .layoutWeight(1)

  // ToolBar at bottom
  ToolBar() {
    ToolBarItem() {
      Text('编辑')
        .fontSize(14)
    }
    ToolBarItem() {
      Text('删除')
        .fontSize(14)
    }
  }
}
.width('100%')
.height(400)
```

## Constructor Parameters

```typescript
ToolBar()
```

No required parameters - uses child ToolBarItem components.

## ToolBarItem

### Basic Structure

```typescript
ToolBarItem() {
  // Content - typically Text, Image, or Icon
  Text('按钮文本')
}
.onClick(() => {
  // Handle click
})
```

## Common Attributes

### ToolBar Attributes

```typescript
ToolBar()
  .height(48)              // Toolbar height
  .backgroundColor('#F5F5F5')  // Background color
  .padding({ left: 16, right: 16 })  // Internal padding
```

### ToolBarItem Attributes

```typescript
ToolBarItem() {
  Text('操作')
}
.width(60)                // Item width
.height(40)               // Item height
.backgroundColor('#007DFF')  // Background color
.borderRadius(8)          // Corner radius
.onClick(() => {
  // Action handler
})
```

## Common Use Cases

### Icon Toolbar

```typescript
@ComponentV2
export struct IconToolBar {
  @Local selectedTool: string = 'home'

  build() {
    Column() {
      Text('主内容区域')
        .fontSize(16)
        .layoutWeight(1)

      ToolBar() {
        ForEach([
          { name: 'home', icon: '🏠' },
          { name: 'search', icon: '🔍' },
          { name: 'settings', icon: '⚙️' }
        ], (item: Record<string, string>) => {
          ToolBarItem() {
            Column({ space: 4 }) {
              Text(item.icon)
                .fontSize(24)
              Text(item.name)
                .fontSize(12)
                .fontColor(this.selectedTool === item.name ? '#007DFF' : '#666666')
            }
          }
          .onClick(() => {
            this.selectedTool = item.name
          })
        })
      }
    }
    .width('100%')
    .height(400)
  }
}
```

### Action Toolbar

```typescript
@ComponentV2
export struct ActionToolBar {
  @Local selectedAction: string = ''

  build() {
    Column() {
      Text('选择操作:')
        .fontSize(16)
      Text(this.selectedAction)
        .fontSize(20)
        .fontColor('#007DFF')
        .margin({ top: 8 })

      Blank()

      ToolBar() {
        ForEach(['编辑', '删除', '分享', '更多'], (action: string) => {
          ToolBarItem() {
            Text(action)
              .fontSize(14)
              .fontColor('#FFFFFF')
          }
          .width(70)
          .height(36)
          .backgroundColor('#007DFF')
          .borderRadius(18)
          .onClick(() => {
            this.selectedAction = action
          })
        })
      }
    }
    .width('100%')
    .height(300)
    .padding(16)
  }
}
```

### Text and Icon Toolbar

```typescript
@ComponentV2
export struct MixedToolBar {
  @Local activeIndex: number = 0

  build() {
    Column() {
      Text(`当前选项: ${['首页', '消息', '发现', '我的'][this.activeIndex]}`)
        .fontSize(18)
        .layoutWeight(1)

      ToolBar() {
        ForEach(['首页', '消息', '发现', '我的'], (title: string, index: number) => {
          ToolBarItem() {
            Column({ space: 2 }) {
              Text(this.getIcon(index))
                .fontSize(22)
              Text(title)
                .fontSize(10)
                .fontColor(this.activeIndex === index ? '#007DFF' : '#999999')
                .fontWeight(this.activeIndex === index ? FontWeight.Bold : FontWeight.Normal)
            }
          }
          .onClick(() => {
            this.activeIndex = index
          })
        })
      }
      .height(56)
      .backgroundColor('#FFFFFF')
      .border({ width: { top: 1 }, color: '#E5E5E5' })
    }
    .width('100%')
    .height(300)
  }

  private getIcon(index: number): string {
    const icons = ['🏠', '💬', '🔍', '👤']
    return icons[index] || ''
  }
}
```

### Custom Toolbar with Badge

```typescript
@ComponentV2
export struct BadgeToolBar {
  @Local notificationCount: number = 5
  @Local selectedTab: string = 'home'

  build() {
    Column() {
      Text('工具栏示例')
        .layoutWeight(1)

      ToolBar() {
        ForEach([
          { id: 'home', label: '首页', icon: '🏠' },
          { id: 'message', label: '消息', icon: '💬', badge: this.notificationCount },
          { id: 'profile', label: '我的', icon: '👤' }
        ], (item: Record<string, Object>) => {
          ToolBarItem() {
            Stack({ alignContent: Alignment.TopEnd }) {
              Column({ space: 2 }) {
                Text(item['icon'] as string)
                  .fontSize(24)
                Text(item['label'] as string)
                  .fontSize(11)
                  .fontColor(this.selectedTab === item['id'] ? '#007DFF' : '#666666')
              }

              // Badge
              if (item['badge'] && (item['badge'] as number) > 0) {
                Text(item['badge'] as string)
                  .fontSize(10)
                  .fontColor('#FFFFFF')
                  .backgroundColor('#FF0000')
                  .borderRadius(10)
                  .padding({ left: 4, right: 4, top: 1, bottom: 1 })
                  .margin({ top: -4, right: -4 })
              }
            }
          }
          .onClick(() => {
            this.selectedTab = item['id'] as string
          })
        })
      }
      .height(60)
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height(400)
  }
}
```

## Best Practices

1. **Icon Selection**: Use clear, recognizable icons
2. **Touch Targets**: Ensure toolbar items are at least 48x48px for easy tapping
3. **Visual Feedback**: Highlight active items with color or weight changes
4. **Labels**: Provide text labels for clarity, especially for less obvious icons
5. **Grouping**: Group related actions together logically
6. **Positioning**: Place toolbars consistently (usually top or bottom)

## Related Components

- [TabBar](../tabbar/tabbar.md) - For tab-based navigation
- [NavigationBar](../navigationbar/navigationbar.md) - For top navigation
- [SideBar](../sidebar/sidebar.md) - For sidebar navigation

## Differences from Similar Components

- **ToolBar**: General-purpose action bar, flexible positioning
- **TabBar**: Specifically for tab navigation, typically at bottom
- **NavigationBar**: For app/page titles and top-level navigation

## API Reference

For complete API documentation, see the official OpenHarmony documentation.

## Examples

See [`SideBarExample.ets`](../../../../ycomponent/src/main/ets/components/sidebar/SideBarExample.ets) for comprehensive ToolBar examples.
