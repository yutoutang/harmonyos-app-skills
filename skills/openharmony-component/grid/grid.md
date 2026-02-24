# Grid 组件 HarmonyOS 6.0 开发 Skill

## 概述

Grid 组件是 OpenHarmony 中的网格布局容器，按照行列方式排列子组件。支持固定列数、自适应列数等多种布局方式，适合构建规则的网格界面。

## 重要说明

- **基础组件**: Grid 是 ArkUI 的基础内置组件，无需导入
- **网格布局**: 按行列排列子组件
- **列配置**: 支持固定列数、最小列宽等
- **子组件**: 需要配合 GridItem 组件使用

## 模块信息

- **组件名称**: Grid
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [Grid 网格 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-grid-V5)

## 一、API 参数

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `columnsTemplate` | `string` | '1fr 1fr' | 列模板 |
| `rowsTemplate` | `string` | - | 行模板 |
| `columnsGap` | `number \| string \| Resource` | 0 | 列间距 |
| `rowsGap` | `number \| string \| Resource` | 0 | 行间距 |
| `width` | `number \| string \| Resource` | - | Grid 宽度 |

## 二、使用示例

### 2.1 固定列数网格

```typescript
Grid() {
  ForEach([1, 2, 3, 4, 5, 6], (item: number) => {
    GridItem() {
      Text(`Item ${item}`)
        .width('100%')
        .height(60)
        .textAlign(TextAlign.Center)
        .backgroundColor('#E3F2FD')
        .borderRadius(8)
    }
  })
}
.columnsTemplate('1fr 1fr 1fr')
.rowsGap(12)
.columnsGap(12)
.width('100%')
```

### 2.2 自适应列数

```typescript
Grid() {
  ForEach([1, 2, 3, 4, 5, 6], (item: number) => {
    GridItem() {
      Text(`Item ${item}`)
        .width(100%)
        .height(60)
        .backgroundColor('#E8F5E9')
        .borderRadius(8)
    }
  })
}
.columnsTemplate('repeat(auto-fit, minmax(120, 1fr))')
.rowsGap(12)
.columnsGap(12)
.width('100%')
```

### 2.3 混合跨度

```typescript
Grid() {
  GridItem() {
    Text('Item 1')
      .width('100%')
      .height(60)
  }
  .columnStart(0)
  .columnEnd(1)

  GridItem() {
    Text('Item 2 - 跨2列')
      .width('100%')
      .height(60)
  }
  .columnStart(1)
  .columnEnd(3)
}
.columnsTemplate('1fr 1fr 1fr')
.rowsGap(12)
.columnsGap(12)
.width('100%')
```

## 三、最佳实践

- 列模板使用 '1fr 1fr 1fr' 等灵活设置
- 使用 auto-fit + minmax 实现响应式网格
- 大数据量使用 LazyGridForEach 而非 ForEach
