---
name: online-auth-kit
description: 在线认证 Kit，提供 FIDO、IFAA、Soter 等在线认证能力
---

# 在线认证 HarmonyOS 开发 Skill

## 概述

在线认证 Kit (OnlineAuthenticationKit) 为 HarmonyOS 应用提供多种在线认证方式，包括 FIDO、IFAA、Soter、FIDO2 等。

## 重要说明

- **Kit 名称**: OnlineAuthenticationKit
- **SDK 版本**: HarmonyOS 4.1.0+ (API 11+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  fido,
  ifaa,
  soter,
  fido2
} from '@kit.OnlineAuthenticationKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| fido | Module | FIDO 认证模块 |
| ifaa | Module | IFAA 认证模块 |
| soter | Module | Soter 认证模块 |
| fido2 | Module | FIDO2 认证模块 |

### 2.2 主要接口

#### fido.register()

注册 FIDO 凭据。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| options | RegisterOptions | 是 | - | 注册选项 |

返回值: `Promise<Credential>`

#### fido.authenticate()

进行 FIDO 认证。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| options | AuthOptions | 是 | - | 认证选项 |

返回值: `Promise<AuthResult>`

## 三、使用示例

### 3.1 FIDO2 注册

```typescript
import { fido2 } from '@kit.OnlineAuthenticationKit'

async function registerFido2(): Promise<void> {
  try {
    const credential = await fido2.register({
      challenge: new Uint8Array([1, 2, 3]),
      user: {
        id: 'user_id',
        name: 'username',
        displayName: 'User Name'
      }
    })

    console.log('FIDO2 registered:', credential.id)
  } catch (error) {
    console.error('Register failed:', error)
  }
}
```

### 3.2 FIDO2 认证

```typescript
import { fido2 } from '@kit.OnlineAuthenticationKit'

async function authenticateFido2(): Promise<void> {
  try {
    const result = await fido2.authenticate({
      challenge: new Uint8Array([1, 2, 3])
    })

    console.log('FIDO2 authenticated')
  } catch (error) {
    console.error('Authenticate failed:', error)
  }
}
```

## 四、最佳实践

1. **降级方案**: 提供多种认证方式的降级方案
2. **用户体验**: 简化认证流程
3. **安全存储**: 妥善存储认证凭据

## 五、参考资料

- [在线认证官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/online-auth-introduction-V5)

---
## See Also
- [AccountKit](kit/account-kit.md) - 华为账号
- [DeviceSecurityKit](kit/device-security-kit.md) - 设备安全
