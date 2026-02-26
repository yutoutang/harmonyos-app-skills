# RowSplit 组件 HarmonyOS 6.0 开发 Skill

## 概述

RowSplit 组件是 OpenHarmony 中的水平分割容器组件,用于将子组件按水平方向排列,并支持拖动调整各子组件的高度比例。它类似于 Row 组件,但提供了可拖动分割线的功能,适用于需要动态调整垂直布局的场景。

## 重要说明

- **基础组件**: RowSplit 是 ArkUI 的基础内置组件,无需导入
- **子组件**: 可以包含多个子组件,每个子组件占据一定高度
- **可拖动**: 支持拖动分割线来调整相邻子组件的高度比例
- **响应式**: 配合 @State/@Local 使用实现响应式更新
- **最小高度**: 可设置每个子组件的最小高度,防止过度压缩

## 模块信息

- **组件名称**: RowSplit
- **SDK 版本**: HarmonyOS 6.0 (API 9+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [RowSplit - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-rowsplit-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// RowSplit 是内置组件,无需导入
// 直接使用即可
RowSplit() {
  // 子组件
}
```

### 1.2 基础用法

```typescript
// 简单的水平分割布局
RowSplit() {
  Row() {
    Text('顶部内容')
  }
  .backgroundColor('#F5F5F5')

  Row() {
    Text('中间内容')
  }
  .backgroundColor('#FFFFFF')

  Row() {
    Text('底部内容')
  }
  .backgroundColor('#F5F5F5')
}
.width('100%')
.height(400)
```

## 二、API 参数

### 2.1 构造参数

RowSplit 没有必需的构造参数。

### 2.2 RowSplit 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `resizeable` | `boolean` | true | 是否可拖动分割线 |
| `divider` | `DividerStyle \| null` | { strokeWidth: 1, color: '#FFFFFF', startMargin: 0, endMargin: 0 } | 分割线样式 |

### 2.3 DividerStyle 接口

```typescript
interface DividerStyle {
  strokeWidth: Length;    // 分割线宽度
  color: ResourceColor;   // 分割线颜色
  startMargin: Length;    // 起始边距
  endMargin: Length;      // 结束边距
}
```

### 2.4 子组件属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `layoutWeight` | `number` | - | 权重,用于分配剩余空间 |
| `minHeight` | `Length` | 0 | 最小高度 |

## 三、使用示例

### 3.1 基础分割布局示例

```typescript
@ComponentV2
struct BasicRowSplitExample {
  build() {
    Column({ space: 16 }) {
      Text('RowSplit 基础示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      RowSplit() {
        Row() {
          Text('区域 1')
            .fontSize(16)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#E3F2FD')
        .justifyContent(FlexAlign.Center)

        Row() {
          Text('区域 2')
            .fontSize(16)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#BBDEFB')
        .justifyContent(FlexAlign.Center)

        Row() {
          Text('区域 3')
            .fontSize(16)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#90CAF9')
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height(400)
      .divider({
        strokeWidth: 2,
        color: '#2196F3',
        startMargin: 8,
        endMargin: 8
      })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}
```

### 3.2 固定比例分割示例

```typescript
@ComponentV2
struct FixedRatioRowSplitExample {
  build() {
    Column({ space: 16 }) {
      Text('固定比例分割')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      RowSplit() {
        Row() {
          Text('25%')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#F44336')
        .justifyContent(FlexAlign.Center)
        .layoutWeight(1)

        Row() {
          Text('50%')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#2196F3')
        .justifyContent(FlexAlign.Center)
        .layoutWeight(2)

        Row() {
          Text('25%')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#4CAF50')
        .justifyContent(FlexAlign.Center)
        .layoutWeight(1)
      }
      .width('100%')
      .height(400)
      .divider({
        strokeWidth: 1,
        color: '#FFFFFF'
      })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}
```

### 3.3 禁用拖动示例

```typescript
@ComponentV2
struct NoResizeRowSplitExample {
  build() {
    Column({ space: 16 }) {
      Text('禁用拖动调整')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      Text('分割线不可拖动,固定比例布局')
        .fontSize(14)
        .fontColor('#666666')
        .width('100%')

      RowSplit() {
        Row() {
          Text('顶部栏')
            .fontSize(16)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#ECEFF1')
        .justifyContent(FlexAlign.Center)
        .layoutWeight(1)

        Row() {
          Text('主内容区')
            .fontSize(16)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#FFFFFF')
        .justifyContent(FlexAlign.Center)
        .layoutWeight(3)
      }
      .width('100%')
      .height(400)
      .resizeable(false)
      .divider({
        strokeWidth: 1,
        color: '#B0BEC5'
      })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}
```

### 3.4 带最小高度限制示例

```typescript
@ComponentV2
struct MinHeightRowSplitExample {
  build() {
    Column({ space: 16 }) {
      Text('最小高度限制')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      Text('每个区域有最小高度限制,防止过度压缩')
        .fontSize(14)
        .fontColor('#666666')
        .width('100%')

      RowSplit() {
        Row() {
          Text('最小 60')
            .fontSize(14)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#FFCDD2')
        .justifyContent(FlexAlign.Center)
        .layoutWeight(1)
        .minHeight(60)

        Row() {
          Text('最小 100')
            .fontSize(14)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#C8E6C9')
        .justifyContent(FlexAlign.Center)
        .layoutWeight(2)
        .minHeight(100)

        Row() {
          Text('最小 60')
            .fontSize(14)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#BBDEFB')
        .justifyContent(FlexAlign.Center)
        .layoutWeight(1)
        .minHeight(60)
      }
      .width('100%')
      .height(400)
      .divider({
        strokeWidth: 2,
        color: '#FFFFFF',
        startMargin: 4,
        endMargin: 4
      })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}
```

### 3.5 自定义分割线样式示例

```typescript
@ComponentV2
struct CustomDividerRowSplitExample {
  build() {
    Column({ space: 16 }) {
      Text('自定义分割线样式')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // 粗分割线
      RowSplit() {
        Row() {
          Text('区域 1')
            .fontSize(16)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#FFF3E0')
        .justifyContent(FlexAlign.Center)

        Row() {
          Text('区域 2')
            .fontSize(16)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#FFE0B2')
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height(300)
      .divider({
        strokeWidth: 4,
        color: '#FF9800'
      })
      .margin({ bottom: 16 })

      // 带边距的分割线
      RowSplit() {
        Row() {
          Text('区域 A')
            .fontSize(16)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#F3E5F5')
        .justifyContent(FlexAlign.Center)

        Row() {
          Text('区域 B')
            .fontSize(16)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#E1BEE7')
        .justifyContent(FlexAlign.Center)

        Row() {
          Text('区域 C')
            .fontSize(16)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#CE93D8')
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height(300)
      .divider({
        strokeWidth: 2,
        color: '#9C27B0',
        startMargin: 20,
        endMargin: 20
      })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}
```

### 3.6 动态调整示例

```typescript
@ComponentV2
struct DynamicRowSplitExample {
  @Local showPanel: boolean = true

  build() {
    Column({ space: 16 }) {
      Row() {
        Button('切换面板')
          .onClick(() => {
            this.showPanel = !this.showPanel
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)

      RowSplit() {
        if (this.showPanel) {
          Row() {
            Text('顶部面板')
              .fontSize(16)
          }
          .width('100%')
          .height('100%')
          .backgroundColor('#E8EAF6')
          .justifyContent(FlexAlign.Center)
          .layoutWeight(1)
          .minHeight(80)
        }

        Row() {
          Text('主内容区')
            .fontSize(16)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#FFFFFF')
        .justifyContent(FlexAlign.Center)
        .layoutWeight(3)
      }
      .width('100%')
      .height(400)
      .divider({
        strokeWidth: 1,
        color: '#3F51B5'
      })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}
```

## 四、高级用法

### 4.1 三栏布局

```typescript
@ComponentV2
struct ThreeRowLayoutExample {
  build() {
    RowSplit() {
      // 顶部导航栏
      Row() {
        Text('导航')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#263238')
      .fontColor(Color.White)
      .justifyContent(FlexAlign.Center)
      .layoutWeight(1)
      .minHeight(60)

      // 中间内容区
      Row() {
        Text('内容')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
      .justifyContent(FlexAlign.Center)
      .layoutWeight(4)

      // 底部工具栏
      Row() {
        Text('工具')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#ECEFF1')
      .justifyContent(FlexAlign.Center)
      .layoutWeight(1)
      .minHeight(60)
    }
    .width('100%')
    .height('100%')
    .divider({
      strokeWidth: 1,
      color: '#CFD8DC'
    })
  }
}
```

### 4.2 聊天界面布局

```typescript
@ComponentV2
struct ChatLayoutExample {
  @Local messageList: string[] = [
    '消息 1', '消息 2', '消息 3', '消息 4', '消息 5'
  ]

  build() {
    RowSplit() {
      // 顶部用户信息
      Row() {
        Text('聊天对象')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#E3F2FD')
      .padding({ left: 16, right: 16 })
      .layoutWeight(0)
      .minHeight(60)

      // 中间消息列表
      Column() {
        ForEach(this.messageList, (message: string) => {
          Text(message)
            .fontSize(16)
            .width('100%')
            .padding(12)
            .backgroundColor('#F5F5F5')
            .borderRadius(8)
            .margin({ bottom: 8 })
        })
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .layoutWeight(1)

      // 底部输入框
      Row({ space: 8 }) {
        TextInput({ placeholder: '输入消息' })
          .layoutWeight(1)
        Button('发送')
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#FAFAFA')
      .layoutWeight(0)
      .minHeight(60)
    }
    .width('100%')
    .height(500)
    .divider({
      strokeWidth: 1,
      color: '#E0E0E0'
    })
  }
}
```

### 4.3 邮件界面布局

```typescript
@ComponentV2
struct EmailLayoutExample {
  build() {
    RowSplit() {
      // 邮件头部
      Column({ space: 8 }) {
        Text('邮件标题')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
        Row({ space: 16 }) {
          Text('发件人: xxx@example.com')
            .fontSize(14)
          Text('时间: 2024-01-01')
            .fontSize(14)
        }
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .layoutWeight(0)
      .minHeight(100)

      // 邮件内容
      Column() {
        Text('邮件正文内容')
          .fontSize(16)
          .lineHeight(24)
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .justifyContent(FlexAlign.Start)
      .layoutWeight(1)

      // 底部回复栏
      Row({ space: 8 }) {
        TextInput({ placeholder: '回复邮件...' })
          .layoutWeight(1)
        Button('发送')
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#FAFAFA')
      .layoutWeight(0)
      .minHeight(60)
    }
    .width('100%')
    .height(600)
    .divider({
      strokeWidth: 1,
      color: '#E0E0E0'
    })
  }
}
```

## 五、最佳实践

### 5.1 使用 layoutWeight

```typescript
// ✅ 推荐:使用 layoutWeight 设置比例
RowSplit() {
  Row() {}
  .layoutWeight(1)  // 占 1/4

  Row() {}
  .layoutWeight(2)  // 占 2/4

  Row() {}
  .layoutWeight(1)  // 占 1/4
}

// ❌ 避免:使用固定高度,难以响应
RowSplit() {
  Row() {}
  .height('100px')  // 固定高度

  Row() {}
  .height('200px')
}
```

### 5.2 设置最小高度

```typescript
// ✅ 推荐:设置 minHeight 防止过度压缩
RowSplit() {
  Row() {}
  .layoutWeight(1)
  .minHeight(60)  // 最小高度

  Row() {}
  .layoutWeight(3)
}

// ❌ 避免:不设置最小高度可能导致内容无法显示
RowSplit() {
  Row() {}
  .layoutWeight(1)
  // 无最小高度限制
}
```

### 5.3 自定义分割线

```typescript
// ✅ 推荐:自定义分割线样式提升视觉效果
RowSplit() {
  // 子组件
}
.divider({
  strokeWidth: 2,
  color: '#2196F3',
  startMargin: 8,
  endMargin: 8
})

// ❌ 避免:使用默认分割线可能不够明显
RowSplit() {
  // 子组件
}
// 使用默认分割线
```

### 5.4 顶部/底部固定区域

```typescript
// ✅ 推荐:使用 layoutWeight(0) 固定头部/底部高度
RowSplit() {
  // 顶部栏 - 固定高度
  Row() {}
  .layoutWeight(0)
  .minHeight(60)

  // 内容区 - 占据剩余空间
  Row() {}
  .layoutWeight(1)

  // 底部栏 - 固定高度
  Row() {}
  .layoutWeight(0)
  .minHeight(60)
}
```

## 六、常见问题

### Q1: RowSplit 和 Row 有什么区别?

**主要区别**:

1. **RowSplit** 支持拖动调整高度,有可拖动的分割线
2. **Row** 只能按水平方向排列子组件,不支持拖动调整

**使用场景**:
- 需要固定布局 → 使用 **Row**
- 需要动态调整 → 使用 **RowSplit**

### Q2: 如何禁用拖动功能?

**解决方案**:
```typescript
RowSplit() {
  // 子组件
}
.resizeable(false)  // 禁用拖动
```

### Q3: 子组件高度如何设置?

**解决方案**:
```typescript
// 方式 1: 使用 layoutWeight(推荐)
Row() {}
.layoutWeight(1)

// 方式 2: 使用固定高度
Row() {}
.height('100px')

// 方式 3: 混合使用
Row() {}
.height('60px')  // 固定高度

Row() {}
.layoutWeight(1)  // 占据剩余空间
```

### Q4: 如何防止子组件被过度压缩?

**解决方案**:
```typescript
Row() {}
.layoutWeight(1)
.minHeight(60)  // 设置最小高度
```

### Q5: 分割线样式如何自定义?

**解决方案**:
```typescript
RowSplit() {
  // 子组件
}
.divider({
  strokeWidth: 2,      // 分割线宽度
  color: '#2196F3',    // 分割线颜色
  startMargin: 8,      // 起始边距
  endMargin: 8         // 结束边距
})
```

### Q6: 如何实现固定头部和底部?

**解决方案**:
```typescript
RowSplit() {
  // 顶部固定区域
  Row() {
    Text('顶部栏')
  }
  .layoutWeight(0)  // 不参与剩余空间分配
  .minHeight(60)    // 固定最小高度

  // 中间可滚动区域
  Scroll() {
    Column() {
      // 内容
    }
  }
  .layoutWeight(1)  // 占据剩余空间

  // 底部固定区域
  Row() {
    Text('底部栏')
  }
  .layoutWeight(0)
  .minHeight(60)
}
```

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 9+ | ✅ | 完全支持 |
| API 10+ | ✅ | 增强了自定义能力 |
| API 12+ | ✅ | 性能优化 |

## 八、参考资料

- [RowSplit 组件 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-rowsplit-V5)
- [ColumnSplit 组件 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-columnsplit-V5)
- [Row 组件 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-row-V5)
