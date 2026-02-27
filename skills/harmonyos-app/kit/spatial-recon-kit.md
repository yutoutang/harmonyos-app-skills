---
name: spatial-recon-kit
description: 空间重建 Kit，提供空间场景重建能力
---

# 空间重建 HarmonyOS 开发 Skill

## 概述

空间重建 Kit (SpatialReconKit) 为 HarmonyOS 应用提供空间场景重建能力，支持3D空间建模和渲染。

## 重要说明

- **Kit 名称**: SpatialReconKit
- **SDK 版本**: HarmonyOS 6.0.1+ (API 21+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import { spatialRender } from '@kit.SpatialReconKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| spatialRender | Module | 空间渲染模块 |

### 2.2 主要接口

#### spatialRender.initialize()

初始化空间渲染。

返回值: `Promise<void>`

## 三、使用示例

### 3.1 初始化空间渲染

```typescript
import { spatialRender } from '@kit.SpatialReconKit'

async function initSpatialRender(): Promise<void> {
  try {
    await spatialRender.initialize()

    console.log('Spatial render initialized')
  } catch (error) {
    console.error('Initialize failed:', error)
  }
}
```

## 四、最佳实践

1. **性能优化**: 控制场景复杂度
2. **精度平衡**: 在精度和性能间找平衡
3. **存储管理**: 管理空间数据存储

## 五、参考资料

- [空间重建官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/spatial-recon-introduction-V5)

---
## See Also
- [AREngine](kit/ar-engine.md) - AR 引擎
