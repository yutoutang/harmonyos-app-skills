# SideBar Component

## Overview

SideBar is a container component in OpenHarmony that provides a sidebar navigation pattern, typically used for creating responsive layouts with a collapsible side panel.

## Basic Usage

### Simple SideBar

```typescript
SideBarContainer(SideBarContainer.Edge.Start) {
  // Sidebar content (left)
  Column() {
    Text('侧边栏')
  }
  .width('80%')
  .backgroundColor('#F5F5F5')

  // Main content (right)
  Column() {
    Text('主内容区')
  }
  .width('100%')
  .backgroundColor('#FFFFFF')
}
.width('100%')
.height(300)
```

## Constructor Parameters

```typescript
SideBarContainer(type: SideBarContainer.Edge)
```

**Type Values:**
- `SideBarContainer.Edge.Start` - Sidebar on the left (default)
- `SideBarContainer.Edge.End` - Sidebar on the right

## Common Attributes

### Size Control

```typescript
SideBarContainer(SideBarContainer.Edge.Start) {
  // content...
}
.width('100%')              // Container width
.height(400)               // Container height
```

### Sidebar Mode

```typescript
SideBarContainer(SideBarContainer.Edge.Start) {
  // content...
}
.sidebarPosition(SideBarContainer.SidebarPosition.Start)  // Sidebar position
.autoHide(false)             // Auto-hide when not in use
.controlButton(true)         // Show control button
```

### Width Control

```typescript
SideBarContainer(SideBarContainer.Edge.Start) {
  // content...
}
.minSideBarWidth(200)        // Minimum sidebar width
.maxSideBarWidth(400)        // Maximum sidebar width
.realSideBarWidth(300)       // Actual sidebar width
```

## Common Use Cases

### Navigation Menu

```typescript
@ComponentV2
export struct NavigationSideBar {
  @Local selectedIndex: number = 0
  private menuItems: string[] = ['首页', '发现', '消息', '我的']

  build() {
    SideBarContainer(SideBarContainer.Edge.Start) {
      // Sidebar menu
      Column() {
        ForEach(this.menuItems, (item: string, index: number) => {
          Text(item)
            .width('100%')
            .height(50)
            .fontSize(16)
            .fontColor(this.selectedIndex === index ? '#007DFF' : '#333333')
            .backgroundColor(this.selectedIndex === index ? '#E6F0FF' : Color.Transparent)
            .textAlign(TextAlign.Center)
            .onClick(() => {
              this.selectedIndex = index
            })
        })
      }
      .width('80%')
      .height('100%')
      .backgroundColor('#F5F5F5')

      // Main content
      Column() {
        Text(`当前选中: ${this.menuItems[this.selectedIndex]}`)
          .fontSize(20)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height(300)
  }
}
```

### Right Sidebar

```typescript
@ComponentV2
export struct RightSideBar {
  @Local showSideBar: boolean = true

  build() {
    SideBarContainer(SideBarContainer.Edge.End) {
      // Main content
      Column() {
        Text('主内容区')
      }
      .width('100%')
      .height('100%')

      // Right sidebar
      Column() {
        Text('右侧边栏')
      }
      .width('80%')
      .height('100%')
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .height(400)
  }
}
```

### Responsive Layout

```typescript
@ComponentV2
export struct ResponsiveSideBar {
  @Local isExpanded: boolean = false

  build() {
    SideBarContainer(SideBarContainer.Edge.Start) {
      // Sidebar
      Column() {
        Text('菜单项1')
        Text('菜单项2')
        Text('菜单项3')
      }
      .width(this.isExpanded ? '80%' : '60%')
      .backgroundColor('#F5F5F5')
      .transition({ type: TransitionType.All, opacity: 1 })

      // Main content
      Column() {
        Button('切换侧边栏')
          .onClick(() => {
            this.isExpanded = !this.isExpanded
          })
      }
      .width('100%')
    }
    .width('100%')
    .height(500)
  }
}
```

## Events

### onChange Callback

```typescript
SideBarContainer(SideBarContainer.Edge.Start) {
  // content...
}
.onChange((value: boolean) => {
  console.log('Sidebar shown:', value)
})
```

## Best Practices

1. **Width Management**: Use percentage-based widths for responsive design
2. **Content Organization**: Keep sidebar content focused and concise
3. **Visual Hierarchy**: Use colors and typography to indicate active state
4. **Accessibility**: Provide clear labels and navigation patterns

## Related Components

- [Navigator](../navigator/navigator.md) - For complex navigation
- [Tabs](../tabs/tabs.md) - For tab-based navigation
- [Panel](../panel/panel.md) - For slide-out panels

## API Reference

For complete API documentation, see the official OpenHarmony documentation.

## Examples

See [`SideBarExample.ets`](../../../../ycomponent/src/main/ets/components/sidebar/SideBarExample.ets) for comprehensive examples.
