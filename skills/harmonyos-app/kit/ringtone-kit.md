---
name: ringtone-kit
description: 铃声服务 Kit，提供铃声管理能力
---

# 铃声服务 HarmonyOS 开发 Skill

## 概述

铃声 Kit (RingtoneKit) 为 HarmonyOS 应用提供铃声管理和播放能力。

## 重要说明

- **Kit 名称**: RingtoneKit
- **SDK 版本**: HarmonyOS 5.0.0+ (API 12+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import { ringtone } from '@kit.RingtoneKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| ringtone | Module | 铃声模块 |

### 2.2 主要接口

#### ringtone.play()

播放铃声。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| uri | string | 是 | - | 铃声文件 URI |

返回值: `Promise<void>`

## 三、使用示例

### 3.1 播放铃声

```typescript
import { ringtone } from '@kit.RingtoneKit'

async function playRingtone(): Promise<void> {
  try {
    await ringtone.play('file:///data/ringtones/default.mp3')
  } catch (error) {
    console.error('Play ringtone failed:', error)
  }
}
```

## 四、最佳实践

1. **音频焦点**: 正确管理音频焦点
2. **音量控制**: 尊重用户的音量设置
3. **静音模式**: 检查静音模式状态

## 五、参考资料

- [铃声服务官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/ringtone-introduction-V5)

---
## See Also
- [CoreSpeechKit](kit/core-speech-kit.md) - 核心语音服务
