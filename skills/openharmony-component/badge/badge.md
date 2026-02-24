# Badge HarmonyOS 6.0 开发 Skill

## 概述

Badge 是一个角标组件,用于在其他组件上附加标记(如数字、小红点、文本等),常用于显示通知数量、未读消息、状态标识等。

## 重要说明

- Badge 必须包含一个子组件(通常是需要标记的组件)
- 支持圆形、数字、文本等多种样式
- 可以通过 position 参数控制角标位置
- 在 API 12+ 中支持更多自定义样式选项

## 模块信息

- **组件名称**: Badge
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **更新日期**: 2026-02-24
- **官方文档**: https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-basic-components-badge-0000001427744872-V3

## 一、组件基础

### 1.1 导入方式

```typescript
// Badge 是 ArkUI 内置组件,无需导入
```

### 1.2 基础用法

```typescript
// 数字角标
Badge({
  count: 5,
  position: BadgePosition.RightTop
}) {
  Text('消息')
}

// 小红点
Badge({
  count: 0,
  position: BadgePosition.RightTop
}) {
  Text('通知')
}

// 文本角标
Badge({
  value: 'NEW',
  position: BadgePosition.RightTop
}) {
  Text('商品')
}
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| count | number | 否 | 0 | 角标数字,设为 0 时显示小红点 |
| value | string | 否 | - | 角标文本,设置后 count 无效 |
| position | BadgePosition | 否 | RightTop | 角标位置 |
| style | BadgeStyle | 否 | - | 角标样式配置 |

**BadgePosition 枚举值:**
- `BadgePosition.RightTop`: 右上角(默认)
- `BadgePosition.Right`: 右侧居中
- `BadgePosition.Left`: 左侧居中

**BadgeStyle 对象:**
```typescript
interface BadgeStyle {
  color: ResourceColor      // 文本颜色
  fontSize: number | string // 字体大小
  badgeSize: number | string// 角标大小
  badgeColor: ResourceColor // 背景颜色
}
```

### 2.2 属性方法

Badge 组件没有额外的属性方法。

### 2.3 事件回调

Badge 支持通用事件:
- `onClick`: 点击事件
- `onAppear`: 出现事件
- `onDisappear`: 消失事件

## 三、使用示例

### 3.1 数字角标

```typescript
@ComponentV2
struct NumberBadgeExample {
  @Local messageCount: number = 99

  build() {
    Column({ space: 20 }) {
      Text('数字角标示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        Badge({
          count: 5,
          position: BadgePosition.RightTop
        }) {
          Text('消息')
            .fontSize(16)
            .padding(12)
            .backgroundColor('#E3F2FD')
            .borderRadius(8)
        }

        Badge({
          count: this.messageCount,
          position: BadgePosition.RightTop,
          style: {
            color: '#FFFFFF',
            fontSize: 12,
            badgeSize: 20,
            badgeColor: '#FF0000'
          }
        }) {
          Text('通知')
            .fontSize(16)
            .padding(12)
            .backgroundColor('#E8F5E9')
            .borderRadius(8)
        }
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.2 小红点角标

```typescript
@ComponentV2
struct DotBadgeExample {
  build() {
    Column({ space: 20 }) {
      Text('小红点示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        Badge({
          count: 0,
          position: BadgePosition.RightTop,
          style: {
            badgeSize: 10,
            badgeColor: '#FF0000'
          }
        }) {
          Text('首页')
            .fontSize(16)
            .padding(12)
            .backgroundColor('#F5F5F5')
            .borderRadius(8)
        }

        Badge({
          count: 0,
          position: BadgePosition.RightTop
        }) {
          Text('发现')
            .fontSize(16)
            .padding(12)
            .backgroundColor('#F5F5F5')
            .borderRadius(8)
        }

        Badge({
          count: 0,
          position: BadgePosition.Right
        }) {
          Text('我的')
            .fontSize(16)
            .padding(12)
            .backgroundColor('#F5F5F5')
            .borderRadius(8)
        }
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.3 文本角标

```typescript
@ComponentV2
struct TextBadgeExample {
  build() {
    Column({ space: 20 }) {
      Text('文本角标示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        Badge({
          value: 'NEW',
          position: BadgePosition.RightTop,
          style: {
            color: '#FFFFFF',
            fontSize: 10,
            badgeSize: 18,
            badgeColor: '#FF9800'
          }
        }) {
          Text('商品')
            .fontSize(16)
            .padding(12)
            .backgroundColor('#F5F5F5')
            .borderRadius(8)
        }

        Badge({
          value: 'HOT',
          position: BadgePosition.RightTop,
          style: {
            color: '#FFFFFF',
            fontSize: 10,
            badgeSize: 18,
            badgeColor: '#F44336'
          }
        }) {
          Text('活动')
            .fontSize(16)
            .padding(12)
            .backgroundColor('#F5F5F5')
            .borderRadius(8)
        }

        Badge({
          value: '+99',
          position: BadgePosition.RightTop,
          style: {
            color: '#FFFFFF',
            fontSize: 12,
            badgeSize: 20,
            badgeColor: '#2196F3'
          }
        }) {
          Text('消息')
            .fontSize(16)
            .padding(12)
            .backgroundColor('#F5F5F5')
            .borderRadius(8)
        }
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.4 图标按钮角标

```typescript
@ComponentV2
struct IconBadgeExample {
  build() {
    Column({ space: 20 }) {
      Text('图标按钮角标')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        Badge({
          count: 3,
          position: BadgePosition.RightTop
        }) {
          Text('🔔')
            .fontSize(24)
            .width(48)
            .height(48)
            .textAlign(TextAlign.Center)
            .backgroundColor('#E3F2FD')
            .borderRadius(24)
        }

        Badge({
          count: 0,
          position: BadgePosition.RightTop
        }) {
          Text('✉️')
            .fontSize(24)
            .width(48)
            .height(48)
            .textAlign(TextAlign.Center)
            .backgroundColor('#E8F5E9')
            .borderRadius(24)
        }

        Badge({
          value: '!',
          position: BadgePosition.RightTop,
          style: {
            badgeColor: '#FFC107',
            color: '#000000'
          }
        }) {
          Text('⚙️')
            .fontSize(24)
            .width(48)
            .height(48)
            .textAlign(TextAlign.Center)
            .backgroundColor('#FFF3E0')
            .borderRadius(24)
        }
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.5 底部导航栏角标

```typescript
@ComponentV2
struct TabBadgeExample {
  @Local selectedIndex: number = 0
  @Local badgeCounts: number[] = [5, 0, 99, 0]

  build() {
    Column({ space: 20 }) {
      Text('底部导航栏角标')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row() {
        ForEach(['首页', '消息', '发现', '我的'], (tab: string, index: number) => {
          Column() {
            Badge({
              count: this.badgeCounts[index],
              position: BadgePosition.RightTop
            }) {
              Text(tab)
                .fontSize(14)
                .fontColor(this.selectedIndex === index ? '#007DFF' : '#666666')
            }
          }
          .layoutWeight(1)
          .height(50)
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            this.selectedIndex = index
          })
        })
      }
      .width('100%')
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
      .padding({ top: 12, bottom: 12 })
      .shadow({ radius: 4, color: '#E0E0E0' })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.6 位置变化示例

```typescript
@ComponentV2
struct BadgePositionExample {
  build() {
    Column({ space: 20 }) {
      Text('角标位置示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        Badge({
          count: 5,
          position: BadgePosition.RightTop
        }) {
          Text('右上角')
            .fontSize(14)
            .padding(12)
            .backgroundColor('#E3F2FD')
            .borderRadius(8)
        }

        Badge({
          count: 5,
          position: BadgePosition.Right
        }) {
          Text('右侧')
            .fontSize(14)
            .padding(12)
            .backgroundColor('#E8F5E9')
            .borderRadius(8)
        }

        Badge({
          count: 5,
          position: BadgePosition.Left
        }) {
          Text('左侧')
            .fontSize(14)
            .padding(12)
            .backgroundColor('#FFF3E0')
            .borderRadius(8)
        }
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

## 四、最佳实践

### 4.1 使用场景

1. **消息通知**: 显示未读消息数量
2. **状态标识**: 标记新内容、热门内容
3. **提醒功能**: 使用小红点提醒用户
4. **导航菜单**: 底部导航栏的角标提示

### 4.2 设计建议

1. **数量限制**: 数字超过 99 时显示 "99+"
2. **颜色选择**: 红色用于重要通知,蓝色用于一般提示
3. **大小适中**: 角标不应过大影响主体内容
4. **位置一致**: 同一应用中角标位置保持一致

### 4.3 性能优化

- Badge 是轻量级组件,性能开销很小
- 避免频繁更新角标数字(如每秒更新)

## 五、常见问题

### Q1: 数字超过 99 如何显示?

A: 使用 `value` 参数显示自定义文本:

```typescript
@Local count: number = 123

Badge({
  value: this.count > 99 ? '99+' : `${this.count}`,
  position: BadgePosition.RightTop
}) {
  // 子组件
}
```

### Q2: 如何隐藏角标?

A: 将 count 设为 0 且不设置 style:

```typescript
Badge({
  count: 0,
  position: BadgePosition.RightTop
}) {
  // 子组件,不显示角标
}
```

### Q3: 如何自定义角标颜色和大小?

A: 使用 style 参数:

```typescript
Badge({
  count: 5,
  style: {
    color: '#FFFFFF',
    fontSize: 12,
    badgeSize: 20,
    badgeColor: '#FF5722'
  }
}) {
  // 子组件
}
```

### Q4: Badge 可以嵌套使用吗?

A: 不建议嵌套使用。如果需要多个角标,考虑使用 Stack 布局:

```typescript
Stack() {
  Text('主要内容')

  // 右上角角标
  Text('5')
    .position({ x: '80%', y: 0 })
    .fontSize(12)
    .fontColor('#FFFFFF')
    .backgroundColor('#FF0000')
    .borderRadius(10)
    .padding(2)

  // 左下角角标
  Text('NEW')
    .position({ x: 0, y: '80%' })
    .fontSize(10)
    .fontColor('#FFFFFF')
    .backgroundColor('#FF9800')
    .borderRadius(4)
    .padding(2)
}
.width(60)
.height(60)
```

## 六、参考资源

- [HarmonyOS Badge 官方文档](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-basic-components-badge-0000001427744872-V3)
- [BadgePosition 枚举](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/ts-appendix-enums-0000001478181369-V3)
