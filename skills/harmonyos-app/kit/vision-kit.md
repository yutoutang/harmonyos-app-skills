---
name: vision-kit
description: 视觉服务 Kit，提供文档扫描、卡片识别等 AI 视觉能力
---

# 视觉服务 HarmonyOS 开发 Skill

## 概述

视觉 Kit (VisionKit) 为 HarmonyOS 应用提供强大的 AI 视觉能力，包括文档扫描、卡片识别、活体检测等功能。

## 重要说明

- **Kit 名称**: VisionKit
- **SDK 版本**: HarmonyOS 5.0.0+ (API 12+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  interactiveLiveness,
  CardRecognition,
  CallbackParam,
  CardRecognitionResult,
  CardType,
  CardSide,
  CardRecognitionConfig,
  CardContentConfig,
  BankCardConfig,
  IdCardConfig,
  DocumentScanner,
  DocumentScannerConfig,
  DocType,
  FilterId,
  ShootingMode,
  EditTab,
  SaveOption,
  DocumentScannerResultCallback,
  visionImageAnalyzer
} from '@kit.VisionKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| interactiveLiveness | Module | 交互式活体检测 |
| CardRecognition | Class | 卡片识别 |
| DocumentScanner | Class | 文档扫描 |
| visionImageAnalyzer | Module | 图像分析 |

### 2.2 主要接口

#### DocumentScanner.start()

启动文档扫描。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| config | DocumentScannerConfig | 是 | - | 扫描配置 |
| callback | Callback | 是 | - | 结果回调 |

#### CardRecognition.start()

启动卡片识别。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| config | CardRecognitionConfig | 是 | - | 识别配置 |

## 三、使用示例

### 3.1 文档扫描

```typescript
import { DocumentScanner, DocumentScannerConfig } from '@kit.VisionKit'

async function scanDocument(): Promise<void> {
  const config: DocumentScannerConfig = {
    docType: DocType.DOC,
    filterId: FilterId.ORIGINAL,
    shootingMode: ShootingMode.AUTO
  }

  DocumentScanner.start(config, (result) => {
    if (result.success) {
      console.log('Scanned pages:', result.pages)
    }
  })
}
```

### 3.2 身份证识别

```typescript
import { CardRecognition, CardType, CardSide } from '@kit.VisionKit'

async function recognizeIdCard(): Promise<void> {
  const config = {
    cardType: CardType.ID_CARD,
    cardSide: CardSide.FRONT
  }

  const result = await CardRecognition.start(config)
  console.log('ID Card:', result.cardContent)
}
```

## 四、最佳实践

1. **权限管理**: 需要相机和存储权限
2. **结果验证**: 对识别结果进行业务验证
3. **性能优化**: 合理配置识别参数
4. **用户引导**: 提供清晰的操作指引

## 五、权限要求

| 权限名称 | 用途 |
|---------|------|
| ohos.permission.CAMERA | 相机权限 |

## 六、参考资料

- [视觉服务官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/vision-introduction-V5)

---
## See Also
- [CoreVisionKit](kit/core-vision-kit.md) - 核心视觉服务
