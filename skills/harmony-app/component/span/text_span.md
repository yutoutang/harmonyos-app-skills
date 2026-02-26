# TextSpan 组件 HarmonyOS 6.0 开发 Skill

## 概述

TextSpan 是 OpenHarmony 中用于替代传统 Span 组件的文本片段组件，提供了更强大的文本样式控制能力。TextSpan 是 Text 组件的内容子组件，用于实现富文本效果，支持更灵活的样式设置和更好的类型安全。

## 重要说明

- **子组件限制**: TextSpan 只能作为 Text 组件的内容子组件使用
- **类型安全**: 相比 Span，TextSpan 提供了更好的类型检查
- **样式隔离**: TextSpan 的样式不会影响其他文本片段
- **推荐使用**: 在新项目中推荐使用 TextSpan 替代 Span

## 模块信息

- **组件名称**: TextSpan
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [TextSpan 文本片段 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-text-span-V5)

## 一、组件基础

### 1.1 TextSpan vs Span

```typescript
// Span (传统方式)
Text() {
  Span('文本内容')
    .fontColor('#FF0000')
}

// TextSpan (推荐方式)
Text('文本内容')
  .fontColor('#FF0000')

// TextSpan 作为内容容器
Text() {
  TextSpan('文本内容')
    .fontColor('#FF0000')
}
```

### 1.2 基础用法

```typescript
// 简单文本片段
Text() {
  TextSpan('红色文本')
    .fontColor('#FF0000')
  TextSpan('蓝色文本')
    .fontColor('#0000FF')
}

// 嵌套使用
Text() {
  TextSpan('普通文本')
  TextSpan('重点文本')
    .fontColor('#FF0000')
    .fontWeight(FontWeight.Bold)
  TextSpan('继续普通文本')
}
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| content | `string \| Resource` | 否 | ' ' | 文本内容 |

### 2.2 字体属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `fontColor` | `ResourceColor` | 继承 Text | 字体颜色 |
| `fontSize` | `number \| string \| Resource` | 继承 Text | 字体大小 |
| `fontStyle` | `FontStyle` | 继承 Text | 字体样式（正常/斜体） |
| `fontWeight` | `number \| FontWeight \| string` | 继承 Text | 字体粗细（100-900） |
| `fontFamily` | `string \| Resource` | 继承 Text | 字体列表 |

### 2.3 文本装饰属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `decoration` | `DecorationStyleInterface` | {type: None} | 文本装饰线 |
| `letterSpacing` | `number \| string` | 继承 Text | 字符间距 |
| `textCase` | `TextCase` | 继承 Text | 文本大小写转换 |

### 2.4 文本效果属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `textShadow` | `ShadowOptions \| Array<ShadowOptions>` | - | 文本阴影 |
| `textBackground` | `TextStyleOptions` | - | 文本背景样式 |
| `textStyle` | `TextTextStyle` | TextStyle.NORMAL | 文本样式类型 |

### 2.5 交互属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `onClick` | `() => void` | - | 点击事件 |
| `onLongPress` | `() => void` | - | 长按事件 |

## 三、使用示例

### 3.1 基础样式示例

```typescript
// 不同颜色
Text() {
  TextSpan('红色')
    .fontColor('#FF0000')
  TextSpan('绿色')
    .fontColor('#28A745')
  TextSpan('蓝色')
    .fontColor('#007DFF')
}

// 不同字体大小
Text() {
  TextSpan('小')
    .fontSize(14)
  TextSpan('中')
    .fontSize(18)
  TextSpan('大')
    .fontSize(24)
}

// 不同字重
Text() {
  TextSpan('Light')
    .fontWeight(300)
  TextSpan(' Regular')
  TextSpan(' Medium')
    .fontWeight(500)
  TextSpan(' Bold')
    .fontWeight(700)
}
```

### 3.2 文本装饰示例

```typescript
// 下划线
Text() {
  TextSpan('普通文本')
  TextSpan('下划线文本')
    .decoration({
      type: TextDecorationType.Underline,
      color: '#007DFF'
    })
}

// 删除线（价格示例）
Text() {
  TextSpan('原价：')
  TextSpan('¥199')
    .fontColor('#999999')
    .decoration({
      type: TextDecorationType.LineThrough,
      color: '#999999'
    })
  TextSpan('  现价：')
  TextSpan('¥99')
    .fontColor('#FF0000')
    .fontSize(24)
    .fontWeight(FontWeight.Bold)
}
```

### 3.3 文本阴影示例

```typescript
// 霓虹效果
Text() {
  TextSpan('霓虹文字')
    .fontSize(32)
    .fontColor('#FFFFFF')
    .textShadow([
      { radius: 10, color: '#FF00FF', offsetX: 0, offsetY: 0 },
      { radius: 20, color: '#FF00FF', offsetX: 0, offsetY: 0 },
      { radius: 30, color: '#FF00FF', offsetX: 0, offsetY: 0 }
    ])
}

// 立体效果
Text() {
  TextSpan('立体文字')
    .fontSize(28)
    .fontColor('#4CAF50')
    .textShadow([
      { radius: 2, color: 'rgba(0,0,0,0.3)', offsetX: 2, offsetY: 2 },
      { radius: 4, color: 'rgba(0,0,0,0.2)', offsetX: 4, offsetY: 4 }
    ])
}
```

### 3.4 文本背景示例

```typescript
// 高亮标记
Text() {
  TextSpan('这是')
  TextSpan('重要')
    .textBackground({ color: '#FFEBEE' })
    .fontColor('#D32F2F')
  TextSpan('的内容')
}

// 标签样式
Text() {
  TextSpan('HOT')
    .textBackground({
      color: '#FF5252',
      radius: 4
    })
    .fontColor('#FFFFFF')
    .fontSize(12)
    .padding({ left: 6, right: 6, top: 2, bottom: 2 })
  TextSpan(' ')
  TextSpan('NEW')
    .textBackground({
      color: '#448AFF',
      radius: 4
    })
    .fontColor('#FFFFFF')
    .fontSize(12)
    .padding({ left: 6, right: 6, top: 2, bottom: 2 })
}
```

### 3.5 交互示例

```typescript
@ComponentV2
struct InteractiveTextSpanExample {
  @Local clicked: boolean = false

  build() {
    Column({ space: 16 }) {
      // 点击事件
      Text() {
        TextSpan('点击')
        TextSpan('这里')
          .fontColor('#007DFF')
          .decoration({
            type: TextDecorationType.Underline,
            color: '#007DFF'
          })
          .onClick(() => {
            this.clicked = !this.clicked
            console.info('TextSpan 被点击')
          })
        TextSpan(this.clicked ? '已点击' : '未点击')
      }

      // 长按事件
      Text() {
        TextSpan('长按')
        TextSpan('这里')
          .fontColor('#FF0000')
          .fontWeight(FontWeight.Bold)
          .onLongPress(() => {
            console.info('TextSpan 被长按')
          })
        TextSpan('触发事件')
      }
    }
  }
}
```

### 3.6 实际应用场景

```typescript
// 链接样式
Text() {
  TextSpan('我已阅读并同意')
  TextSpan('《用户协议》')
    .fontColor('#007DFF')
    .decoration({
      type: TextDecorationType.Underline,
      color: '#007DFF'
    })
    .onClick(() => {
      // 打开用户协议
    })
  TextSpan('和')
  TextSpan('《隐私政策》')
    .fontColor('#007DFF')
    .decoration({
      type: TextDecorationType.Underline,
      color: '#007DFF'
    })
    .onClick(() => {
      // 打开隐私政策
    })
}

// 搜索关键词高亮
Text() {
  TextSpan('搜索 "')
  TextSpan('HarmonyOS')
    .fontColor('#FF0000')
    .fontWeight(FontWeight.Bold)
    .textBackground({ color: '#FFF8E1' })
  TextSpan('" 找到相关结果')
}

// 价格展示
Text() {
  TextSpan('¥')
    .fontSize(14)
    .fontColor('#FF0000')
  TextSpan('99')
    .fontSize(28)
    .fontColor('#FF0000')
    .fontWeight(FontWeight.Bold)
  TextSpan('.00')
    .fontSize(14)
    .fontColor('#FF0000')
}

// 用户等级
Text() {
  TextSpan('用户等级: ')
  TextSpan('VIP')
    .fontColor('#FFD700')
    .fontWeight(FontWeight.Bold)
    .textStyle(TextStyle.ITALIC)
    .textBackground({
      color: 'rgba(255, 215, 0, 0.1)',
      radius: 4
    })
}
```

## 四、高级用法

### 4.1 动态样式

```typescript
@ComponentV2
struct DynamicTextSpanExample {
  @Local isActive: boolean = false

  build() {
    Text() {
      TextSpan('状态: ')
      TextSpan(this.isActive ? '激活' : '未激活')
        .fontColor(this.isActive ? '#28A745' : '#999999')
        .fontWeight(FontWeight.Bold)
        .textBackground({
          color: this.isActive ? '#E8F5E9' : '#F5F5F5',
          radius: 4
        })
    }
    .onClick(() => {
      this.isActive = !this.isActive
    })
  }
}
```

### 4.2 条件渲染

```typescript
@ComponentV2
struct ConditionalTextSpanExample {
  @Local score: number = 85

  build() {
    Text() {
      TextSpan('分数: ')
      TextSpan(`${this.score}分`)
        .fontWeight(FontWeight.Bold)
      TextSpan(' 等级: ')

      if (this.score >= 90) {
        TextSpan('优秀')
          .fontColor('#28A745')
          .fontWeight(FontWeight.Bold)
      } else if (this.score >= 80) {
        TextSpan('良好')
          .fontColor('#007DFF')
          .fontWeight(FontWeight.Bold)
      } else if (this.score >= 60) {
        TextSpan('及格')
          .fontColor('#FFC107')
          .fontWeight(FontWeight.Bold)
      } else {
        TextSpan('不及格')
          .fontColor('#FF0000')
          .fontWeight(FontWeight.Bold)
      }
    }
  }
}
```

### 4.3 结合其他 Span 类型

```typescript
// 结合 ImageSpan
Text() {
  TextSpan('消息')
  ImageSpan($r('app.media.icon_notification'))
    .width(20)
    .height(20)
    .verticalAlign(ImageSpanAlignment.CENTER)
  TextSpan('通知')
}

// 结合 SymbolSpan
Text() {
  TextSpan('天气: ')
  SymbolSpan($r('sys.symbol.sunny'))
    .fontSize(24)
  TextSpan('晴朗')
}
```

## 五、最佳实践

### 5.1 选择合适的组件

```typescript
// ✅ 推荐：新项目使用 TextSpan
Text() {
  TextSpan('文本')
    .fontColor('#FF0000')
}

// ⚠️ 兼容：旧项目继续使用 Span
Text() {
  Span('文本')
    .fontColor('#FF0000')
}
```

### 5.2 样式组织

```typescript
// ✅ 推荐：在 Text 上设置公共样式
Text() {
  TextSpan('红色')
    .fontColor('#FF0000')
  TextSpan('蓝色')
    .fontColor('#0000FF')
  TextSpan('绿色')
    .fontColor('#28A745')
}
.fontSize(16)
.lineHeight(24)

// ❌ 避免：重复设置相同样式
Text() {
  TextSpan('红色')
    .fontSize(16)
    .lineHeight(24)
    .fontColor('#FF0000')
  TextSpan('蓝色')
    .fontSize(16)
    .lineHeight(24)
    .fontColor('#0000FF')
}
```

### 5.3 类型安全

```typescript
// ✅ 推荐：使用常量避免拼写错误
const RED_COLOR = '#FF0000'
const BLUE_COLOR = '#0000FF'

Text() {
  TextSpan('红色')
    .fontColor(RED_COLOR)
  TextSpan('蓝色')
    .fontColor(BLUE_COLOR)
}

// ❌ 避免：硬编码字符串
Text() {
  TextSpan('红色')
    .fontColor('#ff0000')  // 容易拼写错误
}
```

## 六、常见问题

### Q1: TextSpan 和 Span 有什么区别？

**答案**:
- TextSpan 是更新的组件，提供更好的类型安全
- TextSpan 支持更多的样式选项
- 在新项目中推荐使用 TextSpan

### Q2: TextSpan 可以单独使用吗？

**答案**: 不可以。TextSpan 必须作为 Text 组件的子组件使用。

```typescript
// ❌ 错误
TextSpan('文本')

// ✅ 正确
Text() {
  TextSpan('文本')
}
```

### Q3: 如何实现 TextSpan 的点击效果？

**解决方案**:
```typescript
@ComponentV2
struct ClickableTextSpanExample {
  @Local isPressed: boolean = false

  build() {
    Text() {
      TextSpan('点击我')
        .fontColor(this.isPressed ? '#0056B3' : '#007DFF')
        .textBackground({
          color: this.isPressed ? 'rgba(0, 125, 255, 0.1)' : 'transparent'
        })
        .onClick(() => {
          this.isPressed = !this.isPressed
        })
    }
  }
}
```

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 12+ | ✅ | 完全支持 |
| API 11- | ❌ | 不支持，使用 Span 代替 |

## 八、参考资料

- [TextSpan 文本片段 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-text-span-V5)
- [Span 文本片段 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-span-V5)
- [Text 文本 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-text-V5)
