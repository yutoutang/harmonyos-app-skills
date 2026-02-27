---
name: scan-kit
description: 扫码服务 Kit，提供扫描和生成条形码/二维码功能
---

# 扫码服务 HarmonyOS 开发 Skill

## 概述

扫码 Kit (ScanKit) 为 HarmonyOS 应用提供强大的扫描和生成条形码/二维码功能。支持多种码制识别、自定义扫描界面、码图生成等能力。

## 重要说明

- **Kit 名称**: ScanKit
- **SDK 版本**: HarmonyOS 4.1.0+ (API 11+)
- **更新日期**: 2026-02-27

## 一、导入方式

```typescript
import {
  scanCore,
  scanBarcode,
  customScan,
  detectBarcode,
  generateBarcode
} from '@kit.ScanKit'
```

## 二、API 参考

### 2.1 模块导出

| 导出名称 | 类型 | 描述 |
|---------|------|------|
| scanCore | Module | 扫码核心功能模块 |
| scanBarcode | Module | 默认扫码界面模块 |
| customScan | Module | 自定义扫码界面模块 |
| detectBarcode | Module | 码图检测模块 |
| generateBarcode | Module | 码图生成模块 |

### 2.2 主要接口

#### scanBarcode.start()

启动默认扫码界面进行扫码。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| options | ScanOptions | 是 | - | 扫码配置选项 |

返回值: `Promise<ScanResult>`

#### generateBarcode.create()

生成码图。

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| content | string | 是 | - | 码图内容 |
| type | ScanType | 是 | - | 码图类型 |
| options | GenerateOptions | 否 | - | 生成选项 |

返回值: `Promise<PixelMap>`

## 三、使用示例

### 3.1 使用默认扫码界面

```typescript
import { scanBarcode } from '@kit.ScanKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

async function scanWithDefaultView(): Promise<void> {
  try {
    const result = await scanBarcode.start({
      scanTypes: [scanCore.ScanType.ALL]
    })

    hilog.info(0x0000, 'ScanKit', 'Scan result: %{public}s', result.originalValue)
  } catch (error) {
    const err = error as BusinessError
    hilog.error(0x0000, 'ScanKit', 'Scan failed: %{public}d', err.code)
  }
}
```

### 3.2 自定义扫码界面

```typescript
import { customScan } from '@kit.ScanKit'

@Entry
@ComponentV2
struct CustomScanPage {
  @Local scanResult: string = ''

  build() {
    Column() {
      // 自定义扫码视图
      customScan.ScanView({
        onResult: (result) => {
          this.scanResult = result.originalValue
        }
      })
        .width('100%')
        .height('60%')

      Text(this.scanResult)
        .fontSize(16)
        .margin({ top: 20 })
    }
  }
}
```

### 3.3 生成二维码

```typescript
import { generateBarcode, scanCore } from '@kit.ScanKit'
import { image } from '@kit.ImageKit'

async function generateQRCode(): Promise<image.PixelMap> {
  try {
    const pixelMap = await generateBarcode.create(
      'https://developer.huawei.com',
      scanCore.ScanType.QR_CODE,
      {
        width: 300,
        height: 300,
        backgroundColor: 0xFFFFFFFF,
        foregroundColor: 0xFF000000
      }
    )

    return pixelMap
  } catch (error) {
    console.error('Generate QR code failed:', error)
    return null
  }
}
```

### 3.4 检测图片中的码

```typescript
import { detectBarcode } from '@kit.ScanKit'
import { image } from '@kit.ImageKit'

async function detectCodeInImage(imageSource: image.ImageSource): Promise<void> {
  try {
    const results = await detectBarcode.decode(imageSource, {
      scanTypes: [scanCore.ScanType.ALL]
    })

    results.forEach(result => {
      console.log('Detected:', result.originalValue)
    })
  } catch (error) {
    console.error('Detect failed:', error)
  }
}
```

## 四、最佳实践

1. **权限处理**: 需要相机权限，在使用前进行权限检查和请求
2. **码制选择**: 根据业务需求选择合适的扫码类型，提高识别效率
3. **内存管理**: 生成的 PixelMap 使用后及时释放
4. **用户体验**: 提供震动、声音等反馈增强扫码体验
5. **结果验证**: 对扫码结果进行格式验证，防止恶意内容

## 五、常见问题

### Q: 如何同时识别多种类型的码？

A: 在 `scanTypes` 中传入 `scanCore.ScanType.ALL` 即可。

### Q: 自定义扫码界面如何添加扫描框？

A: 使用 `customScan.ScanView` 并通过叠加层组件绘制扫描框。

### Q: 生成的二维码不清晰怎么办？

A: 增加生成尺寸，或使用更高分辨率的设备。

## 六、权限要求

| 权限名称 | 用途 |
|---------|------|
| ohos.permission.CAMERA | 相机权限，用于扫码 |

## 七、参考资料

- [扫码服务官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/scan-introduction-V5)
- [ScanKit API 参考](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/scan-overview-V5)

---
## See Also
- [AccountKit](kit/account-kit.md) - 华为账号
- [ShareKit](kit/share-kit.md) - 分享服务
