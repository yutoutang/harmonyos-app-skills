---
name: car-kit
description: 车载服务 Kit，提供车机交互能力
---

# 车载服务 HarmonyOS 开发 Skill

## 概述

车载 Kit (CarKit) 为 HarmonyOS 应用提供车机交互能力，支持导航信息投射、智慧出行等功能。

## 重要说明

- **Kit 名称**: CarKit
- **SDK 版本**: HarmonyOS 4.1.0+ (API 11+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  navigationInfoMgr,
  smartMobilityCommon
} from '@kit.CarKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| navigationInfoMgr | Module | 导航信息管理 |
| smartMobilityCommon | Module | 智慧出行通用模块 |

### 2.2 主要接口

#### navigationInfoMgr.startNavigation()

启动导航投射。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| destInfo | DestinationInfo | 是 | - | 目的地信息 |

返回值: `Promise<void>`

## 三、使用示例

### 3.1 启动导航投射

```typescript
import { navigationInfoMgr } from '@kit.CarKit'

async function startCarNavigation(): Promise<void> {
  try {
    await navigationInfoMgr.startNavigation({
      latitude: 39.9,
      longitude: 116.4,
      name: '目的地名称'
    })

    console.log('Navigation started')
  } catch (error) {
    console.error('Start navigation failed:', error)
  }
}
```

## 四、最佳实践

1. **连接检测**: 检测车机连接状态
2. **驾驶安全**: 确保操作不影响驾驶安全
3. **数据同步**: 保持与车机的数据同步

## 五、参考资料

- [车载服务官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/car-introduction-V5)

---
## See Also
- [MapKit](kit/map-kit.md) - 地图服务
