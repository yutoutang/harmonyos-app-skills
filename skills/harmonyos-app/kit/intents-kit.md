---
name: intents-kit
description: 意图服务 Kit，提供智能意图识别能力
---

# 意图服务 HarmonyOS 开发 Skill

## 概述

意图服务 Kit (IntentsKit) 为 HarmonyOS 应用提供智能意图识别能力，帮助应用理解用户意图并提供相应服务。

## 重要说明

- **Kit 名称**: IntentsKit
- **SDK 版本**: HarmonyOS 4.1.0+ (API 11+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  insightIntent,
  InsightIntentUIExtensionAbility
} from '@kit.IntentsKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| insightIntent | Module | 智能意图模块 |
| InsightIntentUIExtensionAbility | Class | 意图 UI 扩展能力 |

### 2.2 主要接口

#### insightIntent.query()

查询意图。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| query | string | 是 | - | 查询内容 |

返回值: `Promise<IntentResult>`

## 三、使用示例

### 3.1 意图识别

```typescript
import { insightIntent } from '@kit.IntentsKit'

async function recognizeIntent(text: string): Promise<void> {
  try {
    const result = await insightIntent.query(text)

    console.log('Intent:', result.intent)
    console.log('Confidence:', result.confidence)
  } catch (error) {
    console.error('Intent recognition failed:', error)
  }
}
```

## 四、最佳实践

1. **上下文管理**: 维护对话上下文
2. **结果验证**: 验证意图识别结果
3. **用户反馈**: 收集用户反馈优化识别

## 五、参考资料

- [意图服务官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/intents-introduction-V5)

---
## See Also
- [AgentFrameworkKit](kit/agent-framework-kit.md) - 智能体框架
