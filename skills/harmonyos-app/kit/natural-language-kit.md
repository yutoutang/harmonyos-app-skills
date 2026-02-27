---
name: natural-language-kit
description: 自然语言服务 Kit，提供文本处理 NLP 能力
---

# 自然语言服务 HarmonyOS 开发 Skill

## 概述

自然语言 Kit (NaturalLanguageKit) 为 HarmonyOS 应用提供自然语言处理能力，包括实体识别、文本处理等功能。

## 重要说明

- **Kit 名称**: NaturalLanguageKit
- **SDK 版本**: HarmonyOS 5.0.0+ (API 12+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  textProcessing,
  EntityType
} from '@kit.NaturalLanguageKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| textProcessing | Module | 文本处理模块 |
| EntityType | Enum | 实体类型枚举 |

### 2.2 主要接口

#### textProcessing.detectEntities()

检测文本中的实体。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| text | string | 是 | - | 待检测文本 |

返回值: `Promise<Entity[]>`

## 三、使用示例

### 3.1 实体识别

```typescript
import { textProcessing, EntityType } from '@kit.NaturalLanguageKit'

async function detectEntities(text: string): Promise<void> {
  try {
    const entities = await textProcessing.detectEntities(text, [
      EntityType.PERSON,
      EntityType.LOCATION,
     EntityType.ORGANIZATION
    ])

    entities.forEach(entity => {
      console.log('Entity:', entity.text, 'Type:', entity.type)
    })
  } catch (error) {
    console.error('Entity detection failed:', error)
  }
}
```

## 四、最佳实践

1. **结果过滤**: 根据置信度过滤结果
2. **上下文处理**: 考虑文本上下文
3. **性能优化**: 批量处理提高效率

## 五、参考资料

- [自然语言服务官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/nlp-introduction-V5)

---
## See Also
- [CoreSpeechKit](kit/core-speech-kit.md) - 核心语音服务
