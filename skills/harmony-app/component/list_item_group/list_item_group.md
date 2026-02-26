# ListItemGroup 组件 HarmonyOS 6.0 开发 Skill

## 概述

ListItemGroup 组件是 OpenHarmony 中用于对 List 的列表项进行分组的容器组件。它可以包含多个 ListItem 和其他子组件，并提供分组标题、分组间距等功能。

## 重要说明

- **基础组件**: ListItemGroup 是 ArkUI 的基础内置组件，无需导入
- **父组件要求**: 必须作为 List 的直接子组件
- **分组功能**: 支持设置分组标题、头部、尾部
- **嵌套支持**: 可包含 ListItem 和其他基础组件
- **吸附效果**: 支持分组标题吸附效果

## 模块信息

- **组件名称**: ListItemGroup
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [ListItemGroup - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-listitemgroup-V5)

## 一、API 参数

### 构造函数

```typescript
ListItemGroup(value?: { space?: number | string, header?: CustomBuilder, footer?: CustomBuilder })
```

| 参数 | 类型 | 必填 | 描述 |
|------|------|------|------|
| space | number \| string | 否 | 分组内列表项间距 |
| header | CustomBuilder | 否 | 分组头部 |
| footer | CustomBuilder | 否 | 分组尾部 |

### 样式属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| header | CustomBuilder | - | 设置分组头部 |
| footer | CustomBuilder | - | 设置分组尾部 |
| space | number \| string | 0 | 分组内列表项间距 |
| divider | DividerStyle | - | 分组分隔线样式 |

### ListItemGroup 样式

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| backgroundColor | ResourceColor | - | 背景颜色 |
| borderRadius | Length | - | 圆角半径 |
| borderWidth | Length | - | 边框宽度 |
| borderColor | ResourceColor | - | 边框颜色 |

## 二、使用示例

### 2.1 基础分组列表

```typescript
@ComponentV2
struct BasicListItemGroupExample {
  @Local groups: GroupData[] = [
    {
      title: 'Fruits',
      items: ['Apple', 'Banana', 'Orange', 'Grape']
    },
    {
      title: 'Vegetables',
      items: ['Carrot', 'Broccoli', 'Spinach', 'Tomato']
    },
    {
      title: 'Dairy',
      items: ['Milk', 'Cheese', 'Yogurt', 'Butter']
    }
  ]

  build() {
    List({ space: 16 }) {
      ForEach(this.groups, (group: GroupData) => {
        ListItemGroup({ header: this.groupHeader(group.title), space: 8 }) {
          ForEach(group.items, (item: string) => {
            ListItem() {
              Text(item)
                .width('100%')
                .height(50)
                .fontSize(16)
                .padding({ left: 16 })
                .backgroundColor(Color.White)
                .borderRadius(4)
            }
          })
        }
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
      })
    }
    .width('100%')
    .height(500)
    .padding({ left: 16, right: 16 })
  }

  @Builder groupHeader(title: string) {
    Text(title)
      .width('100%')
      .height(40)
      .fontSize(18)
      .fontWeight(FontWeight.Bold)
      .padding({ left: 12 })
      .backgroundColor('#E3F2FD')
      .fontColor('#007DFF')
  }
}

interface GroupData {
  title: string
  items: string[]
}
```

### 2.2 带头部和尾部的分组

```typescript
@ComponentV2
struct HeaderFooterListItemGroupExample {
  @Local sections: SectionData[] = [
    {
      title: 'Work Tasks',
      count: 5,
      items: [
        { name: 'Meeting', status: 'Pending' },
        { name: 'Code Review', status: 'In Progress' },
        { name: 'Documentation', status: 'Pending' }
      ],
      summary: '3 tasks shown'
    },
    {
      title: 'Personal Tasks',
      count: 8,
      items: [
        { name: 'Shopping', status: 'Pending' },
        { name: 'Exercise', status: 'Completed' }
      ],
      summary: '2 tasks shown'
    }
  ]

  build() {
    List({ space: 16 }) {
      ForEach(this.sections, (section: SectionData) => {
        ListItemGroup({
          header: this.sectionHeader(section.title, section.count),
          footer: this.sectionFooter(section.summary),
          space: 8
        }) {
          ForEach(section.items, (item: TaskItem) => {
            ListItem() {
              Row({ space: 12 }) {
                Text(item.name)
                  .fontSize(16)
                  .fontColor('#333333')
                  .layoutWeight(1)

                Text(item.status)
                  .fontSize(14)
                  .fontColor(this.getStatusColor(item.status))
                  .padding({ left: 12, right: 12, top: 4, bottom: 4 })
                  .backgroundColor(this.getStatusBgColor(item.status))
                  .borderRadius(12)
              }
              .width('100%')
              .padding(16)
              .backgroundColor(Color.White)
              .borderRadius(4)
            }
          })
        }
        .backgroundColor('#FAFAFA')
        .borderRadius(12)
      })
    }
    .width('100%')
    .height(600)
    .padding({ left: 16, right: 16 })
  }

  @Builder sectionHeader(title: string, count: number) {
    Row() {
      Text(title)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .layoutWeight(1)

      Text(count.toString())
        .fontSize(14)
        .fontColor('#007DFF')
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .backgroundColor('#E3F2FD')
        .borderRadius(12)
    }
    .width('100%')
    .height(50)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#FFFFFF')
    .borderRadius({ topLeft: 12, topRight: 12 })
  }

  @Builder sectionFooter(summary: string) {
    Text(summary)
      .width('100%')
      .height(40)
      .fontSize(14)
      .fontColor('#999999')
      .textAlign(TextAlign.Center)
      .backgroundColor('#F0F0F0')
      .borderRadius({ bottomLeft: 12, bottomRight: 12 })
  }

  private getStatusColor(status: string): string {
    return status === 'Completed' ? '#28A745' : status === 'In Progress' ? '#FFC107' : '#666666'
  }

  private getStatusBgColor(status: string): string {
    return status === 'Completed' ? '#E8F5E9' : status === 'In Progress' ? '#FFF8E1' : '#F5F5F5'
  }
}

interface SectionData {
  title: string
  count: number
  items: TaskItem[]
  summary: string
}

interface TaskItem {
  name: string
  status: string
}
```

### 2.3 可折叠分组列表

```typescript
@ComponentV2
struct CollapsibleListItemGroupExample {
  @Local expandedGroups: Set<string> = new Set()

  build() {
    List({ space: 16 }) {
      ForEach(this.getGroupData(), (group: CollapsibleGroup) => {
        ListItemGroup({
          header: this.collapsibleHeader(group),
          space: 8
        }) {
          if (this.expandedGroups.has(group.id)) {
            ForEach(group.items, (item: string) => {
              ListItem() {
                Text(item)
                  .width('100%')
                  .height(50)
                  .fontSize(16)
                  .padding({ left: 16 })
                  .backgroundColor(Color.White)
                  .borderRadius(4)
                  .onClick(() => {
                    console.info(`Clicked: ${item}`)
                  })
              }
            })
          }
        }
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
      })
    }
    .width('100%')
    .height(600)
    .padding({ left: 16, right: 16 })
  }

  @Builder collapsibleHeader(group: CollapsibleGroup) {
    Row() {
      Text(group.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#333333')
        .layoutWeight(1)

      Text(this.expandedGroups.has(group.id) ? '▼' : '▶')
        .fontSize(16)
        .fontColor('#666666')
    }
    .width('100%')
    .height(50)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#FFFFFF')
    .borderRadius(8)
    .onClick(() => {
      this.toggleGroup(group.id)
    })
  }

  private toggleGroup(groupId: string) {
    if (this.expandedGroups.has(groupId)) {
      this.expandedGroups.delete(groupId)
    } else {
      this.expandedGroups.add(groupId)
    }
    // 触发更新
    this.expandedGroups = new Set(this.expandedGroups)
  }

  private getGroupData(): CollapsibleGroup[] {
    return [
      {
        id: '1',
        title: '🔧 Settings',
        items: ['General', 'Display', 'Sound', 'Network']
      },
      {
        id: '2',
        title: '👤 Account',
        items: ['Profile', 'Security', 'Privacy', 'Notifications']
      },
      {
        id: '3',
        title: '💬 Support',
        items: ['Help Center', 'Contact Us', 'FAQ', 'Feedback']
      }
    ]
  }
}

interface CollapsibleGroup {
  id: string
  title: string
  items: string[]
}
```

### 2.4 吸附分组标题

```typescript
@ComponentV2
struct StickyListItemGroupExample {
  @Local contactData: ContactGroup[] = [
    {
      letter: 'A',
      contacts: ['Alice', 'Adam', 'Anna', 'Andrew']
    },
    {
      letter: 'B',
      contacts: ['Bob', 'Betty', 'Brian', 'Barbara']
    },
    {
      letter: 'C',
      contacts: ['Charlie', 'Cathy', 'Chris', 'Carol']
    },
    {
      letter: 'D',
      contacts: ['David', 'Diana', 'Daniel', 'Dorothy']
    }
  ]

  build() {
    List() {
      ForEach(this.contactData, (group: ContactGroup) => {
        // 分组标题（吸附）
        ListItem({ sticky: StickyMode.Opacity }) {
          Text(group.letter)
            .width('100%')
            .height(40)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .padding({ left: 16 })
            .backgroundColor('#E3F2FD')
            .fontColor('#007DFF')
        }

        // 分组内容
        ListItemGroup({ space: 1 }) {
          ForEach(group.contacts, (contact: string) => {
            ListItem() {
              Text(contact)
                .width('100%')
                .height(60)
                .fontSize(16)
                .padding({ left: 16 })
                .backgroundColor(Color.White)
                .onClick(() => {
                  console.info(`Contact: ${contact}`)
                })
            }
          })
        }
      })
    }
    .width('100%')
    .height('100%')
    .divider({ strokeWidth: 1, color: '#EEEEEE', startMargin: 16, endMargin: 16 })
  }
}

interface ContactGroup {
  letter: string
  contacts: string[]
}
```

### 2.5 分组分隔线样式

```typescript
@ComponentV2
struct StyledListItemGroupExample {
  build() {
    List({ space: 16 }) {
      ForEach(['Group 1', 'Group 2', 'Group 3'], (groupName: string, groupIndex: number) => {
        ListItemGroup({
          header: this.groupHeader(groupName),
          space: 0
        }) {
          ForEach([1, 2, 3], (item: number) => {
            ListItem() {
              Text(`Item ${item}`)
                .width('100%')
                .height(50)
                .fontSize(16)
                .padding({ left: 16 })
                .backgroundColor(Color.White)
            }
          })
        }
        .divider({
          strokeWidth: 2,
          color: groupIndex % 2 === 0 ? '#007DFF' : '#28A745',
          startMargin: 16,
          endMargin: 16
        })
        .backgroundColor('#F9F9F9')
        .borderRadius(8)
      })
    }
    .width('100%')
    .height(500)
    .padding({ left: 16, right: 16 })
  }

  @Builder groupHeader(name: string) {
    Text(name)
      .width('100%')
      .height(45)
      .fontSize(16)
      .fontWeight(FontWeight.Bold)
      .padding({ left: 16 })
      .backgroundColor('#FFFFFF')
      .fontColor('#333333')
  }
}
```

## 三、最佳实践

### 3.1 性能优化

1. **使用 LazyForEach**: 对于大量分组数据，使用 LazyForEach 渲染分组
2. **控制展开数量**: 可折叠分组中，限制同时展开的分组数量
3. **避免深层嵌套**: ListItemGroup 内避免多层嵌套组件
4. **合理使用 divider**: 使用 List 的 divider 属性而非 ListItemGroup 之间的 margin

### 3.2 布局建议

1. **头部高度统一**: 所有分组头部保持相同高度（通常 40-50vp）
2. **间距一致性**: 使用相同的 space 值和 padding
3. **圆角样式**: 分组圆角通常设为 8-12vp
4. **背景层次**: 使用不同背景色区分分组、头部、内容

### 3.3 交互设计

1. **头部点击**: 分组头部通常作为折叠/展开的触发区域
2. **吸附效果**: 使用 StickyMode.Opacity 实现平滑的吸附效果
3. **视觉反馈**: 使用 stateEffect 或颜色变化提供点击反馈

### 3.4 常见问题

**Q: ListItemGroup 的头部不显示？**
A: 确保使用 @Builder 装饰器定义头部，并在构造函数中传递

**Q: 分组内容不显示？**
A: 检查 ListItemGroup 内是否正确包含 ListItem 组件

**Q: 折叠动画不流畅？**
A: 避免在折叠状态切换时重新创建所有子组件，使用 if/else 控制显示

**Q: 吸附效果不生效？**
A: 吸附效果需要在 ListItem 上设置，而非 ListItemGroup，通常在分组标题的 ListItem 上

## 四、相关组件

- **List**: ListItemGroup 的父容器
- **ListItem**: 分组内的列表项
- **LazyForEach**: 高性能数据渲染
- **Divider**: 分组分隔线组件
