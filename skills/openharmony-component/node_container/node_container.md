# NodeContainer 组件 HarmonyOS 6.0 开发 Skill

## 概述

NodeContainer 是 OpenHarmony 中的基础容器组件，用于挂载自定义节点（如 FrameNode 或 BuilderNode），通过 NodeController 动态控制节点的添加和移除。它为开发者提供了在运行时动态创建和管理 UI 节点的能力。

## 重要说明

- **动态节点管理**: NodeContainer 专门用于动态添加和管理自定义节点
- **NodeController 配合使用**: 必须与 NodeController 一起使用
- **无子组件**: NodeContainer 不支持子组件声明
- **API 版本**: 从 API 11 开始支持
- **高级特性**: 支持 UI 业务解耦、动态模板加载等高级场景

## 模块信息

- **组件名称**: NodeContainer
- **SDK 版本**: HarmonyOS 6.0 (API 21)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [NodeContainer - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-basic-components-nodecontainer-V5)
  - [使用 NodeController 加载不同模板函数](https://developer.huawei.com/consumer/cn/doc/architecture-guides/convenient-life-v1_2-ts_46-0000002359512880)

## 一、组件基础

### 1.1 导入方式

```typescript
// NodeContainer 是内置组件
// 需要导入相关的 NodeController 和 Node 类
import { NodeController, BuilderNode, FrameNode, UIContext } from '@kit.ArkUI'

// 在组件中使用
NodeContainer(this.nodeController)
```

### 1.2 基础用法

```typescript
// 创建自定义 NodeController
class MyNodeController extends NodeController {
  private node: BuilderNode<object> | null = null

  makeNode(uiContext: UIContext): FrameNode {
    // 创建 BuilderNode
    this.node = new BuilderNode(uiContext)
    // 设置构建函数
    this.node.build(wrapBuilder(MyBuilder))
    // 返回 FrameNode
    return this.node.getFrameNode()
  }
}

// 定义 Builder 函数
@Builder
function MyBuilder() {
  Column() {
    Text('动态节点内容')
      .fontSize(20)
  }
  .width(200)
  .height(100)
  .backgroundColor('#F5F5F5')
}

// 在组件中使用
@ComponentV2
struct NodeContainerExample {
  private nodeController: NodeController = new MyNodeController()

  build() {
    NodeContainer(this.nodeController)
  }
}
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| nodeController | `NodeController` | 是 | - | 节点控制器实例 |

### 2.2 NodeController 类

NodeController 是抽象类，需要继承并实现以下方法：

| 方法 | 类型 | 描述 |
|------|------|------|
| `makeNode` | `(uiContext: UIContext) => FrameNode` | 创建并返回要挂载的节点（必须实现） |
| `onMount` | `() => void` | 节点挂载到容器时的回调 |
| `onUnmount` | `() => void` | 节点从容器卸载时的回调 |
| `rebuild` | `() => void` | 请求重建节点 |

### 2.3 属性

NodeContainer 支持通用容器属性：

| 属性 | 类型 | 描述 |
|------|------|------|
| width | `Length` | 容器宽度 |
| height | `Length` | 容器高度 |
| size | `Size` | 容器尺寸 |
| backgroundColor | `ResourceColor` | 背景颜色 |
| padding | `Padding` | 内边距 |
| margin | `Margin` | 外边距 |

## 三、使用示例

### 3.1 基础动态节点

```typescript
/**
 * 基础 NodeContainer 示例
 * 演示如何创建和挂载简单的动态节点
 */
class BasicNodeController extends NodeController {
  private builderNode: BuilderNode<object> | null = null

  // 必须实现：创建节点
  makeNode(uiContext: UIContext): FrameNode {
    if (!this.builderNode) {
      this.builderNode = new BuilderNode(uiContext)
      this.builderNode.build(wrapBuilder(BasicContentBuilder))
    }
    return this.builderNode.getFrameNode()
  }

  // 可选：节点挂载时调用
  onMount(): void {
    console.info('Node mounted to container')
  }

  // 可选：节点卸载时调用
  onUnmount(): void {
    console.info('Node unmounted from container')
  }
}

@Builder
function BasicContentBuilder() {
  Column({ space: 12 }) {
    Text('动态节点内容')
      .fontSize(20)
      .fontWeight(FontWeight.Bold)

    Text('这是通过 NodeContainer 动态挂载的节点')
      .fontSize(14)
      .fontColor('#666666')
  }
  .width('100%')
  .height('100%')
  .padding(16)
  .backgroundColor('#E3F2FD')
  .borderRadius(12)
}

@ComponentV2
struct BasicNodeContainerExample {
  private nodeController: NodeController = new BasicNodeController()

  build() {
    Column({ space: 16 }) {
      Text('基础 NodeContainer 示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      NodeContainer(this.nodeController)
        .width('100%')
        .height(200)
        .backgroundColor('#F5F5F5')
        .borderRadius(12)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.2 动态切换节点

```typescript
/**
 * 动态切换节点示例
 * 演示如何在不同节点模板之间切换
 */
class SwitchableNodeController extends NodeController {
  private builderNode: BuilderNode<{ template: string }> | null = null
  private currentTemplate: string = 'templateA'

  makeNode(uiContext: UIContext): FrameNode {
    if (!this.builderNode) {
      this.builderNode = new BuilderNode<{ template: string }>(uiContext)
    }
    // 使用当前模板重新构建
    this.builderNode.update(wrapBuilder(SwitchableContentBuilder), {
      template: this.currentTemplate
    })
    return this.builderNode.getFrameNode()
  }

  // 切换模板的方法
  switchTemplate(template: string): void {
    this.currentTemplate = template
    this.rebuild() // 请求重建节点
  }
}

@Builder
function SwitchableContentBuilder(params: { template: string }) {
  if (params.template === 'templateA') {
    Column({ space: 12 }) {
      Text('模板 A')
        .fontSize(24)
        .fontColor('#007DFF')
      Text('这是模板 A 的内容')
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#E3F2FD')
  } else if (params.template === 'templateB') {
    Column({ space: 12 }) {
      Text('模板 B')
        .fontSize(24)
        .fontColor('#28A745')
      Text('这是模板 B 的内容')
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#E8F5E9')
  } else {
    Column({ space: 12 }) {
      Text('模板 C')
        .fontSize(24)
        .fontColor('#FFC107')
      Text('这是模板 C 的内容')
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#FFF8E1')
  }
}

@ComponentV2
struct SwitchableNodeContainerExample {
  private nodeController: SwitchableNodeController = new SwitchableNodeController()

  build() {
    Column({ space: 16 }) {
      Text('动态切换节点示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      NodeContainer(this.nodeController)
        .width('100%')
        .height(200)

      Row({ space: 12 }) {
        Button('模板 A')
          .onClick(() => {
            this.nodeController.switchTemplate('templateA')
          })

        Button('模板 B')
          .onClick(() => {
            this.nodeController.switchTemplate('templateB')
          })

        Button('模板 C')
          .onClick(() => {
            this.nodeController.switchTemplate('templateC')
          })
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.3 带参数的动态节点

```typescript
/**
 * 带参数的动态节点示例
 * 演示如何向动态节点传递参数并更新
 */
interface UserData {
  name: string
  age: number
  avatar: string
}

class ParametrizedNodeController extends NodeController {
  private builderNode: BuilderNode<UserData> | null = null
  private userData: UserData = {
    name: '张三',
    age: 25,
    avatar: '\uE641' // 用户图标
  }

  makeNode(uiContext: UIContext): FrameNode {
    if (!this.builderNode) {
      this.builderNode = new BuilderNode<UserData>(uiContext)
    }
    this.builderNode.update(wrapBuilder(UserProfileBuilder), this.userData)
    return this.builderNode.getFrameNode()
  }

  // 更新用户数据
  updateUserData(newData: Partial<UserData>): void {
    this.userData = { ...this.userData, ...newData }
    this.rebuild()
  }
}

@Builder
function UserProfileBuilder(user: UserData) {
  Row({ space: 16 }) {
    // 头像
    Text(user.avatar)
      .fontSize(48)
      .width(80)
      .height(80)
      .textAlign(TextAlign.Center)
      .backgroundColor('#E0E0E0')
      .borderRadius(40)

    // 用户信息
    Column({ space: 8 }) {
      Text(user.name)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Text(`年龄: ${user.age} 岁`)
        .fontSize(14)
        .fontColor('#666666')
    }
    .alignItems(HorizontalAlign.Start)
    .layoutWeight(1)
  }
  .width('100%')
  .padding(20)
  .backgroundColor('#FFFFFF')
  .borderRadius(12)
  .shadow({ radius: 8, color: '#1F000000', offsetX: 0, offsetY: 2 })
}

@ComponentV2
struct ParametrizedNodeContainerExample {
  private nodeController: ParametrizedNodeController = new ParametrizedNodeController()

  build() {
    Column({ space: 16 }) {
      Text('带参数的动态节点')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      NodeContainer(this.nodeController)
        .width('100%')

      Row({ space: 12 }) {
        Button('更新姓名')
          .onClick(() => {
            this.nodeController.updateUserData({ name: '李四' })
          })

        Button('增加年龄')
          .onClick(() => {
            const currentAge = this.nodeController['userData'].age
            this.nodeController.updateUserData({ age: currentAge + 1 })
          })
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
  }
}
```

### 3.4 列表动态节点

```typescript
/**
 * 列表动态节点示例
 * 演示如何在 NodeContainer 中渲染动态列表
 */
class ListNodeController extends NodeController {
  private builderNode: BuilderNode<{ items: string[] }> | null = null
  private items: string[] = ['项目 1', '项目 2', '项目 3']

  makeNode(uiContext: UIContext): FrameNode {
    if (!this.builderNode) {
      this.builderNode = new BuilderNode<{ items: string[] }>(uiContext)
    }
    this.builderNode.update(wrapBuilder(ListContentBuilder), {
      items: this.items
    })
    return this.builderNode.getFrameNode()
  }

  // 添加项目
  addItem(): void {
    this.items.push(`项目 ${this.items.length + 1}`)
    this.rebuild()
  }

  // 删除项目
  removeItem(): void {
    if (this.items.length > 0) {
      this.items.pop()
      this.rebuild()
    }
  }
}

@Builder
function ListContentBuilder(params: { items: string[] }) {
  Column({ space: 8 }) {
    ForEach(params.items, (item: string, index: number) => {
      Row() {
        Text(`${index + 1}. ${item}`)
          .fontSize(16)
          .layoutWeight(1)

        Text('\uE645') // 箭头图标
          .fontSize(16)
          .fontColor('#CCCCCC')
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#FFFFFF')
      .borderRadius(8)
    }, (item: string, index: number) => `${index}_${item}`)
  }
  .width('100%')
  .padding(12)
}

@ComponentV2
struct ListNodeContainerExample {
  private nodeController: ListNodeController = new ListNodeController()

  build() {
    Column({ space: 16 }) {
      Text('列表动态节点示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      NodeContainer(this.nodeController)
        .width('100%')
        .height(300)
        .backgroundColor('#FAFAFA')
        .borderRadius(12)

      Row({ space: 12 }) {
        Button('添加项目')
          .onClick(() => {
            this.nodeController.addItem()
          })

        Button('删除项目')
          .onClick(() => {
            this.nodeController.removeItem()
          })
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.5 条件渲染节点

```typescript
/**
 * 条件渲染节点示例
 * 演示如何根据条件渲染不同的节点内容
 */
class ConditionalNodeController extends NodeController {
  private builderNode: BuilderNode<{ state: 'loading' | 'success' | 'error', data?: string }> | null = null
  private state: 'loading' | 'success' | 'error' = 'loading'
  private data: string = ''

  makeNode(uiContext: UIContext): FrameNode {
    if (!this.builderNode) {
      this.builderNode = new BuilderNode<{
        state: 'loading' | 'success' | 'error'
        data?: string
      }>(uiContext)
    }
    this.builderNode.update(wrapBuilder(ConditionalContentBuilder), {
      state: this.state,
      data: this.data
    })
    return this.builderNode.getFrameNode()
  }

  // 模拟加载数据
  loadData(): void {
    this.state = 'loading'
    this.rebuild()

    // 模拟异步加载
    setTimeout(() => {
      const success = Math.random() > 0.3 // 70% 成功率
      if (success) {
        this.state = 'success'
        this.data = '加载的数据内容'
      } else {
        this.state = 'error'
      }
      this.rebuild()
    }, 1500)
  }
}

@Builder
function ConditionalContentBuilder(params: {
  state: 'loading' | 'success' | 'error'
  data?: string
}) {
  Column({ space: 16 }) {
    if (params.state === 'loading') {
      Column({ space: 12 }) {
        LoadingProgress()
          .width(40)
          .height(40)
          .color('#007DFF')

        Text('加载中...')
          .fontSize(16)
          .fontColor('#666666')
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
    } else if (params.state === 'success') {
      Column({ space: 12 }) {
        Text('\uE640') // 成功图标
          .fontSize(48)
          .fontColor('#28A745')

        Text('加载成功')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)

        Text(params.data || '')
          .fontSize(14)
          .fontColor('#666666')
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
    } else if (params.state === 'error') {
      Column({ space: 12 }) {
        Text('\uE63F') // 错误图标
          .fontSize(48)
          .fontColor('#DC3545')

        Text('加载失败')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)

        Text('请稍后重试')
          .fontSize(14)
          .fontColor('#666666')
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
    }
  }
  .width('100%')
  .height('100%')
  .padding(20)
}

@ComponentV2
struct ConditionalNodeContainerExample {
  private nodeController: ConditionalNodeController = new ConditionalNodeController()

  build() {
    Column({ space: 16 }) {
      Text('条件渲染节点示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      NodeContainer(this.nodeController)
        .width('100%')
        .height(250)
        .backgroundColor('#FAFAFA')
        .borderRadius(12)

      Button('重新加载')
        .onClick(() => {
          this.nodeController.loadData()
        })
    }
    .width('100%')
    .padding(16)
  }

  aboutToAppear(): void {
    // 组件出现时自动加载数据
    this.nodeController.loadData()
  }
}
```

## 四、高级用法

### 4.1 动态组件库

```typescript
/**
 * 动态组件库示例
 * 演示如何实现可复用的动态组件库
 */
type ComponentType = 'chart' | 'table' | 'calendar'

class ComponentLibraryNodeController extends NodeController {
  private builderNode: BuilderNode<{ type: ComponentType, data: object }> | null = null
  private currentType: ComponentType = 'chart'
  private componentData: object = {}

  makeNode(uiContext: UIContext): FrameNode {
    if (!this.builderNode) {
      this.builderNode = new BuilderNode<{
        type: ComponentType
        data: object
      }>(uiContext)
    }
    this.builderNode.update(wrapBuilder(ComponentLibraryBuilder), {
      type: this.currentType,
      data: this.componentData
    })
    return this.builderNode.getFrameNode()
  }

  switchComponent(type: ComponentType, data: object = {}): void {
    this.currentType = type
    this.componentData = data
    this.rebuild()
  }
}

@Builder
function ComponentLibraryBuilder(params: { type: ComponentType, data: object }) {
  if (params.type === 'chart') {
    // 图表组件
    Column({ space: 12 }) {
      Text('数据统计')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        Column({ space: 4 }) {
          Text('85%')
            .fontSize(24)
            .fontColor('#007DFF')
          Text('完成率')
            .fontSize(12)
            .fontColor('#666666')
        }

        Column({ space: 4 }) {
          Text('120')
            .fontSize(24)
            .fontColor('#28A745')
          Text('任务数')
            .fontSize(12)
            .fontColor('#666666')
        }

        Column({ space: 4 }) {
          Text('15')
            .fontSize(24)
            .fontColor('#FFC107')
          Text('待处理')
            .fontSize(12)
            .fontColor('#666666')
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#E3F2FD')
  } else if (params.type === 'table') {
    // 表格组件
    Column({ space: 8 }) {
      Text('数据列表')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      ForEach(['项目 A', '项目 B', '项目 C'], (item: string) => {
        Row() {
          Text(item)
            .fontSize(14)
            .layoutWeight(1)
          Text('进行中')
            .fontSize(12)
            .fontColor('#28A745')
        }
        .width('100%')
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(8)
      })
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
  } else if (params.type === 'calendar') {
    // 日历组件
    Column({ space: 12 }) {
      Text('2026年2月')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Grid() {
        ForEach(['日', '一', '二', '三', '四', '五', '六'], (day: string) => {
          GridItem() {
            Text(day)
              .fontSize(14)
              .fontColor('#666666')
          }
          .height(30)
        })

        ForEach(Array.from({ length: 28 }, (_, i) => i + 1), (date: number) => {
          GridItem() {
            Text(date.toString())
              .fontSize(14)
          }
          .height(30)
        })
      }
      .columnsTemplate('1fr 1fr 1fr 1fr 1fr 1fr 1fr')
      .rowsGap(8)
      .columnsGap(8)
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#FFF8E1')
  }
}

@ComponentV2
struct ComponentLibraryExample {
  private nodeController: ComponentLibraryNodeController = new ComponentLibraryNodeController()

  build() {
    Column({ space: 16 }) {
      Text('动态组件库')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      NodeContainer(this.nodeController)
        .width('100%')
        .height(300)

      Row({ space: 12 }) {
        Button('图表')
          .onClick(() => {
            this.nodeController.switchComponent('chart')
          })

        Button('表格')
          .onClick(() => {
            this.nodeController.switchComponent('table')
          })

        Button('日历')
          .onClick(() => {
            this.nodeController.switchComponent('calendar')
          })
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

### 4.2 嵌套动态节点

```typescript
/**
 * 嵌套动态节点示例
 * 演示如何在动态节点中嵌套另一个 NodeContainer
 */
class InnerNodeController extends NodeController {
  private builderNode: BuilderNode<{ content: string }> | null = null

  makeNode(uiContext: UIContext): FrameNode {
    if (!this.builderNode) {
      this.builderNode = new BuilderNode<{ content: string }>(uiContext)
    }
    this.builderNode.update(wrapBuilder(InnerBuilder), {
      content: '内部节点内容'
    })
    return this.builderNode.getFrameNode()
  }
}

@Builder
function InnerBuilder(params: { content: string }) {
  Text(params.content)
    .fontSize(16)
    .padding(12)
    .backgroundColor('#E8F5E9')
    .borderRadius(8)
}

class OuterNodeController extends NodeController {
  private builderNode: BuilderNode<{ innerController: NodeController }> | null = null
  private innerController: NodeController = new InnerNodeController()

  makeNode(uiContext: UIContext): FrameNode {
    if (!this.builderNode) {
      this.builderNode = new BuilderNode<{ innerController: NodeController }>(uiContext)
    }
    this.builderNode.update(wrapBuilder(OuterBuilder), {
      innerController: this.innerController
    })
    return this.builderNode.getFrameNode()
  }

  getInnerController(): NodeController {
    return this.innerController
  }
}

@Builder
function OuterBuilder(params: { innerController: NodeController }) {
  Column({ space: 12 }) {
    Text('外部节点')
      .fontSize(18)
      .fontWeight(FontWeight.Bold)

    // 嵌套的 NodeContainer
    NodeContainer(params.innerController)
      .width('100%')
  }
  .width('100%')
  .padding(16)
  .backgroundColor('#E3F2FD')
  .borderRadius(12)
}

@ComponentV2
struct NestedNodeContainerExample {
  private outerController: OuterNodeController = new OuterNodeController()

  build() {
    Column({ space: 16 }) {
      Text('嵌套动态节点示例')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      NodeContainer(this.outerController)
        .width('100%')
        .height(200)
    }
    .width('100%')
    .padding(16)
  }
}
```

## 五、最佳实践

### 5.1 资源管理

```typescript
// ✅ 推荐：及时释放资源
class ResourceManagedController extends NodeController {
  private builderNode: BuilderNode<object> | null = null

  makeNode(uiContext: UIContext): FrameNode {
    if (!this.builderNode) {
      this.builderNode = new BuilderNode<object>(uiContext)
    }
    this.builderNode.build(wrapBuilder(ContentBuilder))
    return this.builderNode.getFrameNode()
  }

  onUnmount(): void {
    // 清理资源
    this.builderNode = null
  }
}

// ❌ 避免：不清理资源
class MemoryLeakController extends NodeController {
  private builderNode: BuilderNode<object> | null = null

  makeNode(uiContext: UIContext): FrameNode {
    this.builderNode = new BuilderNode<object>(uiContext)
    this.builderNode.build(wrapBuilder(ContentBuilder))
    return this.builderNode.getFrameNode()
  }

  // 缺少 onUnmount 实现，可能导致内存泄漏
}
```

### 5.2 性能优化

```typescript
// ✅ 推荐：避免频繁重建
class OptimizedController extends NodeController {
  private builderNode: BuilderNode<{ data: string }> | null = null
  private cachedData: string = ''

  makeNode(uiContext: UIContext): FrameNode {
    if (!this.builderNode) {
      this.builderNode = new BuilderNode<{ data: string }>(uiContext)
    }

    // 只在数据真正改变时更新
    if (this.cachedData !== this.currentData) {
      this.cachedData = this.currentData
      this.builderNode.update(wrapBuilder(ContentBuilder), {
        data: this.currentData
      })
    }

    return this.builderNode.getFrameNode()
  }

  private currentData: string = ''
  updateData(newData: string): void {
    if (this.currentData !== newData) {
      this.currentData = newData
      this.rebuild()
    }
  }
}
```

### 5.3 错误处理

```typescript
// ✅ 推荐：添加错误处理
class SafeController extends NodeController {
  private builderNode: BuilderNode<object> | null = null

  makeNode(uiContext: UIContext): FrameNode {
    try {
      if (!this.builderNode) {
        this.builderNode = new BuilderNode<object>(uiContext)
      }
      this.builderNode.build(wrapBuilder(ContentBuilder))
      return this.builderNode.getFrameNode()
    } catch (error) {
      console.error('Failed to create node:', error)
      // 返回一个错误节点
      return this.createErrorNode(uiContext)
    }
  }

  private createErrorNode(uiContext: UIContext): FrameNode {
    const errorNode = new BuilderNode<object>(uiContext)
    errorNode.build(wrapBuilder(ErrorBuilder))
    return errorNode.getFrameNode()
  }
}

@Builder
function ErrorBuilder() {
  Text('节点加载失败')
    .fontSize(16)
    .fontColor('#DC3545')
    .padding(16)
}
```

## 六、常见问题

### Q1: NodeContainer 的内容不显示？

**解决方案**:
```typescript
// 确保设置了尺寸
NodeContainer(this.nodeController)
  .width('100%')
  .height(200) // 必须设置明确的高度

// 确保正确实现了 makeNode
class MyController extends NodeController {
  makeNode(uiContext: UIContext): FrameNode {
    const builderNode = new BuilderNode<object>(uiContext)
    builderNode.build(wrapBuilder(MyBuilder))
    return builderNode.getFrameNode() // 确保返回 FrameNode
  }
}
```

### Q2: 如何动态更新节点内容？

**解决方案**:
```typescript
// 使用 update 方法
this.builderNode.update(wrapBuilder(MyBuilder), {
  data: newData
})

// 然后调用 rebuild
this.rebuild()
```

### Q3: NodeContainer 可以嵌套使用吗？

**答**: 可以，但要注意：
- 避免过深的嵌套（建议不超过 3 层）
- 每层都需要独立的 NodeController
- 注意资源管理和生命周期

### Q4: 如何在动态节点中使用状态？

**解决方案**:
```typescript
// 在 BuilderNode 中传递参数
this.builderNode.update(wrapBuilder(StatefulBuilder), {
  count: this.count,
  onIncrement: () => {
    this.count++
    this.rebuild()
  }
})

@Builder
function StatefulBuilder(params: {
  count: number
  onIncrement: () => void
}) {
  Column({ space: 12 }) {
    Text(`计数: ${params.count}`)
    Button('增加')
      .onClick(params.onIncrement)
  }
}
```

### Q5: NodeContainer 与普通组件的区别？

| 特性 | NodeContainer | 普通组件 |
|------|--------------|----------|
| 动态性 | 运行时动态创建 | 编译时确定 |
| 模板切换 | 支持动态切换 | 需要条件渲染 |
| 业务解耦 | 支持完全解耦 | 紧耦合 |
| 使用复杂度 | 较高 | 较低 |
| 性能 | 略低 | 较高 |

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 11 | ✅ | 首次引入 |
| API 12 | ✅ | 性能优化 |
| API 13+ | ✅ | 功能增强 |

## 八、参考资料

- [NodeContainer 组件 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-basic-components-nodecontainer-V5)
- [使用 NodeController 加载不同模板函数 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/architecture-guides/convenient-life-v1_2-ts_46-0000002359512880)
- [鸿蒙开发：动态添加节点 - CSDN](https://m.blog.csdn.net/ming_147/article/details/146641179)
- [鸿蒙HarmonyOS界面开发-组件动态创建 - CSDN](https://yuknight.blog.csdn.net/article/details/151796118)
- [HarmonyOS 5.0应用开发——NodeContainer自定义占位节点 - CSDN](https://m.blog.csdn.net/gao_xin_xing/article/details/145510883)
