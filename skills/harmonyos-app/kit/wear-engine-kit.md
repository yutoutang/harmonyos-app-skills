---
name: wear-engine-kit
description: 穿戴引擎 Kit，提供穿戴设备数据同步能力
---

# 穿戴引擎 HarmonyOS 开发 Skill

## 概述

穿戴引擎 Kit (WearEngine) 为 HarmonyOS 应用提供穿戴设备数据同步能力，支持手机与穿戴设备之间的数据交换。

## 重要说明

- **Kit 名称**: WearEngine
- **SDK 版本**: HarmonyOS 5.0.0+ (API 12+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import { wearEngine } from '@kit.WearEngine'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| wearEngine | Module | 穿戴引擎模块 |

### 2.2 主要接口

#### wearEngine.syncData()

同步数据到穿戴设备。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| data | Data | 是 | - | 待同步数据 |

返回值: `Promise<void>`

## 三、使用示例

### 3.1 同步数据到穿戴设备

```typescript
import { wearEngine } from '@kit.WearEngine'

async function syncToWearable(): Promise<void> {
  try {
    await wearEngine.syncData({
      type: 'steps',
      value: 10000,
      timestamp: Date.now()
    })

    console.log('Data synced')
  } catch (error) {
    console.error('Sync failed:', error)
  }
}
```

## 四、最佳实践

1. **连接状态**: 检查设备连接状态
2. **数据压缩**: 大数据考虑压缩传输
3. **电量管理**: 考虑对穿戴设备电量的影响

## 五、参考资料

- [穿戴引擎官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/wear-engine-introduction-V5)

---
## See Also
- [HealthServiceKit](kit/health-service-kit.md) - 健康服务
