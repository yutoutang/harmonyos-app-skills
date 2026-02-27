---
name: graphics-accelerate-kit
description: 图形加速 Kit，提供游戏图形加速能力
---

# 图形加速 HarmonyOS 开发 Skill

## 概述

图形加速 Kit (GraphicsAccelerateKit) 为 HarmonyOS 游戏应用提供图形加速能力，包括资源下载管理、启动加速等功能。

## 重要说明

- **Kit 名称**: GraphicsAccelerateKit
- **SDK 版本**: HarmonyOS 6.0.0+ (API 20+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  assetDownloadManager,
  AssetAccelerationExtensionAbility,
  AssetAccelerationExtensionInfo,
  ContentRequestType,
  AssetAccelerationExtensionContext,
  launchAcceleration
} from '@kit.GraphicsAccelerateKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| assetDownloadManager | Module | 资源下载管理器 |
| AssetAccelerationExtensionAbility | Class | 资源加速扩展能力 |
| AssetAccelerationExtensionContext | Class | 资源加速扩展上下文 |
| launchAcceleration | Module | 启动加速模块 |

### 2.2 主要接口

#### launchAcceleration.enable()

启用启动加速。

返回值: `Promise<void>`

## 三、使用示例

### 3.1 启用启动加速

```typescript
import { launchAcceleration } from '@kit.GraphicsAccelerateKit'

async function enableLaunchAcceleration(): Promise<void> {
  try {
    await launchAcceleration.enable()

    console.log('Launch acceleration enabled')
  } catch (error) {
    console.error('Enable failed:', error)
  }
}
```

## 四、最佳实践

1. **资源优化**: 合理配置资源下载策略
2. **启动优化**: 结合启动加速优化加载流程
3. **扩展能力**: 实现自定义扩展能力

## 五、参考资料

- [图形加速官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/graphics-accelerate-introduction-V5)

---
## See Also
- [GameServiceKit](kit/game-service-kit.md) - 游戏服务
