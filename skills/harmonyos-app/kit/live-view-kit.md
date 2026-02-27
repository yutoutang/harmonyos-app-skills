---
name: live-view-kit
description: 实时视图 Kit，提供锁屏实时视图能力
---

# 实时视图 HarmonyOS 开发 Skill

## 概述

实时视图 Kit (LiveViewKit) 为 HarmonyOS 应用提供锁屏实时视图能力，允许应用在锁屏界面展示实时信息。

## 重要说明

- **Kit 名称**: LiveViewKit
- **SDK 版本**: HarmonyOS 4.1.0+ (API 11+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  liveViewManager,
  LiveViewLockScreenExtensionAbility,
  LiveViewLockScreenExtensionContext
} from '@kit.LiveViewKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| liveViewManager | Module | 实时视图管理器 |
| LiveViewLockScreenExtensionAbility | Class | 锁屏扩展能力 |
| LiveViewLockScreenExtensionContext | Class | 锁屏扩展上下文 |

### 2.2 主要接口

#### liveViewManager.start()

启动实时视图。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| content | LiveViewContent | 是 | - | 视图内容 |

返回值: `Promise<void>`

## 三、使用示例

### 3.1 创建锁屏实时视图

```typescript
import { LiveViewLockScreenExtensionAbility } from '@kit.LiveViewKit'

export default class MyLiveViewExtension extends LiveViewLockScreenExtensionAbility {
  onCreated(): void {
    console.log('LiveViewExtension created')
  }

  onDestroy(): void {
    console.log('LiveViewExtension destroyed')
  }
}
```

## 四、最佳实践

1. **内容简洁**: 锁屏空间有限，显示简洁信息
2. **性能优化**: 避免频繁更新
3. **电量管理**: 考虑对电量的影响

## 五、参考资料

- [实时视图官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/liveview-introduction-V5)

---
## See Also
- [ScreenTimeGuardKit](kit/screen-time-guard-kit.md) - 屏幕时间守护
