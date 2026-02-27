---
name: enterprise-data-guard-kit
description: 企业数据保护 Kit，提供企业文档保护能力
---

# 企业数据保护 HarmonyOS 开发 Skill

## 概述

企业数据保护 Kit (EnterpriseDataGuardKit) 为 HarmonyOS 应用提供企业文档保护能力，支持文档标记、控制和恢复密钥管理。

## 重要说明

- **Kit 名称**: EnterpriseDataGuardKit
- **SDK 版本**: HarmonyOS 4.1.0+ (API 11+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  fileGuard,
  recoveryKey
} from '@kit.EnterpriseDataGuardKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| fileGuard | Module | 文件保护模块 |
| recoveryKey | Module | 恢复密钥服务 |

### 2.2 主要接口

#### fileGuard.protectFile()

保护文件。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| fileUri | string | 是 | - | 文件 URI |
| policy | ProtectionPolicy | 是 | - | 保护策略 |

返回值: `Promise<void>`

## 三、使用示例

### 3.1 保护企业文档

```typescript
import { fileGuard } from '@kit.EnterpriseDataGuardKit'

async function protectDocument(fileUri: string): Promise<void> {
  try {
    await fileGuard.protectFile(fileUri, {
      allowCopy: false,
      allowPrint: false,
      allowExport: false
    })

    console.log('Document protected')
  } catch (error) {
    console.error('Protect document failed:', error)
  }
}
```

## 四、最佳实践

1. **策略设计**: 根据业务需求设计合适的保护策略
2. **密钥管理**: 妥善管理恢复密钥
3. **性能影响**: 考虑加密对性能的影响

## 五、参考资料

- [企业数据保护官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/enterprise-dataguard-introduction-V5)

---
## See Also
- [EnterpriseSpaceKit](kit/enterprise-space-kit.md) - 企业空间
