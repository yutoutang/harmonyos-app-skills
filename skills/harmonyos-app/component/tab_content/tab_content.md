# TabContent 组件 HarmonyOS 6.0 开发 Skill

## 概述

TabContent 组件是 OpenHarmony 中 Tabs 组件的子组件，用于定义标签页的具体内容。每个 TabContent 代表一个独立的标签页，必须配合 Tabs 父组件使用，并通过 tabBar 属性设置标签栏显示内容。

## 重要说明

- **子组件**: TabContent 必须作为 Tabs 的直接子组件使用
- **必需属性**: 必须设置 tabBar 属性来显示标签栏内容
- **内容容器**: TabContent 只能包含一个根组件
- **独立作用域**: 每个 TabContent 有独立的布局和样式

## 模块信息

- **组件名称**: TabContent
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [TabContent - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-tabcontent-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// TabContent 是内置组件，无需导入
// 必须作为 Tabs 的子组件使用
Tabs() {
  TabContent() {
    // 标签页内容
  }
  .tabBar('标签标题')
}
```

### 1.2 基础用法

```typescript
// 简单的文本标签
Tabs() {
  TabContent() {
    Text('首页内容')
  }
  .tabBar('首页')

  TabContent() {
    Text('发现内容')
  }
  .tabBar('发现')
}

// 使用自定义构建函数
Tabs() {
  TabContent() {
    Text('首页内容')
  }
  .tabBar(this.customTabBuilder('首页'))
}
```

## 二、API 参数

### 2.1 构造参数

TabContent 没有必需的构造参数。

### 2.2 TabContent 属性

| 属性 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| `tabBar` | `string \| Resource \| CustomBuilder` | 是 | - | 标签栏内容 |
| `icon` | `string \| Resource` | 否 | - | 标签图标（已废弃，使用 tabBar 替代） |

### 2.3 tabBar 参数类型

#### 字符串类型

```typescript
.tabBar('首页')
```

#### 资源引用类型

```typescript
.tabBar($r('app.string.tab_home'))
```

#### 自定义构建函数类型

```typescript
.tabBar(this.customTabBuilder('首页', 0))

@Builder
customTabBuilder(title: string, index: number) {
  Column() {
    Text(title)
  }
}
```

## 三、使用示例

### 3.1 文本标签示例

```typescript
@ComponentV2
struct TextTabBarExample {
  build() {
    Tabs() {
      TabContent() {
        Column() {
          Text('首页内容')
            .fontSize(24)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .tabBar('首页')

      TabContent() {
        Column() {
          Text('发现内容')
            .fontSize(24)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .tabBar('发现')

      TabContent() {
        Column() {
          Text('我的内容')
            .fontSize(24)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .tabBar('我的')
    }
    .width('100%')
    .height('100%')
  }
}
```

### 3.2 图标标签示例

```typescript
@ComponentV2
struct IconTabBarExample {
  @Local currentIndex: number = 0

  build() {
    Tabs({ index: this.currentIndex }) {
      TabContent() {
        Column() {
          Text('首页')
            .fontSize(24)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .tabBar(this.iconTabBuilder('首页', 0, '\uE100'))

      TabContent() {
        Column() {
          Text('发现')
            .fontSize(24)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .tabBar(this.iconTabBuilder('发现', 1, '\uE101'))

      TabContent() {
        Column() {
          Text('我的')
            .fontSize(24)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .tabBar(this.iconTabBuilder('我的', 2, '\uE102'))
    }
    .width('100%')
    .height('100%')
    .onChange((index: number) => {
      this.currentIndex = index
    })
  }

  @Builder
  iconTabBuilder(title: string, index: number, icon: string) {
    Column({ space: 4 }) {
      Text(icon)
        .fontSize(24)
        .fontColor(this.currentIndex === index ? '#007DFF' : '#999999')

      Text(title)
        .fontSize(12)
        .fontColor(this.currentIndex === index ? '#007DFF' : '#999999')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}
```

### 3.3 带角标的标签示例

```typescript
@ComponentV2
struct BadgeTabBarExample {
  @Local currentIndex: number = 0

  build() {
    Tabs({ index: this.currentIndex }) {
      TabContent() {
        Column() {
          Text('消息')
            .fontSize(24)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .tabBar(this.badgeTabBuilder('消息', 0, 5))

      TabContent() {
        Column() {
          Text('联系人')
            .fontSize(24)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .tabBar(this.badgeTabBuilder('联系人', 1, 0))

      TabContent() {
        Column() {
          Text('动态')
            .fontSize(24)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .tabBar(this.badgeTabBuilder('动态', 2, 99))
    }
    .width('100%')
    .height('100%')
    .onChange((index: number) => {
      this.currentIndex = index
    })
  }

  @Builder
  badgeTabBuilder(title: string, index: number, count: number) {
    Row({ space: 8 }) {
      Text(title)
        .fontSize(16)
        .fontColor(this.currentIndex === index ? '#007DFF' : '#666666')

      if (count > 0) {
        Text(count > 99 ? '99+' : count.toString())
          .fontSize(10)
          .fontColor(Color.White)
          .backgroundColor('#FF0000')
          .borderRadius(10)
          .padding({ left: 4, right: 4, top: 2, bottom: 2 })
      }
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}
```

### 3.4 复杂布局标签页示例

```typescript
@ComponentV2
struct ComplexTabContentExample {
  @Local dataList: string[] = ['项目1', '项目2', '项目3', '项目4', '项目5']

  build() {
    Tabs() {
      // 列表标签页
      TabContent() {
        Column() {
          ForEach(this.dataList, (item: string) => {
            Text(item)
              .fontSize(16)
              .width('100%')
              .padding(16)
              .backgroundColor('#FFFFFF')
              .borderRadius(8)
              .margin({ bottom: 8 })
          })
        }
        .width('100%')
        .height('100%')
        .padding(16)
        .backgroundColor('#F5F5F5')
      }
      .tabBar('列表')

      // 网格标签页
      TabContent() {
        Grid() {
          ForEach([1, 2, 3, 4, 5, 6], (item: number) => {
            GridItem() {
              Text(`项目${item}`)
                .fontSize(16)
                .width('100%')
                .height(100)
                .backgroundColor('#007DFF')
                .fontColor(Color.White)
                .textAlign(TextAlign.Center)
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(8)
        .rowsGap(8)
        .width('100%')
        .height('100%')
        .padding(16)
      }
      .tabBar('网格')

      // 表单标签页
      TabContent() {
        Column({ space: 16 }) {
          TextInput({ placeholder: '请输入用户名' })
          TextInput({ placeholder: '请输入密码' })
            .type(InputType.Password)
          Button('提交')
            .width('100%')
        }
        .width('100%')
        .height('100%')
        .padding(16)
        .justifyContent(FlexAlign.Center)
      }
      .tabBar('表单')
    }
    .width('100%')
    .height('100%')
  }
}
```

### 3.5 使用资源引用示例

```typescript
@ComponentV2
struct ResourceTabBarExample {
  build() {
    Tabs() {
      TabContent() {
        Column() {
          Text($r('app.string.tab_home_content'))
            .fontSize(24)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .tabBar($r('app.string.tab_home'))

      TabContent() {
        Column() {
          Text($r('app.string.tab_discover_content'))
            .fontSize(24)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .tabBar($r('app.string.tab_discover'))
    }
    .width('100%')
    .height('100%')
  }
}
```

## 四、高级用法

### 4.1 条件渲染标签页

```typescript
@ComponentV2
struct ConditionalTabContentExample {
  @Local isLoggedIn: boolean = false

  build() {
    Tabs() {
      TabContent() {
        Text('首页')
          .fontSize(24)
      }
      .tabBar('首页')

      // 条件显示的标签页
      if (this.isLoggedIn) {
        TabContent() {
          Text('个人中心')
            .fontSize(24)
        }
        .tabBar('个人中心')
      }

      TabContent() {
        Text('设置')
          .fontSize(24)
      }
      .tabBar('设置')
    }
    .width('100%')
    .height('100%')
  }
}
```

### 4.2 动态标签页

```typescript
@ComponentV2
struct DynamicTabContentExample {
  @Local tabs: Array<{ title: string, content: string }> = [
    { title: '标签1', content: '内容1' },
    { title: '标签2', content: '内容2' },
    { title: '标签3', content: '内容3' }
  ]

  build() {
    Column() {
      Tabs() {
        ForEach(this.tabs, (tab: { title: string, content: string }, index: number) => {
          TabContent() {
            Column() {
              Text(tab.content)
                .fontSize(24)
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
          }
          .tabBar(tab.title)
        }, (tab: { title: string, content: string }, index: number) => index.toString())
      }
      .width('100%')
      .layoutWeight(1)

      Button('添加标签')
        .onClick(() => {
          const newIndex = this.tabs.length + 1
          this.tabs.push({ title: `标签${newIndex}`, content: `内容${newIndex}` })
        })
    }
    .width('100%')
    .height('100%')
  }
}
```

### 4.3 嵌套滚动标签页

```typescript
@ComponentV2
struct NestedScrollTabContentExample {
  @Local items: string[] = []

  aboutToAppear() {
    // 初始化数据
    for (let i = 0; i < 50; i++) {
      this.items.push(`项目 ${i + 1}`)
    }
  }

  build() {
    Tabs() {
      TabContent() {
        List({ space: 8 }) {
          ForEach(this.items, (item: string) => {
            ListItem() {
              Text(item)
                .fontSize(16)
                .width('100%')
                .padding(16)
                .backgroundColor('#FFFFFF')
                .borderRadius(8)
            }
          })
        }
        .width('100%')
        .height('100%')
        .padding(16)
      }
      .tabBar('列表')

      TabContent() {
        Scroll() {
          Column({ space: 16 }) {
            ForEach(this.items, (item: string) => {
              Text(item)
                .fontSize(16)
                .width('100%')
                .padding(16)
                .backgroundColor('#FFFFFF')
                .borderRadius(8)
            })
          }
          .width('100%')
          .padding(16)
        }
        .width('100%')
        .height('100%')
        .scrollBar(BarState.Auto)
      }
      .tabBar('滚动')
    }
    .width('100%')
    .height('100%')
  }
}
```

## 五、最佳实践

### 5.1 内容布局

```typescript
// ✅ 推荐：使用 Column 作为根容器
TabContent() {
  Column() {
    // 内容
  }
  .width('100%')
  .height('100%')
  .justifyContent(FlexAlign.Center)
}
.tabBar('标签')

// ❌ 避免：直接放置多个组件（会报错）
TabContent() {
  Text('标题')
  Text('内容') // 错误：只能有一个根组件
}
```

### 5.2 标签设计

```typescript
// ✅ 推荐：使用自定义 Builder 实现复杂标签
TabContent() {
  // 内容
}
.tabBar(this.customTabBuilder('首页', 0))

@Builder
customTabBuilder(title: string, index: number) {
  Column() {
    Text(title)
  }
}

// ❌ 避免：标签内容过于复杂
TabContent() {
  // 内容
}
.tabBar('非常非常非常长的标签标题') // 可能显示不全
```

### 5.3 性能优化

```typescript
// ✅ 推荐：使用 keyGenerator
ForEach(items, (item: Item, index: number) => {
  TabContent() {
    // 内容
  }
  .tabBar(item.title)
}, (item: Item) => item.id)
```

## 六、常见问题

### Q1: TabContent 只能有一个子组件？

**是的**，每个 TabContent 只能包含一个根组件。如果需要多个组件，使用 Column、Row 等容器包裹。

**解决方案**:
```typescript
// ✅ 正确：使用 Column 包裹多个组件
TabContent() {
  Column() {
    Text('标题')
    Text('内容')
    Button('按钮')
  }
}
.tabBar('标签')
```

### Q2: tabBar 不显示？

**问题**: 设置了 tabBar 但标签栏不显示。

**解决方案**:
```typescript
// 确保 tabBar 属性已设置
TabContent() {
  Text('内容')
}
.tabBar('标签') // 必须设置
```

### Q3: 如何实现带角标的标签？

**解决方案**:
```typescript
TabContent() {
  Text('内容')
}
.tabBar(this.badgeTabBuilder('消息', 5))

@Builder
badgeTabBuilder(title: string, count: number) {
  Stack({ alignContent: Alignment.TopEnd }) {
    Text(title)
    if (count > 0) {
      Text(count.toString())
        .fontSize(10)
        .backgroundColor('#FF0000')
        .borderRadius(10)
    }
  }
}
```

### Q4: TabContent 内容可以滚动吗？

**可以**，TabContent 内部可以包含 List、Scroll、Grid 等可滚动组件。

**示例**:
```typescript
TabContent() {
  List() {
    // 列表项
  }
}
.tabBar('列表')
```

### Q5: 如何动态添加/删除 TabContent？

**解决方案**:
```typescript
@ComponentV2
struct DynamicTabs {
  @Local tabs: string[] = ['标签1', '标签2', '标签3']

  build() {
    Tabs() {
      ForEach(this.tabs, (tab: string, index: number) => {
        TabContent() {
          Text(tab + ' 内容')
        }
        .tabBar(tab)
      }, (tab: string, index: number) => index.toString())
    }
  }
}
```

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 9+ | ✅ | 完全支持 |
| API 10+ | ✅ | 增强了自定义能力 |
| API 12+ | ✅ | 性能优化 |

## 八、参考资料

- [TabContent 组件 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-tabcontent-V5)
- [Tabs 组件 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-tabs-V5)
