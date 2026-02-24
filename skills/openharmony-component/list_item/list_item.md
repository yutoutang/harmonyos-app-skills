# ListItem 组件 HarmonyOS 6.0 开发 Skill

## 概述

ListItem 组件是 OpenHarmony 中 List 组件的子组件，用于表示列表中的单个列表项。每个 ListItem 必须作为 List 的直接子组件使用，不能单独使用。

## 重要说明

- **基础组件**: ListItem 是 ArkUI 的基础内置组件，无需导入
- **父组件要求**: 必须作为 List 的直接子组件
- **嵌套限制**: 不能在 ListItem 中嵌套 List 组件（会导致性能问题）
- **高度设置**: 必须设置明确的高度或使用自适应布局
- **渲染控制**: 支持 if/else、ForEach、LazyForEach

## 模块信息

- **组件名称**: ListItem
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [ListItem - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-listitem-V5)

## 一、API 参数

### 构造函数

```typescript
ListItem(value?: { sticky?: StickyMode })
```

| 参数 | 类型 | 必填 | 描述 |
|------|------|------|------|
| sticky | StickyMode | 否 | 吸附模式，用于设置 ListItem 吸附效果 |

### StickyMode 枚举

| 值 | 描述 |
|----|------|
| StickyMode.None | 不设置吸附效果 |
| StickyMode.Normal | 正常吸附效果 |
| StickyMode.Opacity | 透明度渐变吸附效果 |

### 通用属性

ListItem 支持以下通用属性：

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| width | Length | - | 宽度 |
| height | Length | - | 高度 |
| backgroundColor | ResourceColor | - | 背景颜色 |
| borderRadius | Length | - | 圆角半径 |
| margin | Padding | - | 外边距 |
| padding | Padding | - | 内边距 |
| onClick | () => void | - | 点击事件 |

## 二、使用示例

### 2.1 基础 ListItem

```typescript
@ComponentV2
struct BasicListItemExample {
  @Local items: string[] = ['Apple', 'Banana', 'Orange', 'Grape', 'Mango']

  build() {
    List({ space: 8 }) {
      ForEach(this.items, (item: string) => {
        ListItem() {
          Text(item)
            .width('100%')
            .height(60)
            .fontSize(18)
            .textAlign(TextAlign.Center)
            .backgroundColor('#F5F5F5')
            .borderRadius(8)
        }
      })
    }
    .width('100%')
    .height(300)
  }
}
```

### 2.2 自定义样式 ListItem

```typescript
@ComponentV2
struct CustomStyleListItemExample {
  @Local contacts: Contact[] = [
    { name: 'Alice', phone: '123-456-7890', avatar: 'A' },
    { name: 'Bob', phone: '987-654-3210', avatar: 'B' },
    { name: 'Charlie', phone: '555-123-4567', avatar: 'C' }
  ]

  build() {
    List({ space: 12 }) {
      ForEach(this.contacts, (contact: Contact) => {
        ListItem() {
          Row({ space: 12 }) {
            // 头像
            Text(contact.avatar)
              .width(50)
              .height(50)
              .fontSize(20)
              .fontColor(Color.White)
              .backgroundColor('#007DFF')
              .borderRadius(25)
              .textAlign(TextAlign.Center)

            // 信息
            Column({ space: 4 }) {
              Text(contact.name)
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')

              Text(contact.phone)
                .fontSize(14)
                .fontColor('#666666')
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)
          }
          .width('100%')
          .padding(16)
          .backgroundColor(Color.White)
          .borderRadius(12)
        }
      })
    }
    .width('100%')
    .height(400)
    .padding({ left: 16, right: 16 })
  }
}

interface Contact {
  name: string
  phone: string
  avatar: string
}
```

### 2.3 吸附效果 ListItem

```typescript
@ComponentV2
struct StickyListItemExample {
  @Local sections: Section[] = [
    { title: 'A', items: ['Apple', 'Apricot', 'Avocado'] },
    { title: 'B', items: ['Banana', 'Blueberry', 'Blackberry'] },
    { title: 'C', items: ['Cherry', 'Coconut', 'Cranberry'] }
  ]

  build() {
    List() {
      ForEach(this.sections, (section: Section) => {
        // 吸附标题
        ListItem({ sticky: StickyMode.Opacity }) {
          Text(section.title)
            .width('100%')
            .height(40)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .padding({ left: 16 })
            .backgroundColor('#E3F2FD')
            .fontColor('#007DFF')
        }

        // 列表项
        ForEach(section.items, (item: string) => {
          ListItem() {
            Text(item)
              .width('100%')
              .height(50)
              .padding({ left: 16 })
              .fontSize(16)
              .fontColor('#333333')
              .backgroundColor(Color.White)
          }
        })
      })
    }
    .width('100%')
    .height('100%')
    .divider({ strokeWidth: 1, color: '#EEEEEE' })
  }
}

interface Section {
  title: string
  items: string[]
}
```

### 2.4 可交互 ListItem

```typescript
@ComponentV2
struct InteractiveListItemExample {
  @Local tasks: Task[] = [
    { id: 1, title: 'Complete project', completed: false },
    { id: 2, title: 'Review code', completed: true },
    { id: 3, title: 'Write tests', completed: false }
  ]

  build() {
    List({ space: 8 }) {
      ForEach(this.tasks, (task: Task) => {
        ListItem() {
          Row({ space: 12 }) {
            // 复选框
            Checkbox()
              .select(task.completed)
              .onChange((value: boolean) => {
                task.completed = value
                console.info(`Task ${task.id} completed: ${value}`)
              })

            // 任务标题
            Text(task.title)
              .fontSize(16)
              .fontColor(task.completed ? '#999999' : '#333333')
              .decoration({
                type: task.completed ? TextDecorationType.LineThrough : TextDecorationType.None
              })
              .layoutWeight(1)

            // 删除按钮
            Button('Delete')
              .type(ButtonType.Normal)
              .backgroundColor('#FF5252')
              .fontColor(Color.White)
              .height(32)
              .onClick(() => {
                this.tasks = this.tasks.filter(t => t.id !== task.id)
              })
          }
          .width('100%')
          .padding(16)
          .backgroundColor(Color.White)
          .borderRadius(8)
          .border({ width: 1, color: task.completed ? '#E0E0E0' : '#007DFF' })
        }
      })
    }
    .width('100%')
    .height(400)
    .padding({ left: 16, right: 16 })
  }
}

interface Task {
  id: number
  title: string
  completed: boolean
}
```

### 2.5 LazyForEach 优化 ListItem

```typescript
@ComponentV2
struct LazyForEachListItemExample {
  private dataSource: MyDataSource = new MyDataSource()

  build() {
    List({ space: 8 }) {
      LazyForEach(this.dataSource, (item: DataItem) => {
        ListItem() {
          Row({ space: 12 }) {
            Text(item.id.toString())
              .width(40)
              .height(40)
              .fontSize(16)
              .fontColor(Color.White)
              .backgroundColor('#007DFF')
              .borderRadius(20)
              .textAlign(TextAlign.Center)

            Column({ space: 4 }) {
              Text(item.title)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')

              Text(item.description)
                .fontSize(14)
                .fontColor('#666666')
                .maxLines(2)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)
          }
          .width('100%')
          .padding(16)
          .backgroundColor(Color.White)
          .borderRadius(8)
        }
      }, (item: DataItem) => item.id.toString())
    }
    .width('100%')
    .height('100%')
    .cachedCount(5)
  }
}

class MyDataSource implements IDataSource {
  private data: DataItem[] = []
  private listeners: DataChangeListener[] = []

  constructor() {
    for (let i = 0; i < 1000; i++) {
      this.data.push({
        id: i,
        title: `Item ${i}`,
        description: `This is the description for item ${i}`
      })
    }
  }

  public totalCount(): number {
    return this.data.length
  }

  public getData(index: number): DataItem {
    return this.data[index]
  }

  public registerDataChangeListener(listener: DataChangeListener): void {
    this.listeners.push(listener)
  }

  public unregisterDataChangeListener(listener: DataChangeListener): void {
    const index = this.listeners.indexOf(listener)
    if (index >= 0) {
      this.listeners.splice(index, 1)
    }
  }
}

interface DataItem {
  id: number
  title: string
  description: string
}
```

## 三、最佳实践

### 3.1 性能优化

1. **使用 LazyForEach**: 对于大量数据（>100 项），使用 LazyForEach 而非 ForEach
2. **避免复杂嵌套**: ListItem 内部避免多层嵌套结构
3. **设置固定高度**: 给 ListItem 设置明确高度，提升渲染性能
4. **使用 cachedCount**: 设置合适的缓存数量（通常为可见数量的 1-2 倍）

### 3.2 布局建议

1. **宽度自适应**: ListItem 宽度通常设为 100%，由 List 控制
2. **内边距统一**: 使用 padding 而非 margin 设置内部间距
3. **圆角一致**: 多个 ListItem 使用相同的 borderRadius
4. **背景颜色**: 使用白色或浅灰色背景，提升可读性

### 3.3 交互设计

1. **点击反馈**: 使用 stateEffect 或 onClick 提供点击反馈
2. **滑动操作**: 使用 swipeAction 实现滑动删除等操作
3. **分隔线**: 使用 List 的 divider 属性而非 ListItem 的 margin

### 3.4 常见问题

**Q: ListItem 中的内容被截断？**
A: 确保设置了明确的 height 或使用自适应布局（如 Column 的 layoutWeight）

**Q: LazyForEach 不更新？**
A: 确保数据源实现了 IDataSource 接口，并正确调用 notifyDataReload

**Q: ListItem 点击无响应？**
A: 检查是否设置了 onClick 事件，或是否有其他组件遮挡

**Q: 吸附效果不生效？**
A: 确保 List 设置了 scroll 属性，且 sticky 模式正确

## 四、相关组件

- **List**: ListItem 的父容器
- **ListItemGroup**: ListItem 分组容器
- **LazyForEach**: 高性能数据渲染
- **ForEach**: 简单数据渲染
