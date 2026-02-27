---
name: desktop-extension-kit
description: 桌面扩展 Kit，提供桌面状态栏扩展能力
---

# 桌面扩展 HarmonyOS 开发 Skill

## 概述

桌面扩展 Kit (DesktopExtensionKit) 为 HarmonyOS 应用提供桌面状态栏扩展能力，允许应用在桌面状态栏中显示自定义内容。

## 重要说明

- **Kit 名称**: DesktopExtensionKit
- **SDK 版本**: HarmonyOS 6.0.0+ (API 20+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  statusBarManager,
  StatusBarViewExtensionAbility
} from '@kit.DeskTopExtensionKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| statusBarManager | Module | 状态栏管理模块 |
| StatusBarViewExtensionAbility | Class | 状态栏视图扩展能力 |

### 2.2 主要接口

#### statusBarManager.show()

显示状态栏扩展。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| content | Content | 是 | - | 显示内容 |

返回值: `Promise<void>`

## 三、使用示例

### 3.1 创建状态栏扩展

```typescript
import { StatusBarViewExtensionAbility } from '@kit.DeskTopExtensionKit'

export default class MyStatusBarExtension extends StatusBarViewExtensionAbility {
  onCreated(): void {
    console.log('StatusBarExtension created')
  }

  onDestroy(): void {
    console.log('StatusBarExtension destroyed')
  }
}
```

## 四、最佳实践

1. **内容简洁**: 状态栏空间有限，显示简洁内容
2. **性能优化**: 避免频繁更新状态栏内容
3. **用户隐私**: 不在状态栏显示敏感信息

## 五、参考资料

- [桌面扩展官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/desktop-introduction-V5)

---
## See Also
- [StatusBarExtensionKit](kit/status-bar-extension-kit.md) - 状态栏扩展 (已弃用)
