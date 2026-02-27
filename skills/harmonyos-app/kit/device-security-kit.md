---
name: device-security-kit
description: 设备安全 Kit，提供设备安全检测、认证等安全能力
---

# 设备安全 HarmonyOS 开发 Skill

## 概述

设备安全 Kit (DeviceSecurityKit) 为 HarmonyOS 应用提供完整的设备安全能力，包括安全检测、设备证书、安全审计、可信应用、反欺诈、可信认证、防窥屏等功能。

## 重要说明

- **Kit 名称**: DeviceSecurityKit
- **SDK 版本**: HarmonyOS 5.0.0+ (API 12+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  safetyDetect,
  deviceCertificate,
  securityAudit,
  trustedAppService,
  businessRiskIntelligentDetection,
  antifraudPicker,
  trustedAuthentication,
  dlpAntiPeep
} from '@kit.DeviceSecurityKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| safetyDetect | Module | 安全检测 |
| deviceCertificate | Module | 设备证书 |
| securityAudit | Module | 安全审计 |
| trustedAppService | Module | 可信应用服务 |
| businessRiskIntelligentDetection | Module | 业务风险智能检测 |
| antifraudPicker | Module | 反欺诈 |
| trustedAuthentication | Module | 可信认证 |
| dlpAntiPeep | Module | 防窥屏 |

### 2.2 主要接口

#### safetyDetect.isDeviceSecure()

检测设备是否安全。

返回值: `Promise<boolean>`

#### trustedAuthentication.verify()

可信认证验证。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| challenge | string | 是 | - | 认证挑战 |

返回值: `Promise<AuthResult>`

## 三、使用示例

### 3.1 设备安全检测

```typescript
import { safetyDetect } from '@kit.DeviceSecurityKit'

async function checkDeviceSecurity(): Promise<void> {
  try {
    const isSecure = await safetyDetect.isDeviceSecure()

    if (isSecure) {
      console.log('Device is secure')
    } else {
      console.log('Device may be compromised')
    }
  } catch (error) {
    console.error('Security check failed:', error)
  }
}
```

### 3.2 防窥屏保护

```typescript
import { dlpAntiPeep } from '@kit.DeviceSecurityKit'

async function enableAntiPeep(): Promise<void> {
  try {
    await dlpAntiPeep.enable({
      sensitivity: dlpAntiPeep.Sensitivity.HIGH
    })

    console.log('Anti-peep enabled')
  } catch (error) {
    console.error('Enable anti-peep failed:', error)
  }
}
```

## 四、最佳实践

1. **多层防护**: 结合多种安全能力
2. **用户体验**: 安全措施不影响用户体验
3. **定期检查**: 定期进行安全检查

## 五、参考资料

- [设备安全官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/security-introduction-V5)

---
## See Also
- [OnlineAuthenticationKit](kit/online-auth-kit.md) - 在线认证
