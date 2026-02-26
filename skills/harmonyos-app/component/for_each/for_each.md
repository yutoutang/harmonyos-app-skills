# ForEach 渲染控制 HarmonyOS 6.0 开发 Skill

## 概述

ForEach 是 ArkUI 的基础渲染控制 API，用于根据数据数组循环渲染 UI 组件。它适用于小到中等规模的数据集（通常 < 100 项），会为每个数据项创建对应的组件实例。

## 重要说明

- **非虚拟化**: ForEach 会为所有数据项创建组件实例，不适合大数据集
- **KeyGenerator**: 必须提供唯一的 key 生成函数以优化渲染性能
- **适用场景**: 小规模列表、静态数据、已知数据量的场景
- **对比 LazyForEach**: 数据量 < 100 使用 ForEach，≥ 100 使用 LazyForEach

## 模块信息

- **API 名称**: ForEach
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [ForEach - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-for-each-V5)

## 一、API 签名

```typescript
ForEach(
  arr: Array,
  itemGenerator: (item: any, index?: number) => void,
  keyGenerator?: (item: any, index?: number) => string
)
```

### 参数说明

| 参数 | 类型 | 必填 | 描述 |
|------|------|------|------|
| `arr` | `Array` | 是 | 要遍历的数据数组 |
| `itemGenerator` | `(item, index?) => void` | 是 | 组件生成函数，接收数据项和索引 |
| `keyGenerator` | `(item, index?) => string` | 否 | 唯一标识生成函数，强烈推荐 |

## 二、基础用法

### 2.1 简单列表

```typescript
@ComponentV2
struct BasicForEachExample {
  @Local fruits: string[] = ['Apple', 'Banana', 'Orange', 'Grape']

  build() {
    Column({ space: 8 }) {
      ForEach(this.fruits, (fruit: string) => {
        Text(fruit)
          .width('100%')
          .height(50)
          .padding({ left: 16 })
          .backgroundColor('#F5F5F5')
      })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 2.2 带索引的渲染

```typescript
@ComponentV2
struct ForEachWithIndexExample {
  @Local items: string[] = ['Item 1', 'Item 2', 'Item 3']

  build() {
    List({ space: 8 }) {
      ForEach(this.items, (item: string, index: number) => {
        ListItem() {
          Row({ space: 12 }) {
            Text(`${index + 1}`)
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .width(40)

            Text(item)
              .fontSize(16)
              .layoutWeight(1)
          }
          .width('100%')
          .height(60)
          .padding({ left: 16, right: 16 })
          .backgroundColor(Color.White)
        }
      })
    }
    .width('100%')
    .height(300)
  }
}
```

### 2.3 嵌套 ForEach（分组数据）

```typescript
@ComponentV2
struct NestedForEachExample {
  @Local sections: SectionData[] = [
    { title: 'Fruits', items: ['Apple', 'Banana', 'Orange'] },
    { title: 'Vegetables', items: ['Carrot', 'Broccoli', 'Spinach'] }
  ]

  build() {
    Column({ space: 16 }) {
      ForEach(this.sections, (section: SectionData) => {
        Column({ space: 8 }) {
          // 分组标题
          Text(section.title)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .padding({ left: 16 })

          // 分组项
          ForEach(section.items, (item: string) => {
            Text(item)
              .width('100%')
              .height(50)
              .padding({ left: 32 })
              .backgroundColor('#F5F5F5')
          })
        }
      })
    }
    .width('100%')
    .padding(16)
  }
}

interface SectionData {
  title: string
  items: string[]
}
```

## 三、KeyGenerator 详解

### 3.1 为什么需要 KeyGenerator

KeyGenerator 为每个数据项生成唯一标识，帮助 ArkUI:
- **追踪数据项**: 在数据变化时识别哪些项新增、删除或移动
- **优化渲染**: 避免不必要的组件重建，提升性能
- **保持状态**: 保留组件的内部状态（如滚动位置、输入内容）

### 3.2 KeyGenerator 最佳实践

#### 使用唯一 ID（推荐）

```typescript
interface User {
  id: string
  name: string
  email: string
}

@ComponentV2
struct KeyGeneratorBestExample {
  @Local users: User[] = [
    { id: '1', name: 'Alice', email: 'alice@example.com' },
    { id: '2', name: 'Bob', email: 'bob@example.com' },
    { id: '3', name: 'Charlie', email: 'charlie@example.com' }
  ]

  build() {
    List({ space: 8 }) {
      ForEach(
        this.users,
        (user: User) => {
          ListItem() {
            Column({ space: 4 }) {
              Text(user.name)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
              Text(user.email)
                .fontSize(14)
                .fontColor('#666666')
            }
            .width('100%')
            .padding(16)
            .backgroundColor(Color.White)
          }
        },
        (user: User) => user.id // ✅ 使用唯一 ID
      )
    }
    .width('100%')
    .height(300)
  }
}
```

#### 使用复合键（无唯一 ID 时）

```typescript
@ComponentV2
struct CompositeKeyExample {
  @Local items: Array<{ name: string, category: string }> = [
    { name: 'Apple', category: 'Fruit' },
    { name: 'Banana', category: 'Fruit' },
    { name: 'Carrot', category: 'Vegetable' }
  ]

  build() {
    Column({ space: 8 }) {
      ForEach(
        this.items,
        (item: { name: string, category: string }, index: number) => {
          Text(`${item.category}: ${item.name}`)
            .width('100%')
            .height(50)
            .padding({ left: 16 })
            .backgroundColor('#F5F5F5')
        },
        (item: { name: string, category: string }, index: number) => {
          // ✅ 使用复合键保证唯一性
          return `${item.category}-${item.name}-${index}`
        }
      )
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.3 常见错误

#### ❌ 错误 1: 使用索引作为 key（数据可变时）

```typescript
// 错误示例
ForEach(this.items, (item: Item) => {
  Text(item.name)
}, (item: Item, index: number) => index.toString()) // ❌ 数据变化时索引可能变化
```

#### ❌ 错误 2: 使用不稳定的值作为 key

```typescript
// 错误示例
ForEach(this.users, (user: User) => {
  Text(user.name)
}, (user: User) => user.name) // ❌ 名称可能重复或变化
```

#### ✅ 正确做法

```typescript
// 正确示例
ForEach(this.users, (user: User) => {
  Text(user.name)
}, (user: User) => user.id) // ✅ 使用唯一且稳定的 ID
```

## 四、性能优化

### 4.1 数据量选择

| 数据量 | 推荐方案 | 原因 |
|--------|----------|------|
| < 50 项 | ForEach | 渲染开销小，实现简单 |
| 50-100 项 | ForEach（静态）或 LazyForEach | 根据更新频率选择 |
| > 100 项 | LazyForEach | 虚拟滚动，仅渲染可见项 |

### 4.2 减少重建优化

```typescript
@ComponentV2
struct ReduceRebuildExample {
  @Local items: Item[] = []

  build() {
    Column() {
      // ✅ 提供稳定的 key 避免不必要的重建
      ForEach(
        this.items,
        (item: Item) => {
          // 使用 @Reusable 装饰的组件
          ReusableItemCard({ data: item })
        },
        (item: Item) => item.id
      )
    }
  }
}

@Reusable
@ComponentV2
struct ReusableItemCard {
  @Param data: Item = new Item()

  build() {
    Column() {
      Text(this.data.name)
    }
    .width('100%')
    .padding(16)
    .backgroundColor(Color.White)
  }
}
```

### 4.3 避免复杂计算

```typescript
@ComponentV2
struct AvoidComplexCalcExample {
  @Local items: Item[] = []
  @Local expensiveValue: number = 0

  // ❌ 错误：在 ForEach 中进行复杂计算
  build() {
    Column() {
      ForEach(this.items, (item: Item) => {
        Text(this.calculateExpensiveValue(item)) // 每次渲染都计算
      })
    }
  }

  // ✅ 正确：预先计算或使用缓存
  build() {
    Column() {
      ForEach(
        this.items,
        (item: Item) => {
          Text(item.cachedValue) // 使用预计算的值
        },
        (item: Item) => item.id
      )
    }
  }
}
```

## 五、与 LazyForEach 对比

| 特性 | ForEach | LazyForEach |
|------|---------|-------------|
| **渲染方式** | 全量渲染 | 按需渲染（虚拟化） |
| **数据规模** | < 100 项 | 任意规模 |
| **内存占用** | 高（所有组件） | 低（仅可见组件） |
| **滚动性能** | 一般 | 优秀 |
| **实现复杂度** | 简单 | 较复杂（需要 DataSource） |
| **适用组件** | 所有容器 | List、Grid、Swiper、WaterFlow |

## 六、常见问题与解决方案

### 6.1 数据更新不生效

**问题**: 修改数组数据后界面不更新

**原因**: 数组引用未变化，ArkUI 无法检测

**解决方案**:

```typescript
@ComponentV2
struct DataUpdateSolution {
  @Local items: string[] = ['A', 'B', 'C']

  addItem() {
    // ❌ 错误：直接修改
    // this.items.push('D')

    // ✅ 正确：创建新数组
    this.items = [...this.items, 'D']
  }

  removeItem(index: number) {
    // ✅ 使用 filter 创建新数组
    this.items = this.items.filter((_, i) => i !== index)
  }

  updateItem(index: number, newValue: string) {
    // ✅ 使用 map 创建新数组
    this.items = this.items.map((item, i) =>
      i === index ? newValue : item
    )
  }

  build() {
    Column({ space: 16 }) {
      ForEach(
        this.items,
        (item: string, index: number) => {
          Row({ space: 8 }) {
            Text(item)
            Button('删除')
              .onClick(() => this.removeItem(index))
          }
        },
        (item: string, index: number) => `${index}-${item}`
      )

      Button('添加')
        .onClick(() => this.addItem())
    }
    .padding(16)
  }
}
```

### 6.2 Key 冲突导致的问题

**问题**: 界面显示错误或组件状态混乱

**原因**: KeyGenerator 返回了重复的 key

**解决方案**:

```typescript
@ComponentV2
struct KeyConflictSolution {
  @Local items: Array<{ name: string }> = [
    { name: 'Apple' },
    { name: 'Apple' }, // 重复数据
    { name: 'Apple' }
  ]

  build() {
    Column() {
      // ❌ 错误：仅使用 name 作为 key
      ForEach(
        this.items,
        (item: { name: string }) => Text(item.name),
        (item: { name: string }) => item.name // key 冲突！
      )

      // ✅ 正确：使用索引确保唯一性
      ForEach(
        this.items,
        (item: { name: string }, index: number) =>
          Text(`${item.name} (${index})`),
        (item: { name: string }, index: number) =>
          `${item.name}-${index}` // 包含索引保证唯一
      )
    }
  }
}
```

### 6.3 嵌套滚动性能问题

**问题**: 嵌套 ForEach 导致滚动卡顿

**解决方案**:

```typescript
@ComponentV2
struct NestedScrollSolution {
  @Local sections: SectionData[] = []

  build() {
    // ❌ 错误：多层嵌套 ForEach
    Scroll() {
      Column() {
        ForEach(this.sections, (section: SectionData) => {
          Column() {
            ForEach(section.items, (item: string) => {
              Text(item)
            })
          }
        })
      }
    }

    // ✅ 正确：使用 List + ListItemGroup
    List() {
      ForEach(this.sections, (section: SectionData) => {
        ListItemGroup({ header: this.headerBuilder(section.title) }) {
          ForEach(section.items, (item: string) => {
            ListItem() {
              Text(item)
            }
          })
        }
      })
    }
  }

  @Builder headerBuilder(title: string) {
    Text(title)
      .fontSize(18)
      .fontWeight(FontWeight.Bold)
      .padding({ left: 16 })
  }
}
```

## 七、实际应用示例

### 7.1 标签列表

```typescript
@ComponentV2
struct TagsListExample {
  @Local tags: string[] = [
    'TypeScript', 'ArkUI', 'HarmonyOS', 'Mobile',
    'Cross-Platform', 'OpenHarmony', 'DevEco'
  ]
  @Local selectedTags: Set<string> = new Set()

  build() {
    Column({ space: 16 }) {
      Text('选择标签')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Flex({ wrap: FlexWrap.Wrap, space: { main: 8, cross: 8 } }) {
        ForEach(this.tags, (tag: string) => {
          Text(tag)
            .fontSize(14)
            .padding({ left: 12, right: 12, top: 6, bottom: 6 })
            .backgroundColor(this.selectedTags.has(tag) ? '#007DFF' : '#F5F5F5')
            .fontColor(this.selectedTags.has(tag) ? Color.White : '#333333')
            .borderRadius(16)
            .onClick(() => {
              if (this.selectedTags.has(tag)) {
                this.selectedTags.delete(tag)
              } else {
                this.selectedTags.add(tag)
              }
              this.selectedTags = new Set(this.selectedTags)
            })
        }, (tag: string) => tag)
      }
      .width('100%')

      Text(`已选择: ${this.selectedTags.size} 个标签`)
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 7.2 步骤指示器

```typescript
@ComponentV2
struct StepIndicatorExample {
  @Local steps: string[] = ['注册', '验证', '完善信息', '完成']
  @Local currentStep: number = 1

  build() {
    Column({ space: 24 }) {
      ForEach(this.steps, (step: string, index: number) => {
        Row({ space: 12 }) {
          // 步骤圆圈
          Circle()
            .width(32)
            .height(32)
            .fill(index < this.currentStep ? '#007DFF' : '#E0E0E0')
            .overlay(
              Text(`${index + 1}`)
                .fontSize(14)
                .fontColor(index < this.currentStep ? Color.White : '#666666')
            )

          // 步骤名称
          Text(step)
            .fontSize(16)
            .fontColor(index < this.currentStep ? '#007DFF' : '#999999')
            .fontWeight(
              index === this.currentStep ? FontWeight.Bold : FontWeight.Normal
            )

          // 连接线（非最后一项）
          if (index < this.steps.length - 1) {
            Line()
              .width(40)
              .height(2)
              .backgroundColor(index < this.currentStep - 1 ? '#007DFF' : '#E0E0E0')
              .margin({ left: 8 })
          }
        }
        .width('100%')
      }, (step: string, index: number) => `step-${index}`)

      Row({ space: 16 }) {
        Button('上一步')
          .enabled(this.currentStep > 0)
          .onClick(() => {
            this.currentStep = Math.max(0, this.currentStep - 1)
          })

        Button('下一步')
          .enabled(this.currentStep < this.steps.length - 1)
          .onClick(() => {
            this.currentStep = Math.min(this.steps.length - 1, this.currentStep + 1)
          })
      }
      .margin({ top: 16 })
    }
    .width('100%')
    .padding(24)
  }
}
```

### 7.3 图片画廊

```typescript
@ComponentV2
struct ImageGalleryExample {
  @Local images: Array<{ url: string, title: string }> = [
    { url: 'https://example.com/img1.jpg', title: '风景 1' },
    { url: 'https://example.com/img2.jpg', title: '风景 2' },
    { url: 'https://example.com/img3.jpg', title: '风景 3' }
  ]

  build() {
    Column({ space: 16 }) {
      Text('图片画廊')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Grid() {
        ForEach(
          this.images,
          (image: { url: string, title: string }) => {
            GridItem() {
              Column({ space: 8 }) {
                // 图片占位符
                Row()
                  .width('100%')
                  .aspectRatio(1)
                  .backgroundColor('#E0E0E0')
                  .borderRadius(8)

                Text(image.title)
                  .fontSize(14)
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
              }
              .width('100%')
              .padding(8)
            }
            .onClick(() => {
              console.info(`Clicked: ${image.title}`)
            })
          },
          (image: { url: string, title: string }) => image.url
        )
      }
      .columnsTemplate('1fr 1fr 1fr')
      .rowsGap(12)
      .columnsGap(12)
      .width('100%')
    }
    .width('100%')
    .padding(16)
  }
}
```

## 八、总结

### 何时使用 ForEach

✅ **适合场景**:
- 数据量 < 100 项
- 数据相对静态，更新频率低
- 需要快速实现简单列表
- 嵌套数据结构（如分组列表）
- 标签、按钮组等小规模组件集合

❌ **不适合场景**:
- 数据量 > 100 项（应使用 LazyForEach）
- 数据频繁变化（考虑 LazyForEach 的通知机制）
- 需要虚拟滚动的长列表
- 对内存占用敏感的场景

### 关键要点

1. **务必提供 KeyGenerator**: 使用唯一且稳定的标识符
2. **保持数据不可变性**: 修改数据时创建新数组引用
3. **合理使用索引**: 仅在确保唯一性时使用索引作为 key
4. **性能监控**: 数据量接近 100 时考虑迁移到 LazyForEach
5. **简化组件结构**: ForEach 内的组件尽可能简单

## 相关文档

- [LazyForEach 懒加载](../lazy_for_each/lazy_for_each.md)
- [List 组件](../list/list.md)
- [Grid 组件](../grid/grid.md)
- [WaterFlow 瀑布流](../water_flow/water_flow.md)
