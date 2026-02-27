---
name: account-kit
description: 华为账号服务 Kit，提供用户认证、登录和账号管理功能
---

# 华为账号 HarmonyOS 开发 Skill

## 概述

华为账号 Kit (AccountKit) 为 HarmonyOS 应用提供完整的用户认证和账号管理解决方案。支持华为账号登录、匿名登录、实人认证、收货地址管理、未成年人保护等功能。

## 重要说明

- **Kit 名称**: AccountKit
- **SDK 版本**: HarmonyOS 4.1.0+ (API 11+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  authentication,
  extendService,
  LoginPanel,
  LoginWithHuaweiIDButton,
  loginComponentManager,
  realName,
  shippingAddress,
  minorsProtection,
  invoiceAssistant
} from '@kit.AccountKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| authentication | Module | 华为账号认证服务，提供登录、登出、获取用户信息等功能 |
| extendService | Module | 账号扩展服务 |
| LoginPanel | Class | 登录面板组件 |
| LoginWithHuaweiIDButton | Class | 华为账号登录按钮组件 |
| loginComponentManager | Class | 登录组件管理器 |
| realName | Module | 实人认证服务 |
| shippingAddress | Module | 收货地址管理服务 |
| minorsProtection | Module | 未成年人保护服务 |
| invoiceAssistant | Module | 发票助手服务 |

### 2.2 主要接口

#### authentication.authenticate()

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| param | AuthParam | 是 | - | 认证参数 |

返回值: `Promise<AuthResult>`

## 三、使用示例

### 3.1 华为账号登录

```typescript
import { authentication } from '@kit.AccountKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

async function loginWithHuaweiID(): Promise<void> {
  try {
    const result = await authentication.authenticate({
      forceLogin: false,
      requestAuthToken: true,
      requestAccessToken: true
    })

    hilog.info(0x0000, 'AccountKit', 'Login success: %{public}s', JSON.stringify(result))
  } catch (error) {
    const err = error as BusinessError
    hilog.error(0x0000, 'AccountKit', 'Login failed: %{public}d, %{public}s',
      err.code, err.message)
  }
}
```

### 3.2 使用登录按钮组件

```typescript
import { LoginWithHuaweiIDButton } from '@kit.AccountKit'
import { hilog } from '@kit.PerformanceAnalysisKit'

@Entry
@ComponentV2
struct LoginPage {
  @Local loginResult: string = ''

  build() {
    Column() {
      Text('华为账号登录示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      LoginWithHuaweiIDButton({
        onClicked: (event) => {
          if (event.errorCode === 0) {
            this.loginResult = '登录成功'
          } else {
            this.loginResult = `登录失败: ${event.errorCode}`
          }
        }
      })
        .width('80%')
        .height(48)

      if (this.loginResult) {
        Text(this.loginResult)
          .margin({ top: 16 })
          .fontSize(16)
      }
    }
    .width('100%')
    .height('100%')
    .padding(16)
  }
}
```

### 3.3 获取用户信息

```typescript
import { authentication } from '@kit.AccountKit'
import { hilog } from '@kit.PerformanceAnalysisKit'

async function getUserInfo(): Promise<void> {
  try {
    const authAccount = await authentication.getAuthAccount()

    hilog.info(0x0000, 'AccountKit',
      'User ID: %{public}s, Display Name: %{public}s',
      authAccount.id, authAccount.displayName)
  } catch (error) {
    hilog.error(0x0000, 'AccountKit', 'Get user info failed')
  }
}
```

### 3.4 退出登录

```typescript
import { authentication } from '@kit.AccountKit'

async function logout(): Promise<void> {
  try {
    await authentication.logout()
    console.log('Logout success')
  } catch (error) {
    console.error('Logout failed:', error)
  }
}
```

## 四、最佳实践

1. **登录状态检查**: 在应用启动时检查登录状态，而非每次使用时检查
2. **错误处理**: 对所有认证操作进行完整的错误处理
3. **用户信息缓存**: 合理缓存用户信息，减少网络请求
4. **登录超时处理**: 设置合理的登录超时时间
5. **多设备支持**: 考虑用户在多设备上使用同一账号的场景

## 五、常见问题

### Q: 如何判断用户是否已登录？

A: 使用 `authentication.getAuthAccount()` 方法，如果未登录会抛出异常。

### Q: 登录按钮样式可以自定义吗？

A: 可以使用 `LoginPanel` 组件进行更灵活的自定义，或使用 API 自己实现登录流程。

### Q: 如何获取用户头像？

A: 通过 `authAccount.avatarUri` 属性获取用户头像 URI。

## 六、权限要求

| 权限名称 | 用途 |
|---------|------|
| ohos.permission.INTERNET | 网络访问权限，用于与华为账号服务器通信 |

## 七、参考资料

- [华为账号服务官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/account-introduction-V5)
- [AccountKit API 参考](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/account-overview-V5)

---
## See Also
- [ScanKit](kit/scan-kit.md) - 扫码服务
- [ShareKit](kit/share-kit.md) - 分享服务
