# FormLink 组件 HarmonyOS 6.0 开发 Skill

## 概述

FormLink 是 OpenHarmony 中用于静态卡片交互的组件，为静态卡片提供与应用交互的能力。它支持在卡片内部进行页面跳转、消息传递和方法调用三种交互模式。

## 重要说明

- **专用组件**: FormLink 专门用于 ArkTS 卡片开发，不适用于普通页面
- **静态卡片**: 用于静态卡片的交互，动态卡片使用 router 事件
- **无子组件**: FormLink 不支持子组件
- **事件类型**: 支持 router（导航）、message（消息）、call（调用）三种类型
- **API 版本**: 从 API 9 开始支持，API 20+ 增强功能
- **卡片配置**: 需要在 form_config.json 中配置相关参数

## 模块信息

- **组件名称**: FormLink
- **SDK 版本**: HarmonyOS 6.0 (API 21)
- **系统能力**: SystemCapability.Ability.Form
- **更新日期**: 2026-02-24
- **官方文档**:
  - [FormLink - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-container-formlink)
  - [ArkTS 卡片概述](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/arkts-form-overview)
  - [卡片跳转到应用页面](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/arkts-ui-widget-event-router)

## 一、组件基础

### 1.1 导入方式

```typescript
// FormLink 是内置组件，主要用于 ArkTS 卡片中
// 在卡片页面中使用
FormLink({
  action: () => {
    // 交互逻辑
  }
}) {
  // Link 内容，通常是 Text 或 Image
}
```

### 1.2 基础用法

```typescript
// 简单的卡片链接
@Entry
@Component
struct FormLinkCardExample {
  build() {
    Column() {
      FormLink({
        action: () => {
          console.info('FormLink clicked')
        }
      }) {
        Text('点击查看详情')
          .fontSize(16)
          .fontColor('#007DFF')
      }
    }
    .width('100%')
    .height('100%')
  }
}
```

## 二、API 参数

### 2.1 构造参数

FormLink 不使用传统的构造参数，而是接受一个配置对象：

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| action | `() => void` | 是 | - | 点击时执行的回调函数 |

### 2.2 支持的子组件

FormLink 支持单个子组件，通常是：
- **Text**: 文本链接
- **Image**: 图片链接
- **Row/Column**: 包含文本和图标的复合链接

### 2.3 属性

FormLink 继承自通用组件属性，支持：
- 尺寸属性：width, height, size, constraintSize
- 位置属性：position, offset, align, alignOffsets
- 布局属性：margin, padding, layoutWeight
- 背景属性：backgroundColor, backgroundImage
- 边框属性：border, borderImage
- 样式属性：opacity, display, visibility
- 事件属性：onClick, onAppear, onDisAppear

## 三、交互模式

### 3.1 Router 导航模式

用于从卡片跳转到应用页面：

```typescript
@Entry
@Component
struct RouterFormLinkExample {
  build() {
    Column() {
      FormLink({
        action: () => {
          // 跳转到应用页面
          postCardAction(this, {
        action: 'router',
        abilityName: 'EntryAbility',
        params: {
          targetPage: 'detail_page',
          id: '12345'
        }
      })
        }
      }) {
        Row({ space: 8 }) {
          Text('查看详情')
            .fontSize(14)
            .fontColor('#007DFF')
          Text('\uE641') // 图标
            .fontSize(16)
            .fontColor('#007DFF')
        }
      }
    }
  }
}
```

### 3.2 Message 消息模式

用于向应用发送消息数据：

```typescript
@Entry
@Component
struct MessageFormLinkExample {
  build() {
    Column() {
      FormLink({
        action: () => {
          // 发送消息到应用
          postCardAction(this, {
        action: 'message',
        params: {
          msg: 'button_click',
          data: {
            buttonId: 'btn_like',
            timestamp: Date.now()
          }
        }
      })
        }
      }) {
        Text('点赞')
          .fontSize(16)
          .fontColor('#FF0000')
      }
    }
  }
}
```

### 3.3 Call 调用模式

用于调用应用的方法（API 20+）：

```typescript
@Entry
@Component
struct CallFormLinkExample {
  build() {
    Column() {
      FormLink({
        action: () => {
          // 调用应用方法
          postCardAction(this, {
        action: 'call',
        abilityName: 'EntryAbility',
        params: {
          method: 'updateData',
          params: {
            key: 'value'
          }
        }
      })
        }
      }) {
        Text('刷新数据')
          .fontSize(16)
          .fontColor('#007DFF')
      }
    }
  }
}
```

## 四、使用示例

### 4.1 基础文本链接

```typescript
@Entry
@Component
struct BasicTextLinkExample {
  build() {
    Column({ space: 12 }) {
      Text('天气预报')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Text('北京')
        .fontSize(16)
        .margin({ top: 8 })

      Text('25°C 晴')
        .fontSize(24)
        .margin({ top: 4 })

      FormLink({
        action: () => {
          postCardAction(this, {
        action: 'router',
        abilityName: 'EntryAbility',
        params: {
          city: '北京'
        }
      })
        }
      }) {
        Text('查看详情 >')
          .fontSize(14)
          .fontColor('#007DFF')
      }
      .margin({ top: 12 })
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
  }
}
```

### 4.2 图标按钮链接

```typescript
@Entry
@Component
struct IconButtonLinkExample {
  build() {
    Column({ space: 16 }) {
      Text('快捷操作')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)

      Row({ space: 20 }) {
        // 点赞按钮
        FormLink({
          action: () => {
            postCardAction(this, {
          action: 'message',
          params: {
            type: 'like',
            targetId: '123'
          }
        })
          }
        }) {
          Column({ space: 4 }) {
            Text('\uE642') // 心形图标
              .fontSize(24)
              .fontColor('#FF0000')
            Text('点赞')
              .fontSize(12)
              .fontColor('#666666')
          }
        }

        // 收藏按钮
        FormLink({
          action: () => {
            postCardAction(this, {
          action: 'message',
          params: {
            type: 'favorite',
            targetId: '123'
          }
        })
          }
        }) {
          Column({ space: 4 }) {
            Text('\uE643') // 星形图标
              .fontSize(24)
              .fontColor('#FFC107')
            Text('收藏')
              .fontSize(12)
              .fontColor('#666666')
          }
        }

        // 分享按钮
        FormLink({
          action: () => {
            postCardAction(this, {
          action: 'router',
          abilityName: 'EntryAbility',
          params: {
            action: 'share',
            targetId: '123'
          }
        })
          }
        }) {
          Column({ space: 4 }) {
            Text('\uE644') // 分享图标
              .fontSize(24)
              .fontColor('#007DFF')
            Text('分享')
              .fontSize(12)
              .fontColor('#666666')
          }
        }
      }
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
  }
}
```

### 4.3 卡片列表项链接

```typescript
@Entry
@Component
struct ListItemLinkExample {
  @Local items: Array<{
    id: string
    title: string
    desc: string
  }> = [
    { id: '1', title: '待办事项1', desc: '完成项目报告' },
    { id: '2', title: '待办事项2', desc: '团队会议' },
    { id: '3', title: '待办事项3', desc: '代码审查' }
  ]

  build() {
    Column({ space: 8 }) {
      Text('待办清单')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      ForEach(this.items, (item: typeof this.items[0]) => {
        FormLink({
          action: () => {
            postCardAction(this, {
          action: 'router',
          abilityName: 'EntryAbility',
          params: {
            taskId: item.id
          }
        })
          }
        }) {
          Row() {
            Column({ space: 4 }) {
              Text(item.title)
                .fontSize(16)
                .fontColor('#333333')
              Text(item.desc)
                .fontSize(12)
                .fontColor('#999999')
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            Text('\uE645') // 箭头图标
              .fontSize(16)
              .fontColor('#CCCCCC')
          }
          .width('100%')
          .padding(12)
          .backgroundColor('#F8F8F8')
          .borderRadius(8)
        }
      }, (item: typeof this.items[0]) => item.id)
    }
    .width('100%')
    .height('100%')
    .padding(12)
    .backgroundColor('#FFFFFF')
  }
}
```

### 4.4 新闻卡片链接

```typescript
@Entry
@Component
struct NewsCardLinkExample {
  @Local news: {
    id: string
    title: string
    summary: string
    time: string
  } = {
    id: '001',
    title: '科技新闻标题',
    summary: '这是一条重要的科技新闻摘要...',
    time: '2小时前'
  }

  build() {
    Column({ space: 12 }) {
      // 新闻标题
      Text(this.news.title)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      // 新闻摘要
      Text(this.news.summary)
        .fontSize(14)
        .fontColor('#666666')
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      // 时间和链接
      Row() {
        Text(this.news.time)
          .fontSize(12)
          .fontColor('#999999')
          .layoutWeight(1)

        FormLink({
          action: () => {
            postCardAction(this, {
          action: 'router',
          abilityName: 'EntryAbility',
          params: {
            newsId: this.news.id
          }
        })
          }
        }) {
          Text('阅读全文')
            .fontSize(14)
            .fontColor('#007DFF')
        }
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}
```

### 4.5 音乐播放控制卡片

```typescript
@Entry
@Component
struct MusicControlCardExample {
  @Local isPlaying: boolean = false
  @Local songName: string = '歌曲名称'
  @Local artist: string = '歌手'

  build() {
    Column({ space: 16 }) {
      // 歌曲信息
      Column({ space: 4 }) {
        Text(this.songName)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
        Text(this.artist)
          .fontSize(14)
          .fontColor('#666666')
      }
      .onClick(() => {
        postCardAction(this, {
      action: 'router',
      abilityName: 'EntryAbility',
      params: {
        page: 'player'
      }
    })
      })

      // 控制按钮
      Row({ space: 32 }) {
        // 上一曲
        FormLink({
          action: () => {
            postCardAction(this, {
          action: 'message',
          params: {
            action: 'previous'
          }
        })
          }
        }) {
          Text('\uE646') // 上一曲图标
            .fontSize(24)
            .fontColor('#333333')
        }

        // 播放/暂停
        FormLink({
          action: () => {
            postCardAction(this, {
          action: 'message',
          params: {
            action: this.isPlaying ? 'pause' : 'play'
          }
        })
          }
        }) {
          Text(this.isPlaying ? '\uE647' : '\uE648')
            .fontSize(32)
            .fontColor('#007DFF')
        }

        // 下一曲
        FormLink({
          action: () => {
            postCardAction(this, {
          action: 'message',
          params: {
            action: 'next'
          }
        })
          }
        }) {
          Text('\uE649') // 下一曲图标
            .fontSize(24)
            .fontColor('#333333')
        }
      }
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#F8F8F8')
    .borderRadius(16)
  }
}
```

## 五、高级用法

### 5.1 动态路由参数

```typescript
@Entry
@Component
struct DynamicRouterExample {
  @Local userId: string = 'user_123'
  @Local itemId: string = 'item_456'

  build() {
    Column() {
      FormLink({
        action: () => {
          // 动态构建路由参数
          const params = {
            userId: this.userId,
            itemId: this.itemId,
            timestamp: Date.now().toString()
          }

          postCardAction(this, {
        action: 'router',
        abilityName: 'EntryAbility',
        params: params
      })
        }
      }) {
        Text('查看个人资料')
          .fontSize(16)
          .fontColor('#007DFF')
      }
    }
  }
}
```

### 5.2 条件性交互

```typescript
@Entry
@Component
struct ConditionalActionExample {
  @Local isLoggedIn: boolean = false
  @Local contentId: string = 'content_001'

  build() {
    Column() {
      FormLink({
        action: () => {
          if (this.isLoggedIn) {
            // 已登录用户直接跳转
            postCardAction(this, {
          action: 'router',
          abilityName: 'EntryAbility',
          params: {
            contentId: this.contentId
          }
        })
          } else {
            // 未登录用户跳转到登录页
            postCardAction(this, {
          action: 'router',
          abilityName: 'EntryAbility',
          params: {
            page: 'login',
            redirect: this.contentId
          }
        })
          }
        }
      }) {
        Text(this.isLoggedIn ? '继续阅读' : '登录阅读')
          .fontSize(16)
          .fontColor('#007DFF')
      }
    }
  }
}
```

### 5.3 批量操作

```typescript
@Entry
@Component
struct BatchActionExample {
  @Local selectedItems: string[] = []

  build() {
    Column() {
      // 批量删除按钮
      FormLink({
        action: () => {
          postCardAction(this, {
        action: 'message',
        params: {
          action: 'batch_delete',
          items: this.selectedItems
        }
      })
        }
      }) {
        Row({ space: 8 }) {
          Text('\uE64A') // 删除图标
            .fontSize(16)
            .fontColor('#FF0000')
          Text(`删除选中 (${this.selectedItems.length})`)
            .fontSize(14)
            .fontColor('#FF0000')
        }
      }
      .enabled(this.selectedItems.length > 0)
      .opacity(this.selectedItems.length > 0 ? 1 : 0.5)
    }
  }
}
```

## 六、卡片配置

### 6.1 form_config.json 配置

```json5
{
  "forms": [
    {
      "name": "MyFormLinkCard",
      "description": "FormLink 示例卡片",
      "src": "./ets/pages/FormLinkCardPage.ets",
      "uiSyntax": "arkts",
      "window": {
        "designWidth": 720,
        "autoDesignWidth": true
      },
      "colorMode": "auto",
      "isDefault": true,
      "updateEnabled": true,
      "scheduledUpdateTime": "00:00",
      "updateDuration": 1,
      "defaultDimension": "2*2",
      "supportDimensions": ["2*2", "2*4", "4*4"]
    }
  ]
}
```

### 6.2 module.json5 配置

```json5
{
  "module": {
    "name": "entry",
    "type": "entry",
    "abilities": [
      {
        "name": "FormAbility",
        "srcEntry": "./ets/formability/FormAbility.ets",
        "label": "$string:form_ability_label",
        "description": "$string:form_ability_desc",
        "type": "form",
        "formsEnabled": true
      }
    ]
  }
}
```

## 七、最佳实践

### 7.1 链接样式设计

```typescript
// ✅ 推荐：明确的视觉反馈
FormLink({
  action: () => { /* ... */ }
}) {
  Text('点击查看')
    .fontSize(16)
    .fontColor('#007DFF')
    .decoration({ type: TextDecorationType.Underline })
}

// ❌ 避免：不清晰的交互区域
FormLink({
  action: () => { /* ... */ }
}) {
  Text('点击')
    .fontSize(12)
    .fontColor('#CCCCCC')
}
```

### 7.2 错误处理

```typescript
// ✅ 推荐：添加错误处理
FormLink({
  action: () => {
    try {
      postCardAction(this, {
        action: 'router',
        abilityName: 'EntryAbility',
        params: { /* ... */ }
      })
    } catch (error) {
      console.error('FormLink action failed:', error)
    }
  }
}) {
  Text('安全跳转')
}
```

### 7.3 性能优化

```typescript
// ✅ 推荐：避免频繁的参数构建
@Local cachedParams: Record<string, string> = {}

build() {
  FormLink({
    action: () => {
      // 使用缓存的参数
      if (Object.keys(this.cachedParams).length === 0) {
        this.cachedParams = this.buildParams()
      }
      postCardAction(this, {
        action: 'router',
        abilityName: 'EntryAbility',
        params: this.cachedParams
      })
    }
  }) {
    Text('优化跳转')
  }
}
```

## 八、常见问题

### Q1: FormLink 可以在普通页面中使用吗？

**答**: 不建议。FormLink 专为 ArkTS 卡片设计，普通页面应使用 Router 或 Navigation 组件。

### Q2: 如何调试 FormLink 的点击事件？

**解决方案**:
```typescript
FormLink({
  action: () => {
    console.info('FormLink clicked')
    console.info('Action params:', JSON.stringify(params))
    // 执行实际操作
  }
}) {
  Text('调试链接')
}
```

### Q3: FormLink 支持长按事件吗？

**解决方案**: 使用 gesture 手势绑定：
```typescript
FormLink({
  action: () => { /* 点击事件 */ }
}) {
  Text('长按菜单')
}
.gesture(
  LongPressGesture()
    .onAction(() => {
      // 长按处理
    })
)
```

### Q4: 如何传递复杂对象？

**解决方案**:
```typescript
// 传递复杂对象需要序列化
FormLink({
  action: () => {
    const complexObject = {
      user: { id: '1', name: 'Test' },
      items: ['a', 'b', 'c'],
      metadata: { key: 'value' }
    }

    postCardAction(this, {
      action: 'message',
      params: {
        data: JSON.stringify(complexObject)
      }
    })
  }
}) {
  Text('传递复杂对象')
}
```

### Q5: 卡片跳转后如何返回数据？

**答**: 卡片是无状态的，跳转后无法直接返回数据。建议使用本地存储或消息机制在应用内处理数据。

## 九、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 9 | ✅ | 基础支持 |
| API 10 | ✅ | 增强功能 |
| API 11 | ✅ | 支持更多交互模式 |
| API 12 | ✅ | 性能优化 |
| API 20+ | ✅ | call 模式支持，交互卡片增强 |

## 十、参考资料

- [FormLink 组件 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-container-formlink)
- [ArkTS 卡片概述 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/arkts-form-overview)
- [卡片跳转到应用页面 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/arkts-ui-widget-event-router)
- [HarmonyOS 静态卡片（ArkTS + FormLink）详细介绍 - CSDN](https://m.blog.csdn.net/Yihong1833100198/article/details/155322149)
- [鸿蒙开发：一文了解桌面卡片 - LeetCode](https://leetcode.cn/discuss/post/3712038/)
