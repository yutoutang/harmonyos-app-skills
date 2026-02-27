---
name: core-vision-kit
description: 核心视觉服务 Kit，提供 OCR、人脸检测等 AI 视觉能力
---

# 核心视觉服务 HarmonyOS 开发 Skill

## 概述

核心视觉 Kit (CoreVisionKit) 为 HarmonyOS 应用提供基础的 AI 视觉能力，包括文字识别、人脸检测、人脸比对、主体分割、物体检测、骨架检测等。

## 重要说明

- **Kit 名称**: CoreVisionKit
- **SDK 版本**: HarmonyOS 4.1.0+ (API 11+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  visionBase,
  textRecognition,
  faceDetector,
  faceComparator,
  subjectSegmentation,
  objectDetection,
  skeletonDetection
} from '@kit.CoreVisionKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| visionBase | Module | 视觉基础模块 |
| textRecognition | Module | 文字识别 (OCR) |
| faceDetector | Module | 人脸检测 |
| faceComparator | Module | 人脸比对 |
| subjectSegmentation | Module | 主体分割 |
| objectDetection | Module | 物体检测 |
| skeletonDetection | Module | 骨架检测 |

### 2.2 主要接口

#### textRecognition.recognize()

识别图片中的文字。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| image | PixelMap | 是 | - | 待识别图片 |

返回值: `Promise<TextRecognitionResult>`

#### faceDetector.detect()

检测图片中的人脸。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| image | PixelMap | 是 | - | 待检测图片 |

返回值: `Promise<FaceDetectionResult>`

## 三、使用示例

### 3.1 文字识别 (OCR)

```typescript
import { textRecognition } from '@kit.CoreVisionKit'
import { image } from '@kit.ImageKit'

async function recognizeText(pixelMap: image.PixelMap): Promise<void> {
  try {
    const result = await textRecognition.recognize(pixelMap)

    result.blocks.forEach(block => {
      console.log('Text:', block.text)
    })
  } catch (error) {
    console.error('Text recognition failed:', error)
  }
}
```

### 3.2 人脸检测

```typescript
import { faceDetector } from '@kit.CoreVisionKit'

async function detectFaces(pixelMap: image.PixelMap): Promise<void> {
  try {
    const result = await faceDetector.detect(pixelMap)

    console.log('Detected faces:', result.faces.length)
    result.faces.forEach(face => {
      console.log('Face rect:', face.boundingRect)
    })
  } catch (error) {
    console.error('Face detection failed:', error)
  }
}
```

### 3.3 物体检测

```typescript
import { objectDetection } from '@kit.CoreVisionKit'

async function detectObjects(pixelMap: image.PixelMap): Promise<void> {
  try {
    const result = await objectDetection.detect(pixelMap)

    result.objects.forEach(obj => {
      console.log('Object:', obj.type, 'confidence:', obj.confidence)
    })
  } catch (error) {
    console.error('Object detection failed:', error)
  }
}
```

## 四、最佳实践

1. **图片预处理**: 对输入图片进行适当的预处理
2. **结果过滤**: 根据置信度过滤结果
3. **性能优化**: 大图片考虑缩放处理
4. **内存管理**: 及时释放图片资源

## 五、参考资料

- [文字识别官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/ocr-introduction-V5)
- [人脸检测官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/face-introduction-V5)

---
## See Also
- [VisionKit](kit/vision-kit.md) - 视觉服务
