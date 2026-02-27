---
name: file-manager-service-kit
description: 文件管理服务 Kit，提供文件管理能力
---

# 文件管理服务 HarmonyOS 开发 Skill

## 概述

文件管理服务 Kit (FileManagerServiceKit) 为 HarmonyOS 应用提供文件管理能力。

## 重要说明

- **Kit 名称**: FileManagerServiceKit
- **SDK 版本**: HarmonyOS 5.0.5+ (API 17+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import { fileManagerService } from '@kit.FileManagerServiceKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| fileManagerService | Module | 文件管理服务模块 |

### 2.2 主要接口

#### fileManagerService.openFile()

打开文件。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| uri | string | 是 | - | 文件 URI |

返回值: `Promise<void>`

## 三、使用示例

### 3.1 打开文件

```typescript
import { fileManagerService } from '@kit.FileManagerServiceKit'

async function openFile(fileUri: string): Promise<void> {
  try {
    await fileManagerService.openFile(fileUri)
  } catch (error) {
    console.error('Open file failed:', error)
  }
}
```

## 四、参考资料

- [文件管理服务官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/filemanager-introduction-V5)

---
## See Also
- [PreviewKit](kit/preview-kit.md) - 预览服务
