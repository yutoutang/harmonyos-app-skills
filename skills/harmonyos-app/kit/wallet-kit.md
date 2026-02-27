---
name: wallet-kit
description: 钱包服务 Kit，提供卡包和交通卡能力
---

# 钱包服务 HarmonyOS 开发 Skill

## 概述

钱包 Kit (WalletKit) 为 HarmonyOS 应用提供卡包和交通卡能力，支持添加卡证、交通卡充值等功能。

## 重要说明

- **Kit 名称**: WalletKit
- **SDK 版本**: HarmonyOS 5.0.0+ (API 12+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  walletPass,
  walletTransitCard
} from '@kit.WalletKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| walletPass | Module | 卡包模块 |
| walletTransitCard | Module | 交通卡模块 |

### 2.2 主要接口

#### walletPass.addPass()

添加卡证。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| passData | PassData | 是 | - | 卡证数据 |

返回值: `Promise<string>`

## 三、使用示例

### 3.1 添加卡证

```typescript
import { walletPass } from '@kit.WalletKit'

async function addPass(): Promise<void> {
  try {
    const passId = await walletPass.addPass({
      type: 'boardingPass',
      title: '机票',
      data: { /* 卡证数据 */ }
    })

    console.log('Pass added:', passId)
  } catch (error) {
    console.error('Add pass failed:', error)
  }
}
```

### 3.2 交通卡充值

```typescript
import { walletTransitCard } from '@kit.WalletKit'

async function rechargeTransitCard(): Promise<void> {
  try {
    await walletTransitCard.recharge({
      cardId: 'card_id',
      amount: 100
    })

    console.log('Recharge success')
  } catch (error) {
    console.error('Recharge failed:', error)
  }
}
```

## 四、最佳实践

1. **数据验证**: 验证卡证数据的有效性
2. **安全保护**: 保护敏感卡证信息
3. **用户引导**: 提供清晰的操作引导

## 五、参考资料

- [钱包服务官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/wallet-introduction-V5)

---
## See Also
- [PaymentKit](kit/payment-kit.md) - 支付服务
