# HarmonyOS UI Design System

本文档基于40+优质HarmonyOS应用模板总结的设计规范和样式风格指南。

## Table of Contents

- [Color System](#color-system)
- [Typography](#typography)
- [Spacing System](#spacing-system)
- [Border Radius](#border-radius)
- [Shadows](#shadows)
- [Component Patterns](#component-patterns)
- [Responsive Design](#responsive-design)
- [Dark Mode](#dark-mode)

---

## Color System

### System Colors

优先使用系统内置颜色，确保应用与系统风格一致：

```typescript
// 文本颜色
$r('sys.color.ohos_id_color_text_primary')    // 主要文本
$r('sys.color.ohos_id_color_text_secondary')  // 次要文本
$r('sys.color.ohos_id_color_text_tertiary')   // 辅助文本

// 背景颜色
$r('sys.color.ohos_id_color_background')      // 默认背景
$r('sys.color.white')                          // 白色背景

// 强调色
$r('sys.color.ohos_id_color_emphasize')       // 主题强调色
```

### Semantic Color Tokens

定义语义化颜色变量，便于主题切换和维护：

**color.json**
```json5
{
  "color": [
    // 主题色
    { "name": "system_theme_color", "value": "#FE4F35" },

    // 文本颜色层级
    { "name": "font_color_level1", "value": "#191919" },      // 主要文本 90%透明度
    { "name": "font_color_level2", "value": "#99000000" },     // 次要文本 60%透明度
    { "name": "font_color_level3", "value": "#9e9e9e" },       // 辅助文本

    // 文本颜色（深色背景用）
    { "name": "font_color_level1_invert", "value": "#ffffff" },
    { "name": "font_color_level2_invert", "value": "#99ffffff" },
    { "name": "font_color_level3_invert", "value": "#61ffffff" },

    // 图标颜色层级
    { "name": "icon_color_level1", "value": "#191919" },
    { "name": "icon_color_level2", "value": "#99000000" },
    { "name": "icon_color_level3", "value": "#9e9e9e" },

    // 状态颜色
    { "name": "icon_color_highlight", "value": "#007dff" },   // 高亮/链接
    { "name": "icon_color_warning", "value": "#fa2a2d" },     // 警告/错误
    { "name": "icon_color_success", "value": "#64BB5C" },     // 成功

    // 背景颜色
    { "name": "system_color_background_white", "value": "#ffffff" },
    { "name": "system_color_background_auxiliary", "value": "#f1f3f5" },
    { "name": "system_color_background_theme", "value": "#33FE4F35" }, // 20%透明度主题色

    // 分割线
    { "name": "system_color_divider", "value": "#f1f3f5" },

    // 阴影
    { "name": "system_color_background_shadow", "value": "#1A000000" } // 10%黑色
  ]
}
```

**Usage:**
```typescript
Text('主要内容')
  .fontColor($r('app.color.font_color_level1'))

Text('次要内容')
  .fontColor($r('app.color.font_color_level3'))

Image($r('app.media.icon'))
  .fillColor($r('app.color.icon_color_level2'))
```

### Color Usage Guidelines

| 应用场景 | 推荐颜色 | 说明 |
|---------|---------|------|
| 页面背景 | `$r('sys.color.ohos_id_color_background')` 或 `#FFFFFF` | 白色或系统背景色 |
| 卡片背景 | `#FFFFFF` | 纯白，轻微阴影 |
| 主要文本 | `$r('app.color.font_color_level1')` | 90%黑色 |
| 次要文本 | `$r('app.color.font_color_level2')` | 60%黑色 |
| 辅助文本 | `$r('app.color.font_color_level3')` | 灰色 |
| 主按钮 | `$r('app.color.system_theme_color')` | 应用主题色 |
| 次按钮 | 透明色 + 边框 | 轻量设计 |
| 分割线 | `$r('app.color.system_color_divider')` | 浅灰色 |
| 链接/高亮 | `$r('app.color.icon_color_highlight')` | 蓝色 |

---

## Typography

### System Font Sizes

优先使用系统字体大小：

```typescript
// 系统定义的字体大小
$r('sys.float.Display_L')   // 28sp - 大标题
$r('sys.float.Title_L')     // 20sp - 标题
$r('sys.float.Title_M')     // 18sp - 中等标题
$r('sys.float.Title_S')     // 16sp - 小标题
$r('sys.float.Body_L')      // 16sp - 大正文
$r('sys.float.Body_M')      // 14sp - 正文
$r('sys.float.Body_S')      // 12sp - 小正文
```

### Custom Font Sizes

在 `float.json` 中定义自定义字体大小：

```json5
{
  "float": [
    { "name": "title_lg_font_size", "value": "24" },
    { "name": "title_default_font_size", "value": "18" },
    { "name": "font_size_16", "value": "16" },
    { "name": "font_size_14", "value": "14" },
    { "name": "font_size_12", "value": "12" },
    { "name": "font_size_10", "value": "10" }
  ]
}
```

### Typography Patterns

```typescript
// 页面大标题
Text('首页')
  .fontSize($r('app.float.title_lg_font_size'))
  .fontWeight(FontWeight.Bold)
  .fontColor($r('app.color.font_color_level1'))

// 卡片标题
Text('卡片标题')
  .fontSize($r('sys.float.Title_S'))
  .fontWeight(FontWeight.Medium)
  .fontColor($r('app.color.font_color_level1'))

// 正文
Text('正文内容')
  .fontSize($r('sys.float.Body_M'))
  .fontColor($r('app.color.font_color_level2'))

// 辅助文本
Text('辅助信息')
  .fontSize($r('sys.float.Body_S'))
  .fontColor($r('app.color.font_color_level3'))

// Tab文字
Text('首页')
  .fontSize(12)
  .fontColor(this.isActive ? $r('app.color.system_theme_color') :
    $r('app.color.font_color_level3'))
  .fontWeight(this.isActive ? FontWeight.Medium : FontWeight.Normal)
```

### Text Hierarchy

| 层级 | 字体大小 | 字重 | 颜色 | 使用场景 |
|------|---------|------|------|---------|
| H1 - Display | 28sp | Bold | Level1 | 页面主标题 |
| H2 - Title | 20sp | Bold | Level1 | 区域标题 |
| H3 - Subtitle | 18sp | Medium | Level1 | 卡片标题 |
| Body Large | 16sp | Regular | Level1 | 重要正文 |
| Body | 14sp | Regular | Level2 | 普通正文 |
| Caption | 12sp | Regular | Level3 | 辅助说明 |
| Label | 10sp | Regular | Level3 | 标签/按钮文字 |

---

## Spacing System

### Standard Spacing Scale

定义统一的间距规范：

```json5
// float.json
{
  "float": [
    { "name": "space_4", "value": "4" },
    { "name": "space_8", "value": "8" },
    { "name": "space_12", "value": "12" },
    { "name": "space_16", "value": "16" },
    { "name": "space_24", "value": "24" },
    { "name": "space_32", "value": "32" }
  ]
}

// string.json
{
  "string": [
    { "name": "margin_xs", "value": "4" },
    { "name": "margin_sm", "value": "8" },
    { "name": "margin_md", "value": "12" },
    { "name": "margin_lg", "value": "16" },
    { "name": "margin_xl", "value": "24" }
  ]
}
```

### Spacing Usage

```typescript
// 组件内部间距
Column({ space: 16 }) {  // 垂直间距16
  Text('标题')
  Text('内容')
}

Row({ space: 12 }) {  // 水平间距12
  Image()
  Text()
}

// 页面级内边距
Column() {}
.width('100%')
.padding({ left: 16, right: 16, top: 12, bottom: 12 })

// 组件外边距
Column() {}
.margin({ top: 16, bottom: 8 })
```

### Spacing Guidelines

| 场景 | 推荐间距 | 说明 |
|------|---------|------|
| 页面左右边距 | 16px | 内容与屏幕边缘 |
| 列表项内边距 | 16px | 列表项内容 |
| 卡片内边距 | 16px | 卡片内部内容 |
| 组件组间距 | 24px | 不同模块之间 |
| 相关元素间距 | 12px | 同组元素 |
| 紧密元素间距 | 8px | 标签、图标旁 |
| 最小间距 | 4px | 极紧密元素 |

---

## Border Radius

统一使用以下圆角规范：

```typescript
// 常用圆角值
8   // 小圆角 - 按钮、标签
12  // 中圆角 - 卡片、输入框
16  // 大圆角 - 大卡片、底部弹窗
24  // 超大圆角 - 特殊组件
```

**Usage:**
```typescript
// 卡片圆角
Column() {}
.backgroundColor(Color.White)
.borderRadius(12)

// 按钮圆角
Button('点击')
.type(ButtonType.Capsule)  // 胶囊型（全圆角）

// 标签圆角
Text('标签')
.padding({ left: 8, right: 8, top: 4, bottom: 4 })
.borderRadius(8)

// 图片圆角
Image(url)
.borderRadius(12)
```

### Radius Guidelines

| 组件类型 | 圆角值 | 说明 |
|---------|--------|------|
| 卡片 | 12px | 最常用的卡片样式 |
| 按钮 | Capsule | 胶囊型按钮 |
| 标签 | 8px | 小标签 |
| 输入框 | 12px | 与卡片一致 |
| 图片 | 12px | 统一视觉风格 |
| 头像 | 50% | 圆形 |
| 底部弹窗 | 16px | 顶部圆角 |

---

## Shadows

使用系统预定义阴影样式：

```typescript
// 系统阴影
.shadow(ShadowStyle.OUTER_DEFAULT_XS)  // 极小阴影
.shadow(ShadowStyle.OUTER_DEFAULT_SM)  // 小阴影
.shadow(ShadowStyle.OUTER_DEFAULT_MD)  // 中阴影
.shadow(ShadowStyle.OUTER_DEFAULT_LG)  // 大阴影

// 自定义阴影
.shadow({
  radius: 8,           // 模糊半径
  color: '#1A000000',  // 10%黑色
  offsetX: 0,          // X偏移
  offsetY: 2           // Y偏移
})
```

**Usage:**
```typescript
// 卡片阴影
Column() {}
.backgroundColor(Color.White)
.borderRadius(12)
.shadow(ShadowStyle.OUTER_DEFAULT_XS)

// 悬浮按钮阴影
Button({ type: ButtonType.Circle }) {}
.shadow(ShadowStyle.OUTER_DEFAULT_MD)
```

### Shadow Guidelines

| 场景 | 阴影样式 | 视觉效果 |
|------|---------|---------|
| 普通卡片 | OUTER_DEFAULT_XS | 极轻微悬浮感 |
| 重要卡片 | OUTER_DEFAULT_SM | 轻微悬浮感 |
| 弹出层 | OUTER_DEFAULT_MD | 明显悬浮感 |
| FAB按钮 | OUTER_DEFAULT_MD | 明显悬浮感 |
| 抽屉 | OUTER_DEFAULT_LG | 强烈悬浮感 |

---

## Component Patterns

### Card Pattern

标准卡片组件样式：

```typescript
@ComponentV2
struct Card {
  @BuilderParam content: () => void;

  build() {
    Column() {
      this.content()
    }
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(12)
    .padding(16)
    .shadow(ShadowStyle.OUTER_DEFAULT_XS)
  }
}

// Usage
Card() {
  Column({ space: 12 }) {
    Text('卡片标题')
      .fontSize(16)
      .fontWeight(FontWeight.Medium)
    Text('卡片内容')
      .fontSize(14)
      .fontColor($r('app.color.font_color_level2'))
  }
}
.margin({ bottom: 16 })
```

### Button Patterns

```typescript
// 主按钮 - 实心背景
Button('主操作')
  .type(ButtonType.Capsule)
  .width('100%')
  .height(48)
  .fontSize(16)
  .fontWeight(FontWeight.Medium)
  .backgroundColor($r('app.color.system_theme_color'))
  .fontColor(Color.White)
  .shadow(ShadowStyle.OUTER_DEFAULT_SM)

// 次按钮 - 边框样式
Button('次要操作')
  .type(ButtonType.Capsule)
  .width('100%')
  .height(48)
  .fontSize(16)
  .backgroundColor(Color.Transparent)
  .fontColor($r('app.color.system_theme_color'))
  .border({ width: 1, color: $r('app.color.system_theme_color') })

// 文本按钮
Button('文本按钮')
  .type(ButtonType.Normal)
  .fontSize(16)
  .fontColor($r('app.color.icon_color_highlight'))
  .backgroundColor(Color.Transparent)
```

### List Item Pattern

```typescript
@Builder
function ListItemComp() {
  Row() {
    // 左侧图标
    Image($r('app.media.icon'))
      .width(24)
      .height(24)
      .fillColor($r('app.color.icon_color_level2'))

    // 中间内容
    Column({ space: 4 }) {
      Text('标题')
        .fontSize(16)
        .fontColor($r('app.color.font_color_level1'))
      Text('副标题')
        .fontSize(14)
        .fontColor($r('app.color.font_color_level3'))
    }
    .margin({ left: 12 })
    .alignItems(HorizontalAlign.Start)
    .layoutWeight(1)

    // 右侧箭头
    Image($r('app.media.ic_right_arrow'))
      .width(16)
      .height(16)
      .fillColor($r('app.color.icon_color_level3'))
  }
  .width('100%')
  .padding(16)
  .backgroundColor(Color.White)
  .borderRadius(12)
  .onClick(() => {
    // 点击事件
  })
}

// 在列表中使用
List({ space: 12 }) {
  ListItem() {
    ListItemComp()
  }
  // ...更多列表项
}
.width('100%')
.padding({ left: 16, right: 16 })
```

### Tag Component

```typescript
@ComponentV2
struct Tag {
  @Param text: string = '';
  @Param backgroundColor: ResourceColor = '#F0F0F0';
  @Param textColor: ResourceColor = '#666666';

  build() {
    Text(this.text)
      .fontSize(12)
      .fontColor(this.textColor)
      .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      .backgroundColor(this.backgroundColor)
      .borderRadius(8)
  }
}

// Usage
Row({ space: 8 }) {
  Tag({ text: '热门', backgroundColor: '#FFE6E6', textColor: '#FF3B30' })
  Tag({ text: '推荐', backgroundColor: '#E6F5FF', textColor: '#007AFF' })
  Tag({ text: '新上', backgroundColor: '#E6FFE6', textColor: '#64BB5C' })
}
```

### Search Bar Pattern

```typescript
@ComponentV2
struct SearchBar {
  @Param placeholder: string = '搜索';
  @Param onSearch: (text: string) => void = () => {};
  @Local searchText: string = '';

  build() {
    Row() {
      Image($r('app.media.ic_search'))
        .width(20)
        .height(20)
        .fillColor($r('app.color.icon_color_level3'))
        .margin({ right: 8 })

      TextInput({ placeholder: this.placeholder })
        .layoutWeight(1)
        .height(36)
        .backgroundColor(Color.Transparent)
        .border({ width: 0 })
        .onChange((value: string) => {
          this.searchText = value;
        })
        .onSubmit(() => {
          this.onSearch(this.searchText);
        })
    }
    .width('100%')
    .height(48)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#F5F5F5')
    .borderRadius(24)
  }
}
```

### Empty State Pattern

```typescript
@ComponentV2
struct EmptyState {
  @Param message: string = '暂无数据';
  @Param image: Resource = $r('app.media.no_data');

  build() {
    Column({ space: 16 }) {
      Image(this.image)
        .width(120)
        .height(120)
        .opacity(0.6)

      Text(this.message)
        .fontSize(16)
        .fontColor($r('app.color.font_color_level3'))
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}
```

---

## Responsive Design

### Breakpoints

HarmonyOS 响应式断点系统：

```typescript
// 系统断点
'sm'  // Small: 0-600vp (手机竖屏)
'md'  // Medium: 600-840vp (手机横屏/折叠屏)
'lg'  // Large: 840vp+ (平板)

// 使用断点
@ComponentV2
struct ResponsiveComponent {
  @StorageProp('currentBreakpoint') breakpoint: string = 'sm';

  build() {
    if (this.breakpoint === 'sm') {
      // 手机布局
      Column() {}
    } else if (this.breakpoint === 'lg') {
      // 平板布局
      Row() {}
    }
  }
}
```

### Responsive Grid

```typescript
@ComponentV2
struct ResponsiveGrid {
  @StorageProp('currentBreakpoint') breakpoint: string = 'sm';

  getColumnsTemplate(): string {
    switch (this.breakpoint) {
      case 'sm': return '1fr 1fr';      // 手机：2列
      case 'md': return '1fr 1fr 1fr';  // 折叠屏：3列
      case 'lg': return '1fr 1fr 1fr 1fr'; // 平板：4列
      default: return '1fr 1fr';
    }
  }

  build() {
    Grid() {
      ForEach(this.items, (item: Item) => {
        GridItem() {
          ItemCard({ item: item })
        }
      })
    }
    .columnsTemplate(this.getColumnsTemplate())
    .columnsGap(12)
    .rowsGap(12)
    .padding(12)
  }
}
```

### GridRow for Layout

```typescript
GridRow({
  columns: { sm: 4, md: 8, lg: 12 },
  gutter: { x: 12, y: 12 }
}) {
  // 侧边栏
  GridCol({ span: { sm: 4, md: 2, lg: 3 } }) {
    Sidebar()
  }

  // 主内容
  GridCol({ span: { sm: 4, md: 6, lg: 9 } }) {
    MainContent()
  }
}
.width('100%')
```

---

## Dark Mode

### Dark Mode Colors

**resources/dark/element/color.json**
```json5
{
  "color": [
    { "name": "system_theme_color", "value": "#FF6B5B" },
    { "name": "font_color_level1", "value": "#E5E5E5" },
    { "name": "font_color_level2", "value": "#99E5E5E5" },
    { "name": "font_color_level3", "value": "#80FFFFFF" },
    { "name": "system_color_background_white", "value": "#1A1A1A" },
    { "name": "system_color_background_auxiliary", "value": "#2A2A2A" },
    { "name": "system_color_divider", "value": "#333333" }
  ]
}
```

### Dark Mode Best Practices

```typescript
// 使用系统颜色自动适配
Column() {}
.backgroundColor($r('sys.color.ohos_id_color_background'))

// 或使用自定义颜色资源
Text('文字')
  .fontColor($r('app.color.font_color_level1'))  // 自动适配深色模式

// 图片着色
Image($r('app.media.icon'))
  .fillColor($r('app.color.icon_color_level1'))  // 自动适配

// 条件样式
Column() {}
.backgroundColor(this.isDark ? '#1A1A1A' : '#FFFFFF')
```

---

## Design Tokens Summary

### Common Tokens

```typescript
// 尺寸
FULL_WIDTH = '100%'
FULL_HEIGHT = '100%'

// 间距
SPACE_XS = 4
SPACE_SM = 8
SPACE_MD = 12
SPACE_LG = 16
SPACE_XL = 24

// 圆角
RADIUS_SM = 8
RADIUS_MD = 12
RADIUS_LG = 16

// 字体大小
FONT_TITLE_LG = 24
FONT_TITLE_MD = 18
FONT_BODY = 14
FONT_CAPTION = 12
```

### Quick Reference Card

```typescript
// 快速卡片模板
Column() {}
  .width('100%')
  .backgroundColor(Color.White)
  .borderRadius(12)
  .padding(16)
  .shadow(ShadowStyle.OUTER_DEFAULT_XS)

// 快速按钮模板
Button('按钮')
  .type(ButtonType.Capsule)
  .height(48)
  .fontSize(16)
  .fontWeight(FontWeight.Medium)

// 快速文本样式
Text('标题')
  .fontSize(16)
  .fontWeight(FontWeight.Medium)
  .fontColor($r('app.color.font_color_level1'))

Text('正文')
  .fontSize(14)
  .fontColor($r('app.color.font_color_level2'))

Text('辅助')
  .fontSize(12)
  .fontColor($r('app.color.font_color_level3'))
```

---

## Animation

### Standard Animations

```typescript
// 页面转场
.router(RouterTransitionCode.DEFAULT)

// 元素动画
.animation({
  duration: 300,
  curve: Curve.EaseInOut
})

// 列表项动画
ForEach(this.items, (item: Item) => {
  ListItem() {}
}, (item: Item) => item.id)
.transition(TransitionEffect.All.scale({ x: 0, y: 0 }).animation({
  duration: 300,
  curve: Curve.Friction
}))
```

---

## Accessibility

### Accessibility Best Practices

```typescript
// 使用语义化颜色
Text('重要信息')
  .fontColor($r('app.color.icon_color_warning'))  // 警告色

Text('成功信息')
  .fontColor($r('app.color.icon_color_success'))  // 成功色

// 支持系统字体缩放
Text('文字')
  .fontSize($r('sys.float.Body_M'))  // 系统字体大小

// 最小点击区域
Button() {}
  .width(44)  // 至少44x44vp
  .height(44)

// 文本对比度
// 确保文本与背景对比度 ≥ 4.5:1
```

---

## Resources

### System Colors Reference
- [HarmonyOS Color System](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/arkts-colors-visualization-mode-V5)

### System Icons
- [HarmonyOS Icons](https://developer.huawei.com/consumer/cn/design/harmonyos-icon/)

### Design Guidelines
- [HarmonyOS Design](https://developer.huawei.com/consumer/cn/design/harmonyos-design/)
