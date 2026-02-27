---
name: store-kit
description: 应用商店服务 Kit (已弃用)，请使用 AppGalleryKit
---

# 应用商店服务 HarmonyOS 开发 Skill

## 概述

商店 Kit (StoreKit) 为 HarmonyOS 应用提供与应用商店的交互能力。

> **注意**: 此 Kit 已于 5.0.3(15) 版本弃用，请使用 [AppGalleryKit](kit/app-gallery-kit.md) 代替。

## 重要说明

- **Kit 名称**: StoreKit
- **SDK 版本**: HarmonyOS 4.1.0+ (API 11+)
- **状态**: 已弃用 (@since 5.0.3(15))
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  appInfoManager,
  productViewManager,
  moduleInstallManager,
  sceneManager,
  updateManager,
  attributionManager,
  attributionTestManager,
  privacyManager
} from '@kit.StoreKit'
```

## 二、迁移指南

### 迁移到 AppGalleryKit

**旧代码 (StoreKit):**
```typescript
import { appInfoManager } from '@kit.StoreKit'
```

**新代码 (AppGalleryKit):**
```typescript
import { appInfoManager } from '@kit.AppGalleryKit'
```

API 基本保持兼容，只需更新导入语句即可。

## 三、参考资料

- [应用市场服务官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/appgallery-introduction-V5)

---
## See Also
- [AppGalleryKit](kit/app-gallery-kit.md) - 应用市场服务 (推荐)
