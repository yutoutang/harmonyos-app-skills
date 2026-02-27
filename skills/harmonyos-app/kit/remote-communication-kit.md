---
name: remote-communication-kit
description: 远程通信 Kit，提供 RPC 远程通信能力
---

# 远程通信 HarmonyOS 开发 Skill

## 概述

远程通信 Kit (RemoteCommunicationKit) 为 HarmonyOS 应用提供 RPC 远程通信能力，支持设备间和服务间的远程调用。

## 重要说明

- **Kit 名称**: RemoteCommunicationKit
- **SDK 版本**: HarmonyOS 4.1.0+ (API 11+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  rcp,
  urpc
} from '@kit.RemoteCommunicationKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| rcp | Module | RPC 模块 |
| urpc | Module | uRPC 模块 |

### 2.2 主要接口

#### rcp.call()

调用远程方法。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| method | string | 是 | - | 方法名 |
| params | any[] | 否 | [] | 参数列表 |

返回值: `Promise<any>`

## 三、使用示例

### 3.1 RPC 调用

```typescript
import { rcp } from '@kit.RemoteCommunicationKit'

async function callRemoteMethod(): Promise<void> {
  try {
    const result = await rcp.call('remoteService.methodName', [
      'param1',
      'param2'
    ])

    console.log('RPC result:', result)
  } catch (error) {
    console.error('RPC call failed:', error)
  }
}
```

## 四、最佳实践

1. **超时设置**: 设置合理的超时时间
2. **错误处理**: 完善的错误处理和重试机制
3. **序列化**: 注意参数序列化限制

## 五、参考资料

- [远程通信官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/rcp-introduction-V5)

---
## See Also
- [ServiceCollaborationKit](kit/service-collaboration-kit.md) - 服务协作
