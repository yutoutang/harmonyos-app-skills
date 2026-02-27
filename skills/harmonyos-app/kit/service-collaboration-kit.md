---
name: service-collaboration-kit
description: 服务协作 Kit，提供跨设备服务协作能力
---

# 服务协作 HarmonyOS 开发 Skill

## 概述

服务协作 Kit (ServiceCollaborationKit) 为 HarmonyOS 应用提供跨设备服务协作能力，包括服务流转、设备选择等。

## 重要说明

- **Kit 名称**: ServiceCollaborationKit
- **SDK 版本**: HarmonyOS 4.1.0+ (API 11+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  CollaborationCameraBusinessFilter,
  createCollaborationCameraMenuItems,
  CollaborationCameraStateDialog,
  CollaborationServiceFilter,
  createCollaborationServiceMenuItems,
  CollaborationServiceStateDialog,
  CollaborationDevicePicker,
  devicePicker
} from '@kit.ServiceCollaborationKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| CollaborationCameraBusinessFilter | Class | 相机协作过滤器 |
| createCollaborationCameraMenuItems | Function | 创建相机菜单项 |
| CollaborationCameraStateDialog | Class | 相机状态对话框 |
| CollaborationServiceFilter | Class | 服务过滤器 |
| createCollaborationServiceMenuItems | Function | 创建服务菜单项 |
| CollaborationServiceStateDialog | Class | 服务状态对话框 |
| CollaborationDevicePicker | Class | 协作设备选择器 |
| devicePicker | Module | 设备选择器模块 |

### 2.2 主要接口

#### devicePicker.pick()

选择协作设备。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| options | PickerOptions | 是 | - | 选择器选项 |

返回值: `Promise<Device[]>`

## 三、使用示例

### 3.1 选择协作设备

```typescript
import { devicePicker } from '@kit.ServiceCollaborationKit'

async function pickCollaborationDevice(): Promise<void> {
  try {
    const devices = await devicePicker.pick({
      filter: (device) => device.type === 'phone'
    })

    console.log('Selected devices:', devices)
  } catch (error) {
    console.error('Pick device failed:', error)
  }
}
```

## 四、最佳实践

1. **设备发现**: 实现高效的设备发现
2. **连接管理**: 正确管理设备连接
3. **数据同步**: 保证数据一致性

## 五、参考资料

- [服务协作官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/collaboration-introduction-V5)

---
## See Also
- [RemoteCommunicationKit](kit/remote-communication-kit.md) - 远程通信
