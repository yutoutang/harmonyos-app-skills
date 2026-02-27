---
name: agent-framework-kit
description: 智能体框架 Kit，提供 AI 智能体开发能力
---

# 智能体框架 HarmonyOS 开发 Skill

## 概述

智能体框架 Kit (AgentFrameworkKit) 为 HarmonyOS 应用提供 AI 智能体开发能力，支持创建智能对话助手、功能调用等 AI 应用。

## 重要说明

- **Kit 名称**: AgentFrameworkKit
- **SDK 版本**: HarmonyOS 6.0.0+ (API 20+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  AgentController,
  BaseOptions,
  FunctionController,
  FunctionOptions,
  ButtonType,
  FunctionComponent
} from '@kit.AgentFrameworkKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| AgentController | Class | 智能体控制器 |
| BaseOptions | Interface | 基础配置选项 |
| FunctionController | Class | 功能控制器 |
| FunctionOptions | Interface | 功能配置选项 |
| ButtonType | Enum | 按钮类型 |
| FunctionComponent | Component | 功能组件 |

### 2.2 主要接口

#### AgentController.initialize()

初始化智能体。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| options | BaseOptions | 是 | - | 配置选项 |

返回值: `Promise<void>`

#### AgentController.sendMessage()

发送消息给智能体。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| message | string | 是 | - | 消息内容 |

返回值: `Promise<string>`

## 三、使用示例

### 3.1 创建智能体助手

```typescript
import { AgentController, BaseOptions } from '@kit.AgentFrameworkKit'

async function createAgent(): Promise<void> {
  const options: BaseOptions = {
    agentId: 'your_agent_id',
    apiKey: 'your_api_key'
  }

  const agent = new AgentController(options)
  await agent.initialize()

  const response = await agent.sendMessage('你好')
  console.log('Agent response:', response)
}
```

## 四、最佳实践

1. **API 安全**: 妥善保管 API 密钥
2. **错误处理**: 对网络错误进行友好提示
3. **会话管理**: 合理管理对话上下文

## 五、参考资料

- [智能体框架官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/agent-introduction-V5)

---
## See Also
- [IntentsKit](kit/intents-kit.md) - 意图服务
