# WithTheme 主题系统 HarmonyOS 6.0 开发 Skill

## 概述

WithTheme 是 HarmonyOS 6.0 (API 12+) 中实现主题管理的重要机制，支持深色模式（Dark Mode）、浅色模式（Light Mode）的动态切换，以及自定义主题的定义和应用。通过主题系统，开发者可以轻松实现应用的全局样式统一和主题自适应。

## 重要说明

- **API 版本要求**: API 12+ (HarmonyOS 5.0.0 及以上)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **主题类型**: 支持系统主题、应用主题、组件级主题
- **资源组织**: 通过 `dark.element` 和 `light.element` 目录管理不同主题的资源
- **实时切换**: 支持运行时动态切换主题，无需重启应用

## 模块信息

- **功能名称**: 主题系统 (Theme System)
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [深色模式 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/web-set-dark-mode-V5)

## 一、主题系统基础

### 1.1 主题配置

主题通过资源文件系统和配置 API 共同管理。

#### 资源目录结构

```
resources/
├── base/
│   └── element/
│       ├── color.json          # 默认颜色资源
│       ├── float.json          # 默认尺寸资源
│       └── string.json         # 默认字符串资源
├── dark/
│   └── element/
│       ├── color.json          # 深色模式颜色
│       ├── float.json          # 深色模式尺寸
│       └── string.json         # 深色模式字符串
└── light/
    └── element/
        ├── color.json          # 浅色模式颜色
        ├── float.json          # 浅色模式尺寸
        └── string.json         # 浅色模式字符串
```

#### color.json 示例

**resources/base/element/color.json**:
```json
{
  "color": [
    {
      "name": "primary_color",
      "value": "#007DFF"
    },
    {
      "name": "background_color",
      "value": "#FFFFFF"
    },
    {
      "name": "text_color",
      "value": "#000000"
    }
  ]
}
```

**resources/dark/element/color.json**:
```json
{
  "color": [
    {
      "name": "primary_color",
      "value": "#4D94FF"
    },
    {
      "name": "background_color",
      "value": "#1A1A1A"
    },
    {
      "name": "text_color",
      "value": "#FFFFFF"
    }
  ]
}
```

### 1.2 使用主题资源

```typescript
@ComponentV2
struct ThemedComponent {
  build() {
    Column() {
      Text('Themed Text')
        .fontColor($r('app.color.text_color'))
        .backgroundColor($r('app.color.background_color'))
    }
  }
}
```

系统会根据当前主题自动选择对应的资源值。

## 二、系统主题 API

### 2.1 Configuration API

`@ohos.application.Configuration` 模块提供了系统主题配置的能力。

```typescript
import { Configuration } from '@ohos.application.Configuration'
import { ConfigurationConstant } from '@kit.AbilityKit'

@ComponentV2
struct SystemThemeExample {
  @Local currentTheme: 'light' | 'dark' = 'light'

  aboutToAppear() {
    // 获取当前系统主题
    const config = Configuration.getGlobalConfiguration()
    this.currentTheme = config.colorMode === ConfigurationConstant.ColorMode.COLOR_MODE_DARK
      ? 'dark'
      : 'light'

    // 监听系统主题变化
    Configuration.on('configurationChange', (newConfig) => {
      this.currentTheme = newConfig.colorMode === ConfigurationConstant.ColorMode.COLOR_MODE_DARK
        ? 'dark'
        : 'light'
    })
  }

  build() {
    Column() {
      Text(`Current theme: ${this.currentTheme}`)
        .fontColor(this.currentTheme === 'dark' ? '#FFFFFF' : '#000000')
        .backgroundColor(this.currentTheme === 'dark' ? '#1A1A1A' : '#FFFFFF')
    }
  }
}
```

### 2.2 ColorMode 枚举

```typescript
enum ColorMode {
  COLOR_MODE_LIGHT = 0,      // 浅色模式
  COLOR_MODE_DARK = 1,       // 深色模式
  COLOR_MODE_NOT_SET = -1    // 跟随系统（默认）
}
```

### 2.3 ApplicationContext API

通过 ApplicationContext 可以设置应用的颜色模式。

```typescript
import { UIAbility } from '@kit.AbilityKit'
import { ConfigurationConstant } from '@kit.AbilityKit'

export default class EntryAbility extends UIAbility {
  onWindowStageCreate(windowStage: window.WindowStage) {
    windowStage.loadContent('pages/Index', (err) => {
      if (!err) {
        // 设置应用为深色模式
        this.context.getApplicationContext().setColorMode(
          ConfigurationConstant.ColorMode.COLOR_MODE_DARK
        )

        // 或设置为浅色模式
        // this.context.getApplicationContext().setColorMode(
        //   ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT
        // )

        // 或跟随系统
        // this.context.getApplicationContext().setColorMode(
        //   ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET
        // )
      }
    })
  }
}
```

## 三、应用级主题管理

### 3.1 使用 AppStorage 管理主题

```typescript
// 定义主题类型
type ThemeMode = 'light' | 'dark'

// 存储键名
const THEME_KEY = 'app_theme_mode'

@ComponentV2
export struct ThemeManager {
  @StorageLink(THEME_KEY) currentTheme: ThemeMode = 'light'

  build() {
    // Empty component - just for theme management
  }
}

// 初始化主题
export function initTheme() {
  // 从持久化存储读取主题偏好
  const savedTheme = Preferences.getTheme()
  AppStorage.setOrCreate(THEME_KEY, savedTheme)
}

// 切换主题
export function toggleTheme() {
  const current = AppStorage.get<ThemeMode>(THEME_KEY) ?? 'light'
  const newTheme: ThemeMode = current === 'light' ? 'dark' : 'light'

  AppStorage.set(THEME_KEY, newTheme)
  Preferences.saveTheme(newTheme)

  // 更新应用配置
  const colorMode = newTheme === 'dark'
    ? ConfigurationConstant.ColorMode.COLOR_MODE_DARK
    : ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT

  getContext(this).getApplicationContext().setColorMode(colorMode)
}

// 获取当前主题
export function getCurrentTheme(): ThemeMode {
  return AppStorage.get<ThemeMode>(THEME_KEY) ?? 'light'
}
```

### 3.2 使用 Environment 管理主题

```typescript
import { environment } from '@kit.ArkUI'

// 在应用初始化时设置环境变量
environment.EnvProp('colorMode', 'light')

@ComponentV2
struct EnvironmentThemeExample {
  @StorageProp('colorMode') colorMode: string = 'light'

  build() {
    Column() {
      Text('Theme aware text')
        .fontColor(this.colorMode === 'dark' ? '#FFFFFF' : '#000000')
        .backgroundColor(this.colorMode === 'dark' ? '#1A1A1A' : '#FFFFFF')

      Button('Toggle Theme')
        .onClick(() => {
          const newMode = this.colorMode === 'light' ? 'dark' : 'light'
          AppStorage.set('colorMode', newMode)
        })
    }
  }
}
```

### 3.3 使用 PersistentStorage 持久化主题

```typescript
import { PersistentStorage } from '@kit.ArkUI'

// 定义主题键
const THEME_KEY = 'app_theme_mode'

// 持久化主题设置
PersistentStorage.persistProp(THEME_KEY, 'light')

@ComponentV2
struct PersistentThemeExample {
  @StorageLink(THEME_KEY) currentTheme: 'light' | 'dark' = 'light'

  build() {
    Column() {
      Text(`Current Theme: ${this.currentTheme}`)
        .fontColor(this.currentTheme === 'dark' ? '#FFFFFF' : '#000000')

      Button('Toggle Theme')
        .onClick(() => {
          this.currentTheme = this.currentTheme === 'light' ? 'dark' : 'light'
          // 自动持久化到存储
        })
    }
  }
}
```

## 四、自定义主题定义

### 4.1 主题配置接口

```typescript
// 定义主题配置接口
interface ThemeConfig {
  name: string
  colors: {
    primary: string
    secondary: string
    background: string
    surface: string
    error: string
    onPrimary: string
    onSecondary: string
    onBackground: string
    onSurface: string
    onError: string
  }
  typography: {
    headlineLarge: number
    headlineMedium: number
    bodyLarge: number
    bodyMedium: number
    bodySmall: number
  }
  shapes: {
    borderRadiusSmall: number
    borderRadiusMedium: number
    borderRadiusLarge: number
  }
}

// 浅色主题配置
export const LightTheme: ThemeConfig = {
  name: 'light',
  colors: {
    primary: '#007DFF',
    secondary: '#03DAC6',
    background: '#FFFFFF',
    surface: '#F5F5F5',
    error: '#B00020',
    onPrimary: '#FFFFFF',
    onSecondary: '#000000',
    onBackground: '#000000',
    onSurface: '#000000',
    onError: '#FFFFFF'
  },
  typography: {
    headlineLarge: 32,
    headlineMedium: 24,
    bodyLarge: 16,
    bodyMedium: 14,
    bodySmall: 12
  },
  shapes: {
    borderRadiusSmall: 4,
    borderRadiusMedium: 8,
    borderRadiusLarge: 16
  }
}

// 深色主题配置
export const DarkTheme: ThemeConfig = {
  name: 'dark',
  colors: {
    primary: '#4D94FF',
    secondary: '#03DAC6',
    background: '#121212',
    surface: '#1E1E1E',
    error: '#CF6679',
    onPrimary: '#FFFFFF',
    onSecondary: '#000000',
    onBackground: '#FFFFFF',
    onSurface: '#FFFFFF',
    onError: '#000000'
  },
  typography: {
    headlineLarge: 32,
    headlineMedium: 24,
    bodyLarge: 16,
    bodyMedium: 14,
    bodySmall: 12
  },
  shapes: {
    borderRadiusSmall: 4,
    borderRadiusMedium: 8,
    borderRadiusLarge: 16
  }
}
```

### 4.2 主题提供者组件

```typescript
@ObservedV2
export class ThemeManager {
  @Trace currentTheme: ThemeConfig = LightTheme

  setTheme(theme: ThemeConfig) {
    this.currentTheme = theme
  }

  toggleTheme() {
    if (this.currentTheme.name === 'light') {
      this.setTheme(DarkTheme)
    } else {
      this.setTheme(LightTheme)
    }
  }

  @Computed
  get isDark(): boolean {
    return this.currentTheme.name === 'dark'
  }
}

// 全局主题管理器
export const themeManager = new ThemeManager()

@ComponentV2
export struct ThemeProvider {
  @Param theme: ThemeConfig = LightTheme
  @Param children: () => void = () => {}

  build() {
    Column() {
      this.children()
    }
    .backgroundColor(this.theme.colors.background)
  }
}
```

### 4.3 使用自定义主题

```typescript
@ComponentV2
struct ThemedPage {
  @Local theme: ThemeConfig = LightTheme

  build() {
    Column() {
      Text('Headline')
        .fontSize(this.theme.typography.headlineLarge)
        .fontColor(this.theme.colors.onBackground)

      Text('Body text')
        .fontSize(this.theme.typography.bodyMedium)
        .fontColor(this.theme.colors.onBackground)

      Button('Primary Action')
        .backgroundColor(this.theme.colors.primary)
        .fontColor(this.theme.colors.onPrimary)
        .borderRadius(this.theme.shapes.borderRadiusMedium)
        .onClick(() => {
          // Toggle theme
          this.theme = this.theme.name === 'light' ? DarkTheme : LightTheme
        })

      Button('Secondary Action')
        .backgroundColor(this.theme.colors.secondary)
        .fontColor(this.theme.colors.onSecondary)
        .borderRadius(this.theme.shapes.borderRadiusMedium)
    }
    .backgroundColor(this.theme.colors.background)
    .padding(20)
  }
}
```

## 五、主题切换实现

### 5.1 主题切换按钮组件

```typescript
@ComponentV2
export struct ThemeToggleButton {
  @StorageLink('app_theme_mode') currentTheme: 'light' | 'dark' = 'light'

  build() {
    Button() {
      Row({ space: 8 }) {
        if (this.currentTheme === 'light') {
          SymbolGlyph($r('sys.symbol.moon'))
            .fontSize(24)
            .fontColor([0x000000])
        } else {
          SymbolGlyph($r('sys.symbol.sun_max'))
            .fontSize(24)
            .fontColor([0xFFFFFF])
        }

        Text(this.currentTheme === 'light' ? 'Dark' : 'Light')
          .fontSize(16)
      }
    }
    .backgroundColor(this.currentTheme === 'dark' ? '#333333' : '#E0E0E0')
    .fontColor(this.currentTheme === 'dark' ? '#FFFFFF' : '#000000')
    .borderRadius(20)
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .onClick(() => {
      this.toggleTheme()
    })
  }

  private toggleTheme() {
    const newTheme: 'light' | 'dark' = this.currentTheme === 'light' ? 'dark' : 'light'
    AppStorage.set('app_theme_mode', newTheme)

    // 更新应用配置
    const context = getContext(this) as common.UIAbilityContext
    const colorMode = newTheme === 'dark'
      ? ConfigurationConstant.ColorMode.COLOR_MODE_DARK
      : ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT

    context.getApplicationContext().setColorMode(colorMode)
  }
}
```

### 5.2 带动画的主题切换

```typescript
@ComponentV2
export struct AnimatedThemeSwitch {
  @StorageLink('app_theme_mode') currentTheme: 'light' | 'dark' = 'light'
  @Local progress: number = 0

  build() {
    Stack() {
      // 背景层
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(this.currentTheme === 'dark' ? '#121212' : '#FFFFFF')
        .animation({
          duration: 300,
          curve: Curve.EaseInOut
        })

      // 内容层
      Column() {
        Text('Animated Theme Switch')
          .fontSize(24)
          .fontColor(this.currentTheme === 'dark' ? '#FFFFFF' : '#000000')
          .animation({
            duration: 300,
            curve: Curve.EaseInOut
          })

        Button('Toggle Theme')
          .onClick(() => {
            this.animateThemeChange()
          })
      }
    }
  }

  private animateThemeChange() {
    animateTo({
      duration: 300,
      curve: Curve.EaseInOut
    }, () => {
      this.currentTheme = this.currentTheme === 'light' ? 'dark' : 'light'
    })
  }
}
```

## 六、主题继承和覆盖

### 6.1 组件级主题覆盖

```typescript
@ComponentV2
struct ParentComponent {
  @Param theme: ThemeConfig = LightTheme

  build() {
    Column() {
      Text('Uses parent theme')
        .fontColor(this.theme.colors.onBackground)

      ChildComponent({
        localTheme: DarkTheme  // 覆盖父组件主题
      })

      AnotherChild()  // 使用父组件主题
    }
    .backgroundColor(this.theme.colors.background)
  }
}

@ComponentV2
struct ChildComponent {
  @Param localTheme: ThemeConfig = LightTheme

  build() {
    Text('Uses local theme')
      .fontColor(this.localTheme.colors.onBackground)
      .backgroundColor(this.localTheme.colors.surface)
  }
}

@ComponentV2
struct AnotherChild {
  @StorageLink('app_theme_mode') currentTheme: 'light' | 'dark' = 'light'
  private theme: ThemeConfig = this.currentTheme === 'dark' ? DarkTheme : LightTheme

  build() {
    Text('Uses global theme')
      .fontColor(this.theme.colors.onBackground)
  }
}
```

### 6.2 上下文主题传递

```typescript
@ComponentV2
export struct ThemeContext {
  @Param theme: ThemeConfig = LightTheme
  @Param content: () => void = () => {}

  build() {
    this.content()
  }
}

// 使用上下文
@ComponentV2
struct ContextExample {
  build() {
    ThemeContext({
      theme: DarkTheme,
      content: () => {
        Column() {
          Text('Nested content')
            .fontColor(DarkTheme.colors.onBackground)
        }
        .backgroundColor(DarkTheme.colors.background)
      }
    })
  }
}
```

## 七、最佳实践

### 7.1 资源组织

```typescript
// ✅ 推荐：使用资源引用
Text('Hello')
  .fontColor($r('app.color.text_color'))
  .backgroundColor($r('app.color.background_color'))

// ❌ 避免：硬编码颜色
Text('Hello')
  .fontColor('#000000')
  .backgroundColor('#FFFFFF')
```

### 7.2 主题一致性

```typescript
// ✅ 推荐：定义主题常量
export const AppTheme = {
  colors: {
    primary: '#007DFF',
    secondary: '#03DAC6',
    // ...
  }
}

// 在整个应用中使用
Text('Hello')
  .fontColor(AppTheme.colors.primary)

// ❌ 避免：分散的颜色定义
Text('Hello')
  .fontColor('#007DFF')  // 在多个地方重复定义
```

### 7.3 主题切换时机

```typescript
// ✅ 推荐：在设置页面提供主题切换
@ComponentV2
struct SettingsPage {
  @StorageLink('app_theme_mode') currentTheme: 'light' | 'dark' = 'light'

  build() {
    Column() {
      Text('Settings')
        .fontSize(24)

      List() {
        ListItem() {
          Row() {
            Text('Dark Mode')
            Toggle({ type: ToggleType.Switch, isOn: this.currentTheme === 'dark' })
              .onChange((isOn: boolean) => {
                const newTheme: 'light' | 'dark' = isOn ? 'dark' : 'light'
                AppStorage.set('app_theme_mode', newTheme)
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }
      }
    }
  }
}
```

### 7.4 主题资源命名规范

```json
{
  "color": [
    {
      "name": "primary_color",
      "value": "#007DFF"
    },
    {
      "name": "primary_variant",
      "value": "#4D94FF"
    },
    {
      "name": "secondary_color",
      "value": "#03DAC6"
    },
    {
      "name": "background_color",
      "value": "#FFFFFF"
    },
    {
      "name": "surface_color",
      "value": "#F5F5F5"
    },
    {
      "name": "error_color",
      "value": "#B00020"
    },
    {
      "name": "on_primary_color",
      "value": "#FFFFFF"
    },
    {
      "name": "on_secondary_color",
      "value": "#000000"
    },
    {
      "name": "on_background_color",
      "value": "#000000"
    },
    {
      "name": "on_surface_color",
      "value": "#000000"
    },
    {
      "name": "on_error_color",
      "value": "#FFFFFF"
    }
  ]
}
```

## 八、常见问题

### Q1: 如何监听系统主题变化？

```typescript
import { Configuration } from '@ohos.application.Configuration'

@ComponentV2
struct ThemeChangeListener {
  @Local currentTheme: 'light' | 'dark' = 'light'

  aboutToAppear() {
    // 监听系统配置变化
    Configuration.on('configurationChange', (config) => {
      this.currentTheme = config.colorMode === ConfigurationConstant.ColorMode.COLOR_MODE_DARK
        ? 'dark'
        : 'light'
    })
  }

  aboutToDisappear() {
    // 取消监听
    Configuration.off('configurationChange')
  }

  build() {
    Text(`System Theme: ${this.currentTheme}`)
  }
}
```

### Q2: 如何实现主题切换的平滑过渡？

```typescript
@ComponentV2
struct SmoothThemeTransition {
  @StorageLink('app_theme_mode') currentTheme: 'light' | 'dark' = 'light'

  build() {
    Column() {
      Text('Content')
        .fontColor(this.currentTheme === 'dark' ? '#FFFFFF' : '#000000')
        .transition({
          type: TransitionType.All,
          opacity: 0,
          scale: { x: 0.95, y: 0.95 }
        })
        .animation({
          duration: 300,
          curve: Curve.EaseInOut
        })
    }
    .backgroundColor(this.currentTheme === 'dark' ? '#121212' : '#FFFFFF')
    .animation({
      duration: 300,
      curve: Curve.EaseInOut
    })
  }
}
```

### Q3: 如何在 Web 组件中使用深色模式？

```typescript
import { webview } from '@kit.ArkWeb'

@ComponentV2
struct DarkModeWeb {
  private webController: webview.WebviewController = new webview.WebviewController()

  build() {
    Web({
      src: 'https://example.com',
      controller: this.webController
    })
      .domStorageAccess(true)
      .onControllerAttached(() => {
        // 启用深色模式
        this.webController.setDarkMode(true)
        // 或强制深色模式
        this.webController.setForceDarkAccess(true)
      })
  }
}
```

### Q4: 如何测试不同主题下的 UI？

```typescript
// ✅ 推荐：使用预览功能测试
@Preview({
  backgroundColor: '#FFFFFF'  // 浅色背景
})
@ComponentV2
struct LightThemePreview {
  build() {
    Text('Light Theme')
      .fontColor('#000000')
  }
}

@Preview({
  backgroundColor: '#121212'  // 深色背景
})
@ComponentV2
struct DarkThemePreview {
  build() {
    Text('Dark Theme')
      .fontColor('#FFFFFF')
  }
}

// 或在代码中动态切换
@ComponentV2
struct ThemeTestPage {
  @Local testTheme: 'light' | 'dark' = 'light'

  build() {
    Column() {
      Text('Test Content')
        .fontColor(this.testTheme === 'dark' ? '#FFFFFF' : '#000000')

      Row({ space: 8 }) {
        Button('Light')
          .onClick(() => {
            this.testTheme = 'light'
          })

        Button('Dark')
          .onClick(() => {
            this.testTheme = 'dark'
          })
      }
    }
    .backgroundColor(this.testTheme === 'dark' ? '#121212' : '#FFFFFF')
  }
}
```

## 九、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 9-10 | ⚠️ | 有限支持，主要通过资源文件 |
| API 11 | ✅ | 增强主题支持 |
| API 12+ | ✅ | 完整的主题系统，支持深色模式 API |
| API 13+ | ✅ | 更丰富的主题定制能力 |

## 十、参考资料

- [设置深色模式 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/web-set-dark-mode-V5)
- [鸿蒙中如何实现深色模式与浅色模式切换](https://m.blog.csdn.net/2201_75843490/article/details/149980755)
- [HarmonyOS 5.0.0 或以上：封装 useTheme，实现深色/浅色主题动态切换](https://m.blog.csdn.net/weixin_43815680/article/details/148200973)
- [鸿蒙深色模式切换功能](https://blog.csdn.net/m0_63958973/article/details/146569957)

## 十一、总结

HarmonyOS 6.0 的主题系统提供了完整的主题管理能力：

**核心特性**:
- 系统主题跟随和自定义主题
- 深色/浅色模式动态切换
- 主题资源自动适配
- 组件级主题覆盖

**最佳实践**:
- 使用资源引用管理颜色、尺寸等
- 通过 AppStorage 或 PersistentStorage 持久化主题偏好
- 定义统一的主题配置接口
- 实现平滑的主题切换动画

**性能优化**:
- 避免频繁的主题切换
- 使用动画提升用户体验
- 合理组织主题资源文件

通过合理使用主题系统，可以提升应用的用户体验，满足不同用户的个性化需求。
