# Repeat 组件 HarmonyOS 6.0 开发 Skill

## 概述

Repeat 组件是 OpenHarmony 中用于根据数组数据重复渲染子组件的容器组件。它与 ForEach 类似，但提供了更灵活的渲染控制和更好的性能优化机制。Repeat 组件适用于需要根据数据源生成多个相同或相似组件结构的场景。

## 重要说明

- **数据驱动**: Repeat 是数据驱动的组件，根据数组数据自动生成子组件
- **key 值**: 必须提供唯一的 key 值以优化渲染性能
- **性能优化**: 相比 ForEach，Repeat 提供了更细粒度的更新控制
- **子组件限制**: 只能包含一个子组件，通常配合容器组件使用
- **使用场景**: 适合中规模数据列表（10-1000 项）

## 模块信息

- **组件名称**: Repeat
- **SDK 版本**: HarmonyOS 6.0 (API 9+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [Repeat 重复渲染 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-repeat-V5)

## 一、组件基础

### 1.1 基本语法

```typescript
Repeat(value: RepeatItem[])
  .itemIdGenerator((item: RepeatItem, index: number) => {
    return item.id  // 返回唯一 key
  })
  .each((item: RepeatItem, index: number) => {
    // 渲染每个子组件
    ListItem() {
      Text(item.name)
    }
  })
```

### 1.2 与 ForEach 的区别

| 特性 | Repeat | ForEach |
|------|--------|---------|
| **性能优化** | 更细粒度的更新控制 | 基础的虚拟 DOM diff |
| **key 管理** | 必须显式提供 itemIdGenerator | 可选 keyGenerator |
| **使用复杂度** | 较复杂，需要更多配置 | 简单，开箱即用 |
| **适用场景** | 中大规模数据列表（10-1000项） | 小规模数据列表（<100项） |
| **灵活性** | 更高的渲染控制能力 | 简化的渲染逻辑 |
| **状态管理** | 更好的组件状态保持 | 基础状态管理 |

### 1.3 基础用法

```typescript
@ObservedV2
class RepeatItem {
  id: string = ''
  name: string = ''
  constructor(id: string, name: string) {
    this.id = id
    this.name = name
  }
}

@ComponentV2
struct BasicRepeatExample {
  @Local items: RepeatItem[] = []

  aboutToAppear() {
    // 初始化数据
    this.items = [
      new RepeatItem('1', 'Item 1'),
      new RepeatItem('2', 'Item 2'),
      new RepeatItem('3', 'Item 3'),
      new RepeatItem('4', 'Item 4'),
      new RepeatItem('5', 'Item 5')
    ]
  }

  build() {
    Column() {
      Text('Repeat 基础示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Repeat(this.items)
        .itemIdGenerator((item: RepeatItem, index: number) => {
          return item.id  // 使用 item.id 作为唯一 key
        })
        .each((item: RepeatItem, index: number) => {
          Row() {
            Text(`Index: ${index}`)
              .fontSize(14)
              .fontColor('#666666')
              .width(60)

            Text(item.name)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)

            Blank()

            Text(`ID: ${item.id}`)
              .fontSize(12)
              .fontColor('#999999')
          }
          .width('100%')
          .height(60)
          .padding({ left: 16, right: 16 })
          .backgroundColor('#F5F5F5')
          .borderRadius(8)
          .margin({ bottom: 8 })
        })
    }
    .width('100%')
    .padding(16)
  }
}
```

## 二、API 参数

### 2.1 构造函数

```typescript
Repeat(value: T[])
```

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| value | `T[]` | 是 | - | 要重复渲染的数据数组 |

### 2.2 itemIdGenerator 方法

```typescript
.itemIdGenerator((item: T, index: number) => string)
```

| 参数 | 类型 | 描述 |
|------|------|------|
| item | `T` | 当前数据项 |
| index | `number` | 当前索引 |
| **返回值** | `string` | 唯一标识符，用于性能优化 |

**重要**: key 必须唯一且稳定，避免使用 index 作为 key

### 2.3 each 方法

```typescript
.each((item: T, index: number) => void)
```

| 参数 | 类型 | 描述 |
|------|------|------|
| item | `T` | 当前数据项 |
| index | `number` | 当前索引 |

**说明**: each 方法的回调函数中必须包含一个子组件

## 三、使用示例

### 3.1 简单列表示例

```typescript
@ObservedV2
class User {
  id: string = ''
  name: string = ''
  avatar: string = ''
  constructor(id: string, name: string, avatar: string) {
    this.id = id
    this.name = name
    this.avatar = avatar
  }
}

@ComponentV2
struct SimpleListExample {
  @Local users: User[] = []

  aboutToAppear() {
    this.users = [
      new User('1', '张三', 'avatar1.png'),
      new User('2', '李四', 'avatar2.png'),
      new User('3', '王五', 'avatar3.png')
    ]
  }

  build() {
    Column({ space: 8 }) {
      Repeat(this.users)
        .itemIdGenerator((user: User, index: number) => user.id)
        .each((user: User, index: number) => {
          Row({ space: 12 }) {
            // 头像
            Circle()
              .width(40)
              .height(40)
              .fill('#E3F2FD')

            // 用户信息
            Column({ space: 4 }) {
              Text(user.name)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
              Text(`ID: ${user.id}`)
                .fontSize(12)
                .fontColor('#999999')
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Text('>')
              .fontSize(20)
              .fontColor('#CCCCCC')
          }
          .width('100%')
          .height(70)
          .padding({ left: 16, right: 16 })
          .backgroundColor('#FFFFFF')
          .borderRadius(8)
          .shadow({
            radius: 4,
            color: 'rgba(0, 0, 0, 0.1)',
            offsetX: 0,
            offsetY: 2
          })
        })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.2 网格布局示例

```typescript
@ObservedV2
class Product {
  id: string = ''
  name: string = ''
  price: number = 0
  constructor(id: string, name: string, price: number) {
    this.id = id
    this.name = name
    this.price = price
  }
}

@ComponentV2
struct GridRepeatExample {
  @Local products: Product[] = []

  aboutToAppear() {
    this.products = [
      new Product('1', '商品 A', 99),
      new Product('2', '商品 B', 199),
      new Product('3', '商品 C', 299),
      new Product('4', '商品 D', 399),
      new Product('5', '商品 E', 499),
      new Product('6', '商品 F', 599)
    ]
  }

  build() {
    Column({ space: 12 }) {
      Text('商品列表')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      // 使用 Flex 实现网格布局
      Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
        Repeat(this.products)
          .itemIdGenerator((product: Product) => product.id)
          .each((product: Product) => {
            Column({ space: 8 }) {
              // 商品图片占位
              Rect()
                .width('100%')
                .height(120)
                .fill('#E3F2FD')
                .borderRadius({ topLeft: 8, topRight: 8 })

              // 商品信息
              Column({ space: 4 }) {
                Text(product.name)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })

                Text(`¥${product.price}`)
                  .fontSize(16)
                  .fontColor('#FF0000')
                  .fontWeight(FontWeight.Bold)
              }
              .alignItems(HorizontalAlign.Start)
              .padding(12)
            }
            .width('48%')
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
            .shadow({
              radius: 4,
              color: 'rgba(0, 0, 0, 0.1)',
              offsetX: 0,
              offsetY: 2
            })
          })
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.3 嵌套列表示例

```typescript
@ObservedV2
class Category {
  id: string = ''
  name: string = ''
  items: string[] = []
  constructor(id: string, name: string, items: string[]) {
    this.id = id
    this.name = name
    this.items = items
  }
}

@ComponentV2
struct NestedRepeatExample {
  @Local categories: Category[] = []

  aboutToAppear() {
    this.categories = [
      new Category('1', '水果', ['苹果', '香蕉', '橙子']),
      new Category('2', '蔬菜', ['西红柿', '黄瓜', '青菜']),
      new Category('3', '肉类', ['猪肉', '牛肉', '鸡肉'])
    ]
  }

  build() {
    Column({ space: 16 }) {
      Text('分类列表')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      // 外层 Repeat 渲染分类
      Repeat(this.categories)
        .itemIdGenerator((category: Category) => category.id)
        .each((category: Category) => {
          Column({ space: 8 }) {
            // 分类标题
            Row() {
              Text(category.name)
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
            }
            .width('100%')
            .padding({ left: 12, right: 12, top: 8, bottom: 8 })
            .backgroundColor('#F5F5F5')
            .borderRadius({ topLeft: 8, topRight: 8 })

            // 内层 ForEach 渲染子项
            Column() {
              ForEach(category.items, (item: string, index: number) => {
                Row() {
                  Text(item)
                    .fontSize(14)
                }
                .width('100%')
                .height(44)
                .padding({ left: 24, right: 12 })
                .backgroundColor('#FFFFFF')
                .border({ width: { bottom: 1 }, color: '#F0F0F0' })
              })
            }
            .borderRadius({ bottomLeft: 8, bottomRight: 8 })
            .clip(true)
          }
          .width('100%')
        })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.4 可交互列表示例

```typescript
@ObservedV2
class TodoItem {
  id: string = ''
  title: string = ''
  completed: boolean = false
  constructor(id: string, title: string, completed: boolean = false) {
    this.id = id
    this.title = title
    this.completed = completed
  }
}

@ComponentV2
struct InteractiveRepeatExample {
  @Local todos: TodoItem[] = []

  aboutToAppear() {
    this.todos = [
      new TodoItem('1', '完成 HarmonyOS 6.0 组件文档', true),
      new TodoItem('2', '编写 Repeat 组件示例', false),
      new TodoItem('3', '编写 ContainerSpan 组件示例', false),
      new TodoItem('4', '测试所有组件功能', false)
    ]
  }

  toggleTodo(id: string) {
    const todo = this.todos.find(item => item.id === id)
    if (todo) {
      todo.completed = !todo.completed
    }
  }

  deleteTodo(id: string) {
    this.todos = this.todos.filter(item => item.id !== id)
  }

  build() {
    Column({ space: 16 }) {
      Text('待办事项')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Repeat(this.todos)
        .itemIdGenerator((todo: TodoItem) => todo.id)
        .each((todo: TodoItem) => {
          Row({ space: 12 }) {
            // 复选框
            Circle()
              .width(24)
              .height(24)
              .fill(todo.completed ? '#007DFF' : '#FFFFFF')
              .border({
                width: 2,
                color: todo.completed ? '#007DFF' : '#CCCCCC'
              })
              .onClick(() => {
                this.toggleTodo(todo.id)
              })

            // 标题
            Text(todo.title)
              .fontSize(16)
              .fontColor(todo.completed ? '#999999' : '#333333')
              .decoration({
                type: todo.completed ? TextDecorationType.LineThrough : TextDecorationType.None
              })
              .layoutWeight(1)

            // 删除按钮
            Text('×')
              .fontSize(24)
              .fontColor('#FF0000')
              .onClick(() => {
                this.deleteTodo(todo.id)
              })
          }
          .width('100%')
          .height(60)
          .padding({ left: 16, right: 16 })
          .backgroundColor('#FFFFFF')
          .borderRadius(8)
          .shadow({
            radius: 4,
            color: 'rgba(0, 0, 0, 0.1)',
            offsetX: 0,
            offsetY: 2
          })
        })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.5 条件渲染示例

```typescript
@ObservedV2
class Message {
  id: string = ''
  content: string = ''
  type: 'text' | 'image' | 'audio' = 'text'
  timestamp: string = ''
  constructor(id: string, content: string, type: 'text' | 'image' | 'audio', timestamp: string) {
    this.id = id
    this.content = content
    this.type = type
    this.timestamp = timestamp
  }
}

@ComponentV2
struct ConditionalRepeatExample {
  @Local messages: Message[] = []

  aboutToAppear() {
    this.messages = [
      new Message('1', '你好！', 'text', '10:00'),
      new Message('2', 'image.png', 'image', '10:01'),
      new Message('3', 'audio.mp3', 'audio', '10:02'),
      new Message('4', '再见！', 'text', '10:03')
    ]
  }

  build() {
    Column({ space: 12 }) {
      Text('消息列表')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Repeat(this.messages)
        .itemIdGenerator((message: Message) => message.id)
        .each((message: Message) => {
          Row({ space: 8 }) {
            // 根据类型显示不同的图标
            if (message.type === 'text') {
              Text('T')
                .fontSize(16)
                .fontColor('#FFFFFF')
                .width(32)
                .height(32)
                .textAlign(TextAlign.Center)
                .backgroundColor('#007DFF')
                .borderRadius(16)
            } else if (message.type === 'image') {
              Text('I')
                .fontSize(16)
                .fontColor('#FFFFFF')
                .width(32)
                .height(32)
                .textAlign(TextAlign.Center)
                .backgroundColor('#28A745')
                .borderRadius(16)
            } else if (message.type === 'audio') {
              Text('A')
                .fontSize(16)
                .fontColor('#FFFFFF')
                .width(32)
                .height(32)
                .textAlign(TextAlign.Center)
                .backgroundColor('#FFC107')
                .borderRadius(16)
            }

            // 消息内容
            Column({ space: 4 }) {
              if (message.type === 'text') {
                Text(message.content)
                  .fontSize(14)
                  .fontColor('#333333')
              } else {
                Text(`[${message.type}] ${message.content}`)
                  .fontSize(14)
                  .fontColor('#666666')
              }

              Text(message.timestamp)
                .fontSize(12)
                .fontColor('#999999')
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)
          }
          .width('100%')
          .padding(12)
          .backgroundColor('#FFFFFF')
          .borderRadius(8)
        })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.6 动态更新示例

```typescript
@ObservedV2
class CounterItem {
  id: string = ''
  value: number = 0
  constructor(id: string, value: number) {
    this.id = id
    this.value = value
  }
}

@ComponentV2
struct DynamicUpdateExample {
  @Local items: CounterItem[] = []

  aboutToAppear() {
    this.items = [
      new CounterItem('1', 0),
      new CounterItem('2', 0),
      new CounterItem('3', 0)
    ]
  }

  increment(id: string) {
    const item = this.items.find(i => i.id === id)
    if (item) {
      item.value++
    }
  }

  decrement(id: string) {
    const item = this.items.find(i => i.id === id)
    if (item && item.value > 0) {
      item.value--
    }
  }

  addItem() {
    const newId = (this.items.length + 1).toString()
    this.items.push(new CounterItem(newId, 0))
  }

  removeItem(id: string) {
    this.items = this.items.filter(item => item.id !== id)
  }

  build() {
    Column({ space: 16 }) {
      Text('动态计数器')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      // 操作按钮
      Row({ space: 12 }) {
        Button('添加项目')
          .fontSize(14)
          .onClick(() => {
            this.addItem()
          })

        Button('删除第一个')
          .fontSize(14)
          .onClick(() => {
            if (this.items.length > 0) {
              this.removeItem(this.items[0].id)
            }
          })
      }
      .width('100%')

      // Repeat 渲染列表
      Repeat(this.items)
        .itemIdGenerator((item: CounterItem) => item.id)
        .each((item: CounterItem) => {
          Row({ space: 12 }) {
            Button('-')
              .width(40)
              .height(40)
              .fontSize(20)
              .onClick(() => {
                this.decrement(item.id)
              })

            Text(item.value.toString())
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .width(60)
              .textAlign(TextAlign.Center)

            Button('+')
              .width(40)
              .height(40)
              .fontSize(20)
              .onClick(() => {
                this.increment(item.id)
              })

            Blank()

            Text(`ID: ${item.id}`)
              .fontSize(12)
              .fontColor('#999999')
          }
          .width('100%')
          .height(60)
          .padding({ left: 16, right: 16 })
          .backgroundColor('#FFFFFF')
          .borderRadius(8)
          .shadow({
            radius: 4,
            color: 'rgba(0, 0, 0, 0.1)',
            offsetX: 0,
            offsetY: 2
          })
        })
    }
    .width('100%')
    .padding(16)
  }
}
```

## 四、最佳实践

### 4.1 Key 值管理

```typescript
// ✅ 推荐：使用唯一且稳定的 ID
Repeat(this.items)
  .itemIdGenerator((item: ItemType) => {
    return item.id  // item.id 应该是唯一且不变的
  })
  .each((item: ItemType) => {
    // 渲染子组件
  })

// ❌ 避免：使用 index 作为 key
Repeat(this.items)
  .itemIdGenerator((item: ItemType, index: number) => {
    return index.toString()  // 当列表顺序变化时会有问题
  })
  .each((item: ItemType) => {
    // 渲染子组件
  })

// ❌ 避免：使用随机值作为 key
Repeat(this.items)
  .itemIdGenerator((item: ItemType) => {
    return Math.random().toString()  // 每次渲染都会变化
  })
  .each((item: ItemType) => {
    // 渲染子组件
  })
```

### 4.2 性能优化

```typescript
// ✅ 推荐：避免复杂的计算
@ComponentV2
struct OptimizedRepeat {
  @Local items: Item[] = []
  @Local computedValues: Map<string, string> = new Map()

  aboutToAppear() {
    // 预先计算所有值
    this.items.forEach(item => {
      this.computedValues.set(item.id, this.computeValue(item))
    })
  }

  getComputedValue(id: string): string {
    return this.computedValues.get(id) || ''
  }

  build() {
    Repeat(this.items)
      .itemIdGenerator((item: Item) => item.id)
      .each((item: Item) => {
        Text(this.getComputedValue(item.id))  // 使用预计算的值
      })
  }
}

// ❌ 避免：在渲染时进行复杂计算
@ComponentV2
struct UnoptimizedRepeat {
  @Local items: Item[] = []

  build() {
    Repeat(this.items)
      .itemIdGenerator((item: Item) => item.id)
      .each((item: Item) => {
        Text(this.computeComplexValue(item))  // 每次都重新计算
      })
  }
}
```

### 4.3 数据模型设计

```typescript
// ✅ 推荐：使用 @ObservedV2 装饰的类
@ObservedV2
class TodoItem {
  id: string = ''
  title: string = ''
  completed: boolean = false

  constructor(id: string, title: string) {
    this.id = id
    this.title = title
    this.completed = false
  }
}

@ComponentV2
struct TodoList {
  @Local todos: TodoItem[] = []

  build() {
    Repeat(this.todos)
      .itemIdGenerator((todo: TodoItem) => todo.id)
      .each((todo: TodoItem) => {
        // 渲染组件
      })
  }
}

// ❌ 避免：使用普通对象
@ComponentV2
struct BadTodoList {
  @Local todos: Array<{ id: string, title: string, completed: boolean }> = []

  build() {
    Repeat(this.todos)
      .itemIdGenerator((todo) => todo.id)
      .each((todo) => {
        // 对象属性变化不会触发更新
      })
  }
}
```

### 4.4 组件复用

```typescript
// ✅ 推荐：提取可复用的子组件
@ComponentV2
struct TodoItemCard {
  @Param todo: TodoItem = new TodoItem('', '')
  @Event onToggle: (id: string) => void = () => {}
  @Event onDelete: (id: string) => void = () => {}

  build() {
    Row({ space: 12 }) {
      // 复选框
      Circle()
        .width(24)
        .height(24)
        .fill(this.todo.completed ? '#007DFF' : '#FFFFFF')
        .onClick(() => {
          this.onToggle(this.todo.id)
        })

      // 标题
      Text(this.todo.title)
        .fontSize(16)
        .layoutWeight(1)

      // 删除按钮
      Button('删除')
        .onClick(() => {
          this.onDelete(this.todo.id)
        })
    }
  }
}

@ComponentV2
struct TodoList {
  @Local todos: TodoItem[] = []

  build() {
    Column() {
      Repeat(this.todos)
        .itemIdGenerator((todo: TodoItem) => todo.id)
        .each((todo: TodoItem) => {
          TodoItemCard({
            todo: todo,
            onToggle: (id: string) => this.toggleTodo(id),
            onDelete: (id: string) => this.deleteTodo(id)
          })
        })
    }
  }
}
```

## 五、常见问题

### Q1: Repeat 和 ForEach 应该选择哪个？

**答**:
- **选择 Repeat**:
  - 中大规模数据列表（10-1000 项）
  - 需要更细粒度的更新控制
  - 数据项有唯一稳定的 ID
  - 需要更好的性能优化

- **选择 ForEach**:
  - 小规模数据列表（<100 项）
  - 简单的渲染逻辑
  - 快速原型开发
  - 不需要复杂的性能优化

### Q2: Repeat 不显示内容？

**解决方案**:
```typescript
// 检查数据是否为空
@ComponentV2
struct MyComponent {
  @Local items: Item[] = []

  build() {
    Column() {
      if (this.items.length === 0) {
        Text('暂无数据')
      } else {
        Repeat(this.items)
          .itemIdGenerator((item: Item) => item.id)
          .each((item: Item) => {
            // 渲染子组件
          })
      }
    }
  }
}
```

### Q3: 如何在 Repeat 中实现动画效果？

**解决方案**:
```typescript
@ComponentV2
struct AnimatedRepeatItem {
  @Param item: Item = new Item()
  @Local scale: number = 1

  build() {
    Row()
      .scale({ x: this.scale, y: this.scale })
      .animation({
        duration: 300,
        curve: Curve.EaseInOut
      })
      .onClick(() => {
        this.scale = this.scale === 1 ? 1.1 : 1
      })
  }
}
```

### Q4: Repeat 性能问题如何优化？

**优化策略**:
```typescript
// 1. 使用虚拟化列表（List + LazyForEach）
// 对于超大数据集（1000+ 项），使用 List 代替 Repeat

// 2. 避免深层嵌套
// ❌ 避免
Repeat(items) {
  Repeat(subItems) {
    Repeat(deepItems) {
      // 深层嵌套影响性能
    }
  }
}

// 3. 优化子组件
// 提取可复用的轻量级组件

// 4. 懒加载
// 按需加载数据，避免一次性加载过多
```

### Q5: 如何实现无限滚动？

**解决方案**:
```typescript
@ComponentV2
struct InfiniteScrollRepeat {
  @Local items: Item[] = []
  @Local loading: boolean = false
  private page: number = 1

  loadMore() {
    if (this.loading) return

    this.loading = true
    // 模拟异步加载
    setTimeout(() => {
      const newItems = this.fetchData(this.page)
      this.items = [...this.items, ...newItems]
      this.page++
      this.loading = false
    }, 1000)
  }

  fetchData(page: number): Item[] {
    // 模拟数据获取
    return Array.from({ length: 20 }, (_, i) => ({
      id: `item-${page}-${i}`,
      name: `Item ${page}-${i}`
    }))
  }

  build() {
    Scroll() {
      Column() {
        Repeat(this.items)
          .itemIdGenerator((item: Item) => item.id)
          .each((item: Item) => {
            Text(item.name)
              .width('100%')
              .height(60)
          })

        if (this.loading) {
          LoadingProgress()
            .width(40)
            .height(40)
        }
      }
      .onReachEnd(() => {
        this.loadMore()
      })
    }
  }
}
```

## 六、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 9+ | ✅ | 完全支持 |
| API 10+ | ✅ | 性能优化 |
| API 11+ | ✅ | 增强功能 |
| API 12+ | ✅ | 更多自定义选项 |

## 七、参考资料

- [Repeat 重复渲染 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-repeat-V5)
- [ForEach 循环渲染 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-foreach-V5)
- [List 列表 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-list-V5)
- [LazyForEach 数据懒加载 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-lazyforeach-V5)
