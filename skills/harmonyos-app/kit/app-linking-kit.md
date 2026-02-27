---
name: app-linking-kit
description: 应用链接 Kit，提供跨应用链接能力
---

# 应用链接 HarmonyOS 开发 Skill

## 概述

应用链接 Kit (AppLinkingKit) 为 HarmonyOS 应用提供跨应用链接能力，支持延迟深度链接，即使应用未安装也能在安装后跳转到指定页面。

## 重要说明

- **Kit 名称**: AppLinkingKit
- **SDK 版本**: HarmonyOS 5.0.3+ (API 15+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import { deferredLink } from '@kit.AppLinkingKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| deferredLink | Module | 延迟链接模块 |

### 2.2 主要接口

#### deferredLink.getLink()

获取延迟链接信息。

返回值: `Promise<DeferredLinkResult>`

## 三、使用示例

### 3.1 处理延迟链接

```typescript
import { deferredLink } from '@kit.AppLinkingKit'

async function handleDeferredLink(): Promise<void> {
  try {
    const linkResult = await deferredLink.getLink()

    if (linkResult && linkResult.linkUri) {
      // 跳转到对应页面
      console.log('Deferred link:', linkResult.linkUri)
      navigateToPage(linkResult.linkUri)
    }
  } catch (error) {
    console.error('Handle deferred link failed:', error)
  }
}
```

## 四、最佳实践

1. **首次启动检查**: 在应用首次启动时检查延迟链接
2. **链接验证**: 验证链接来源和有效性
3. **用户引导**: 提供清晰的用户引导

## 五、参考资料

- [应用链接官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/applinking-introduction-V5)

---
## See Also
- [AppGalleryKit](kit/app-gallery-kit.md) - 应用市场服务
