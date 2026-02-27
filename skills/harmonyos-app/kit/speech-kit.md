---
name: speech-kit
description: 语音服务 Kit，提供文本朗读、AI 字幕等功能
---

# 语音服务 HarmonyOS 开发 Skill

## 概述

语音 Kit (SpeechKit) 为 HarmonyOS 应用提供文本朗读和 AI 字幕等语音服务能力。

## 重要说明

- **Kit 名称**: SpeechKit
- **SDK 版本**: HarmonyOS 5.0.0+ (API 12+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  TextReader,
  WindowManager,
  TextReaderIcon,
  ReadStateCode,
  AICaptionController,
  AudioInfo,
  AudioData,
  AICaptionOptions,
  AICaptionComponent
} from '@kit.SpeechKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| TextReader | Class | 文本朗读器 |
| WindowManager | Class | 窗口管理器 |
| AICaptionController | Class | AI 字幕控制器 |
| AICaptionComponent | Component | AI 字幕组件 |

### 2.2 主要接口

#### TextReader.speak()

朗读文本。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| text | string | 是 | - | 待朗读文本 |
| options | SpeakOptions | 否 | {} | 朗读选项 |

返回值: `Promise<void>`

## 三、使用示例

### 3.1 文本朗读

```typescript
import { TextReader } from '@kit.SpeechKit'

async function speakText(): Promise<void> {
  const reader = new TextReader()

  await reader.speak('你好，这是语音朗读测试', {
    language: 'zh-CN',
    rate: 1.0,
    pitch: 1.0
  })
}
```

### 3.2 AI 字幕

```typescript
import { AICaptionComponent } from '@kit.SpeechKit'

@Entry
@ComponentV2
struct AICaptionPage {
  build() {
    AICaptionComponent()
      .width('100%')
      .height('100%')
  }
}
```

## 四、最佳实践

1. **音频焦点**: 正确管理音频焦点
2. **资源释放**: 使用完成后释放播放器资源
3. **用户控制**: 提供播放/暂停/停止控制

## 五、参考资料

- [语音服务官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/speech-introduction-V5)

---
## See Also
- [CoreSpeechKit](kit/core-speech-kit.md) - 核心语音服务
