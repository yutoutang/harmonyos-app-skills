---
name: enterprise-space-kit
description: 企业空间 Kit，提供企业文件传输和空间管理能力
---

# 企业空间 HarmonyOS 开发 Skill

## 概述

企业空间 Kit (EnterpriseSpaceKit) 为 HarmonyOS 应用提供企业文件传输和企业空间管理能力。

## 重要说明

- **Kit 名称**: EnterpriseSpaceKit
- **SDK 版本**: HarmonyOS 6.0.0+ (API 20+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  fileTransfer,
  spaceManager
} from '@kit.EnterpriseSpaceKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| fileTransfer | Module | 文件传输模块 |
| spaceManager | Module | 空间管理模块 |

### 2.2 主要接口

#### fileTransfer.transfer()

传输文件到企业空间。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| fileUri | string | 是 | - | 文件 URI |

返回值: `Promise<TransferResult>`

## 三、使用示例

### 3.1 传输文件到企业空间

```typescript
import { fileTransfer } from '@kit.EnterpriseSpaceKit'

async function transferToEnterpriseSpace(fileUri: string): Promise<void> {
  try {
    const result = await fileTransfer.transfer(fileUri)

    console.log('File transferred:', result.destinationUri)
  } catch (error) {
    console.error('Transfer failed:', error)
  }
}
```

## 四、最佳实践

1. **网络检测**: 传输前检查网络状态
2. **断点续传**: 支持大文件断点续传
3. **进度反馈**: 提供传输进度反馈

## 五、参考资料

- [企业空间官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/enterprise-space-introduction-V5)

---
## See Also
- [EnterpriseDataGuardKit](kit/enterprise-data-guard-kit.md) - 企业数据保护
