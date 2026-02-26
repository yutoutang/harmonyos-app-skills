# QRCode 组件 HarmonyOS 6.0 开发 Skill

## 概述

QRCode 组件是 OpenHarmony 中用于生成和显示二维码的组件，支持将文本、URL 等信息编码为二维码图像。它提供了丰富的自定义选项，包括二维码尺寸、颜色、容错级别等属性设置。

## 重要说明

- **编码支持**: 支持 QR Code Model 2 标准
- **容错级别**: 支持 L (7%), M (15%), Q (25%), H (30%) 四级
- **内容限制**: 编码内容过长可能导致二维码过于密集
- **扫描**: 生成的二维码可被系统相机和第三方应用扫描
- **颜色**: 建议使用高对比度颜色确保扫描成功率

## 模块信息

- **组件名称**: QRCode
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [QRCode 二维码 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-qrcode-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// QRCode 是内置组件，无需导入
// 直接使用即可
QRCode('Hello World')
```

### 1.2 基础用法

```typescript
// 基本二维码
QRCode('https://www.example.com')
  .width(200)
  .height(200)

// 设置颜色
QRCode('Hello World')
  .width(200)
  .height(200)
  .color('#007DFF')        // 码颜色
  .backgroundColor('#FFFFFF') // 背景颜色

// 设置容错级别
QRCode('Hello World')
  .width(200)
  .height(200)
  .qrCodeSize(QRCodeSize.QR_CODE_SIZE_200)
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| value | `string` | 是 | - | 二维码内容，可以是文本、URL 等 |

### 2.2 组件属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `width` | `number \| string` | - | 二维码宽度 |
| `height` | `number \| string` | - | 二维码高度 |
| `color` | `ResourceColor` | '#000000' | 二维码颜色 |
| `backgroundColor` | `ResourceColor` | '#FFFFFF' | 二维码背景颜色 |
| `qrCodeSize` | `QRCodeSize` | QR_CODE_SIZE_200 | 二维码尺寸枚举值 |

### 2.3 QRCodeSize 枚举

| 值 | 描述 |
|----|------|
| `QR_CODE_SIZE_96` | 96x96 尺寸 |
| `QR_CODE_SIZE_120` | 120x120 尺寸 |
| `QR_CODE_SIZE_160` | 160x160 尺寸 |
| `QR_CODE_SIZE_200` | 200x200 尺寸 (默认) |
| `QR_CODE_SIZE_240` | 240x240 尺寸 |
| `QR_CODE_SIZE_320` | 320x320 尺寸 |
| `QR_CODE_SIZE_480` | 480x480 尺寸 |

### 2.4 事件

| 事件 | 类型 | 描述 |
|------|------|------|
| `onComplete` | `(codeWidth: number, codeHeight: number) => void` | 二维码生成完成回调 |

## 三、常见使用场景

### 3.1 基本二维码

```typescript
@ComponentV2
struct BasicQRCode {
  build() {
    Column({ space: 16 }) {
      Text('Basic QRCode')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      QRCode('https://www.example.com')
        .width(200)
        .height(200)
        .margin({ top: 20 })

      Text('Scan to visit website')
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.2 自定义颜色

```typescript
@ComponentV2
struct ColoredQRCode {
  build() {
    Column({ space: 16 }) {
      Text('Custom Color QRCode')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        // 蓝色二维码
        Column({ space: 8 }) {
          QRCode('Blue QRCode')
            .width(150)
            .height(150)
            .color('#007DFF')
            .backgroundColor('#F0F8FF')
          Text('Blue')
            .fontSize(12)
        }

        // 绿色二维码
        Column({ space: 8 }) {
          QRCode('Green QRCode')
            .width(150)
            .height(150)
            .color('#28A745')
            .backgroundColor('#F0FFF0')
          Text('Green')
            .fontSize(12)
        }
      }

      // 红色二维码
      Column({ space: 8 }) {
        QRCode('Red QRCode')
          .width(150)
          .height(150)
          .color('#DC3545')
          .backgroundColor('#FFF0F0')
        Text('Red')
          .fontSize(12)
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.3 不同尺寸

```typescript
@ComponentV2
struct SizedQRCode {
  build() {
    Column({ space: 16 }) {
      Text('Different Sizes')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Row({ space: 16 }) {
        Column({ space: 8 }) {
          QRCode('Small')
            .width(100)
            .height(100)
          Text('100x100')
            .fontSize(12)
        }

        Column({ space: 8 }) {
          QRCode('Medium')
            .width(150)
            .height(150)
          Text('150x150')
            .fontSize(12)
        }

        Column({ space: 8 }) {
          QRCode('Large')
            .width(200)
            .height(200)
          Text('200x200')
            .fontSize(12)
        }
      }
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.4 内容输入

```typescript
@ComponentV2
struct QRCodeGenerator {
  @Local qrContent: string = 'https://www.example.com'

  build() {
    Column({ space: 16 }) {
      Text('QR Code Generator')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      TextInput({ placeholder: 'Enter content', text: this.qrContent })
        .onChange((value: string) => {
          this.qrContent = value
        })

      if (this.qrContent) {
        QRCode(this.qrContent)
          .width(200)
          .height(200)
          .margin({ top: 20 })

        Text('Scan the QR code')
          .fontSize(14)
          .fontColor('#666666')
      } else {
        Column() {
          Text('Enter content to generate QR code')
            .fontSize(14)
            .fontColor('#999999')
        }
        .width(200)
        .height(200)
        .backgroundColor('#F5F5F5')
        .justifyContent(FlexAlign.Center)
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.5 生成完成回调

```typescript
@ComponentV2
struct QRCodeCallback {
  @Local codeWidth: number = 0
  @Local codeHeight: number = 0

  build() {
    Column({ space: 16 }) {
      Text('QRCode with Callback')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      QRCode('Callback Example')
        .width(200)
        .height(200)
        .color('#007DFF')
        .onComplete((width: number, height: number) => {
          this.codeWidth = width
          this.codeHeight = height
          console.info(`QRCode generated: ${width}x${height}`)
        })

      if (this.codeWidth > 0) {
        Text(`Generated: ${this.codeWidth}x${this.codeHeight}`)
          .fontSize(14)
          .fontColor('#28A745')
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.6 二维码卡片

```typescript
@ComponentV2
struct QRCodeCard {
  @Param title: string = 'Share QR Code'
  @Param content: string = 'https://www.example.com'
  @Param description: string = 'Scan to connect'

  build() {
    Column({ space: 16 }) {
      Text(this.title)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Column() {
        QRCode(this.content)
          .width(200)
          .height(200)
          .margin(16)

        Text(this.description)
          .fontSize(14)
          .fontColor('#666666')
          .margin({ bottom: 16 })
      }
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
      .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.1)' })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.7 WiFi 二维码

```typescript
@ComponentV2
struct WiFiQRCode {
  @Local ssid: string = ''
  @Local password: string = ''
  @Local security: string = 'WPA'

  build() {
    Column({ space: 16 }) {
      Text('WiFi QR Code')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      TextInput({ placeholder: 'SSID', text: this.ssid })
        .onChange((value: string) => {
          this.ssid = value
        })

      TextInput({ placeholder: 'Password', text: this.password })
        .type(InputType.Password)
        .onChange((value: string) => {
          this.password = value
        })

      if (this.ssid) {
        const wifiString = `WIFI:T:${this.security};S:${this.ssid};P:${this.password};;`
        QRCode(wifiString)
          .width(200)
          .height(200)
          .margin({ top: 20 })

        Text('Scan to connect WiFi')
          .fontSize(14)
          .fontColor('#666666')
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.8 名片二维码

```typescript
@ComponentV2
struct ContactQRCode {
  @Local name: string = 'John Doe'
  @Local phone: string = '+1234567890'
  @Local email: string = 'john@example.com'

  build() {
    Column({ space: 16 }) {
      Text('Contact QR Code')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Column({ space: 12 }) {
        TextInput({ placeholder: 'Name', text: this.name })
          .onChange((value: string) => {
            this.name = value
          })

        TextInput({ placeholder: 'Phone', text: this.phone })
          .onChange((value: string) => {
            this.phone = value
          })

        TextInput({ placeholder: 'Email', text: this.email })
          .onChange((value: string) => {
            this.email = value
          })
      }

      if (this.name || this.phone || this.email) {
        const vcard = `BEGIN:VCARD
VERSION:3.0
N:${this.name}
TEL:${this.phone}
EMAIL:${this.email}
END:VCARD`

        QRCode(vcard)
          .width(200)
          .height(200)
          .margin({ top: 20 })

        Text('Scan to save contact')
          .fontSize(14)
          .fontColor('#666666')
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

## 四、最佳实践

### 4.1 内容长度控制

```typescript
// 不好的做法：内容过长导致二维码过于密集
QRCode('Very long content that makes the QR code too dense and difficult to scan...')

// 好的做法：控制内容长度或使用短链接
QRCode('https://short.link/abc123')
```

### 4.2 颜色对比度

```typescript
// 好的做法：使用高对比度颜色
QRCode('Content')
  .color('#000000')        // 深色码
  .backgroundColor('#FFFFFF') // 浅色背景

// 避免：低对比度颜色
QRCode('Content')
  .color('#CCCCCC')        // 浅色码（不利于扫描）
  .backgroundColor('#DDDDDD')
```

### 4.3 尺寸选择

```typescript
// 根据使用场景选择合适的尺寸
QRCode('Content')
  .width(200)  // 移动端推荐 150-250
  .height(200)
```

### 4.4 错误处理

```typescript
@ComponentV2
struct SafeQRCode {
  @Local content: string = 'Default content'
  @Local error: string = ''

  build() {
    Column({ space: 16 }) {
      TextInput({ placeholder: 'Enter content', text: this.content })
        .onChange((value: string) => {
          if (value.length > 500) {
            this.error = 'Content too long'
          } else {
            this.content = value
            this.error = ''
          }
        })

      if (this.error) {
        Text(this.error)
          .fontSize(14)
          .fontColor('#FF0000')
      } else if (this.content) {
        QRCode(this.content)
          .width(200)
          .height(200)
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

## 五、性能优化建议

1. **避免频繁更新**: 二维码生成是计算密集型操作，避免在短时间内频繁更新内容
2. **控制尺寸**: 使用合适的尺寸，避免过大导致内存占用过高
3. **离屏渲染**: 对于大量二维码，考虑离屏预渲染
4. **缓存结果**: 对于相同内容，缓存生成的二维码避免重复计算

## 六、常见问题

### 6.1 二维码无法扫描

```typescript
// 检查以下几点：
// 1. 确保颜色对比度足够
QRCode('Content')
  .color('#000000')
  .backgroundColor('#FFFFFF')

// 2. 确保内容格式正确
QRCode('https://www.example.com')  // 完整 URL
```

### 6.2 内容过长

```typescript
// 使用短链接服务
const longUrl = 'https://www.example.com/very/long/path?param=value'
const shortUrl = 'https://short.link/abc'
QRCode(shortUrl)
```

### 6.3 性能问题

```typescript
// 避免在列表中大量使用二维码
// 不好的做法：
ForEach(items, (item) => {
  QRCode(item.content)  // 每个列表项都有二维码
})

// 好的做法：只在需要时显示
ForEach(items, (item) => {
  if (item.showQRCode) {
    QRCode(item.content)
  }
})
```
