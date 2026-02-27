---
name: app-gallery-kit
description: 应用市场服务 Kit，提供应用信息、安装、更新等功能
---

# 应用市场服务 HarmonyOS 开发 Skill

## 概述

应用市场 Kit (AppGalleryKit) 为 HarmonyOS 应用提供与应用市场的交互能力，包括应用信息查询、模块安装、应用更新、归因分析等功能。

## 重要说明

- **Kit 名称**: AppGalleryKit
- **SDK 版本**: HarmonyOS 5.0.3+ (API 15+)
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
  privacyManager,
  commentManager
} from '@kit.AppGalleryKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| appInfoManager | Module | 应用信息管理 |
| productViewManager | Module | 产品视图管理 |
| moduleInstallManager | Module | 模块安装管理 |
| sceneManager | Module | 场景管理 |
| updateManager | Module | 应用更新管理 |
| attributionManager | Module | 归因分析管理 |
| attributionTestManager | Module | 归因测试管理 |
| privacyManager | Module | 隐私管理 |
| commentManager | Module | 评论管理 |

### 2.2 主要接口

#### moduleInstallManager.install()

安装模块。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| moduleName | string | 是 | - | 模块名称 |

返回值: `Promise<void>`

#### updateManager.checkUpdate()

检查应用更新。

返回值: `Promise<UpdateInfo>`

## 三、使用示例

### 3.1 检查应用更新

```typescript
import { updateManager } from '@kit.AppGalleryKit'

async function checkForUpdate(): Promise<void> {
  try {
    const updateInfo = await updateManager.checkUpdate()

    if (updateInfo.hasUpdate) {
      console.log('New version available:', updateInfo.version)
    }
  } catch (error) {
    console.error('Check update failed:', error)
  }
}
```

### 3.2 安装动态模块

```typescript
import { moduleInstallManager } from '@kit.AppGalleryKit'

async function installModule(): Promise<void> {
  try {
    await moduleInstallManager.install({
      moduleName: 'dynamic_feature',
      downloadStrategy: moduleInstallManager.DownloadStrategy.DOWNLOAD_NOW
    })

    console.log('Module installed successfully')
  } catch (error) {
    console.error('Install module failed:', error)
  }
}
```

## 四、最佳实践

1. **后台下载**: 支持后台下载，避免影响用户体验
2. **智能推荐**: 根据用户设备推荐合适的模块
3. **更新策略**: 选择合适的更新时机

## 五、参考资料

- [应用市场服务官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/appgallery-introduction-V5)

---
## See Also
- [StoreKit](kit/store-kit.md) - 应用商店服务 (已弃用)
