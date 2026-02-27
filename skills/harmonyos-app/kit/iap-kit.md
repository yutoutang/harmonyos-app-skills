---
name: iap-kit
description: 应用内购买 Kit，提供应用内支付购买能力
---

# 应用内购买 HarmonyOS 开发 Skill

## 概述

应用内购买 Kit (IAPKit) 为 HarmonyOS 应用提供完整的应用内购买解决方案。支持消耗型商品、非消耗型商品、订阅等多种商品类型。

## 重要说明

- **Kit 名称**: IAPKit
- **SDK 版本**: HarmonyOS 4.1.0+ (API 11+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import { iap } from '@kit.IAPKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| iap | Module | 应用内购买核心模块 |

### 2.2 主要接口

#### iap.purchase()

发起购买请求。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| productId | string | 是 | - | 商品ID |
| type | ProductType | 是 | - | 商品类型 |

返回值: `Promise<PurchaseResult>`

#### iap.queryProducts()

查询商品信息。

返回值: `Promise<Product[]>`

## 三、使用示例

### 3.1 查询商品列表

```typescript
import { iap } from '@kit.IAPKit'

async function queryProducts(): Promise<void> {
  try {
    const products = await iap.queryProducts({
      productIds: ['product_001', 'product_002']
    })

    products.forEach(product => {
      console.log('Product:', product.name, product.price)
    })
  } catch (error) {
    console.error('Query products failed:', error)
  }
}
```

### 3.2 发起购买

```typescript
import { iap } from '@kit.IAPKit'

async function purchaseProduct(productId: string): Promise<void> {
  try {
    const result = await iap.purchase({
      productId: productId,
      type: iap.ProductType.CONSUMABLE
    })

    if (result.isSuccess) {
      console.log('Purchase success:', result.orderId)
      // 发货
    }
  } catch (error) {
    console.error('Purchase failed:', error)
  }
}
```

## 四、最佳实践

1. **商品验证**: 购买后进行服务端验证
2. **收据管理**: 妥善保存购买收据
3. **消耗管理**: 及时消耗消耗型商品
4. **错误处理**: 对购买失败进行友好提示
5. **测试环境**: 在沙箱环境充分测试

## 五、常见问题

### Q: 如何处理购买重复发货？

A: 通过服务端记录已发货订单，避免重复发货。

### Q: 订阅如何续费？

A: 系统自动续费，通过监听续费通知处理。

## 六、参考资料

- [应用内购买官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/iap-introduction-V5)

---
## See Also
- [PaymentKit](kit/payment-kit.md) - 支付服务
