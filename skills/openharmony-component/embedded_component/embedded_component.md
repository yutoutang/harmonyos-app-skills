# EmbeddedComponent 组件参考

## 概述

`EmbeddedComponent` 是 OpenHarmony 中用于在应用中嵌入其他组件或应用的容器组件。它允许将一个 Ability 或组件嵌入到当前应用的界面中。

## 基本语法

```typescript
EmbeddedComponent({
  want: Want,
  moduleName: string,
  onLoad?: (event: LoadEvent) => void,
  onError?: (event: ErrorEvent) => void
})
```

## 核心属性

### want
- **类型**: `Want`
- **说明**: 指定要嵌入的 Ability 或组件信息
- **必需**: 是

```typescript
import { Want } from '@kit.AbilityKit';

const want: Want = {
  bundleName: 'com.example.embedded',
  abilityName: 'EmbeddedAbility',
  moduleName: 'entry'
}
```

### moduleName
- **类型**: `string`
- **说明**: 指定要嵌入的模块名称
- **必需**: 是

### onLoad
- **类型**: `(event: LoadEvent) => void`
- **说明**: 组件加载完成的回调
- **可选**: 是

```typescript
onLoad: (event: LoadEvent) => {
  console.log('Embedded component loaded:', event.componentName);
}
```

### onError
- **类型**: `(event: ErrorEvent) => void`
- **说明**: 组件加载失败的回调
- **可选**: 是

```typescript
onError: (event: ErrorEvent) => {
  console.error('Embedded component error:', event.errorCode, event.errorMsg);
}
```

## 使用示例

### 基础用法

```typescript
@ComponentV2
struct BasicEmbeddedExample {
  @Local embeddedWant: Want = {
    bundleName: 'com.example.embedded',
    abilityName: 'EmbeddedAbility',
    moduleName: 'entry'
  }

  build() {
    Column() {
      Text('嵌入外部组件示例')
        .fontSize(18)
        .margin({ bottom: 16 })

      EmbeddedComponent({
        want: this.embeddedWant,
        moduleName: 'entry',
        onLoad: (event) => {
          console.info('Embedded component loaded successfully');
        },
        onError: (event) => {
          console.error('Failed to load embedded component:', event.errorMsg);
        }
      })
      .width('100%')
      .height(400)
      .border({ width: 1, color: Color.Gray })
    }
    .padding(16)
  }
}
```

### 动态切换嵌入组件

```typescript
@ComponentV2
struct DynamicEmbeddedExample {
  @Local currentIndex: number = 0
  @Local embeddedList: Want[] = [
    {
      bundleName: 'com.example.app1',
      abilityName: 'Component1Ability',
      moduleName: 'entry'
    },
    {
      bundleName: 'com.example.app2',
      abilityName: 'Component2Ability',
      moduleName: 'entry'
    }
  ]

  build() {
    Column() {
      Row() {
        Button('上一个')
          .onClick(() => {
            if (this.currentIndex > 0) {
              this.currentIndex--
            }
          })

        Button('下一个')
          .onClick(() => {
            if (this.currentIndex < this.embeddedList.length - 1) {
              this.currentIndex++
            }
          })
      }
      .justifyContent(FlexAlign.SpaceAround)
      .width('100%')
      .margin({ bottom: 16 })

      EmbeddedComponent({
        want: this.embeddedList[this.currentIndex],
        moduleName: 'entry',
        onLoad: (event) => {
          console.info(`Component ${this.currentIndex} loaded`);
        }
      })
      .width('100%')
      .height(500)
    }
    .padding(16)
  }
}
```

### 与状态管理结合

```typescript
@ObservedV2
class EmbeddedState {
  @Trace isLoaded: boolean = false
  @Trace errorMessage: string = ''
  @Trace componentName: string = ''
}

@ComponentV2
struct EmbeddedWithStateExample {
  @Local state: EmbeddedState = new EmbeddedState()

  build() {
    Column() {
      if (this.state.isLoaded) {
        Text(`已加载: ${this.state.componentName}`)
          .fontColor(Color.Green)
          .margin({ bottom: 8 })
      } else if (this.state.errorMessage) {
        Text(`错误: ${this.state.errorMessage}`)
          .fontColor(Color.Red)
          .margin({ bottom: 8 })
      }

      EmbeddedComponent({
        want: {
          bundleName: 'com.example.embedded',
          abilityName: 'MainAbility',
          moduleName: 'entry'
        },
        moduleName: 'entry',
        onLoad: (event) => {
          this.state.isLoaded = true
          this.state.componentName = event.componentName || 'Unknown'
        },
        onError: (event) => {
          this.state.errorMessage = event.errorMsg || 'Unknown error'
        }
      })
      .width('100%')
      .height(400)
    }
    .padding(16)
  }
}
```

## 配置要求

### module.json5 配置

在被嵌入的模块中需要配置相应的 Ability：

```json5
{
  "module": {
    "abilities": [
      {
        "name": "EmbeddedAbility",
        "srcEntry": "./ets/EmbeddedAbility.ets",
        "description": "可嵌入的 Ability",
        "icon": "$media:icon",
        "label": "$string:ability_label",
        "exported": true,
        "type": "page",
        "launchType": "singleton"
      }
    ]
  }
}
```

### 权限要求

根据嵌入的内容可能需要以下权限：

```json5
{
  "requestPermissions": [
    {
      "name": "ohos.permission.KEEP_BACKGROUND_RUNNING",
      "reason": "$string:permission_reason",
      "usedScene": {
        "abilities": ["EmbeddedAbility"],
        "when": "inuse"
      }
    }
  ]
}
```

## 生命周期

EmbeddedComponent 的生命周期包括：

1. **初始化**: 组件创建时的初始化阶段
2. **加载**: 通过 `want` 加载目标组件
3. **渲染**: 组件渲染到界面
4. **卸载**: 组件从界面移除

## LoadEvent 接口

```typescript
interface LoadEvent {
  componentName: string;     // 加载的组件名称
  moduleName: string;        // 模块名称
  bundleName: string;        // Bundle 名称
}
```

## ErrorEvent 接口

```typescript
interface ErrorEvent {
  errorCode: number;         // 错误代码
  errorMsg: string;          // 错误消息
  componentName?: string;    // 出错的组件名称
}
```

## 最佳实践

### 1. 错误处理

始终实现 `onError` 回调以处理加载失败的情况：

```typescript
EmbeddedComponent({
  want: targetWant,
  moduleName: 'entry',
  onError: (event) => {
    // 记录错误
    console.error('Load failed:', event.errorCode, event.errorMsg);

    // 显示用户友好的错误信息
    // 尝试重新加载或显示备用内容
  }
})
```

### 2. 资源管理

```typescript
@ComponentV2
struct EmbeddedWithCleanup {
  @Local isEmbedded: boolean = false

  build() {
    Column() {
      if (this.isEmbedded) {
        EmbeddedComponent({
          want: targetWant,
          moduleName: 'entry',
          onLoad: () => {
            console.info('Component loaded');
          }
        })
      }
    }
  }

  aboutToDisappear() {
    // 清理资源
    this.isEmbedded = false
  }
}
```

### 3. 性能优化

- 按需加载嵌入组件
- 避免频繁切换嵌入内容
- 使用缓存机制减少重复加载

```typescript
@ComponentV2
struct OptimizedEmbeddedExample {
  @Local cachedWants: Map<string, Want> = new Map()
  @Local currentKey: string = ''

  build() {
    Column() {
      EmbeddedComponent({
        want: this.cachedWants.get(this.currentKey) || defaultWant,
        moduleName: 'entry'
      })
    }
  }
}
```

## 限制与注意事项

1. **安全限制**: 只能嵌入具有相同或更高安全级别的组件
2. **性能影响**: 嵌入组件会增加内存和 CPU 使用
3. **生命周期管理**: 需要正确管理嵌入组件的生命周期
4. **权限要求**: 某些嵌入操作需要特定权限
5. **版本兼容性**: 确保目标组件与当前应用版本兼容

## 常见问题

### Q: 如何判断嵌入组件是否加载成功？

A: 使用 `onLoad` 回调：

```typescript
onLoad: (event) => {
  console.info('Load success:', event.componentName);
}
```

### Q: 嵌入组件失败怎么办？

A: 检查以下几点：
- `want` 配置是否正确
- 目标 Ability 是否存在且已导出
- 是否有足够的权限
- 使用 `onError` 获取详细错误信息

### Q: 可以嵌入第三方应用的组件吗？

A: 可以，但需要：
- 目标应用支持嵌入
- 目标 Ability 的 `exported` 属性为 `true`
- 满足安全级别要求

### Q: 如何释放嵌入组件的资源？

A: 移除 EmbeddedComponent 或设置为不可见：

```typescript
@Local shouldShow: boolean = true

EmbeddedComponent() {
  // ...
}
.visibility(this.shouldShow ? Visibility.Visible : Visibility.None)
```

## 相关组件

- **XComponent**: 用于嵌入原生 C++ 绘制内容
- **Web**: 用于嵌入 Web 内容
- **Image**: 用于显示图片资源

## 参考链接

- [OpenHarmony 官方文档 - EmbeddedComponent](https://developer.openharmony.cn/cn/docs/documentation/doc-references-V3/arkts-embedded-component.md)
- [Ability 开发指南](https://developer.openharmony.cn/cn/docs/documentation/doc-guides-V3/ability-dev-guide.md)
