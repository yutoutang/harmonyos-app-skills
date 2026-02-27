---
name: network-boost-kit
description: 网络加速 Kit，提供网络质量检测和加速能力
---

# 网络加速 HarmonyOS 开发 Skill

## 概述

网络加速 Kit (NetworkBoostKit) 为 HarmonyOS 应用提供网络质量检测、网络切换、网络加速等功能。

## 重要说明

- **Kit 名称**: NetworkBoostKit
- **SDK 版本**: HarmonyOS 5.0.0+ (API 12+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  netQuality,
  netHandover,
  netBoost
} from '@kit.NetworkBoostKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| netQuality | Module | 网络质量模块 |
| netHandover | Module | 网络切换模块 |
| netBoost | Module | 网络加速模块 |

### 2.2 主要接口

#### netQuality.getQuality()

获取网络质量。

返回值: `Promise<NetworkQuality>`

#### netBoost.enable()

启用网络加速。

返回值: `Promise<void>`

## 三、使用示例

### 3.1 检测网络质量

```typescript
import { netQuality } from '@kit.NetworkBoostKit'

async function checkNetworkQuality(): Promise<void> {
  try {
    const quality = await netQuality.getQuality()

    console.log('Network quality:', quality.score)
    console.log('RTT:', quality.rtt)
    console.log('Loss rate:', quality.lossRate)
  } catch (error) {
    console.error('Check quality failed:', error)
  }
}
```

### 3.2 启用网络加速

```typescript
import { netBoost } from '@kit.NetworkBoostKit'

async function enableNetworkBoost(): Promise<void> {
  try {
    await netBoost.enable()

    console.log('Network boost enabled')
  } catch (error) {
    console.error('Enable boost failed:', error)
  }
}
```

## 四、最佳实践

1. **智能切换**: 根据网络质量智能切换
2. **用户选择**: 尊重用户的网络选择
3. **电量管理**: 考虑加速对电量的影响

## 五、参考资料

- [网络加速官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/network-boost-introduction-V5)

---
## See Also
- [CloudFoundationKit](kit/cloud-foundation-kit.md) - 云基础服务
