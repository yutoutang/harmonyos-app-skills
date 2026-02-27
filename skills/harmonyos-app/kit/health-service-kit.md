---
name: health-service-kit
description: 健康服务 Kit，提供健康数据存储和服务能力
---

# 健康服务 HarmonyOS 开发 Skill

## 概述

健康服务 Kit (HealthServiceKit) 为 HarmonyOS 应用提供健康数据存储和服务能力，支持步数、心率、睡眠等健康数据的采集和管理。

## 重要说明

- **Kit 名称**: HealthServiceKit
- **SDK 版本**: HarmonyOS 5.0.0+ (API 12+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  healthStore,
  healthService
} from '@kit.HealthServiceKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| healthStore | Module | 健康数据存储模块 |
| healthService | Module | 健康服务模块 |

### 2.2 主要接口

#### healthStore.query()

查询健康数据。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
 dataType | DataType | 是 | - | 数据类型 |
| timeRange | TimeRange | 是 | - | 时间范围 |

返回值: `Promise<HealthData[]>`

## 三、使用示例

### 3.1 查询步数数据

```typescript
import { healthStore } from '@kit.HealthServiceKit'

async function querySteps(): Promise<void> {
  try {
    const steps = await healthStore.query({
      dataType: healthStore.DataType.STEPS,
      timeRange: {
        start: Date.now() - 86400000, // 最近24小时
        end: Date.now()
      }
    })

    console.log('Steps:', steps)
  } catch (error) {
    console.error('Query steps failed:', error)
  }
}
```

## 四、最佳实践

1. **权限管理**: 健康数据需要用户授权
2. **数据隐私**: 保护用户健康数据隐私
3. **数据精度**: 确保数据的准确性和完整性

## 五、权限要求

| 权限名称 | 用途 |
|---------|------|
| ohos.permission.HEALTH_READ | 读取健康数据 |
| ohos.permission.HEALTH_WRITE | 写入健康数据 |

## 六、参考资料

- [健康服务官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/health-introduction-V5)

---
## See Also
- [WearEngine](kit/wear-engine-kit.md) - 穿戴引擎
