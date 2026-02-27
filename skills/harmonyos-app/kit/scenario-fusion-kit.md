---
name: scenario-fusion-kit
description: 场景融合 Kit，提供元服务场景融合能力
---

# 场景融合 HarmonyOS 开发 Skill

## 概述

场景融合 Kit (ScenarioFusionKit) 为 HarmonyOS 元服务提供场景融合能力，支持功能按钮、功能输入、文件 URI 服务等。

## 重要说明

- **Kit 名称**: ScenarioFusionKit
- **SDK 版本**: HarmonyOS 4.1.0+ (API 11+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  FunctionalButton,
  functionalButtonComponentManager,
  atomicService,
  fileUriService,
  FunctionalInput,
  functionalInputComponentManager
} from '@kit.ScenarioFusionKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| FunctionalButton | Component | 功能按钮组件 |
| functionalButtonComponentManager | Class | 功能按钮管理器 |
| atomicService | Module | 元服务模块 |
| fileUriService | Module | 文件 URI 服务 |
| FunctionalInput | Component | 功能输入组件 |
| functionalInputComponentManager | Class | 功能输入管理器 |

### 2.2 主要接口

#### fileUriService.getUri()

获取文件 URI。

返回值: `Promise<string>`

## 三、使用示例

### 3.1 功能按钮

```typescript
import { FunctionalButton } from '@kit.ScenarioFusionKit'

@Entry
@ComponentV2
struct FunctionalButtonPage {
  build() {
    FunctionalButton({
      onClick: () => {
        console.log('Functional button clicked')
      }
    })
  }
}
```

## 四、最佳实践

1. **场景适配**: 适配不同使用场景
2. **用户体验**: 提供流畅的用户体验
3. **数据传递**: 正确处理数据传递

## 五、参考资料

- [场景融合官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/scenario-fusion-introduction-V5)

---
## See Also
- [AppGalleryKit](kit/app-gallery-kit.md) - 应用市场服务
