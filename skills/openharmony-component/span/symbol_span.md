# SymbolSpan 组件 HarmonyOS 6.0 开发 Skill

## 概述

SymbolSpan 是 OpenHarmony 中用于在 Text 组件中内联显示 SF Symbols 图标的组件。SF Symbols 是 Apple 设计的图标系统，HarmonyOS 通过 SymbolSpan 提供了类似的能力，允许开发者使用系统预定义的图标资源。SymbolSpan 只能作为 Text 组件的子组件使用。

## 重要说明

- **子组件限制**: SymbolSpan 只能作为 Text 组件的子组件使用
- **系统图标**: 使用 HarmonyOS 系统预定义的 Symbol 图标
- **资源格式**: 使用 `$r('sys.symbol.xxx')` 格式引用图标
- **动态颜色**: 支持跟随文本颜色动态变化
- **可缩放**: 图标可以任意缩放而不失真

## 模块信息

- **组件名称**: SymbolSpan
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [SymbolSpan 符号图标 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-symbol-span-V5)

## 一、组件基础

### 1.1 基础用法

```typescript
// 系统图标
Text() {
  TextSpan('天气: ')
  SymbolSpan($r('sys.symbol.sunny'))
    .fontSize(24)
  TextSpan(' 晴朗')
}

// 带颜色的图标
Text() {
  TextSpan('状态: ')
  SymbolSpan($r('sys.symbol.checkmark_circle'))
    .fontSize(20)
    .fontColor('#28A745')
  TextSpan(' 成功')
}
```

### 1.2 常用系统图标

```typescript
// 天气图标
Text() {
  SymbolSpan($r('sys.symbol.sunny'))      // 晴天
  SymbolSpan($r('sys.symbol.cloud'))      // 多云
  SymbolSpan($r('sys.symbol.rain'))       // 雨天
  SymbolSpan($r('sys.symbol.snow'))       // 雪天
}

// 操作图标
Text() {
  SymbolSpan($r('sys.symbol.checkmark'))  // 勾选
  SymbolSpan($r('sys.symbol.xmark'))      // 叉号
  SymbolSpan($r('sys.symbol.plus'))       // 加号
  SymbolSpan($r('sys.symbol.minus'))      // 减号
}

// 导航图标
Text() {
  SymbolSpan($r('sys.symbol.house'))      // 首页
  SymbolSpan($r('sys.symbol.person'))     // 用户
  SymbolSpan($r('sys.symbol.gear'))       // 设置
  SymbolSpan($r('sys.symbol.bell'))       // 通知
}
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| id | `Resource \| SymbolGlyph` | 是 | - | Symbol 图标资源 ID |

### 2.2 样式属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `fontSize` | `number \| string \| Resource` | 继承 Text | 图标大小（推荐使用 fontSize 设置尺寸） |
| `fontColor` | `ResourceColor` | 继承 Text | 图标颜色 |
| `fontWeight` | `number \| FontWeight \| string` | 继承 Text | 图标粗细（部分图标支持） |

### 2.3 效果属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `symbolEffect` | `SymbolEffect` | - | Symbol 动画效果 |
| `renderingStrategy` | `SymbolRenderingStrategy` | DEFAULT | 渲染策略 |
| `fontWeight` | `number \| FontWeight` | - | 图标线条粗细 |

### 2.4 交互属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `onClick` | `() => void` | - | 点击事件 |

## 三、使用示例

### 3.1 基础图标示例

```typescript
@ComponentV2
struct BasicSymbolSpanExample {
  build() {
    Column({ space: 16 }) {
      Text('基础 SymbolSpan')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      // 天气图标
      Text() {
        TextSpan('晴天 ')
        SymbolSpan($r('sys.symbol.sunny'))
          .fontSize(24)
          .fontColor('#FF8F00')
        TextSpan(' 多云 ')
        SymbolSpan($r('sys.symbol.cloud'))
          .fontSize(24)
          .fontColor('#757575')
      }
      .fontSize(16)

      // 状态图标
      Text() {
        TextSpan('成功 ')
        SymbolSpan($r('sys.symbol.checkmark_circle_fill'))
          .fontSize(20)
          .fontColor('#28A745')
        TextSpan(' 失败 ')
        SymbolSpan($r('sys.symbol.xmark_circle_fill'))
          .fontSize(20)
          .fontColor('#DC3545')
      }
      .fontSize(16)

      // 操作图标
      Text() {
        SymbolSpan($r('sys.symbol.plus_circle'))
          .fontSize(24)
          .fontColor('#007DFF')
        TextSpan(' 添加')
        SymbolSpan($r('sys.symbol.minus_circle'))
          .fontSize(24)
          .fontColor('#FF0000')
        TextSpan(' 删除')
      }
      .fontSize(16)
    }
  }
}
```

### 3.2 不同尺寸示例

```typescript
@ComponentV2
struct SymbolSpanSizeExample {
  build() {
    Column({ space: 16 }) {
      Text('不同尺寸的 SymbolSpan')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      // 小尺寸
      Text() {
        SymbolSpan($r('sys.symbol.heart'))
          .fontSize(16)
          .fontColor('#E91E63')
        TextSpan(' 小图标 (16fp)')
      }

      // 中等尺寸
      Text() {
        SymbolSpan($r('sys.symbol.heart'))
          .fontSize(24)
          .fontColor('#E91E63')
        TextSpan(' 中图标 (24fp)')
      }

      // 大尺寸
      Text() {
        SymbolSpan($r('sys.symbol.heart'))
          .fontSize(32)
          .fontColor('#E91E63')
        TextSpan(' 大图标 (32fp)')
      }

      // 特大尺寸
      Text() {
        SymbolSpan($r('sys.symbol.heart'))
          .fontSize(48)
          .fontColor('#E91E63')
        TextSpan(' 特大图标 (48fp)')
      }
    }
  }
}
```

### 3.3 不同颜色示例

```typescript
@ComponentV2
struct SymbolSpanColorExample {
  build() {
    Column({ space: 16 }) {
      Text('不同颜色的 SymbolSpan')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      // 主题色
      Row({ space: 16 }) {
        Text() {
          SymbolSpan($r('sys.symbol.circle_fill'))
            .fontSize(32)
            .fontColor('#FF0000')
        }
        Text() {
          SymbolSpan($r('sys.symbol.circle_fill'))
            .fontSize(32)
            .fontColor('#28A745')
        }
        Text() {
          SymbolSpan($r('sys.symbol.circle_fill'))
            .fontSize(32)
            .fontColor('#007DFF')
        }
        Text() {
          SymbolSpan($r('sys.symbol.circle_fill'))
            .fontSize(32)
            .fontColor('#FFC107')
        }
      }

      // 渐变色效果
      Text() {
        SymbolSpan($r('sys.symbol.star_fill'))
          .fontSize(48)
          .fontColor('#FFD700')
        TextSpan(' ')
        SymbolSpan($r('sys.symbol.star_fill'))
          .fontSize(40)
          .fontColor('#FFA500')
        TextSpan(' ')
        SymbolSpan($r('sys.symbol.star_fill'))
          .fontSize(32)
          .fontColor('#FF8C00')
      }
    }
  }
}
```

### 3.4 导航和操作示例

```typescript
@ComponentV2
struct NavigationSymbolSpanExample {
  build() {
    Column({ space: 16 }) {
      Text('导航和操作图标')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      // 底部导航栏
      Row() {
        Column({ space: 4 }) {
          SymbolSpan($r('sys.symbol.house_fill'))
            .fontSize(24)
            .fontColor('#007DFF')
          TextSpan('首页')
            .fontSize(12)
            .fontColor('#007DFF')
        }
        .layoutWeight(1)

        Column({ space: 4 }) {
          SymbolSpan($r('sys.symbol.magnifyingglass'))
            .fontSize(24)
            .fontColor('#757575')
          TextSpan('搜索')
            .fontSize(12)
            .fontColor('#757575')
        }
        .layoutWeight(1)

        Column({ space: 4 }) {
          SymbolSpan($r('sys.symbol.person'))
            .fontSize(24)
            .fontColor('#757575')
          TextSpan('我的')
            .fontSize(12)
            .fontColor('#757575')
        }
        .layoutWeight(1)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      // 设置项
      Column() {
        Row() {
          SymbolSpan($r('sys.symbol.wifi'))
            .fontSize(20)
            .fontColor('#007DFF')
          TextSpan(' Wi-Fi')
            .fontSize(16)
            .margin({ left: 12 })
          Blank()
          SymbolSpan($r('sys.symbol.chevron_right'))
            .fontSize(16)
            .fontColor('#9E9E9E')
        }
        .width('100%')
        .padding(12)

        Row() {
          SymbolSpan($r('sys.symbol.bluetooth'))
            .fontSize(20)
            .fontColor('#007DFF')
          TextSpan(' 蓝牙')
            .fontSize(16)
            .margin({ left: 12 })
          Blank()
          SymbolSpan($r('sys.symbol.chevron_right'))
            .fontSize(16)
            .fontColor('#9E9E9E')
        }
        .width('100%')
        .padding(12)
      }
      .backgroundColor('#FFFFFF')
      .borderRadius(8)
    }
  }
}
```

### 3.5 交互示例

```typescript
@ComponentV2
struct InteractiveSymbolSpanExample {
  @Local isLiked: boolean = false
  @Local isStarred: boolean = false

  build() {
    Column({ space: 16 }) {
      Text('交互式 SymbolSpan')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      // 点赞按钮
      Text() {
        TextSpan('点赞: ')
        SymbolSpan(this.isLiked ? $r('sys.symbol.heart_fill') : $r('sys.symbol.heart'))
          .fontSize(24)
          .fontColor(this.isLiked ? '#E91E63' : '#757575')
          .onClick(() => {
            this.isLiked = !this.isLiked
          })
        TextSpan(` (${this.isLiked ? '已点赞' : '未点赞'})`)
      }
      .fontSize(16)

      // 收藏按钮
      Text() {
        TextSpan('收藏: ')
        SymbolSpan(this.isStarred ? $r('sys.symbol.star_fill') : $r('sys.symbol.star'))
          .fontSize(24)
          .fontColor(this.isStarred ? '#FFC107' : '#757575')
          .onClick(() => {
            this.isStarred = !this.isStarred
          })
        TextSpan(` (${this.isStarred ? '已收藏' : '未收藏'})`)
      }
      .fontSize(16)
    }
  }
}
```

### 3.6 状态指示示例

```typescript
@ComponentV2
struct StatusSymbolSpanExample {
  @Local status: 'success' | 'warning' | 'error' | 'info' = 'success'

  build() {
    Column({ space: 16 }) {
      Text('状态指示')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      // 状态显示
      Text() {
        if (this.status === 'success') {
          SymbolSpan($r('sys.symbol.checkmark_circle_fill'))
            .fontSize(20)
            .fontColor('#28A745')
          TextSpan(' 操作成功')
            .fontColor('#28A745')
        } else if (this.status === 'warning') {
          SymbolSpan($r('sys.symbol.exclamationmark_triangle_fill'))
            .fontSize(20)
            .fontColor('#FFC107')
          TextSpan(' 警告信息')
            .fontColor('#FFC107')
        } else if (this.status === 'error') {
          SymbolSpan($r('sys.symbol.xmark_circle_fill'))
            .fontSize(20)
            .fontColor('#DC3545')
          TextSpan(' 操作失败')
            .fontColor('#DC3545')
        } else {
          SymbolSpan($r('sys.symbol.info_circle_fill'))
            .fontSize(20)
            .fontColor('#007DFF')
          TextSpan(' 提示信息')
            .fontColor('#007DFF')
        }
      }
      .fontSize(16)

      // 状态切换按钮
      Row({ space: 8 }) {
        Button('成功')
          .onClick(() => {
            this.status = 'success'
          })
        Button('警告')
          .onClick(() => {
            this.status = 'warning'
          })
        Button('错误')
          .onClick(() => {
            this.status = 'error'
          })
        Button('信息')
          .onClick(() => {
            this.status = 'info'
          })
      }
    }
  }
}
```

### 3.7 列表项示例

```typescript
@ComponentV2
struct ListItemSymbolSpanExample {
  @Local items: Array<{
    icon: Resource;
    title: string;
    subtitle: string;
  }> = [
    { icon: $r('sys.symbol.wifi_fill'), title: 'Wi-Fi', subtitle: '已连接' },
    { icon: $r('sys.symbol.cellularbars_fill'), title: '蜂窝网络', subtitle: '5G' },
    { icon: $r('sys.symbol.bell_fill'), title: '通知', subtitle: '3条新消息' },
    { icon: $r('sys.symbol.moon_fill'), title: '勿扰模式', subtitle: '已开启' }
  ]

  build() {
    Column({ space: 16 }) {
      Text('列表项示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      ForEach(this.items, (item: { icon: Resource; title: string; subtitle: string }) => {
        Row() {
          SymbolSpan(item.icon)
            .fontSize(24)
            .fontColor('#007DFF')
          Column({ space: 4 }) {
            TextSpan(item.title)
              .fontSize(16)
              .fontColor('#333333')
            TextSpan(item.subtitle)
              .fontSize(14)
              .fontColor('#999999')
          }
          .margin({ left: 12 })
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)
          Blank()
          SymbolSpan($r('sys.symbol.chevron_right'))
            .fontSize(16)
            .fontColor('#9E9E9E')
        }
        .width('100%')
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(8)
      })
    }
  }
}
```

## 四、高级用法

### 4.1 动态图标切换

```typescript
@ComponentV2
struct DynamicSymbolSpanExample {
  @Local isPlaying: boolean = false
  @Local volume: number = 50

  build() {
    Column({ space: 16 }) {
      // 播放/暂停
      Text() {
        SymbolSpan(this.isPlaying ? $r('sys.symbol.pause_circle_fill') : $r('sys.symbol.play_circle_fill'))
          .fontSize(32)
          .fontColor('#007DFF')
          .onClick(() => {
            this.isPlaying = !this.isPlaying
          })
        TextSpan(` ${this.isPlaying ? '暂停中' : '播放中'}`)
      }
      .fontSize(16)

      // 音量图标
      Text() {
        TextSpan('音量: ')
        SymbolSpan(this.getVolumeIcon())
          .fontSize(20)
          .fontColor('#757575')
        TextSpan(` ${this.volume}%`)
      }
      .fontSize(16)
    }
  }

  getVolumeIcon(): Resource {
    if (this.volume === 0) {
      return $r('sys.symbol.speaker_slash_fill')
    } else if (this.volume < 50) {
      return $r('sys.symbol.speaker_1_fill')
    } else if (this.volume < 100) {
      return $r('sys.symbol.speaker_2_fill')
    } else {
      return $r('sys.symbol.speaker_3_fill')
    }
  }
}
```

### 4.2 图标动画效果

```typescript
@ComponentV2
struct AnimatedSymbolSpanExample {
  @Local isAnimating: boolean = false

  build() {
    Column({ space: 16 }) {
      Text('带动画的 SymbolSpan')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      // 脉冲效果
      Text() {
        SymbolSpan($r('sys.symbol.heart_fill'))
          .fontSize(48)
          .fontColor('#E91E63')
          .symbolEffect(this.isAnimating ? SymbolEffect.PULSE : undefined)
        TextSpan(' 脉冲效果')
      }
      .fontSize(16)
      .onClick(() => {
        this.isAnimating = !this.isAnimating
      })

      // 旋转效果
      Text() {
        SymbolSpan($r('sys.symbol.arrow_clockwise'))
          .fontSize(32)
          .fontColor('#007DFF')
        TextSpan(' 旋转效果')
      }
      .fontSize(16)
      .rotate({ angle: this.isAnimating ? 360 : 0 })
      .animation({
        duration: 1000,
        curve: Curve.Linear,
        iterations: -1
      })
    }
  }
}
```

## 五、最佳实践

### 5.1 图标选择

```typescript
// ✅ 推荐：使用填充版图标表示选中状态
Text() {
  SymbolSpan($r('sys.symbol.heart_fill'))
    .fontSize(24)
    .fontColor('#E91E63')
  TextSpan(' 已收藏')
}

// ✅ 推荐：使用描边版图标表示未选中状态
Text() {
  SymbolSpan($r('sys.symbol.heart'))
    .fontSize(24)
    .fontColor('#757575')
  TextSpan(' 未收藏')
}
```

### 5.2 尺寸规范

```typescript
// ✅ 推荐：使用标准尺寸
Text() {
  SymbolSpan($r('sys.symbol.star'))
    .fontSize(16)  // 小图标
}

Text() {
  SymbolSpan($r('sys.symbol.star'))
    .fontSize(24)  // 标准图标
}

Text() {
  SymbolSpan($r('sys.symbol.star'))
    .fontSize(32)  // 大图标
}
```

### 5.3 颜色使用

```typescript
// ✅ 推荐：使用语义化颜色
Text() {
  SymbolSpan($r('sys.symbol.checkmark_circle_fill'))
    .fontSize(20)
    .fontColor('#28A745')  // 成功绿色
}

Text() {
  SymbolSpan($r('sys.symbol.xmark_circle_fill'))
    .fontSize(20)
    .fontColor('#DC3545')  // 错误红色
}
```

## 六、常见问题

### Q1: SymbolSpan 为什么不显示？

**问题**: 添加了 SymbolSpan 但不显示。

**解决方案**:
```typescript
// ❌ 错误：使用不存在的图标
Text() {
  SymbolSpan($r('sys.symbol.invalid_icon'))
}

// ✅ 正确：使用系统预定义的图标
Text() {
  SymbolSpan($r('sys.symbol.house'))
    .fontSize(24)
}
```

### Q2: 如何改变 SymbolSpan 的颜色？

**解决方案**:
```typescript
Text() {
  SymbolSpan($r('sys.symbol.heart_fill'))
    .fontSize(24)
    .fontColor('#E91E63')  // 使用 fontColor 属性
}
```

### Q3: SymbolSpan 和 ImageSpan 有什么区别？

**答案**:
- SymbolSpan 使用系统预定义的矢量图标
- ImageSpan 使用自定义图片资源
- SymbolSpan 颜色可以通过 fontColor 动态改变
- SymbolSpan 支持动画效果

### Q4: 如何查看所有可用的 Symbol 图标？

**解决方案**:
- 查阅 HarmonyOS 官方文档中的 SF Symbols 列表
- 在 DevEco Studio 中使用代码补全查看可用图标
- 使用 `$r('sys.symbol.xxx')` 格式引用

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 12+ | ✅ | 完全支持 |
| API 11- | ❌ | 不支持，使用 ImageSpan 代替 |

## 八、参考资料

- [SymbolSpan 符号图标 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-symbol-span-V5)
- [SymbolGlyph 符号字形 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-symbol-glyph-V5)
- [Text 文本 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-text-V5)
