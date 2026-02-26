# Span 组件 HarmonyOS 6.0 开发 Skill

## 概述

Span 组件是 OpenHarmony 中用于 Text 组件内部的文本片段组件，它可以实现富文本效果，允许在同一个 Text 组件中设置不同文本片段的不同样式。Span 只能作为 Text 组件的子组件使用，不能单独使用。

## 重要说明

- **子组件限制**: Span 只能作为 Text 组件的子组件使用
- **行内显示**: Span 默认为行内元素，多个 Span 会在同一行显示
- **样式继承**: Span 可以继承 Text 的部分样式属性
- **独立性**: 每个 Span 可以有独立的字体样式、装饰等
- **交互支持**: 支持点击事件、长按事件等交互

## 模块信息

- **组件名称**: Span
- **SDK 版本**: HarmonyOS 6.0 (API 9+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [Span 文本片段 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-span-V5)

## 一、组件基础

### 1.1 使用场景

```typescript
// 场景 1: 不同颜色的文本
Text() {
  Span('红色')
    .fontColor('#FF0000')
  Span('和')
  Span('蓝色')
    .fontColor('#0000FF')
}

// 场景 2: 高亮关键词
Text() {
  Span('搜索结果：')
  Span('关键词')
    .fontColor('#FF0000')
    .fontWeight(FontWeight.Bold)
}

// 场景 3: 链接样式
Text() {
  Span('点击')
  Span('这里')
    .fontColor('#007DFF')
    .decoration({ type: TextDecorationType.Underline })
  Span('查看详情')
}
```

### 1.2 基础语法

```typescript
Text() {
  Span('文本内容')
    .fontColor('#FF0000')
    .fontSize(16)
  Span('更多文本')
    .fontColor('#0000FF')
    .fontSize(20)
}
.fontSize(18)  // Text 的样式会被所有 Span 继承
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

### 2.6 布局属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `width` | `Length` | 内容宽度 | 宽度 |
| `height` | `Length` | 内容高度 | 高度 |
| `padding` | `Padding \| Length` | 0 | 内边距 |
| `margin` | `Margin \| Length` | 0 | 外边距 |

## 三、使用示例

### 3.1 基础样式示例

```typescript
// 不同颜色的文本
Text() {
  Span('红色')
    .fontColor('#FF0000')
  Span(' ')
  Span('绿色')
    .fontColor('#28A745')
  Span(' ')
  Span('蓝色')
    .fontColor('#007DFF')
}
.fontSize(18)

// 不同字重
Text() {
  Span('正常')
  Span(' ')
  Span('粗体')
    .fontWeight(FontWeight.Bold)
  Span(' ')
  Span('特粗')
    .fontWeight(900)
}
.fontSize(16)

// 不同大小
Text() {
  Span('小')
    .fontSize(14)
  Span(' ')
  Span('中')
    .fontSize(18)
  Span(' ')
  Span('大')
    .fontSize(24)
}
```

### 3.2 文本装饰示例

```typescript
// 下划线
Text() {
  Span('普通文本')
  Span(' ')
  Span('下划线文本')
    .fontColor('#007DFF')
    .decoration({
      type: TextDecorationType.Underline,
      color: '#007DFF'
    })
}

// 删除线
Text() {
  Span('原价')
    .fontColor('#999999')
  Span(' ')
  Span('¥199')
    .fontColor('#999999')
    .decoration({
      type: TextDecorationType.LineThrough,
      color: '#999999'
    })
  Span(' ')
  Span('¥99')
    .fontColor('#FF0000')
    .fontSize(20)
    .fontWeight(FontWeight.Bold)
}

// 混合装饰
Text() {
  Span('重点内容')
    .fontColor('#FF0000')
    .fontWeight(FontWeight.Bold)
    .decoration({
      type: TextDecorationType.Underline,
      color: '#FF0000'
    })
}
```

### 3.3 文本阴影示例

```typescript
// 简单阴影
Text() {
  Span('阴影文本')
    .fontSize(24)
    .fontColor('#FFFFFF')
    .textShadow({
      radius: 8,
      color: 'rgba(0, 0, 0, 0.5)',
      offsetX: 2,
      offsetY: 2
    })
}

// 多重阴影
Text() {
  Span('立体效果')
    .fontSize(28)
    .fontColor('#FFFFFF')
    .textShadow([
      { radius: 4, color: 'rgba(0, 0, 0, 0.3)', offsetX: 1, offsetY: 1 },
      { radius: 8, color: 'rgba(0, 0, 0, 0.2)', offsetX: 2, offsetY: 2 },
      { radius: 12, color: 'rgba(0, 0, 0, 0.1)', offsetX: 3, offsetY: 3 }
    ])
}
```

### 3.4 文本背景示例

```typescript
// 高亮背景
Text() {
  Span('这是')
  Span('高亮')
    .textBackground({ color: '#FFF8E1' })
    .fontColor('#FF8F00')
  Span('的文本')
}
.fontSize(16)

// 标签样式
Text() {
  Span('热门')
    .textBackground({
      color: '#FFEBEE',
      radius: 4
    })
    .fontColor('#D32F2F')
    .padding({ left: 4, right: 4, top: 2, bottom: 2 })
  Span(' ')
  Span('推荐')
    .textBackground({
      color: '#E8F5E9',
      radius: 4
    })
    .fontColor('#388E3C')
    .padding({ left: 4, right: 4, top: 2, bottom: 2 })
}
```

### 3.5 交互示例

```typescript
@ComponentV2
struct InteractiveSpanExample {
  build() {
    Column({ space: 16 }) {
      // 可点击的 Span
      Text() {
        Span('点击')
        Span('这里')
          .fontColor('#007DFF')
          .decoration({
            type: TextDecorationType.Underline,
            color: '#007DFF'
          })
          .onClick(() => {
            console.info('Span 被点击')
          })
        Span('查看详情')
      }

      // 长按事件
      Text() {
        Span('长按')
        Span('这里')
          .fontColor('#007DFF')
          .fontWeight(FontWeight.Bold)
          .onLongPress(() => {
            console.info('Span 被长按')
          })
        Span('触发事件')
      }
    }
  }
}
```

### 3.6 实际应用场景

```typescript
// 价格展示
Text() {
  Span('¥')
    .fontSize(14)
  Span('99')
    .fontSize(24)
    .fontWeight(FontWeight.Bold)
  Span('.00')
    .fontSize(14)
}

// 用户信息
Text() {
  Span('用户')
  Span(':')
  Span(' ')
  Span('张三')
    .fontWeight(FontWeight.Bold)
    .fontColor('#333333')
}

// 搜索结果
Text() {
  Span('搜索 "')
  Span('关键词')
    .fontColor('#FF0000')
    .fontWeight(FontWeight.Bold)
  Span('" 找到 100 条结果')
}

// 条款同意
Text() {
  Span('我已阅读并同意')
  Span('《用户协议》')
    .fontColor('#007DFF')
    .onClick(() => {
      // 跳转到用户协议
    })
  Span('和')
  Span('《隐私政策》')
    .fontColor('#007DFF')
    .onClick(() => {
      // 跳转到隐私政策
    })
}
```

## 四、高级用法

### 4.1 动态样式

```typescript
@ComponentV2
struct DynamicSpanExample {
  @Local isSelected: boolean = false

  build() {
    Text() {
      Span('状态: ')
      Span(this.isSelected ? '已选中' : '未选中')
        .fontColor(this.isSelected ? '#28A745' : '#999999')
        .fontWeight(FontWeight.Bold)
    }
    .onClick(() => {
      this.isSelected = !this.isSelected
    })
  }
}
```

### 4.2 条件渲染

```typescript
@ComponentV2
struct ConditionalSpanExample {
  @Local userLevel: number = 3

  build() {
    Text() {
      Span('用户等级: ')
      if (this.userLevel >= 5) {
        Span('VIP')
          .fontColor('#FFD700')
          .fontWeight(FontWeight.Bold)
      } else if (this.userLevel >= 3) {
        Span('高级')
          .fontColor('#007DFF')
          .fontWeight(FontWeight.Bold)
      } else {
        Span('普通')
          .fontColor('#999999')
      }
    }
  }
}
```

### 4.3 列表渲染

```typescript
@ComponentV2
struct ListSpanExample {
  @Local tags: string[] = ['标签1', '标签2', '标签3']

  build() {
    Column({ space: 8 }) {
      Text('标签列表:')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)

     ForEach(this.tags, (tag: string, index: number) => {
        Text() {
          Span('# ')
            .fontColor('#007DFF')
          Span(tag)
            .fontColor('#333333')
        }
        .fontSize(14)
      })
    }
  }
}
```

### 4.4 结合 ImageSpan

```typescript
Text() {
  Span('普通文本')
  ImageSpan($r('app.media.icon'))
    .width(20)
    .height(20)
    .objectFit(ImageFit.Contain)
  Span('带图片的文本')
}
```

## 五、最佳实践

### 5.1 样式继承

```typescript
// ✅ 推荐：在 Text 上设置公共样式
Text() {
  Span('红色')
    .fontColor('#FF0000')
  Span('蓝色')
    .fontColor('#0000FF')
  Span('绿色')
    .fontColor('#28A745')
}
.fontSize(16)  // 所有 Span 都继承 16fp 的字体大小

// ❌ 避免：为每个 Span 重复设置相同样式
Text() {
  Span('红色')
    .fontSize(16)
    .fontColor('#FF0000')
  Span('蓝色')
    .fontSize(16)
    .fontColor('#0000FF')
  Span('绿色')
    .fontSize(16)
    .fontColor('#28A745')
}
```

### 5.2 性能优化

```typescript
// ✅ 推荐：使用静态文本
const RED_TEXT = '红色'
const BLUE_TEXT = '蓝色'

Text() {
  Span(RED_TEXT)
    .fontColor('#FF0000')
  Span(BLUE_TEXT)
    .fontColor('#0000FF')
}

// ❌ 避免：在 Span 中进行复杂计算
Text() {
  Span('文本')
    .fontColor(this.getComplexColor())  // 每次渲染都计算
}
```

### 5.3 可访问性

```typescript
// ✅ 推荐：为交互式 Span 提供视觉反馈
Text() {
  Span('点击')
  Span('这里')
    .fontColor('#007DFF')
    .decoration({
      type: TextDecorationType.Underline,
      color: '#007DFF'
    })
    .onClick(() => {
      // 处理点击
    })
}

// ❌ 避免：交互式 Span 没有视觉提示
Text() {
  Span('点击')
  Span('这里')
    .fontColor('#007DFF')
    .onClick(() => {
      // 用户不知道可以点击
    })
}
```

## 六、常见问题

### Q1: Span 为什么不显示？

**问题**: 添加了 Span 但不显示。

**解决方案**:
```typescript
// ❌ 错误：Span 不能单独使用
Span('文本')  // 不会显示

// ✅ 正确：Span 必须在 Text 中使用
Text() {
  Span('文本')  // 正确显示
}
```

### Q2: Span 的样式为什么不生效？

**问题**: 设置了 Span 的样式但没有效果。

**解决方案**:
```typescript
// 检查属性拼写和值
Text() {
  Span('文本')
    .fontColor('#FF0000')  // ✅ 正确
    .fontSize(16)          // ✅ 正确
    .color('#FF0000')      // ❌ 错误，没有 color 属性
}
```

### Q3: 如何让 Span 换行？

**解决方案**:
```typescript
// 方案 1: 使用多个 Text
Column() {
  Text() {
    Span('第一行')
  }
  Text() {
    Span('第二行')
  }
}

// 方案 2: 使用 \n 换行符
Text() {
  Span('第一行\n第二行')
}
```

### Q4: Span 可以设置背景色吗？

**解决方案**:
```typescript
// ✅ 使用 textBackground 属性
Text() {
  Span('高亮文本')
    .textBackground({
      color: '#FFF8E1',
      radius: 4
    })
    .padding({ left: 4, right: 4, top: 2, bottom: 2 })
}
```

### Q5: 如何实现部分文本可选？

**解决方案**:
```typescript
// Span 不支持单独的选择功能
// 如需部分文本可选，使用多个 Text 组件
Row() {
  Text('普通文本')
  Text('可选文本')
    .copyOption(CopyOptions.InApp)
}
```

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 9+ | ✅ | 完全支持 |
| API 10+ | ✅ | 增加了 textBackground 属性 |
| API 12+ | ✅ | 增加了更多样式选项 |

## 八、参考资料

- [Span 文本片段 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-span-V5)
- [Text 文本 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-text-V5)
- [ImageSpan 图片片段 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-image-span-V5)
- [TextSpan 文本片段容器 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-text-span-V5)
