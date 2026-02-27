---
name: preview-kit
description: 预览服务 Kit，提供文件预览能力
---

# 预览服务 HarmonyOS 开发 Skill

## 概述

预览 Kit (PreviewKit) 为 HarmonyOS 应用提供文件预览能力，支持多种文件格式的在线预览。

## 重要说明

- **Kit 名称**: PreviewKit
- **SDK 版本**: HarmonyOS 4.1.0+ (API 11+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  filePreview,
  openFileBoost
} from '@kit.PreviewKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| filePreview | Module | 文件预览模块 |
| openFileBoost | Module | 打开文件加速模块 |

### 2.2 主要接口

#### filePreview.preview()

预览文件。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| uri | string | 是 | - | 文件 URI |
| type | string | 是 | - | 文件类型 |

返回值: `Promise<void>`

## 三、使用示例

### 3.1 预览文件

```typescript
import { filePreview } from '@kit.PreviewKit'

async function previewFile(fileUri: string): Promise<void> {
  try {
    await filePreview.preview({
      uri: fileUri,
      type: 'pdf'
    })
  } catch (error) {
    console.error('Preview failed:', error)
  }
}
```

## 四、最佳实践

1. **格式支持**: 检查文件格式是否支持
2. **缓存管理**: 合理使用预览缓存
3. **性能优化**: 大文件分页加载

## 五、参考资料

- [预览服务官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/preview-introduction-V5)

---
## See Also
- [PDFKit](kit/pdf-kit.md) - PDF 服务
- [ReaderKit](kit/reader-kit.md) - 阅读器服务
