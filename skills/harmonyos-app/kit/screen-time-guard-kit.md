---
name: screen-time-guard-kit
description: 屏幕时间守护 Kit，提供屏幕时间管理能力
---

# 屏幕时间守护 HarmonyOS 开发 Skill

## 概述

屏幕时间守护 Kit (ScreenTimeGuardKit) 为 HarmonyOS 应用提供屏幕时间管理能力，帮助用户管理和控制应用使用时间。

## 重要说明

- **Kit 名称**: ScreenTimeGuardKit
- **SDK 版本**: HarmonyOS 6.0.0+ (API 20+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  guardService,
  appPicker,
  TimeGuardExtensionContext,
  TimeGuardExtensionAbility
} from '@kit.ScreenTimeGuardKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| guardService | Module | 守护服务模块 |
| appPicker | Module | 应用选择器 |
| TimeGuardExtensionContext | Class | 时间守护扩展上下文 |
| TimeGuardExtensionAbility | Class | 时间守护扩展能力 |

### 2.2 主要接口

#### guardService.setLimit()

设置时间限制。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| bundleName | string | 是 | - | 应用包名 |
| limit | number | 是 | - | 时间限制(秒) |

返回值: `Promise<void>`

## 三、使用示例

### 3.1 设置应用时间限制

```typescript
import { guardService } from '@kit.ScreenTimeGuardKit'

async function setAppTimeLimit(): Promise<void> {
  try {
    await guardService.setLimit({
      bundleName: 'com.example.app',
      dailyLimit: 3600 // 1小时
    })

    console.log('Time limit set')
  } catch (error) {
    console.error('Set limit failed:', error)
  }
}
```

## 四、最佳实践

1. **用户控制**: 尊重用户的使用偏好
2. **提醒机制**: 提供友好的提醒机制
3. **豁免列表**: 支持必要应用的豁免

## 五、参考资料

- [屏幕时间守护官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/screentimeguard-introduction-V5)

---
## See Also
- [LiveViewKit](kit/live-view-kit.md) - 实时视图
