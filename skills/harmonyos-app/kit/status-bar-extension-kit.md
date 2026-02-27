---
name: status-bar-extension-kit
description: 状态栏扩展 Kit (已弃用)，请使用 DesktopExtensionKit
---

# 状态栏扩展 HarmonyOS 开发 Skill

## 概述

状态栏扩展 Kit (StatusBarExtensionKit) 为 HarmonyOS 应用提供状态栏扩展能力。

> **注意**: 此 Kit 已于 6.0.0(20) 版本弃用，请使用 [DesktopExtensionKit](kit/desktop-extension-kit.md) 代替。

## 重要说明

- **Kit 名称**: StatusBarExtensionKit
- **SDK 版本**: HarmonyOS 5.0.0+ (API 12+)
- **状态**: 已弃用 (@since 6.0.0(20))
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  statusBarManager,
  StatusBarViewExtensionAbility
} from '@kit.StatusBarExtensionKit'
```

## 二、迁移指南

### 迁移到 DesktopExtensionKit

**旧代码 (StatusBarExtensionKit):**
```typescript
import { statusBarManager } from '@kit.StatusBarExtensionKit'
```

**新代码 (DesktopExtensionKit):**
```typescript
import { statusBarManager } from '@kit.DeskTopExtensionKit'
```

API 基本保持兼容，只需更新导入语句即可。

## 三、参考资料

- [桌面扩展官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/desktop-introduction-V5)

---
## See Also
- [DesktopExtensionKit](kit/desktop-extension-kit.md) - 桌面扩展 (推荐)
