---
name: nearlink-kit
description: 星闪 Kit，提供短距离无线通信能力
---

# 星闪 HarmonyOS 开发 Skill

## 概述

星闪 Kit (NearLinkKit) 为 HarmonyOS 应用提供星闪短距离无线通信能力，支持设备发现、数据传输等功能。

## 重要说明

- **Kit 名称**: NearLinkKit
- **SDK 版本**: HarmonyOS 5.0.1+ (API 13+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  advertising,
  scan,
  constant,
  manager,
  remoteDevice,
  ssap,
  dataTransfer
} from '@kit.NearLinkKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| advertising | Module | 广播模块 |
| scan | Module | 扫描模块 |
| constant | Module | 常量模块 |
| manager | Module | 管理器模块 |
| remoteDevice | Module | 远程设备模块 |
| ssap | Module | 星闪应用协议 |
| dataTransfer | Module | 数据传输模块 |

### 2.2 主要接口

#### scan.startScan()

启动扫描。

返回值: `Promise<void>`

#### dataTransfer.send()

发送数据。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| data | ArrayBuffer | 是 | - | 待发送数据 |

返回值: `Promise<void>`

## 三、使用示例

### 3.1 扫描星闪设备

```typescript
import { scan } from '@kit.NearLinkKit'

async function scanNearlinkDevices(): Promise<void> {
  try {
    await scan.startScan({
      onDeviceFound: (device) => {
        console.log('Found device:', device.name, device.macAddress)
      }
    })
  } catch (error) {
    console.error('Scan failed:', error)
  }
}
```

## 四、最佳实践

1. **权限管理**: 需要位置和蓝牙权限
2. **电量优化**: 合理控制扫描时间
3. **连接管理**: 正确管理设备连接状态

## 五、权限要求

| 权限名称 | 用途 |
|---------|------|
| ohos.permission.ACCESS_BLUETOOTH | 蓝牙权限 |
| ohos.permission.LOCATION | 位置权限 |

## 六、参考资料

- [星闪官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/nearlink-introduction-V5)

---
## See Also
- [RemoteCommunicationKit](kit/remote-communication-kit.md) - 远程通信
