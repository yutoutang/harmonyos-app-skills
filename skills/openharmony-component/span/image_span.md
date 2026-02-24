# ImageSpan 组件 HarmonyOS 6.0 开发 Skill

## 概述

ImageSpan 是 OpenHarmony 中用于在 Text 组件中内联显示图片的组件。它允许文本和图片在同一行混合显示，常用于实现富文本效果，如表情符号、图标、特殊标记等。ImageSpan 只能作为 Text 组件的子组件使用。

## 重要说明

- **子组件限制**: ImageSpan 只能作为 Text 组件的子组件使用
- **行内显示**: ImageSpan 默认为行内元素，与文本在同一基线显示
- **对齐方式**: 支持多种垂直对齐方式（顶部、居中、底部、基线）
- **图片资源**: 支持本地图片、网络图片、Symbol 图标等
- **大小控制**: 必须显式设置宽度和高度

## 模块信息

- **组件名称**: ImageSpan
- **SDK 版本**: HarmonyOS 6.0 (API 9+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [ImageSpan 图片片段 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-image-span-V5)

## 一、组件基础

### 1.1 基础用法

```typescript
// 本地图片
Text() {
  TextSpan('这是一张')
  ImageSpan($r('app.media.icon'))
    .width(20)
    .height(20)
  TextSpan('图片')
}

// 网络图片
Text() {
  TextSpan('网络图片: ')
  ImageSpan('https://example.com/image.png')
    .width(30)
    .height(30)
}

// Symbol 图标
Text() {
  TextSpan('天气: ')
  ImageSpan($r('sys.symbol.sunny'))
    .width(24)
    .height(24)
}
```

### 1.2 使用场景

```typescript
// 场景 1: 表情符号
Text() {
  TextSpan('今天心情')
  ImageSpan($r('app.media.happy'))
    .width(24)
    .height(24)
  TextSpan('很好！')
}

// 场景 2: 图标文本
Text() {
  ImageSpan($r('app.media.icon_phone'))
    .width(16)
    .height(16)
  TextSpan(' 10086')
}

// 场景 3: 徽章标记
Text() {
  TextSpan('用户')
  ImageSpan($r('app.media.badge_vip'))
    .width(40)
    .height(16)
  TextSpan(' 张三')
}
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| value | `string \| Resource \| PixelMap` | 是 | - | 图片资源，可以是本地资源、网络 URL 或 PixelMap |
| options | `ImageSpanOptions` | 否 | - | 图片选项，如 verticalAlign |

### 2.2 尺寸属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `width` | `Length` | - | 图片宽度（必须设置） |
| `height` | `Length` | - | 图片高度（必须设置） |
| `size` | `Length` | - | 同时设置宽度和高度 |

### 2.3 对齐属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `verticalAlign` | `ImageSpanAlignment` | BOTTOM | 垂直对齐方式 |

### 2.4 图片样式属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `objectFit` | `ImageFit` | Cover | 图片填充模式 |
| `objectRepeat` | `ImageRepeat` | NoRepeat | 图片重复方式 |
| `borderRadius` | `Length` | 0 | 圆角半径 |
| `margin` | `Margin \| Length` | 0 | 外边距 |

### 2.5 交互属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `onClick` | `() => void` | - | 点击事件 |

## 三、垂直对齐方式

ImageSpan 支持以下垂直对齐方式：

| 枚举值 | 描述 | 示例 |
|--------|------|------|
| `ImageSpanAlignment.TOP` | 顶部对齐 | 图片顶部与文本顶部对齐 |
| `ImageSpanAlignment.CENTER` | 居中对齐 | 图片垂直居中于文本行 |
| `ImageSpanAlignment.BOTTOM` | 底部对齐 | 图片底部与文本底部对齐（默认） |
| `ImageSpanAlignment.BASELINE` | 基线对齐 | 图片基线与文本基线对齐 |

## 四、使用示例

### 4.1 基础图片示例

```typescript
// 本地资源图片
Text() {
  TextSpan('这是一张')
  ImageSpan($r('app.media.icon_example'))
    .width(24)
    .height(24)
    .objectFit(ImageFit.Contain)
  TextSpan('图片')
}
.fontSize(16)

// 不同尺寸
Text() {
  TextSpan('小图标')
  ImageSpan($r('app.media.icon'))
    .width(16)
    .height(16)
  TextSpan(' 中图标')
  ImageSpan($r('app.media.icon'))
    .width(24)
    .height(24)
  TextSpan(' 大图标')
  ImageSpan($r('app.media.icon'))
    .width(32)
    .height(32)
}
```

### 4.2 垂直对齐示例

```typescript
@ComponentV2
struct ImageSpanAlignmentExample {
  build() {
    Column({ space: 16 }) {
      Text('ImageSpan 对齐方式')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      // 顶部对齐
      Text() {
        TextSpan('顶部对齐: ')
        ImageSpan($r('app.media.icon'))
          .width(30)
          .height(30)
          .verticalAlign(ImageSpanAlignment.TOP)
        TextSpan('文本内容')
      }
      .fontSize(16)

      // 居中对齐
      Text() {
        TextSpan('居中对齐: ')
        ImageSpan($r('app.media.icon'))
          .width(30)
          .height(30)
          .verticalAlign(ImageSpanAlignment.CENTER)
        TextSpan('文本内容')
      }
      .fontSize(16)

      // 底部对齐（默认）
      Text() {
        TextSpan('底部对齐: ')
        ImageSpan($r('app.media.icon'))
          .width(30)
          .height(30)
          .verticalAlign(ImageSpanAlignment.BOTTOM)
        TextSpan('文本内容')
      }
      .fontSize(16)

      // 基线对齐
      Text() {
        TextSpan('基线对齐: ')
        ImageSpan($r('app.media.icon'))
          .width(30)
          .height(30)
          .verticalAlign(ImageSpanAlignment.BASELINE)
        TextSpan('文本内容')
      }
      .fontSize(16)
    }
  }
}
```

### 4.3 表情符号示例

```typescript
@ComponentV2
struct EmojiExample {
  @Local message: string = '今天天气真好！'

  build() {
    Column({ space: 16 }) {
      // 简单表情
      Text() {
        TextSpan('开心 ')
        ImageSpan($r('app.media.emoji_happy'))
          .width(24)
          .height(24)
          .verticalAlign(ImageSpanAlignment.CENTER)
        TextSpan(' 悲伤 ')
        ImageSpan($r('app.media.emoji_sad'))
          .width(24)
          .height(24)
          .verticalAlign(ImageSpanAlignment.CENTER)
      }
      .fontSize(16)

      // 表情文本混合
      Text() {
        TextSpan(this.message)
        ImageSpan($r('app.media.emoji_sunny'))
          .width(28)
          .height(28)
          .verticalAlign(ImageSpanAlignment.CENTER)
      }
      .fontSize(18)
    }
  }
}
```

### 4.4 图标文本示例

```typescript
@ComponentV2
struct IconTextExample {
  build() {
    Column({ space: 16 }) {
      // 电话号码
      Text() {
        ImageSpan($r('app.media.icon_phone'))
          .width(16)
          .height(16)
          .verticalAlign(ImageSpanAlignment.CENTER)
        TextSpan(' 10086')
      }
      .fontSize(16)

      // 邮箱
      Text() {
        ImageSpan($r('app.media.icon_email'))
          .width(16)
          .height(16)
          .verticalAlign(ImageSpanAlignment.CENTER)
        TextSpan(' example@huawei.com')
      }
      .fontSize(16)

      // 地址
      Text() {
        ImageSpan($r('app.media.icon_location'))
          .width(16)
          .height(16)
          .verticalAlign(ImageSpanAlignment.CENTER)
        TextSpan(' 深圳市龙岗区')
      }
      .fontSize(16)
    }
  }
}
```

### 4.5 徽章标记示例

```typescript
@ComponentV2
struct BadgeExample {
  build() {
    Column({ space: 16 }) {
      // VIP 徽章
      Text() {
        TextSpan('用户')
        ImageSpan($r('app.media.badge_vip'))
          .width(40)
          .height(16)
          .verticalAlign(ImageSpanAlignment.CENTER)
          .objectFit(ImageFit.Contain)
        TextSpan(' 张三')
      }
      .fontSize(16)

      // 认证徽章
      Text() {
        TextSpan('李四')
        ImageSpan($r('app.media.badge_verified'))
          .width(16)
          .height(16)
          .verticalAlign(ImageSpanAlignment.CENTER)
      }
      .fontSize(16)

      // 标签
      Text() {
        TextSpan('热门')
        ImageSpan($r('app.media.tag_hot'))
          .width(30)
          .height(14)
          .verticalAlign(ImageSpanAlignment.CENTER)
        TextSpan(' 推荐')
        ImageSpan($r('app.media.tag_new'))
          .width(30)
          .height(14)
          .verticalAlign(ImageSpanAlignment.CENTER)
      }
      .fontSize(16)
    }
  }
}
```

### 4.6 交互示例

```typescript
@ComponentV2
struct InteractiveImageSpanExample {
  build() {
    Column({ space: 16 }) {
      // 可点击的图片
      Text() {
        TextSpan('点击')
        ImageSpan($r('app.media.icon_like'))
          .width(24)
          .height(24)
          .verticalAlign(ImageSpanAlignment.CENTER)
          .onClick(() => {
            console.info('点赞')
          })
        TextSpan('点赞')
      }
      .fontSize(16)

      // 多个可点击图标
      Text() {
        TextSpan('分享: ')

        ImageSpan($r('app.media.icon_wechat'))
          .width(24)
          .height(24)
          .margin({ left: 4, right: 4 })
          .onClick(() => {
            console.info('分享到微信')
          })

        ImageSpan($r('app.media.icon_weibo'))
          .width(24)
          .height(24)
          .margin({ left: 4, right: 4 })
          .onClick(() => {
            console.info('分享到微博')
          })

        ImageSpan($r('app.media.icon_qq'))
          .width(24)
          .height(24)
          .margin({ left: 4, right: 4 })
          .onClick(() => {
            console.info('分享到QQ')
          })
      }
      .fontSize(16)
    }
  }
}
```

### 4.7 圆角图片示例

```typescript
@ComponentV2
struct RoundedImageSpanExample {
  build() {
    Column({ space: 16 }) {
      // 圆形头像
      Text() {
        TextSpan('用户: ')
        ImageSpan($r('app.media.avatar'))
          .width(32)
          .height(32)
          .borderRadius(16)
          .verticalAlign(ImageSpanAlignment.CENTER)
          .objectFit(ImageFit.Cover)
        TextSpan(' 张三')
      }
      .fontSize(16)

      // 圆角图标
      Text() {
        TextSpan('标签: ')
        ImageSpan($r('app.media.icon_tag'))
          .width(24)
          .height(24)
          .borderRadius(4)
          .verticalAlign(ImageSpanAlignment.CENTER)
          .objectFit(ImageFit.Contain)
      }
      .fontSize(16)
    }
  }
}
```

## 五、高级用法

### 5.1 动态图片

```typescript
@ComponentV2
struct DynamicImageSpanExample {
  @Local isLiked: boolean = false

  build() {
    Column({ space: 16 }) {
      Text() {
        TextSpan('点赞状态: ')
        ImageSpan(this.isLiked ? $r('app.media.icon_liked') : $r('app.media.icon_like'))
          .width(24)
          .height(24)
          .verticalAlign(ImageSpanAlignment.CENTER)
          .onClick(() => {
            this.isLiked = !this.isLiked
          })
        TextSpan(this.isLiked ? ' 已点赞' : ' 未点赞')
      }
      .fontSize(16)
    }
  }
}
```

### 5.2 列表中的图片

```typescript
@ComponentV2
struct ListItemWithImageSpan {
  @Local items: string[] = ['选项1', '选项2', '选项3']

  build() {
    Column({ space: 8 }) {
      ForEach(this.items, (item: string) => {
        Text() {
          ImageSpan($r('app.media.icon_check'))
            .width(16)
            .height(16)
            .verticalAlign(ImageSpanAlignment.CENTER)
          TextSpan(` ${item}`)
        }
        .fontSize(16)
        .padding(8)
        .backgroundColor('#F5F5F5')
        .borderRadius(4)
      })
    }
  }
}
```

### 5.3 结合其他 Span

```typescript
@ComponentV2
struct MixedSpanExample {
  build() {
    Column({ space: 16 }) {
      // 文本 + 图片 + 文本
      Text() {
        TextSpan('天气: ')
          .fontSize(16)
        ImageSpan($r('sys.symbol.sunny'))
          .width(24)
          .height(24)
          .verticalAlign(ImageSpanAlignment.CENTER)
        TextSpan(' 晴朗')
          .fontSize(16)
          .fontColor('#FF8F00')
          .fontWeight(FontWeight.Bold)
      }

      // 图片 + 文本 + 图片
      Text() {
        ImageSpan($r('app.media.icon_star'))
          .width(16)
          .height(16)
          .verticalAlign(ImageSpanAlignment.CENTER)
        TextSpan(' 收藏夹 ')
          .fontSize(16)
        ImageSpan($r('app.media.icon_arrow'))
          .width(12)
          .height(12)
          .verticalAlign(ImageSpanAlignment.CENTER)
      }
    }
  }
}
```

## 六、最佳实践

### 6.1 尺寸设置

```typescript
// ✅ 推荐：明确设置宽度和高度
Text() {
  ImageSpan($r('app.media.icon'))
    .width(24)
    .height(24)
}

// ❌ 错误：不设置尺寸
Text() {
  ImageSpan($r('app.media.icon'))  // 图片不会显示
}
```

### 6.2 对齐方式选择

```typescript
// ✅ 推荐：根据场景选择合适的对齐方式
Text() {
  TextSpan('图标')
  ImageSpan($r('app.media.icon'))
    .width(16)
    .height(16)
    .verticalAlign(ImageSpanAlignment.CENTER)  // 小图标居中对齐
}

// ✅ 推荐：大图使用基线对齐
Text() {
  TextSpan('表情')
  ImageSpan($r('app.media.emoji'))
    .width(32)
    .height(32)
    .verticalAlign(ImageSpanAlignment.BASELINE)  // 表情基线对齐
}
```

### 6.3 图片资源优化

```typescript
// ✅ 推荐：使用合适的图片格式和大小
Text() {
  ImageSpan($r('app.media.icon_small'))
    .width(16)
    .height(16)
    .objectFit(ImageFit.Contain)  // 保持比例
}

// ❌ 避免：使用过大的图片
Text() {
  ImageSpan($r('app.media.icon_large'))  // 浪费内存
    .width(16)
    .height(16)
}
```

## 七、常见问题

### Q1: ImageSpan 为什么不显示？

**问题**: 添加了 ImageSpan 但不显示。

**解决方案**:
```typescript
// ❌ 错误：没有设置尺寸
Text() {
  ImageSpan($r('app.media.icon'))
}

// ✅ 正确：设置宽度和高度
Text() {
  ImageSpan($r('app.media.icon'))
    .width(24)
    .height(24)
}
```

### Q2: 如何让 ImageSpan 与文本居中对齐？

**解决方案**:
```typescript
Text() {
  TextSpan('文本')
  ImageSpan($r('app.media.icon'))
    .width(24)
    .height(24)
    .verticalAlign(ImageSpanAlignment.CENTER)  // 设置居中对齐
}
```

### Q3: ImageSpan 可以单独使用吗？

**答案**: 不可以。ImageSpan 必须作为 Text 组件的子组件使用。

### Q4: 如何实现可点击的图片？

**解决方案**:
```typescript
Text() {
  TextSpan('点击')
  ImageSpan($r('app.media.icon'))
    .width(24)
    .height(24)
    .onClick(() => {
      console.info('ImageSpan 被点击')
    })
}
```

## 八、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 9+ | ✅ | 完全支持 |
| API 12+ | ✅ | 增加了更多对齐选项 |

## 九、参考资料

- [ImageSpan 图片片段 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-image-span-V5)
- [Text 文本 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-text-V5)
- [Span 文本片段 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-span-V5)
