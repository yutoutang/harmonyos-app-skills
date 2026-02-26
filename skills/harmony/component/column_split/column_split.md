# ColumnSplit 组件 HarmonyOS 6.0 开发 Skill

## 概述

ColumnSplit 组件是 OpenHarmony 中的垂直分割容器组件,用于将子组件按垂直方向排列,并支持拖动调整各子组件的宽度比例。它类似于 Column 组件,但提供了可拖动分割线的功能,适用于需要动态调整布局的场景。

## 重要说明

- **基础组件**: ColumnSplit 是 ArkUI 的基础内置组件,无需导入
- **子组件**: 可以包含多个子组件,每个子组件占据一定宽度
- **可拖动**: 支持拖动分割线来调整相邻子组件的宽度比例
- **响应式**: 配合 @State/@Local 使用实现响应式更新
- **最小宽度**: 可设置每个子组件的最小宽度,防止过度压缩

## 模块信息

- **组件名称**: ColumnSplit
- **SDK 版本**: HarmonyOS 6.0 (API 9+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [ColumnSplit - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-columnsplit-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// ColumnSplit 是内置组件,无需导入
// 直接使用即可
ColumnSplit() {
  // 子组件
}
```

### 1.2 基础用法

```typescript
// 简单的垂直分割布局
ColumnSplit() {
  Column() {
    Text('左侧内容')
  }
  .backgroundColor('#F5F5F5')

  Column() {
    Text('中间内容')
  }
  .backgroundColor('#FFFFFF')

  Column() {
    Text('右侧内容')
  }
  .backgroundColor('#F5F5F5')
}
.width('100%')
.height(200)
```

## 二、API 参数

### 2.1 构造参数

ColumnSplit 没有必需的构造参数。

### 2.2 ColumnSplit 属性

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
| `minWidth` | `Length` | 0 | 最小宽度 |

## 三、使用示例

### 3.1 基础分割布局示例

```typescript
@ComponentV2
struct BasicColumnSplitExample {
  build() {
    Column({ space: 16 }) {
      Text('ColumnSplit 基础示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      ColumnSplit() {
        Column() {
          Text('区域 1')
            .fontSize(16)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#E3F2FD')
        .justifyContent(FlexAlign.Center)

        Column() {
          Text('区域 2')
            .fontSize(16)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#BBDEFB')
        .justifyContent(FlexAlign.Center)

        Column() {
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
      .height(200)
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
struct FixedRatioColumnSplitExample {
  build() {
    Column({ space: 16 }) {
      Text('固定比例分割')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      ColumnSplit() {
        Column() {
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

        Column() {
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

        Column() {
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
      .height(200)
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
struct NoResizeColumnSplitExample {
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

      ColumnSplit() {
        Column() {
          Text('侧边栏')
            .fontSize(16)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#ECEFF1')
        .justifyContent(FlexAlign.Center)
        .layoutWeight(1)

        Column() {
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
      .height(200)
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

### 3.4 带最小宽度限制示例

```typescript
@ComponentV2
struct MinWidthColumnSplitExample {
  build() {
    Column({ space: 16 }) {
      Text('最小宽度限制')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      Text('每个区域有最小宽度限制,防止过度压缩')
        .fontSize(14)
        .fontColor('#666666')
        .width('100%')

      ColumnSplit() {
        Column() {
          Text('最小 80')
            .fontSize(14)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#FFCDD2')
        .justifyContent(FlexAlign.Center)
        .layoutWeight(1)
        .minWidth(80)

        Column() {
          Text('最小 120')
            .fontSize(14)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#C8E6C9')
        .justifyContent(FlexAlign.Center)
        .layoutWeight(2)
        .minWidth(120)

        Column() {
          Text('最小 80')
            .fontSize(14)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#BBDEFB')
        .justifyContent(FlexAlign.Center)
        .layoutWeight(1)
        .minWidth(80)
      }
      .width('100%')
      .height(200)
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
struct CustomDividerColumnSplitExample {
  build() {
    Column({ space: 16 }) {
      Text('自定义分割线样式')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // 粗分割线
      ColumnSplit() {
        Column() {
          Text('区域 1')
            .fontSize(16)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#FFF3E0')
        .justifyContent(FlexAlign.Center)

        Column() {
          Text('区域 2')
            .fontSize(16)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#FFE0B2')
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height(150)
      .divider({
        strokeWidth: 4,
        color: '#FF9800'
      })
      .margin({ bottom: 16 })

      // 带边距的分割线
      ColumnSplit() {
        Column() {
          Text('区域 A')
            .fontSize(16)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#F3E5F5')
        .justifyContent(FlexAlign.Center)

        Column() {
          Text('区域 B')
            .fontSize(16)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#E1BEE7')
        .justifyContent(FlexAlign.Center)

        Column() {
          Text('区域 C')
            .fontSize(16)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#CE93D8')
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height(150)
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
struct DynamicColumnSplitExample {
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

      ColumnSplit() {
        if (this.showPanel) {
          Column() {
            Text('侧边面板')
              .fontSize(16)
          }
          .width('100%')
          .height('100%')
          .backgroundColor('#E8EAF6')
          .justifyContent(FlexAlign.Center)
          .layoutWeight(1)
          .minWidth(100)
        }

        Column() {
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
      .height(250)
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
struct ThreeColumnLayoutExample {
  build() {
    ColumnSplit() {
      // 左侧导航栏
      Column() {
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
      .minWidth(60)

      // 中间内容区
      Column() {
        Text('内容')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
      .justifyContent(FlexAlign.Center)
      .layoutWeight(4)

      // 右侧工具栏
      Column() {
        Text('工具')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#ECEFF1')
      .justifyContent(FlexAlign.Center)
      .layoutWeight(1)
      .minWidth(60)
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

### 4.2 代码编辑器布局

```typescript
@ComponentV2
struct CodeEditorLayoutExample {
  build() {
    Column() {
      // 顶部工具栏
      Row() {
        Text('代码编辑器')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .height(50)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#37474F')
      .fontColor(Color.White)

      // 分割区域
      ColumnSplit() {
        // 文件树
        Column() {
          Text('文件树')
            .fontSize(16)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#263238')
        .fontColor(Color.White)
        .justifyContent(FlexAlign.Center)
        .layoutWeight(1)
        .minWidth(150)

        // 代码编辑区
        Column() {
          Text('代码编辑区')
            .fontSize(16)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#212121')
        .fontColor(Color.White)
        .justifyContent(FlexAlign.Center)
        .layoutWeight(3)

        // 预览区
        Column() {
          Text('预览')
            .fontSize(16)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#FFFFFF')
        .justifyContent(FlexAlign.Center)
        .layoutWeight(2)
        .minWidth(200)
      }
      .width('100%')
      .layoutWeight(1)
      .divider({
        strokeWidth: 1,
        color: '#37474F'
      })
    }
    .width('100%')
    .height('100%')
  }
}
```

## 五、最佳实践

### 5.1 使用 layoutWeight

```typescript
// ✅ 推荐:使用 layoutWeight 设置比例
ColumnSplit() {
  Column() {}
  .layoutWeight(1)  // 占 1/4

  Column() {}
  .layoutWeight(2)  // 占 2/4

  Column() {}
  .layoutWeight(1)  // 占 1/4
}

// ❌ 避免:使用固定宽度,难以响应
ColumnSplit() {
  Column() {}
  .width('100px')  // 固定宽度

  Column() {}
  .width('200px')
}
```

### 5.2 设置最小宽度

```typescript
// ✅ 推荐:设置 minWidth 防止过度压缩
ColumnSplit() {
  Column() {}
  .layoutWeight(1)
  .minWidth(80)  // 最小宽度

  Column() {}
  .layoutWeight(3)
}

// ❌ 避免:不设置最小宽度可能导致内容无法显示
ColumnSplit() {
  Column() {}
  .layoutWeight(1)
  // 无最小宽度限制
}
```

### 5.3 自定义分割线

```typescript
// ✅ 推荐:自定义分割线样式提升视觉效果
ColumnSplit() {
  // 子组件
}
.divider({
  strokeWidth: 2,
  color: '#2196F3',
  startMargin: 8,
  endMargin: 8
})

// ❌ 避免:使用默认分割线可能不够明显
ColumnSplit() {
  // 子组件
}
// 使用默认分割线
```

## 六、常见问题

### Q1: ColumnSplit 和 Column 有什么区别?

**主要区别**:

1. **ColumnSplit** 支持拖动调整宽度,有可拖动的分割线
2. **Column** 只能按垂直方向排列子组件,不支持拖动调整

**使用场景**:
- 需要固定布局 → 使用 **Column**
- 需要动态调整 → 使用 **ColumnSplit**

### Q2: 如何禁用拖动功能?

**解决方案**:
```typescript
ColumnSplit() {
  // 子组件
}
.resizeable(false)  // 禁用拖动
```

### Q3: 子组件宽度如何设置?

**解决方案**:
```typescript
// 方式 1: 使用 layoutWeight(推荐)
Column() {}
.layoutWeight(1)

// 方式 2: 使用固定宽度
Column() {}
.width('100px')

// 方式 3: 混合使用
Column() {}
.width('100px')  // 固定宽度

Column() {}
.layoutWeight(1)  // 占据剩余空间
```

### Q4: 如何防止子组件被过度压缩?

**解决方案**:
```typescript
Column() {}
.layoutWeight(1)
.minWidth(80)  // 设置最小宽度
```

### Q5: 分割线样式如何自定义?

**解决方案**:
```typescript
ColumnSplit() {
  // 子组件
}
.divider({
  strokeWidth: 2,      // 分割线宽度
  color: '#2196F3',    // 分割线颜色
  startMargin: 8,      // 起始边距
  endMargin: 8         // 结束边距
})
```

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 9+ | ✅ | 完全支持 |
| API 10+ | ✅ | 增强了自定义能力 |
| API 12+ | ✅ | 性能优化 |

## 八、参考资料

- [ColumnSplit 组件 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-columnsplit-V5)
- [RowSplit 组件 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-rowsplit-V5)
- [Column 组件 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-column-V5)
