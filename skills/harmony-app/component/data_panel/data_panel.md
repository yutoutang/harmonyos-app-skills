# DataPanel 数据面板组件 HarmonyOS 6.0 开发 Skill

## 概述

DataPanel 数据面板组件是 OpenHarmony 中用于展示数据占比的组件,它支持线型和环形两种类型,常用于展示百分比数据、数据分布等场景。从 API 9 开始支持在 ArkTS 卡片中使用。

## 重要说明

- **基础组件**: DataPanel 是 ArkUI 的基础内置组件,无需导入
- **面板类型**: 支持线型(Line)和环形(Circle)两种类型
- **数据配置**: 通过数组配置多个数据值和颜色
- **动画支持**: 数据变化时支持平滑动画效果
- **API 支持**: 从 API 9 开始支持在 ArkTS 卡片中使用

## 模块信息

- **组件名称**: DataPanel
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [DataPanel 数据面板 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-basic-components-datapanel)

## 一、组件基础

### 1.1 导入方式

```typescript
// DataPanel 是内置组件,无需导入
// 直接使用即可
DataPanel({ values: [50], max: 100 })
```

### 1.2 基础用法

```typescript
// 环形数据面板
DataPanel({ values: [50], max: 100, type: DataPanelType.Circle })

// 线型数据面板
DataPanel({ values: [30, 50, 20], max: 100, type: DataPanelType.Line })
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| values | `number[]` | 是 | - | 数据值数组 |
| max | `number` | 是 | - | 最大值 |
| type | `DataPanelType` | 否 | DataPanelType.Circle | 面板类型 |

### 2.2 DataPanelType 枚举

| 值 | 描述 |
|----|------|
| `DataPanelType.Line` | 线型数据面板 |
| `DataPanelType.Circle` | 环形数据面板 |

### 2.3 样式属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `closeEffect` | `boolean` | true | 是否关闭动效 |
| `width` | `Length` | - | 宽度 |
| `height` | `Length` | - | 高度 |

## 三、使用示例

### 3.1 环形数据面板示例

```typescript
@ComponentV2
struct CircleDataPanelExample {
  @Local storageUsed: number = 75

  build() {
    Column({ space: 20 }) {
      Text('存储空间')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 单一数据环形面板
      DataPanel({ values: [this.storageUsed], max: 100, type: DataPanelType.Circle })
        .width(150)
        .height(150)
        .closeEffect(false)

      Text(`${this.storageUsed}%`)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)

      Button('更新数据')
        .onClick(() => {
          this.storageUsed = Math.floor(Math.random() * 100)
        })
    }
    .padding(20)
  }
}
```

### 3.2 多值环形数据面板

```typescript
@ComponentV2
struct MultiCircleDataPanelExample {
  @Local values: number[] = [30, 40, 20]

  build() {
    Column({ space: 20 }) {
      Text('多数据环形面板')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      DataPanel({ values: this.values, max: 100, type: DataPanelType.Circle })
        .width(180)
        .height(180)
        .closeEffect(false)

      // 图例
      Row({ space: 20 }) {
        Row({ space: 8 }) {
          Row()
            .width(12)
            .height(12)
            .backgroundColor('#007DFF')
            .borderRadius(6)
          Text('数据A')
            .fontSize(14)
        }

        Row({ space: 8 }) {
          Row()
            .width(12)
            .height(12)
            .backgroundColor('#28A745')
            .borderRadius(6)
          Text('数据B')
            .fontSize(14)
        }

        Row({ space: 8 }) {
          Row()
            .width(12)
            .height(12)
            .backgroundColor('#FFC107')
            .borderRadius(6)
          Text('数据C')
            .fontSize(14)
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)

      Button('随机数据')
        .onClick(() => {
          this.values = [
            Math.floor(Math.random() * 50),
            Math.floor(Math.random() * 50),
            Math.floor(Math.random() * 50)
          ]
        })
    }
    .padding(20)
  }
}
```

### 3.3 线型数据面板示例

```typescript
@ComponentV2
struct LineDataPanelExample {
  @Local values: number[] = [25, 35, 20]

  build() {
    Column({ space: 20 }) {
      Text('线型数据面板')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      DataPanel({ values: this.values, max: 100, type: DataPanelType.Line })
        .width('100%')
        .height(20)
        .closeEffect(false)

      // 显示各数据值
      Row({ space: 20 }) {
        Text(`${this.values[0]}%`)
          .fontSize(14)
          .fontColor('#007DFF')

        Text(`${this.values[1]}%`)
          .fontSize(14)
          .fontColor('#28A745')

        Text(`${this.values[2]}%`)
          .fontSize(14)
          .fontColor('#FFC107')
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .padding(20)
  }
}
```

### 3.4 进度展示示例

```typescript
@ComponentV2
struct ProgressDataPanelExample {
  @Local downloadProgress: number = 0
  @Local isDownloading: boolean = false

  startDownload(): void {
    this.isDownloading = true
    this.downloadProgress = 0

    const timer = setInterval(() => {
      if (this.downloadProgress >= 100) {
        clearInterval(timer)
        this.isDownloading = false
        console.info('下载完成')
      } else {
        this.downloadProgress += 2
      }
    }, 100)
  }

  build() {
    Column({ space: 20 }) {
      Text('下载进度')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Stack() {
        DataPanel({ values: [this.downloadProgress], max: 100, type: DataPanelType.Circle })
          .width(150)
          .height(150)
          .closeEffect(false)

        Column({ space: 4 }) {
          Text(`${this.downloadProgress}%`)
            .fontSize(28)
            .fontWeight(FontWeight.Bold)

          if (this.isDownloading) {
            Text('下载中...')
              .fontSize(14)
              .fontColor('#666666')
          } else if (this.downloadProgress === 100) {
            Text('完成')
              .fontSize(14)
              .fontColor('#28A745')
          } else {
            Text('等待开始')
              .fontSize(14)
              .fontColor('#666666')
          }
        }
      }

      Button('开始下载')
        .width('100%')
        .enabled(!this.isDownloading)
        .onClick(() => {
          this.startDownload()
        })
    }
    .padding(20)
  }
}
```

### 3.5 多指标仪表盘

```typescript
@ComponentV2
struct DashboardExample {
  @Local cpu: number = 45
  @Local memory: number = 62
  @Local network: number = 28

  build() {
    Column({ space: 20 }) {
      Text('系统监控')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        // CPU
        Column({ space: 8 }) {
          Stack() {
            DataPanel({ values: [this.cpu], max: 100, type: DataPanelType.Circle })
              .width(100)
              .height(100)

            Text(`${this.cpu}%`)
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
          }
          Text('CPU')
            .fontSize(14)
        }

        // 内存
        Column({ space: 8 }) {
          Stack() {
            DataPanel({ values: [this.memory], max: 100, type: DataPanelType.Circle })
              .width(100)
              .height(100)

            Text(`${this.memory}%`)
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
          }
          Text('内存')
            .fontSize(14)
        }

        // 网络
        Column({ space: 8 }) {
          Stack() {
            DataPanel({ values: [this.network], max: 100, type: DataPanelType.Circle })
              .width(100)
              .height(100)

            Text(`${this.network}%`)
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
          }
          Text('网络')
            .fontSize(14)
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)

      Button('更新数据')
        .onClick(() => {
          this.cpu = Math.floor(Math.random() * 100)
          this.memory = Math.floor(Math.random() * 100)
          this.network = Math.floor(Math.random() * 100)
        })
    }
    .padding(20)
  }
}
```

## 四、最佳实践

### 4.1 合理选择类型

```typescript
// ✅ 推荐:根据场景选择合适的类型
// 单一百分比 - 使用环形
DataPanel({ values: [75], max: 100, type: DataPanelType.Circle })

// 多数据对比 - 使用线型
DataPanel({ values: [30, 40, 20], max: 100, type: DataPanelType.Line })
```

### 4.2 显示数值

```typescript
// ✅ 推荐:显示具体数值
Stack() {
  DataPanel({ values: [75], max: 100, type: DataPanelType.Circle })
    .width(150)
    .height(150)

  Text('75%')
    .fontSize(24)
}
```

### 4.3 动画效果

```typescript
// ✅ 推荐:保持动画效果,提升用户体验
DataPanel({ values: [50], max: 100 })
  .closeEffect(false) // false 表示开启动画
```

## 五、常见问题

### Q1: 如何更新数据面板的值?

**解决方案**:
```typescript
// 使用响应式变量
@ComponentV2
struct CorrectDataPanel {
  @Local value: number = 50

  build() {
    DataPanel({ values: [this.value], max: 100 })
      .onClick(() => {
        this.value = 75 // 直接修改会触发更新
      })
  }
}
```

### Q2: 如何实现环形面板的文本居中?

**解决方案**:
```typescript
// 使用 Stack 叠加文本
Stack() {
  DataPanel({ values: [75], max: 100, type: DataPanelType.Circle })

  Text('75%')
    .fontSize(24)
}
```

## 六、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 9+ | ✅ | 完全支持,支持 ArkTS 卡片 |
| API 11+ | ✅ | 支持原子化服务 |
| API 12+ | ✅ | 性能优化 |

## 七、参考资料

- [DataPanel 数据面板 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-basic-components-datapanel)
- [通用属性 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-universal-attributes-size)
