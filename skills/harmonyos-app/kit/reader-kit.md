---
name: reader-kit
description: 阅读器服务 Kit，提供电子书阅读能力
---

# 阅读器服务 HarmonyOS 开发 Skill

## 概述

阅读器 Kit (ReaderKit) 为 HarmonyOS 应用提供电子书阅读能力，支持多种电子书格式。

## 重要说明

- **Kit 名称**: ReaderKit
- **SDK 版本**: HarmonyOS 5.0.4+ (API 16+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  bookParser,
  ReadPageComponent,
  readerCore
} from '@kit.ReaderKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| bookParser | Module | 电子书解析器 |
| ReadPageComponent | Component | 阅读页面组件 |
| readerCore | Module | 阅读器核心模块 |

### 2.2 主要接口

#### bookParser.parse()

解析电子书文件。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| uri | string | 是 | - | 电子书文件 URI |

返回值: `Promise<Book>`

## 三、使用示例

### 3.1 使用阅读器组件

```typescript
import { ReadPageComponent } from '@kit.ReaderKit'

@Entry
@ComponentV2
struct ReaderPage {
  @Local bookUri: string = 'file:///data/books/book.epub'

  build() {
    ReadPageComponent({
      uri: this.bookUri
    })
      .width('100%')
      .height('100%')
  }
}
```

## 四、最佳实践

1. **阅读进度**: 保存和恢复阅读进度
2. **字体设置**: 提供字体和亮度调节
3. **性能优化**: 大文件分章加载

## 五、参考资料

- [阅读器服务官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/reader-introduction-V5)

---
## See Also
- [PDFKit](kit/pdf-kit.md) - PDF 服务
