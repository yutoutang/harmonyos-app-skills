---
name: ui-design-kit
description: UI 设计服务 Kit (HDS)，提供华为设计系统组件
---

# UI 设计服务 HarmonyOS 开发 Skill

## 概述

UI 设计 Kit (UIDesignKit) 为 HarmonyOS 应用提供华为设计系统 (HDS) 组件，包括导航、侧边栏、标签页、操作栏、提示组件等丰富的 UI 组件。

## 重要说明

- **Kit 名称**: UIDesignKit
- **SDK 版本**: HarmonyOS 5.0.0+ (API 12+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  hdsDrawable,
  hdsEffect,
  HdsNavigation,
  HdsNavigationAttribute,
  HdsNavDestination,
  HdsNavDestinationAttribute,
  ScrollEffectType,
  BottomBuilderShowType,
  HideMode,
  DividerShowType,
  IconStyleMode,
  TextStyleMode,
  HdsNavigationTitleMode,
  HdsNavDestinationTitleMode,
  BlurStrategy,
  NavDestinationBuilder,
  CustomTransitionDelegate,
  IconType,
  HdsNavigationMenuItemOptions,
  HdsNavigationBackButtonItemOptions,
  HdsNavigationBackgroundStyle,
  HdsNavigationTitleStyle,
  HdsNavigationIconItemStyle,
  HdsNavigationDividerStyle,
  HdsTitleBarContentStyle,
  HdsNavigationTitleBarStyle,
  ScrollEffectOptions,
  TitleBarStyleOptions,
  HdsNavigationBadgeOptions,
  HdsNavigationIconOptions,
  HdsNavigationBadgeIconOptions,
  HdsNavigationMenuContentOptions,
  HdsNavigationTitle,
  BottomBuilderParams,
  HdsNavigationDividerParams,
  TitleBarContentOptions,
  PaddingOptions,
  HdsNavigationTitleBarOptions,
  NavBarWidthRangeOptions,
  DynamicHideParams,
  NestedScrollInfo,
  symbolRegister,
  HdsListItemCard,
  HdsListItemCardOptions,
  HdsListItemCardAttribute,
  HdsSideBar,
  HdsSideMenuBadgeParam,
  HdsSideMenu,
  HdsSideMenuBaseItemParam,
  HdsSideMenuMainItemParam,
  HdsSideMenuSubItemParam,
  HdsSideMenuMainItem,
  HdsSideMenuSubItem,
  IconSize,
  SymbolType,
  PrefixIconType,
  ImageType,
  OnClickCallback,
  OnChangeCallback,
  OnSelectCallback,
  AccessibilityOptions,
  ImageOptions,
  ImageClickOptions,
  SymbolGlyphOptions,
  TextSymbolGlyphOptions,
  PrefixIconOptions,
  BadgeOptions,
  CheckOptions,
  ToggleButtonOptions,
  TextOptions,
  ColorOptions,
  ButtonOptions,
  SuffixIconOptions,
  SuffixArrowIconOptions,
  SuffixArrowIconTextOptions,
  SelectStyle,
  PrefixImage,
  PrefixIcon,
  PrefixBadge,
  PrefixSwitch,
  PrefixToggleButton,
  PrefixButton,
  PrefixCustomBuilder,
  SuffixText,
  SuffixImage,
  SuffixLoadingProgress,
  SuffixRadio,
  SuffixCheckbox,
  SuffixSwitch,
  SuffixArrow,
  SuffixBadge,
  SuffixButton,
  SuffixIcon,
  SuffixSubIcon,
  SuffixSelect,
  SuffixToggleButton,
  SuffixBadgeAndArrow,
  SuffixTextAndArrow,
  SuffixArrowIconText,
  SuffixCustomBuilder,
  SwipeIconType,
  HdsSwipeActionOptions,
  IconOptions,
  SwipeIconConfigurations,
  DeleteIconOptions,
  FullDeleteOptions,
  HdsListItem,
  HdsActionBar,
  ActionBarButton,
  ActionBarButtonOptions,
  ActionBarStyle,
  ActionBarStyleOptions,
  HdsSnackBar,
  SnackBarIconOptions,
  SnackBarMessageOptions,
  SnackBarOperationOptions,
  SnackBarStyleOptions,
  SnackBarOperationType,
  SnackBarIconType,
  HdsTabs,
  HdsTabsAttribute,
  HdsTabsController,
  DividerMode,
  HdsDividerStyle,
  HdsBarMode,
  ExtendBarMode,
  HdsTabsBackgroundStyle,
  bleedIconStyle,
  HdsVisualComponent,
  HdsVisualComponentAttribute,
  HdsSceneController,
  DualEdgeFlowLightWithMaskParam,
  HdsSceneType,
  MultiWindowEntryInAPP,
  MultiWindowEntryInAPPAttribute,
  MultiWindowEntryInAPPIconOptions,
  MultiWindowEntryInAPPSubtitleOptions,
  MultiWindowEntryInAPPMenuParams,
  MultiWindowEntryInAPPParams
} from '@kit.UIDesignKit'
```

## 二、API 参考

### 2.1 主要组件

| 组件名称 | 描述 |
|---------|------|
| HdsNavigation | 导航组件 |
| HdsNavDestination | 导航目标页面 |
| HdsTabs | 标签页组件 |
| HdsSideBar | 侧边栏组件 |
| HdsSideMenu | 侧边菜单组件 |
| HdsActionBar | 操作栏组件 |
| HdsSnackBar | 提示组件 |
| HdsListItemCard | 列表项卡片组件 |
| HdsVisualComponent | 视觉效果组件 |
| MultiWindowEntryInAPP | 多窗口入口组件 |

### 2.2 HdsNavigation 使用

```typescript
@Entry
@ComponentV2
struct NavigationExamplePage {
  build() {
    HdsNavigation() {
      HdsNavDestination() {
        // 页面内容
      }
      .title('页面标题')
    }
  }
}
```

### 2.3 HdsTabs 使用

```typescript
@ComponentV2
struct TabsExamplePage {
  @Local tabsController: HdsTabsController = new HdsTabsController()

  build() {
    HdsTabs({ controller: this.tabsController }) {
      ForEach(['Tab1', 'Tab2', 'Tab3'], (title: string) => {
        TabContent() {
          Text(title)
        }
      })
    }
    .barMode(HdsBarMode.Scrollable)
  }
}
```

## 三、使用示例

### 3.1 完整的 HDS 页面

```typescript
import { HdsNavigation, HdsNavDestination, HdsTabs, HdsSideBar } from '@kit.UIDesignKit'

@Entry
@ComponentV2
struct HDSExamplePage {
  build() {
    HdsNavigation() {
      HdsNavDestination() {
        HdsTabs() {
          TabContent() {
            Text('标签页1')
          }
          TabContent() {
            Text('标签页2')
          }
        }
      }
      .title('HDS 示例')
    }
  }
}
```

## 四、最佳实践

1. **设计规范**: 遵循华为设计系统规范
2. **组件一致性**: 保持组件使用的一致性
3. **主题适配**: 支持深色和浅色主题
4. **可访问性**: 考虑可访问性需求

## 五、参考资料

- [UI 设计服务官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/hds-introduction-V5)

---
## See Also
- [ArkUI 组件](../../component/) - 原生 ArkUI 组件
