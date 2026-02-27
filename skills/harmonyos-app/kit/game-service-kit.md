---
name: game-service-kit
description: 游戏服务 Kit，提供游戏玩家、游戏性能、游戏附近传输等功能
---

# 游戏服务 HarmonyOS 开发 Skill

## 概述

游戏服务 Kit (GameServiceKit) 为 HarmonyOS 游戏应用提供游戏玩家、游戏性能优化、附近游戏传输等功能。

## 重要说明

- **Kit 名称**: GameServiceKit
- **SDK 版本**: HarmonyOS 4.1.0+ (API 11+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  gamePlayer,
  gamePerformance,
  gameNearbyTransfer
} from '@kit.GameServiceKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| gamePlayer | Module | 游戏玩家模块 |
| gamePerformance | Module | 游戏性能模块 |
| gameNearbyTransfer | Module | 附近游戏传输模块 |

### 2.2 主要接口

#### gamePlayer.init()

初始化游戏玩家服务。

返回值: `Promise<void>`

#### gamePerformance.report()

报告游戏性能数据。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| data | PerformanceData | 是 | - | 性能数据 |

## 三、使用示例

### 3.1 初始化游戏玩家服务

```typescript
import { gamePlayer } from '@kit.GameServiceKit'

async function initGamePlayer(): Promise<void> {
  try {
    await gamePlayer.init({
      appId: 'your_app_id'
    })

    console.log('Game player initialized')
  } catch (error) {
    console.error('Init failed:', error)
  }
}
```

### 3.2 报告游戏性能

```typescript
import { gamePerformance } from '@kit.GameServiceKit'

async function reportPerformance(): Promise<void> {
  try {
    await gamePerformance.report({
      fps: 60,
      frameTime: 16.7,
      memoryUsage: 512
    })
  } catch (error) {
    console.error('Report failed:', error)
  }
}
```

## 四、最佳实践

1. **性能监控**: 持续监控游戏性能
2. **玩家体验**: 优化玩家加载体验
3. **附近传输**: 合理使用附近传输功能

## 五、参考资料

- [游戏服务官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/game-introduction-V5)

---
## See Also
- [GraphicsAccelerateKit](kit/graphics-accelerate-kit.md) - 图形加速
