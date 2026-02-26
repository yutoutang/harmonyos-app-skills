# Image 组件 HarmonyOS 6.0 开发 Skill

## 概述

Image 组件是 OpenHarmony 中用于显示图片的组件，支持本地图片、网络图片、Base64 编码图片等多种数据源。它提供了丰富的图片展示功能，包括缩放模式、填充模式、图片缓存、加载状态等。

## 重要说明

- **基础组件**: Image 是 ArkUI 的基础内置组件，无需导入
- **支持格式**: PNG、JPG、GIF、SVG、WebP 等多种格式
- **数据源**: 支持本地资源、网络 URL、Base64、PixelMap 等
- **性能**: 自动缓存已加载的图片
- **SVG**: 支持图片填充颜色
- **网络图片**: 需要在 module.json5 中配置 INTERNET 权限

## 模块信息

- **组件名称**: Image
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [Image 图片 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-image-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// Image 是内置组件，无需导入
// 直接使用即可
Image('https://example.com/image.png')
```

### 1.2 基础用法

```typescript
// 本地图片
Image($r('app.media.icon'))

// 网络图片
Image('https://example.com/image.png')

// Base64 图片
Image('data:image/png;base64,iVBORw0KG...')

// 设置图片大小
Image($r('app.media.icon'))
  .width(100)
  .height(100)
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| src | `string \| Resource \| PixelMap \| DrawableDescriptor` | 是 | - | 图片数据源 |

### 2.2 图片属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `alt` | `string \| Resource \| PixelMap` | null | 加载时显示的占位图 |
| `objectFit` | `ImageFit` | ImageFit.Cover | 图片的填充模式 |
| `objectRepeat` | `ImageRepeat` | ImageRepeat.NoRepeat | 图片的重复样式 |
| `interpolation` | `ImageInterpolation` | None | 图片插值效果 |
| `renderMode` | `ImageRenderMode` | ImageRenderMode.Original | 图片渲染模式 |
| `sourceSize` | `{ width: number, height: number }` | - | 图片解码尺寸 |
| `matchTextDirection` | `boolean` | false | 图片是否跟随系统语言方向 |
| `fitOriginalSize` | `boolean` | false | 图片尺寸是否跟随图片源尺寸 |
| `fillColor` | `ResourceColor` | - | 图片填充颜色（仅 SVG） |

### 2.3 图片填充模式 (ImageFit)

| 值 | 描述 |
|------|------|
| `ImageFit.Cover` | 保持宽高比缩放，填满组件（默认） |
| `ImageFit.Contain` | 保持宽高比缩放，完整显示图片 |
| `ImageFit.Fill` | 不保持宽高比，拉伸填满组件 |
| `ImageFit.None` | 保持原图尺寸，不缩放 |
| `ImageFit.ScaleDown` | 保持宽高比缩小，完整显示 |

### 2.4 图片事件

| 事件 | 参数类型 | 描述 |
|------|----------|------|
| `onComplete` | `(event?: ImageEvent) => void` | 图片加载成功回调 |
| `onError` | `(event?: ImageError) => void` | 图片加载失败回调 |
| `onPause` | `(event?: ImageEvent) => void` | 图片暂停加载回调 |
| `onForget` | `(event?: ImageEvent) => void` | 图片恢复加载回调 |

## 三、使用示例

### 3.1 基础图片示例

```typescript
// 本地图片
Image($r('app.media.icon'))
  .width(100)
  .height(100)

// 网络图片
Image('https://example.com/image.png')
  .width(200)
  .height(200)

// 使用资源引用
Image($r('app.media.my_image'))
  .width('100%')
  .height(200)
```

### 3.2 图片填充模式

```typescript
// Cover 模式（默认）
Image($r('app.media.image'))
  .width(200)
  .height(200)
  .objectFit(ImageFit.Cover)

// Contain 模式
Image($r('app.media.image'))
  .width(200)
  .height(200)
  .objectFit(ImageFit.Contain)

// Fill 模式
Image($r('app.media.image'))
  .width(200)
  .height(200)
  .objectFit(ImageFit.Fill)

// None 模式
Image($r('app.media.image'))
  .objectFit(ImageFit.None)
```

### 3.3 占位图和加载状态

```typescript
Image('https://example.com/large-image.png')
  .width(200)
  .height(200)
  .alt($r('app.media.loading'))  // 加载时显示的占位图
  .onComplete((event) => {
    console.info('图片加载成功')
  })
  .onError((error) => {
    console.error('图片加载失败:', error.componentWidth, error.componentHeight)
  })
```

### 3.4 SVG 图片填充颜色

```typescript
// SVG 图片填充颜色
Image($r('app.media.svg_icon'))
  .width(100)
  .height(100)
  .fillColor('#007DFF')
```

### 3.5 同步加载图片

```typescript
// 同步加载，优先显示
Image($r('app.media.image'))
  .width(200)
  .height(200)
  .syncLoad(true)  // 同步加载
```

### 3.6 图片缩放和裁剪

```typescript
// 解码尺寸（用于大图优化）
Image('https://example.com/large-image.png')
  .width(300)
  .height(300)
  .sourceSize({
    width: 300,
    height: 300
  })
```

## 四、高级用法

### 4.1 网络图片加载

```typescript
@ComponentV2
struct NetworkImageExample {
  @Local isLoading: boolean = true
  @Local loadError: boolean = false

  build() {
    Column() {
      Image('https://www.example.com/image.png')
        .width(200)
        .height(200)
        .alt($r('app.media.placeholder'))
        .onComplete(() => {
          this.isLoading = false
        })
        .onError(() => {
          this.isLoading = false
          this.loadError = true
        })

      if (this.isLoading) {
        Text('加载中...')
      }

      if (this.loadError) {
        Text('加载失败')
      }
    }
  }
}
```

### 4.2 Base64 图片

```typescript
@ComponentV2
struct Base64ImageExample {
  private base64Image: string = 'data:image/png;base64,iVBORw0KGgoAAAANS...'

  build() {
    Image(this.base64Image)
      .width(100)
      .height(100)
  }
}
```

### 4.3 图片缓存

Image 组件会自动缓存已加载的图片。对于相同的 src，第二次加载会直接从缓存中读取。

```typescript
// 第一次加载：从网络下载
Image('https://example.com/image.png')
  .width(200)
  .height(200)

// 第二次加载：从缓存读取
Image('https://example.com/image.png')
  .width(100)
  .height(100)
```

## 五、最佳实践

### 5.1 图片尺寸优化

```typescript
// ✅ 推荐：设置明确的图片尺寸
Image($r('app.media.icon'))
  .width(100)
  .height(100)

// ❌ 避免：不设置尺寸可能导致布局问题
Image($r('app.media.icon'))
```

### 5.2 大图优化

```typescript
// ✅ 推荐：使用 sourceSize 限制解码尺寸
Image('https://example.com/large-image.png')
  .width(300)
  .height(300)
  .sourceSize({
    width: 300,
    height: 300
  })

// ❌ 避免：直接加载大图消耗内存
Image('https://example.com/large-image.png')
```

### 5.3 占位图

```typescript
// ✅ 推荐：为网络图片设置占位图
Image('https://example.com/image.png')
  .alt($r('app.media.placeholder'))
  .width(200)
  .height(200)

// ❌ 避免：没有占位图可能导致用户看到空白
Image('https://example.com/image.png')
```

### 5.4 错误处理

```typescript
// ✅ 推荐：处理图片加载失败
Image('https://example.com/image.png')
  .onError(() => {
    // 显示备用图片或提示信息
  })

// ❌ 避免：不处理加载失败
Image('https://example.com/image.png')
```

## 六、常见问题

### Q1: 网络图片无法加载？

**问题**: Image 组件显示空白或占位图。

**解决方案**:

#### 1. 配置网络权限

在 `src/main/module.json5` 中添加 INTERNET 权限：

```json5
{
  "module": {
    "name": "entry",
    "type": "entry",
    "requestPermissions": [
      {
        "name": "ohos.permission.INTERNET",
        "reason": "$string:internet_permission_reason",
        "usedScene": {
          "abilities": ["EntryAbility"],
          "when": "always"
        }
      }
    ]
  }
}
```

同时在 `src/main/resources/base/element/string.json` 中添加权限说明：

```json
{
  "string": [
    {
      "name": "internet_permission_reason",
      "value": "应用需要访问网络以加载图片资源"
    }
  ]
}
```

#### 2. 检查网络状态

```typescript
// 检查网络是否可用
import { network } from '@kit.NetworkKit'

async checkNetwork() {
  const netManager = network.createNetworkManager()
  const netConnection = netManager.getNetworkContext()
  const hasNetwork = await netConnection.hasDefaultNetwork()
  if (!hasNetwork) {
    console.error('网络不可用')
  }
}
```

#### 3. 使用错误处理

```typescript
Image('https://example.com/image.png')
  .width(200)
  .height(200)
  .alt($r('app.media.placeholder'))
  .onComplete((event) => {
    console.info('图片加载成功')
  })
  .onError((error) => {
    console.error('加载失败:', error.errorCode, error.errorMsg)
    // 根据错误码显示不同的提示
    // errorCode: 0 - 图片加载成功
    // errorCode: 1 - 图片下载失败
    // errorCode: 2 - 图片解码失败
  })
```

#### 4. 常见错误码

| 错误码 | 描述 | 解决方案 |
|--------|------|----------|
| 0 | 加载成功 | - |
| 1 | 网络错误 | 检查网络连接和权限 |
| 2 | 图片解码失败 | 检查图片格式是否支持 |
| 3 | 图片尺寸过大 | 使用 sourceSize 限制解码尺寸 |

### Q2: SVG 图片颜色不正确？

**解决方案**:
```typescript
// 使用 fillColor 设置 SVG 颜色
Image($r('app.media.svg_icon'))
  .width(100)
  .height(100)
  .fillColor('#007DFF')
```

### Q3: 图片变形或模糊？

**解决方案**:
```typescript
// 使用合适的 objectFit
Image($r('app.media.image'))
  .objectFit(ImageFit.Contain)  // 或 Cover
  .width(200)
  .height(200)
```

### Q4: 如何实现图片圆角？

**解决方案**:
```typescript
Image($r('app.media.image'))
  .width(100)
  .height(100)
  .borderRadius(10)  // 设置圆角
```

### Q5: 如何实现图片占位渐变？

**解决方案**:
```typescript
// 使用 linearGradient
Image($r('app.media.image'))
  .width(200)
  .height(200)
  .alt($r('app.media.placeholder'))
  .onError(() => {
    // 显示渐变占位
  })
```

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 9+ | ✅ | 完全支持 |
| API 11+ | ✅ | 增加了 syncMode 等属性 |
| API 12+ | ✅ | 增加了 sourceSize、autoResize 等属性 |
| API 15+ | ✅ | 增加了 ColorFill 支持 |
| API 18+ | ✅ | 增加了更多事件回调 |

## 八、参考资料

- [Image 图片 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-image-V5)
- [通用属性 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-universal-attributes-size-V5)
