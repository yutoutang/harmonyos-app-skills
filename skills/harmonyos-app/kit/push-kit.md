---
name: push-kit
description: 推送服务 Kit，提供应用消息推送能力
---

# 推送服务 HarmonyOS 开发 Skill

## 概述

推送 Kit (PushKit) 为 HarmonyOS 应用提供可靠的消息推送服务。支持通知消息、数据消息、透传消息等多种推送类型，以及多端同步、分组推送等高级功能。

## 重要说明

- **Kit 名称**: PushKit
- **SDK 版本**: HarmonyOS 4.1.0+ (API 11+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  AAID,
  pushCommon,
  PushExtensionAbility,
  PushExtensionContext,
  pushService,
  RemoteLocationExtensionAbility,
  RemoteLocationExtensionContext,
  RemoteNotificationExtensionAbility,
  RemoteNotificationExtensionContext,
  serviceNotification,
  VoIPExtensionAbility,
  VoIPExtensionContext
} from '@kit.PushKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| AAID | Class | 应用匿名标识符 |
| pushCommon | Module | 推送通用模块 |
| PushExtensionAbility | Class | 推送扩展能力 |
| PushExtensionContext | Class | 推送扩展上下文 |
| pushService | Module | 推送服务模块 |
| serviceNotification | Module | 服务通知模块 |

### 2.2 主要接口

#### pushService.getToken()

获取推送令牌。

返回值: `Promise<string>`

#### pushService.on()

监听推送消息。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| callback | Callback | 是 | - | 消息回调 |

## 三、使用示例

### 3.1 获取推送令牌

```typescript
import { pushService } from '@kit.PushKit'

async function getPushToken(): Promise<void> {
  try {
    const token = await pushService.getToken()
    console.log('Push token:', token)
  } catch (error) {
    console.error('Get token failed:', error)
  }
}
```

### 3.2 监听推送消息

```typescript
import { pushService } from '@kit.PushKit'

function listenPushMessages(): void {
  pushService.on('message', (message) => {
    console.log('Received message:', message)
    // 处理推送消息
  })
}
```

### 3.3 发送本地通知

```typescript
import { serviceNotification } from '@kit.PushKit'

async function sendLocalNotification(): Promise<void> {
  try {
    await serviceNotification.notify({
      title: '本地通知',
      content: '这是一条本地通知'
    })
  } catch (error) {
    console.error('Send notification failed:', error)
  }
}
```

## 四、最佳实践

1. **令牌管理**: 及时刷新并同步推送令牌
2. **消息处理**: 在后台正确处理推送消息
3. **用户权限**: 尊重用户的通知偏好设置
4. **消息分类**: 合理分类处理不同类型的推送
5. **性能优化**: 避免在消息处理中执行耗时操作

## 五、常见问题

### Q: 推送令牌会过期吗？

A: 会，需要定期刷新并更新到服务器。

### Q: 如何区分通知消息和数据消息？

A: 通知消息有默认UI展示，数据消息需要自行处理。

## 六、权限要求

| 权限名称 | 用途 |
|---------|------|
| ohos.permission.NOTIFICATION_CONTROLLER | 通知控制器权限 |
| ohos.permission.INTERNET | 网络权限 |

## 七、参考资料

- [推送服务官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/push-introduction-V5)

---
## See Also
- [AccountKit](kit/account-kit.md) - 华为账号
