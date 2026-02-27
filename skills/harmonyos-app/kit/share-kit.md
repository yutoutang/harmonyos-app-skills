---
name: share-kit
description: 分享服务 Kit，提供系统级分享和 HarmonyOS 分享功能
---

# 分享服务 HarmonyOS 开发 Skill

## 概述

分享 Kit (ShareKit) 为 HarmonyOS 应用提供完整的分享解决方案。支持系统级分享、HarmonyOS 设备间分享，可分享文本、图片、文件等多种类型的内容。

## 重要说明

- **Kit 名称**: ShareKit
- **SDK 版本**: HarmonyOS 4.1.0+ (API 11+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  systemShare,
  harmonyShare
} from '@kit.ShareKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| systemShare | Module | 系统级分享服务 |
| harmonyShare | Module | HarmonyOS 设备间分享服务 |

### 2.2 主要接口

#### systemShare.share()

启动系统分享面板。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| data | ShareData | 是 | - | 分享数据 |
| options | ShareOptions | 否 | {} | 分享选项 |

返回值: `Promise<void>`

#### harmonyShare.share()

HarmonyOS 设备间分享。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| data | ShareData | 是 | - | 分享数据 |

返回值: `Promise<void>`

## 三、使用示例

### 3.1 分享文本

```typescript
import { systemShare } from '@kit.ShareKit'

async function shareText(text: string): Promise<void> {
  try {
    await systemShare.share({
      uri: `text://${text}`
    })
  } catch (error) {
    console.error('Share text failed:', error)
  }
}
```

### 3.2 分享图片

```typescript
import { systemShare } from '@kit.ShareKit'

async function shareImage(imageUri: string): Promise<void> {
  try {
    await systemShare.share({
      uri: imageUri,
      type: 'image'
    })
  } catch (error) {
    console.error('Share image failed:', error)
  }
}
```

### 3.3 分享文件

```typescript
import { systemShare } from '@kit.ShareKit'

async function shareFile(fileUri: string): Promise<void> {
  try {
    await systemShare.share({
      uri: fileUri,
      type: 'file'
    })
  } catch (error) {
    console.error('Share file failed:', error)
  }
}
```

### 3.4 HarmonyOS 设备间分享

```typescript
import { harmonyShare } from '@kit.ShareKit'

async function shareToHarmonyDevice(data: string): Promise<void> {
  try {
    await harmonyShare.share({
      uri: `text://${data}`
    })
  } catch (error) {
    console.error('HarmonyShare failed:', error)
  }
}
```

## 四、最佳实践

1. **URI 格式**: 使用正确的 URI 格式（text://, file://等）
2. **错误处理**: 对分享操作进行完整的错误处理
3. **用户反馈**: 分享完成后给用户适当的反馈
4. **内容验证**: 分享前验证内容的有效性
5. **权限检查**: 分享文件时确保有相应的权限

## 五、常见问题

### Q: 分享后如何知道用户选择了哪个应用？

A: 系统分享面板不提供此信息，如需追踪可使用自定义分享界面。

### Q: 如何分享多张图片？

A: 使用 `uris` 数组参数，传递多个图片 URI。

### Q: HarmonyOS 分享有什么特殊要求？

A: 需要设备支持 HarmonyOS 分享功能，且双方设备都在同一网络。

## 六、权限要求

| 权限名称 | 用途 |
|---------|------|
| ohos.permission.READ_WRITE_DOWNLOAD_DIRECTORY | 读写下载目录，用于分享文件 |

## 七、参考资料

- [分享服务官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/share-introduction-V5)

---
## See Also
- [AccountKit](kit/account-kit.md) - 华为账号
- [ScanKit](kit/scan-kit.md) - 扫码服务
