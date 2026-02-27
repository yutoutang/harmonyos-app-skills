---
name: data-augmentation-kit
description: 数据增强 Kit，提供 RAG、检索增强等 AI 数据处理能力
---

# 数据增强 HarmonyOS 开发 Skill

## 概述

数据增强 Kit (DataAugmentationKit) 为 HarmonyOS 应用提供 RAG (检索增强生成)、知识检索、知识处理、本地聊天模型等 AI 数据处理能力。

## 重要说明

- **Kit 名称**: DataAugmentationKit
- **SDK 版本**: HarmonyOS 6.0.0+ (API 20+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  retrieval,
  rag,
  knowledgeProcessor,
  localChatModel
} from '@kit.DataAugmentationKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| retrieval | Module | 检索模块 |
| rag | Module | RAG 模块 |
| knowledgeProcessor | Module | 知识处理模块 |
| localChatModel | Module | 本地聊天模型 |

### 2.2 主要接口

#### rag.query()

使用 RAG 进行查询。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| query | string | 是 | - | 查询内容 |
| options | RAGOptions | 否 | {} | RAG 选项 |

返回值: `Promise<RAGResult>`

## 三、使用示例

### 3.1 RAG 查询

```typescript
import { rag } from '@kit.DataAugmentationKit'

async function ragQuery(query: string): Promise<void> {
  try {
    const result = await rag.query(query, {
      knowledgeBaseId: 'your_kb_id'
    })

    console.log('RAG result:', result.answer)
  } catch (error) {
    console.error('RAG query failed:', error)
  }
}
```

## 四、最佳实践

1. **知识库管理**: 定期更新和维护知识库
2. **结果验证**: 对 RAG 结果进行业务验证
3. **性能优化**: 合理配置检索参数

## 五、参考资料

- [数据增强官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/rag-introduction-V5)

---
## See Also
- [AgentFrameworkKit](kit/agent-framework-kit.md) - 智能体框架
