---
name: cloud-foundation-kit
description: 云基础服务 Kit，提供云函数、云存储、云数据库等能力
---

# 云基础服务 HarmonyOS 开发 Skill

## 概述

云基础 Kit (CloudFoundationKit) 为 HarmonyOS 应用提供完整的云服务能力，包括云函数、云存储、云数据库、云资源预取等功能。

## 重要说明

- **Kit 名称**: CloudFoundationKit
- **SDK 版本**: HarmonyOS 5.0.0+ (API 12+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  cloudCommon,
  cloudFunction,
  cloudStorage,
  cloudDatabase,
  cloudResPrefetch
} from '@kit.CloudFoundationKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| cloudCommon | Module | 云服务通用模块 |
| cloudFunction | Module | 云函数模块 |
| cloudStorage | Module | 云存储模块 |
| cloudDatabase | Module | 云数据库模块 |
| cloudResPrefetch | Module | 云资源预取模块 |

### 2.2 主要接口

#### cloudFunction.call()

调用云函数。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| name | string | 是 | - | 函数名称 |
| params | Object | 否 | {} | 函数参数 |

返回值: `Promise<any>`

#### cloudStorage.upload()

上传文件到云存储。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| file | File | 是 | - | 待上传文件 |
| path | string | 是 | - | 存储路径 |

返回值: `Promise<string>` 返回文件下载 URL

## 三、使用示例

### 3.1 调用云函数

```typescript
import { cloudFunction } from '@kit.CloudFoundationKit'

async function callCloudFunction(): Promise<void> {
  try {
    const result = await cloudFunction.call('helloWorld', {
      name: 'HarmonyOS'
    })

    console.log('Function result:', result)
  } catch (error) {
    console.error('Call function failed:', error)
  }
}
```

### 3.2 云数据库操作

```typescript
import { cloudDatabase } from '@kit.CloudFoundationKit'

async function queryData(): Promise<void> {
  try {
    const result = await cloudDatabase.query('users', {
      where: { age: cloudDatabase.op.gt(18) }
    })

    console.log('Query result:', result)
  } catch (error) {
    console.error('Query failed:', error)
  }
}
```

### 3.3 上传文件

```typescript
import { cloudStorage } from '@kit.CloudFoundationKit'

async function uploadFile(fileUri: string): Promise<void> {
  try {
    const downloadUrl = await cloudStorage.upload({
      file: { uri: fileUri },
      path: 'uploads/myfile.jpg'
    })

    console.log('File uploaded:', downloadUrl)
  } catch (error) {
    console.error('Upload failed:', error)
  }
}
```

## 四、最佳实践

1. **错误处理**: 完善的错误处理和重试机制
2. **数据缓存**: 合理使用缓存减少网络请求
3. **安全规则**: 配置适当的安全规则
4. **性能优化**: 使用云资源预取提升加载速度

## 五、参考资料

- [云基础服务官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/clouddatabase-introduction-V5)

---
## See Also
- [AccountKit](kit/account-kit.md) - 华为账号
