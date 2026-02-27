---
name: call-kit
description: 通话服务 Kit (已弃用)，请使用 CallServiceKit
---

# 通话服务 HarmonyOS 开发 Skill

## 概述

通话 Kit (CallKit) 为 HarmonyOS 应用提供 VoIP 通话能力。

> **注意**: 此 Kit 已于 5.0.2(14) 版本弃用，请使用 [CallServiceKit](kit/call-service-kit.md) 代替。

## 重要说明

- **Kit 名称**: CallKit
- **SDK 版本**: HarmonyOS 4.1.0+ (API 11+)
- **状态**: 已弃用 (@since 5.0.2(14))
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import { voipCall } from '@kit.CallKit'
```

## 二、迁移指南

### 迁移到 CallServiceKit

**旧代码 (CallKit):**
```typescript
import { voipCall } from '@kit.CallKit'
```

**新代码 (CallServiceKit):**
```typescript
import { voipCall } from '@kit.CallServiceKit'
```

API 基本保持兼容，只需更新导入语句即可。

## 三、参考资料

- [通话服务官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/call-introduction-V5)

---
## See Also
- [CallServiceKit](kit/call-service-kit.md) - 通话服务 (推荐)
