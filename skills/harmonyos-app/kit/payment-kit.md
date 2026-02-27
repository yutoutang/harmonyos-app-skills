---
name: payment-kit
description: 支付服务 Kit，提供移动支付能力
---

# 支付服务 HarmonyOS 开发 Skill

## 概述

支付 Kit (PaymentKit) 为 HarmonyOS 应用提供完整的移动支付解决方案。支持数字人民币、银行卡支付等多种支付方式。

## 重要说明

- **Kit 名称**: PaymentKit
- **SDK 版本**: HarmonyOS 4.1.0+ (API 11+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  paymentService,
  ecnyPaymentService,
  realNameService,
  thirdPaymentService
} from '@kit.PaymentKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| paymentService | Module | 支付服务核心模块 |
| ecnyPaymentService | Module | 数字人民币支付服务 |
| realNameService | Module | 实名认证服务 |
| thirdPaymentService | Module | 第三方支付服务 |

### 2.3 主要接口

#### paymentService.pay()

发起支付请求。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| orderInfo | OrderInfo | 是 | - | 订单信息 |

返回值: `Promise<PaymentResult>`

## 三、使用示例

### 3.1 发起支付

```typescript
import { paymentService } from '@kit.PaymentKit'

async function pay(): Promise<void> {
  try {
    const result = await paymentService.pay({
      orderId: 'ORDER_001',
      amount: 100,
      currency: 'CNY'
    })

    if (result.isSuccess) {
      console.log('Payment success')
    }
  } catch (error) {
    console.error('Payment failed:', error)
  }
}
```

## 四、最佳实践

1. **订单验证**: 支付完成后进行服务端验证
2. **安全防护**: 保护支付敏感信息
3. **用户反馈**: 及时反馈支付状态
4. **异常处理**: 妥善处理支付异常

## 五、参考资料

- [支付服务官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/payment-introduction-V5)

---
## See Also
- [IAPKit](kit/iap-kit.md) - 应用内购买
