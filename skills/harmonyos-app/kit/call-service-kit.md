---
name: call-service-kit
description: 通话服务 Kit，提供 VoIP 通话能力
---

# 通话服务 HarmonyOS 开发 Skill

## 概述

通话服务 Kit (CallServiceKit) 为 HarmonyOS 应用提供完整的 VoIP 通话能力，包括音频/视频通话、来电信息查询等功能。

## 重要说明

- **Kit 名称**: CallServiceKit
- **SDK 版本**: HarmonyOS 5.0.2+ (API 14+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  voipCall,
  CallerInfoQueryExtensionAbility,
  CallerInfo,
  CallerInfoQueryExtensionContext
} from '@kit.CallServiceKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| voipCall | Module | VoIP 通话模块 |
| CallerInfoQueryExtensionAbility | Class | 来电信息查询扩展能力 |
| CallerInfo | Class | 来电信息 |
| CallerInfoQueryExtensionContext | Class | 来电信息查询扩展上下文 |

### 2.2 主要接口

#### voipCall.initiateCall()

发起通话。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| calleeNumber | string | 是 | - | 被叫号码 |

返回值: `Promise<void>`

## 三、使用示例

### 3.1 发起 VoIP 通话

```typescript
import { voipCall } from '@kit.CallServiceKit'

async function makeCall(phoneNumber: string): Promise<void> {
  try {
    await voipCall.initiateCall(phoneNumber)
    console.log('Call initiated')
  } catch (error) {
    console.error('Make call failed:', error)
  }
}
```

## 四、最佳实践

1. **权限管理**: 需要通话和麦克风权限
2. **网络检测**: 通话前检测网络状态
3. **呼叫状态**: 正确管理各种呼叫状态

## 五、权限要求

| 权限名称 | 用途 |
|---------|------|
| ohos.permission.MICROPHONE | 麦克风权限 |
| ohos.permission.CAMERA | 相机权限 (视频通话) |

## 六、参考资料

- [通话服务官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/call-introduction-V5)

---
## See Also
- [CallKit](kit/call-kit.md) - 通话服务 (已弃用)
