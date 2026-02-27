---
name: core-speech-kit
description: 核心语音服务 Kit，提供语音识别和语音合成能力
---

# 核心语音服务 HarmonyOS 开发 Skill

## 概述

核心语音 Kit (CoreSpeechKit) 为 HarmonyOS 应用提供语音识别和语音合成等核心语音能力。

## 重要说明

- **Kit 名称**: CoreSpeechKit
- **SDK 版本**: HarmonyOS 4.1.0+ (API 11+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  speechRecognizer,
  textToSpeech
} from '@kit.CoreSpeechKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| speechRecognizer | Module | 语音识别模块 |
| textToSpeech | Module | 语音合成模块 |

### 2.2 主要接口

#### speechRecognizer.start()

启动语音识别。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| config | RecognizerConfig | 是 | - | 识别配置 |

返回值: `Promise<void>`

#### textToSpeech.speak()

朗读文本。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| text | string | 是 | - | 待朗读文本 |
| params | SpeakParams | 否 | {} | 朗读参数 |

返回值: `Promise<void>`

## 三、使用示例

### 3.1 语音识别

```typescript
import { speechRecognizer } from '@kit.CoreSpeechKit'

async function startSpeechRecognition(): Promise<void> {
  try {
    await speechRecognizer.start({
      onResult: (result) => {
        console.log('Recognition result:', result.text)
      },
      onError: (error) => {
        console.error('Recognition error:', error)
      }
    })
  } catch (error) {
    console.error('Start recognition failed:', error)
  }
}
```

### 3.2 语音合成

```typescript
import { textToSpeech } from '@kit.CoreSpeechKit'

async function speakText(text: string): Promise<void> {
  try {
    await textToSpeech.speak(text, {
      language: 'zh-CN',
      rate: 1.0,
      pitch: 1.0
    })
  } catch (error) {
    console.error('Speak failed:', error)
  }
}
```

## 四、最佳实践

1. **权限管理**: 需要麦克风权限
2. **音频焦点**: 正确管理音频焦点
3. **网络检测**: 语音识别需要网络连接
4. **用户反馈**: 提供清晰的语音识别反馈

## 五、权限要求

| 权限名称 | 用途 |
|---------|------|
| ohos.permission.MICROPHONE | 麦克风权限 |
| ohos.permission.INTERNET | 网络权限 |

## 六、参考资料

- [语音识别官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/asr-introduction-V5)
- [语音合成官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/tts-introduction-V5)

---
## See Also
- [SpeechKit](kit/speech-kit.md) - 语音服务
