# Hyperlink 组件 HarmonyOS 6.0 开发 Skill

## 概述

Hyperlink 组件是 OpenHarmony 中提供超链接功能的文本组件，用于显示可点击的链接文本。它支持自定义链接颜色、下划线样式等属性，并能够响应用户的点击事件，实现页面跳转或自定义操作。

## 重要说明

- **交互性**: Hyperlink 本身是可点击的，会触发点击事件
- **样式**: 支持自定义颜色、下划线等样式
- **跳转**: 需要结合路由或其他导航机制实现页面跳转
- **可访问性**: 支持辅助功能，提供更好的用户体验

## 模块信息

- **组件名称**: Hyperlink
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [Hyperlink 超链接 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-hyperlink-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// Hyperlink 是内置组件，无需导入
// 直接使用即可
Hyperlink('https://www.example.com')
```

### 1.2 基础用法

```typescript
// 基本超链接
Hyperlink('https://www.example.com')
  .fontSize(16)

// 自定义显示文本
Hyperlink('https://www.example.com') {
  Text('Visit Website')
    .fontSize(16)
}

// 设置颜色和下划线
Hyperlink('https://www.example.com')
  .fontSize(16)
  .fontColor('#007DFF')
  .textDecoration({ type: TextDecorationType.Underline })
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| content | `string` | 是 | - | 链接地址 (URL 或自定义标识) |
| builder | `CustomBuilder` | 否 | - | 自定义内容构建器 |

### 2.2 组件属性

Hyperlink 继承自 Text 组件，支持所有 Text 属性：

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `fontSize` | `number \| string \| Resource` | 16fp | 字体大小 |
| `fontColor` | `ResourceColor` | '#007DFF' | 字体颜色 |
| `fontStyle` | `FontStyle` | FontStyle.Normal | 字体样式 |
| `fontWeight` | `number \| FontWeight \| string` | FontWeight.Normal | 字体粗细 |
| `textDecoration` | `TextDecorationStyleInterface` | {type: Underline} | 文本装饰 |
| `letterSpacing` | `number \| string` | 0 | 字符间距 |

### 2.3 事件

| 事件 | 类型 | 描述 |
|------|------|------|
| `onClick` | `() => void` | 点击链接时触发 |

## 三、常见使用场景

### 3.1 基本超链接

```typescript
@ComponentV2
struct BasicHyperlink {
  build() {
    Column({ space: 16 }) {
      Text('Basic Hyperlink')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Hyperlink('https://www.example.com')
        .fontSize(16)
        .onClick(() => {
          console.info('Link clicked')
        })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.2 自定义显示文本

```typescript
@ComponentV2
struct CustomTextHyperlink {
  build() {
    Column({ space: 16 }) {
      Text('Custom Text Hyperlink')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Hyperlink('https://www.example.com') {
        Text('Click here to visit our website')
          .fontSize(16)
          .fontColor('#007DFF')
      }
      .onClick(() => {
        console.info('Custom link clicked')
      })

      Hyperlink('tel:+1234567890') {
        Row({ space: 8 }) {
          Text('📞')
          Text('Call us')
        }
        .fontSize(16)
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.3 不同样式

```typescript
@ComponentV2
struct StyledHyperlink {
  build() {
    Column({ space: 16 }) {
      Text('Hyperlink Styles')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 默认样式（蓝色带下划线）
      Hyperlink('https://www.example.com') {
        Text('Default Style Link')
      }

      // 红色链接
      Hyperlink('https://www.example.com') {
        Text('Red Link')
          .fontColor('#FF0000')
      }

      // 粗体链接
      Hyperlink('https://www.example.com') {
        Text('Bold Link')
          .fontWeight(FontWeight.Bold)
      }

      // 无下划线链接
      Hyperlink('https://www.example.com') {
        Text('No Underline Link')
          .textDecoration({ type: TextDecorationType.None })
      }

      // 大号链接
      Hyperlink('https://www.example.com') {
        Text('Large Link')
          .fontSize(20)
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.4 文本中的链接

```typescript
@ComponentV2
struct TextWithLinks {
  build() {
    Column({ space: 16 }) {
      Text('Text with Hyperlinks')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Text() {
        Span('For more information, visit our ')
          .fontSize(14)
          .fontColor('#333333')

        Hyperlink('https://www.example.com') {
          Span('website')
            .fontColor('#007DFF')
        }

        Span(' or contact ')
          .fontSize(14)
          .fontColor('#333333')

        Hyperlink('mailto:support@example.com') {
          Span('support')
            .fontColor('#007DFF')
        }
      }
      .fontSize(14)

      Text() {
        Span('Read our ')
          .fontSize(14)
          .fontColor('#333333')

        Hyperlink('https://www.example.com/privacy') {
          Span('Privacy Policy')
            .fontColor('#007DFF')
            .textDecoration({ type: TextDecorationType.Underline })
        }

        Span(' and ')
          .fontSize(14)
          .fontColor('#333333')

        Hyperlink('https://www.example.com/terms') {
          Span('Terms of Service')
            .fontColor('#007DFF')
            .textDecoration({ type: TextDecorationType.Underline })
        }
      }
      .fontSize(14)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.5 链接组

```typescript
@ComponentV2
struct HyperlinkGroup {
  build() {
    Column({ space: 12 }) {
      Text('Quick Links')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Column({ space: 8 }) {
        Hyperlink('https://www.example.com/home') {
          Text('🏠 Home')
        }
        .fontSize(16)

        Hyperlink('https://www.example.com/about') {
          Text('ℹ️ About')
        }
        .fontSize(16)

        Hyperlink('https://www.example.com/services') {
          Text('⚙️ Services')
        }
        .fontSize(16)

        Hyperlink('https://www.example.com/contact') {
          Text('📧 Contact')
        }
        .fontSize(16)
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.6 外部链接处理

```typescript
@ComponentV2
struct ExternalHyperlink {
  @Local showConfirm: boolean = false
  private externalUrl: string = ''

  build() {
    Column({ space: 16 }) {
      Text('External Link Handler')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Hyperlink('https://www.example.com') {
        Text('Open External Website')
          .fontSize(16)
      }
      .onClick(() => {
        this.showConfirm = true
        this.externalUrl = 'https://www.example.com'
      })

      if (this.showConfirm) {
        Column({ space: 12 }) {
          Text('Open external link?')
            .fontSize(16)

          Row({ space: 12 }) {
            Button('Cancel')
              .onClick(() => {
                this.showConfirm = false
              })

            Button('Open')
              .onClick(() => {
                // 使用系统浏览器打开链接
                console.info(`Opening: ${this.externalUrl}`)
                this.showConfirm = false
              })
          }
        }
        .padding(16)
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.7 页面内导航

```typescript
@ComponentV2
struct NavigationHyperlink {
  @Param navPathStack: NavPathStack = new NavPathStack()

  build() {
    Column({ space: 16 }) {
      Text('Navigation Links')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Hyperlink('page:details') {
        Text('Go to Details Page')
          .fontSize(16)
      }
      .onClick(() => {
        this.navPathStack.pushPathByName('DetailsPage', null)
      })

      Hyperlink('page:profile') {
        Text('View Profile')
          .fontSize(16)
      }
      .onClick(() => {
        this.navPathStack.pushPathByName('ProfilePage', null)
      })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.8 悬停效果

```typescript
@ComponentV2
struct HoverHyperlink {
  @Local isHovered: boolean = false

  build() {
    Column({ space: 16 }) {
      Text('Hover Effect')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Hyperlink('https://www.example.com') {
        Text('Hover over me')
          .fontSize(16)
          .fontColor(this.isHovered ? '#0056b3' : '#007DFF')
          .textDecoration({
            type: this.isHovered ? TextDecorationType.Underline : TextDecorationType.None
          })
      }
      .onHover((isHover: boolean) => {
        this.isHovered = isHover
      })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.9 页脚链接

```typescript
@ComponentV2
struct FooterHyperlink {
  build() {
    Column() {
      Row({ space: 24 }) {
        Hyperlink('https://www.example.com/about') {
          Text('About')
            .fontSize(14)
            .fontColor('#666666')
        }

        Hyperlink('https://www.example.com/privacy') {
          Text('Privacy')
            .fontSize(14)
            .fontColor('#666666')
        }

        Hyperlink('https://www.example.com/terms') {
          Text('Terms')
            .fontSize(14)
            .fontColor('#666666')
        }

        Hyperlink('https://www.example.com/contact') {
          Text('Contact')
            .fontSize(14)
            .fontColor('#666666')
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .padding(16)
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
  }
}
```

### 3.10 可访问性支持

```typescript
@ComponentV2
struct AccessibleHyperlink {
  build() {
    Column({ space: 16 }) {
      Text('Accessible Links')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Hyperlink('https://www.example.com/help') {
        Text('Get Help')
          .fontSize(16)
      }
      .accessibilityText('Opens help documentation in new window')
      .accessibilityLevel('Important')

      Hyperlink('https://www.example.com/download') {
        Text('Download File')
          .fontSize(16)
      }
      .accessibilityText('Downloads PDF file, 2.5 MB')
    }
    .width('100%')
    .padding(16)
  }
}
```

## 四、最佳实践

### 4.1 清晰的链接文本

```typescript
// 好的做法：使用描述性的链接文本
Hyperlink('https://www.example.com/guide') {
  Text('Read the user guide')
}

// 避免：使用模糊的链接文本
Hyperlink('https://www.example.com/guide') {
  Text('Click here')
}
```

### 4.2 视觉反馈

```typescript
@ComponentV2
struct FeedbackHyperlink {
  @Local isPressed: boolean = false

  build() {
    Hyperlink('https://www.example.com') {
      Text('Press Me')
        .fontSize(16)
        .fontColor(this.isPressed ? '#0056b3' : '#007DFF')
        .opacity(this.isPressed ? 0.7 : 1.0)
    }
    .onTouch((event: TouchEvent) => {
      if (event.type === TouchType.Down) {
        this.isPressed = true
      } else if (event.type === TouchType.Up || event.type === TouchType.Cancel) {
        this.isPressed = false
      }
    })
  }
}
```

### 4.3 链接验证

```typescript
@ComponentV2
struct ValidatedHyperlink {
  @Local url: string = ''
  @Local isValid: boolean = true

  build() {
    Column({ space: 16 }) {
      TextInput({ placeholder: 'Enter URL', text: this.url })
        .onChange((value: string) => {
          this.url = value
          this.isValid = this.validateUrl(value)
        })

      if (this.url && this.isValid) {
        Hyperlink(this.url) {
          Text('Visit Link')
            .fontSize(16)
        }
      } else if (this.url && !this.isValid) {
        Text('Invalid URL format')
          .fontSize(14)
          .fontColor('#FF0000')
      }
    }
    .width('100%')
    .padding(16)
  }

  validateUrl(url: string): boolean {
    try {
      new URL(url)
      return true
    } catch {
      return false
    }
  }
}
```

### 4.4 安全考虑

```typescript
@ComponentV2
struct SecureHyperlink {
  @Local url: string = 'https://www.example.com'

  build() {
    Column({ space: 16 }) {
      Hyperlink(this.url) {
        Text('Visit Website')
          .fontSize(16)
      }
      .onClick(() => {
        // 验证 URL 是否为预期域名
        if (this.url.startsWith('https://www.example.com')) {
          console.info(`Navigating to: ${this.url}`)
        } else {
          console.warn('Blocked navigation to untrusted URL')
        }
      })
    }
    .width('100%')
    .padding(16)
  }
}
```

## 五、常见问题

### 5.1 链接颜色不明显

```typescript
// 确保链接颜色与背景有足够对比度
Hyperlink('https://www.example.com') {
  Text('Link')
    .fontColor('#007DFF')  // 使用鲜明的蓝色
}
```

### 5.2 点击区域太小

```typescript
// 增加内边距扩大点击区域
Column() {
  Hyperlink('https://www.example.com') {
    Text('Link')
  }
}
.padding({ top: 8, bottom: 8, left: 12, right: 12 })
```

### 5.3 外部链接提示

```typescript
// 为外部链接添加图标提示
Hyperlink('https://www.example.com') {
  Row({ space: 4 }) {
    Text('External Link')
    Text('↗')  // 外部链接图标
  }
}
```

## 六、性能优化建议

1. **避免过多链接**: 在同一页面中避免使用过多超链接
2. **延迟加载**: 对于长列表中的链接，考虑延迟加载
3. **防抖处理**: 对于可能频繁触发的点击事件，添加防抖处理
4. **预加载**: 对于重要的链接，可以提前预加载目标页面
