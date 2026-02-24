# Marquee 组件 HarmonyOS 6.0 开发 Skill

## 概述

Marquee 组件是 OpenHarmony 中用于实现跑马灯效果（滚动文本）的组件。它可以让文本内容在固定区域内自动滚动显示，常用于公告、通知、广告等场景。

## 重要说明

- **滚动方向**: 支持水平和垂直两个方向
- **滚动模式**: 支持循环滚动和单次滚动
- **性能优化**: 建议控制文本长度，避免过长的内容
- **交互性**: 支持点击、长按等交互事件

## 模块信息

- **组件名称**: Marquee
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [Marquee 跑马灯 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-marquee-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// Marquee 是内置组件，无需导入
// 直接使用即可
Marquee() {
  Text('Hello World')
}
```

### 1.2 基础用法

```typescript
// 简单跑马灯
Marquee() {
  Text('这是一段滚动的文本内容')
}
.width('100%')
.height(40)

// 带样式的跑马灯
Marquee() {
  Text('重要通知：系统将在今晚进行维护')
    .fontSize(16)
    .fontColor('#FFFFFF')
}
.width('100%')
.height(50)
.backgroundColor('#FF6B6B')
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| srcStart | `number` | 否 | 0 | 滚动起始位置 |
| srcEnd | `number` | 否 | - | 滚动结束位置（默认为内容宽度） |
| start | `boolean` | 否 | true | 是否开始滚动 |

### 2.2 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `scrollAmount` | `number` | - | 滚动距离（每次滚动的像素值） |
| `loop` | `number` | -1 | 滚动循环次数（-1 表示无限循环） |
| `direction` | `MarqueeDirection` | MarqueeDirection.Left | 滚动方向 |
| `allowFade` | `boolean` | false | 是否允许淡入淡出效果 |
| `onStart` | `() => void` | - | 滚动开始事件 |
| `onComplete` | `() => void` | - | 滚动完成事件 |
| `onClick` | `() => void` | - | 点击事件 |

### 2.3 滚动方向

| 值 | 描述 |
|------|------|
| `MarqueeDirection.Left` | 从右向左滚动（默认） |
| `MarqueeDirection.Right` | 从左向右滚动 |
| `MarqueeDirection.Up` | 从下向上滚动 |
| `MarqueeDirection.Down` | 从上向下滚动 |

## 三、使用示例

### 3.1 基础跑马灯示例

```typescript
@ComponentV2
struct BasicMarqueeExample {
  build() {
    Column({ space: 16 }) {
      Text('基础跑马灯')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 从右向左滚动
      Marquee() {
        Text('这是一段从右向左滚动的文本内容')
          .fontSize(16)
          .fontColor('#333333')
      }
      .width('100%')
      .height(40)
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.2 不同方向示例

```typescript
@ComponentV2
struct MarqueeDirectionExample {
  build() {
    Column({ space: 16 }) {
      Text('不同方向的跑马灯')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 从右向左
      Marquee() {
        Text('从右向左滚动')
          .fontSize(16)
      }
      .width('100%')
      .height(40)
      .backgroundColor('#E3F2FD')
      .direction(MarqueeDirection.Left)

      // 从左向右
      Marquee() {
        Text('从左向右滚动')
          .fontSize(16)
      }
      .width('100%')
      .height(40)
      .backgroundColor('#F3E5F5')
      .direction(MarqueeDirection.Right)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.3 公告栏示例

```typescript
@ComponentV2
struct AnnouncementMarqueeExample {
  @Local announcement: string = '重要通知：系统将于今晚 22:00-24:00 进行维护，请提前保存工作内容'

  build() {
    Column({ space: 16 }) {
      Row({ space: 8 }) {
        Text('\uE640') // 喇叭图标
          .fontSize(20)
          .fontColor('#FF6B6B')

        Marquee() {
          Text(this.announcement)
            .fontSize(16)
            .fontColor('#333333')
        }
        .layoutWeight(1)
        .height(40)
        .scrollAmount(300)
        .loop(-1) // 无限循环
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#FFF5F5')
      .borderRadius(8)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.4 循环次数控制示例

```typescript
@ComponentV2
struct MarqueeLoopExample {
  build() {
    Column({ space: 16 }) {
      Text('循环次数控制')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 滚动 3 次后停止
      Marquee() {
        Text('滚动 3 次后停止')
          .fontSize(16)
      }
      .width('100%')
      .height(40)
      .backgroundColor('#FFF3E0')
      .loop(3)
      .onComplete(() => {
        console.info('滚动完成')
      })

      // 无限循环
      Marquee() {
        Text('无限循环滚动')
          .fontSize(16)
      }
      .width('100%')
      .height(40)
      .backgroundColor('#E8F5E9')
      .loop(-1)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.5 带交互的跑马灯

```typescript
@ComponentV2
struct InteractiveMarqueeExample {
  @Local clickCount: number = 0

  build() {
    Column({ space: 16 }) {
      Text('点击查看详情')
        .fontSize(14)
        .fontColor('#666666')

      Marquee() {
        Text('点击此处查看更多优惠信息 >>>')
          .fontSize(16)
          .fontColor('#007DFF')
      }
      .width('100%')
      .height(50)
      .backgroundColor('#E3F2FD')
      .borderRadius(8)
      .onClick(() => {
        this.clickCount++
        console.info(`点击了 ${this.clickCount} 次`)
      })
      .onStart(() => {
        console.info('开始滚动')
      })
      .onComplete(() => {
        console.info('滚动完成')
      })

      Text(`已点击 ${this.clickCount} 次`)
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.6 动态内容示例

```typescript
@ComponentV2
struct DynamicMarqueeExample {
  @Local messages: string[] = [
    '欢迎访问 HarmonyOS 开发者官网',
    '最新版本 SDK 已发布',
    '开发者大会报名火热进行中'
  ]
  @Local currentIndex: number = 0
  @Local currentMessage: string = this.messages[0]

  build() {
    Column({ space: 16 }) {
      Text('动态消息滚动')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Marquee() {
        Text(this.currentMessage)
          .fontSize(16)
          .fontColor('#FFFFFF')
      }
      .width('100%')
      .height(50)
      .backgroundColor('#FF6B6B')
      .borderRadius(8)
      .loop(1)
      .onComplete(() => {
        // 切换到下一条消息
        this.currentIndex = (this.currentIndex + 1) % this.messages.length
        this.currentMessage = this.messages[this.currentIndex]
      })

      Text(`消息 ${this.currentIndex + 1} / ${this.messages.length}`)
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.7 控制滚动示例

```typescript
@ComponentV2
struct ControllableMarqueeExample {
  @Local isScrolling: boolean = true

  build() {
    Column({ space: 16 }) {
      Text('控制滚动')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Marquee() {
        Text('可以通过按钮控制开始/停止滚动')
          .fontSize(16)
      }
      .width('100%')
      .height(50)
      .backgroundColor('#E1BEE7')
      .borderRadius(8)
      .start(this.isScrolling)

      Row({ space: 12 }) {
        Button('开始滚动')
          .onClick(() => {
            this.isScrolling = true
          })

        Button('停止滚动')
          .onClick(() => {
            this.isScrolling = false
          })
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.8 滚动速度控制示例

```typescript
@ComponentV2
struct MarqueeSpeedExample {
  @Local scrollAmount: number = 300

  build() {
    Column({ space: 16 }) {
      Text('滚动速度控制')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Marquee() {
        Text('滚动速度可通过 scrollAmount 控制')
          .fontSize(16)
      }
      .width('100%')
      .height(50)
      .backgroundColor('#B3E5FC')
      .borderRadius(8)
      .scrollAmount(this.scrollAmount)

      Slider({
        value: this.scrollAmount,
        min: 100,
        max: 1000,
        step: 50
      })
        .width('100%')
        .onChange((value: number) => {
          this.scrollAmount = value
        })

      Text(`当前速度: ${this.scrollAmount}`)
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(16)
  }
}
```

## 四、事件处理

### 4.1 滚动事件

```typescript
Marquee() {
  Text('事件监听示例')
}
.onStart(() => {
  console.info('开始滚动')
})
.onComplete(() => {
  console.info('滚动完成')
})
.loop(1)
```

### 4.2 点击事件

```typescript
Marquee() {
  Text('点击事件示例')
}
.onClick(() => {
  console.info('点击了跑马灯')
})
```

## 五、最佳实践

### 5.1 内容长度控制

```typescript
// ✅ 推荐：控制文本长度
const message = '适长度的文本内容'
Marquee() {
  Text(message)
}

// ❌ 避免：文本过长
const longMessage = '非常长的文本内容...' // 几百字
Marquee() {
  Text(longMessage) // 滚动时间过长，用户体验不佳
}
```

### 5.2 滚动方向选择

```typescript
// ✅ 推荐：根据内容选择合适的方向
// 横向内容：使用 Left 或 Right
Marquee() {
  Text('横向滚动的文本内容')
}
.direction(MarqueeDirection.Left)

// 纵向内容：使用 Up 或 Down
Marquee() {
  Text('纵向滚动的文本内容')
}
.direction(MarqueeDirection.Up)
```

### 5.3 循环次数设置

```typescript
// ✅ 推荐：重要信息设置无限循环
Marquee() {
  Text('重要通知')
}
.loop(-1) // 无限循环

// ✅ 推荐：临时信息设置有限次数
Marquee() {
  Text('临时通知')
}
.loop(3) // 滚动 3 次后停止
```

### 5.4 性能优化

```typescript
// ✅ 推荐：使用简单的子组件
Marquee() {
  Text('简单文本')
}

// ❌ 避免：使用复杂的子组件
Marquee() {
  Column() {
    Row() {
      Text('文本')
      Image('图片')
    }
  } // 复杂结构可能影响性能
}
```

## 六、常见问题

### Q1: Marquee 不滚动？

**问题**: Marquee 组件不滚动。

**解决方案**:
```typescript
// 确保设置了宽度和高度
Marquee() {
  Text('文本内容')
}
.width('100%') // 必须设置宽度
.height(40) // 必须设置高度
.start(true) // 确保开始滚动
```

### Q2: 如何实现垂直滚动？

**解决方案**:
```typescript
Marquee() {
  Text('垂直滚动文本')
}
.width('100%')
.height(60) // 设置足够的高度
.direction(MarqueeDirection.Up) // 设置方向为向上
```

### Q3: 如何控制滚动速度？

**解决方案**:
```typescript
Marquee() {
  Text('文本内容')
}
.scrollAmount(500) // 数值越大，滚动越快
```

### Q4: 如何实现多条消息轮播？

**解决方案**:
```typescript
@ComponentV2
struct MultiMessageMarquee {
  @Local currentIndex: number = 0
  messages: string[] = ['消息1', '消息2', '消息3']

  build() {
    Marquee() {
      Text(this.messages[this.currentIndex])
    }
    .loop(1)
    .onComplete(() => {
      this.currentIndex = (this.currentIndex + 1) % this.messages.length
    })
  }
}
```

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 8+ | ✅ | 基础支持 |
| API 10+ | ✅ | 增加更多滚动方向 |
| API 12+ | ✅ | 优化滚动性能 |

## 八、参考资料

- [Marquee 跑马灯 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-marquee-V5)
- [动画开发指南 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/animation-development-V5)
