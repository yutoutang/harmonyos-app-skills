---
name: pen-kit
description: 手写笔 Kit，提供手写和笔迹识别能力
---

# 手写笔 HarmonyOS 开发 Skill

## 概述

手写笔 Kit (Penkit) 为 HarmonyOS 应用提供手写输入和笔迹识别能力，支持手写组件、图形生成、点预测等功能。

## 重要说明

- **Kit 名称**: Penkit
- **SDK 版本**: HarmonyOS 5.0.0+ (API 12+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  HandwriteComponent,
  HandwriteController,
  PenHspInfo,
  PenType,
  InstantShapeGenerator,
  ShapeInfo,
  PointPredictor,
  imageFeaturePicker,
  stylusInteraction
} from '@kit.Penkit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| HandwriteComponent | Component | 手写组件 |
| HandwriteController | Class | 手写控制器 |
| PenHspInfo | Interface | 笔信息 |
| PenType | Enum | 笔类型 |
| InstantShapeGenerator | Class | 即时图形生成器 |
| ShapeInfo | Class | 图形信息 |
| PointPredictor | Class | 点预测器 |
| imageFeaturePicker | Module | 图像特征选择器 |
| stylusInteraction | Module | 手写笔交互模块 |

### 2.2 主要接口

#### InstantShapeGenerator.generate()

生成手写图形。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| points | Point[] | 是 | - | 笔迹点 |

返回值: `ShapeInfo`

## 三、使用示例

### 3.1 手写组件

```typescript
import { HandwriteComponent, HandwriteController } from '@kit.Penkit'

@Entry
@ComponentV2
struct HandwritePage {
  @Local controller: HandwriteController = new HandwriteController()

  build() {
    HandwriteComponent({
      controller: this.controller
    })
      .width('100%')
      .height('100%')
  }
}
```

## 四、最佳实践

1. **笔迹优化**: 优化笔迹平滑度和响应速度
2. **手势识别**: 识别常见手势操作
3. **压感支持**: 支持压感级别

## 五、参考资料

- [手写笔官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/pen-introduction-V5)

---
## See Also
- [UIDesignKit](kit/ui-design-kit.md) - UI 设计服务
