---
name: ar-engine
description: AR 引擎 Kit，提供增强现实开发能力
---

# AR 引擎 HarmonyOS 开发 Skill

## 概述

AR 引擎 Kit (AREngine) 为 HarmonyOS 应用提供强大的增强现实开发能力，支持平面检测、图像跟踪、3D 物体渲染等功能。

## 重要说明

- **Kit 名称**: AREngine
- **SDK 版本**: HarmonyOS 5.1.0+ (API 18+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  arEngine,
  ARView,
  arViewController
} from '@kit.AREngine'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| arEngine | Module | AR 引擎核心模块 |
| ARView | Component | AR 视图组件 |
| arViewController | Class | AR 视图控制器 |

### 2.2 主要接口

#### arEngine.initialize()

初始化 AR 引擎。

返回值: `Promise<void>`

#### arEngine.loadWorld()

加载 AR 世界。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| config | ARConfig | 是 | - | AR 配置 |

## 三、使用示例

### 3.1 显示 AR 视图

```typescript
import { ARView } from '@kit.AREngine'

@Entry
@ComponentV2
struct ARExamplePage {
  build() {
    ARView()
      .width('100%')
      .height('100%')
  }
}
```

## 四、最佳实践

1. **性能优化**: 合理控制 AR 场景复杂度
2. **权限管理**: 需要相机权限
3. **设备兼容**: 检测设备 AR 兼容性
4. **电量管理**: AR 功能耗电较大，注意优化

## 五、权限要求

| 权限名称 | 用途 |
|---------|------|
| ohos.permission.CAMERA | 相机权限 |

## 六、参考资料

- [AR 引擎官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/ar-introduction-V5)

---
## See Also
- [VisionKit](kit/vision-kit.md) - 视觉服务
