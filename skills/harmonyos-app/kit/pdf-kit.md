---
name: pdf-kit
description: PDF 服务 Kit，提供 PDF 查看、编辑等功能
---

# PDF 服务 HarmonyOS 开发 Skill

## 概述

PDF Kit (PDFKit) 为 HarmonyOS 应用提供 PDF 文档的查看、渲染和处理能力。

## 重要说明

- **Kit 名称**: PDFKit
- **SDK 版本**: HarmonyOS 5.0.0+ (API 12+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  pdfService,
  pdfViewManager,
  PdfView
} from '@kit.PDFKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| pdfService | Module | PDF 服务核心模块 |
| pdfViewManager | Class | PDF 视图管理器 |
| PdfView | Component | PDF 查看组件 |

### 2.2 主要接口

#### pdfService.load()

加载 PDF 文档。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| uri | string | 是 | - | PDF 文件 URI |

返回值: `Promise<PdfDocument>`

## 三、使用示例

### 3.1 显示 PDF 文档

```typescript
import { PdfView } from '@kit.PDFKit'

@Entry
@ComponentV2
struct PdfViewerPage {
  @Local pdfUri: string = 'file:///data/pdf/document.pdf'

  build() {
    PdfView({
      uri: this.pdfUri
    })
      .width('100%')
      .height('100%')
  }
}
```

## 四、最佳实践

1. **内存管理**: 大文件处理时注意内存使用
2. **缓存策略**: 合理使用缓存提升性能
3. **错误处理**: 处理损坏或加密的 PDF 文件

## 五、参考资料

- [PDF 服务官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/pdf-introduction-V5)

---
## See Also
- [ReaderKit](kit/reader-kit.md) - 阅读器服务
