# TextClock 组件 HarmonyOS 6.0 开发 Skill

## 概述

TextClock 组件是 OpenHarmony 中用于显示时间的文本组件，它可以根据指定的格式自动刷新显示当前时间。支持多种时间格式，包括 12 小时制和 24 小时制。

## 重要说明

- **自动刷新**: 组件会自动每秒刷新显示时间
- **格式化**: 支持自定义时间格式
- **时区**: 默认使用系统时区
- **国际化**: 支持多语言显示

## 模块信息

- **组件名称**: TextClock
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [TextClock 文本时钟 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-textclock-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// TextClock 是内置组件，无需导入
// 直接使用即可
TextClock()
```

### 1.2 基础用法

```typescript
// 简单时钟
TextClock()
  .fontSize(20)

// 设置时间格式
TextClock()
  .format('yyyy-MM-dd HH:mm:ss')
  .fontSize(16)

// 设置时区
TextClock()
  .format('HH:mm:ss')
  .timeZone('Asia/Shanghai')
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| options | `TextClockOptions` | 否 | - | 时钟选项，如 timezone |

### 2.2 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `format` | `string` | 'HH:mm:ss' | 时间格式 |
| `timeZone` | `string` | - | 时区 ID，如 'Asia/Shanghai' |
| `fontColor` | `ResourceColor` | - | 文本颜色 |
| `fontSize` | `number \| string \| Resource` | - | 字体大小 |
| `fontWeight` | `number \| FontWeight \| string` | - | 字体粗细 |
| `fontFamily` | `string \| Resource` | - | 字体列表 |

### 2.3 时间格式占位符

| 占位符 | 描述 | 示例 |
|--------|------|------|
| `yyyy` | 四位年份 | 2026 |
| `yy` | 两位年份 | 26 |
| `MM` | 月份（补零） | 02 |
| `M` | 月份（不补零） | 2 |
| `dd` | 日期（补零） | 24 |
| `d` | 日期（不补零） | 24 |
| `HH` | 24小时制小时（补零） | 14 |
| `H` | 24小时制小时（不补零） | 14 |
| `hh` | 12小时制小时（补零） | 02 |
| `h` | 12小时制小时（不补零） | 2 |
| `mm` | 分钟（补零） | 30 |
| `m` | 分钟（不补零） | 30 |
| `ss` | 秒（补零） | 45 |
| `s` | 秒（不补零） | 45 |
| `a` | 上午/下午 | AM/PM |

## 三、使用示例

### 3.1 基础时钟示例

```typescript
@ComponentV2
struct BasicTextClockExample {
  build() {
    Column({ space: 16 }) {
      Text('基础时钟')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 默认格式
      TextClock()
        .fontSize(24)
        .fontWeight(FontWeight.Bold)

      // 自定义格式
      TextClock()
        .format('yyyy-MM-dd HH:mm:ss')
        .fontSize(18)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.2 不同格式示例

```typescript
@ComponentV2
struct TextClockFormatExample {
  build() {
    Column({ space: 16 }) {
      Text('不同时间格式')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 年-月-日 时:分:秒
      Text('年-月-日 时:分:秒')
        .fontSize(14)
        .fontColor('#666666')
      TextClock()
        .format('yyyy-MM-dd HH:mm:ss')
        .fontSize(18)

      // 月/日/年
      Text('月/日/年')
        .fontSize(14)
        .fontColor('#666666')
      TextClock()
        .format('MM/dd/yyyy')
        .fontSize(18)

      // 12小时制
      Text('12小时制')
        .fontSize(14)
        .fontColor('#666666')
      TextClock()
        .format('hh:mm:ss a')
        .fontSize(18)

      // 简短格式
      Text('简短格式')
        .fontSize(14)
        .fontColor('#666666')
      TextClock()
        .format('HH:mm')
        .fontSize(18)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.3 时钟样式示例

```typescript
@ComponentV2
struct StyledTextClockExample {
  build() {
    Column({ space: 16 }) {
      // 大号时钟
      TextClock()
        .format('HH:mm:ss')
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .fontColor('#007DFF')
        .width('100%')
        .textAlign(TextAlign.Center)

      // 带日期的时钟
      Column({ space: 8 }) {
        TextClock()
          .format('yyyy年MM月dd日')
          .fontSize(16)
          .fontColor('#666666')

        TextClock()
          .format('HH:mm:ss')
          .fontSize(36)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding(24)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)

      // 卡片式时钟
      Column() {
        TextClock()
          .format('HH:mm')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
          .width('100%')
          .textAlign(TextAlign.Center)

        TextClock()
          .format('yyyy-MM-dd')
          .fontSize(14)
          .fontColor('#FFFFFF')
          .width('100%')
          .textAlign(TextAlign.Center)
          .opacity(0.8)
      }
      .width('100%')
      .padding(24)
      .backgroundColor('#28A745')
      .borderRadius(12)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.4 不同时区示例

```typescript
@ComponentV2
struct TimeZoneTextClockExample {
  build() {
    Column({ space: 16 }) {
      Text('不同时区时间')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 北京时间
      Column({ space: 8 }) {
        Text('北京')
          .fontSize(14)
          .fontColor('#666666')
        TextClock()
          .format('HH:mm:ss')
          .timeZone('Asia/Shanghai')
          .fontSize(24)
      }
      .padding(16)
      .backgroundColor('#E3F2FD')
      .borderRadius(8)

      // 伦敦时间
      Column({ space: 8 }) {
        Text('伦敦')
          .fontSize(14)
          .fontColor('#666666')
        TextClock()
          .format('HH:mm:ss')
          .timeZone('Europe/London')
          .fontSize(24)
      }
      .padding(16)
      .backgroundColor('#F3E5F5')
      .borderRadius(8)

      // 纽约时间
      Column({ space: 8 }) {
        Text('纽约')
          .fontSize(14)
          .fontColor('#666666')
        TextClock()
          .format('HH:mm:ss')
          .timeZone('America/New_York')
          .fontSize(24)
      }
      .padding(16)
      .backgroundColor('#FFF3E0')
      .borderRadius(8)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.5 世界时钟示例

```typescript
@ComponentV2
struct WorldClockExample {
  cities: Array<{name: string, timezone: string}> = [
    { name: '北京', timezone: 'Asia/Shanghai' },
    { name: '伦敦', timezone: 'Europe/London' },
    { name: '纽约', timezone: 'America/New_York' },
    { name: '东京', timezone: 'Asia/Tokyo' },
    { name: '悉尼', timezone: 'Australia/Sydney' }
  ]

  build() {
    Column({ space: 16 }) {
      Text('世界时钟')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      ForEach(this.cities, (city: {name: string, timezone: string}) => {
        Row() {
          Text(city.name)
            .fontSize(16)
            .width(80)

          TextClock()
            .format('HH:mm')
            .timeZone(city.timezone)
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .layoutWeight(1)
            .textAlign(TextAlign.End)
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
      })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.6 数字时钟示例

```typescript
@ComponentV2
struct DigitalClockExample {
  build() {
    Column({ space: 16 }) {
      // 数字时钟效果
      Column() {
        TextClock()
          .format('HH:mm:ss')
          .fontSize(56)
          .fontWeight(FontWeight.Bold)
          .fontColor('#007DFF')
          .width('100%')
          .textAlign(TextAlign.Center)
          .textShadow({
            radius: 10,
            color: 'rgba(0, 125, 255, 0.3)',
            offsetX: 0,
            offsetY: 0
          })

        TextClock()
          .format('yyyy年MM月dd日 EEEE')
          .fontSize(18)
          .fontColor('#666666')
          .width('100%')
          .textAlign(TextAlign.Center)
          .margin({ top: 16 })
      }
      .width('100%')
      .padding(32)
      .backgroundColor('#F0F8FF')
      .borderRadius(16)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.7 倒计时样式示例

```typescript
@ComponentV2
struct CountdownStyleExample {
  build() {
    Column({ space: 16 }) {
      Text('时间显示')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 分离的时、分、秒
      Row({ space: 8 }) {
        // 小时
        Column() {
          TextClock()
            .format('HH')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .width('100%')
            .textAlign(TextAlign.Center)
        }
        .width(80)
        .height(80)
        .backgroundColor('#007DFF')
        .borderRadius(8)
        .justifyContent(FlexAlign.Center)

        Text(':')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .margin({ top: -20 })

        // 分钟
        Column() {
          TextClock()
            .format('mm')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .width('100%')
            .textAlign(TextAlign.Center)
        }
        .width(80)
        .height(80)
        .backgroundColor('#28A745')
        .borderRadius(8)
        .justifyContent(FlexAlign.Center)

        Text(':')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .margin({ top: -20 })

        // 秒
        Column() {
          TextClock()
            .format('ss')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .width('100%')
            .textAlign(TextAlign.Center)
        }
        .width(80)
        .height(80)
        .backgroundColor('#FFC107')
        .borderRadius(8)
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.8 带问候的时钟示例

```typescript
@ComponentV2
struct GreetingClockExample {
  @Local currentHour: number = new Date().getHours()
  @Local greeting: string = this.getGreeting(this.currentHour)

  getGreeting(hour: number): string {
    if (hour >= 5 && hour < 12) {
      return '早上好'
    } else if (hour >= 12 && hour < 18) {
      return '下午好'
    } else if (hour >= 18 && hour < 22) {
      return '晚上好'
    } else {
      return '夜深了'
    }
  }

  build() {
    Column({ space: 16 }) {
      // 问候语
      Text(this.greeting)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')

      // 当前时间
      TextClock()
        .format('HH:mm:ss')
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .fontColor('#007DFF')

      // 当前日期
      TextClock()
        .format('yyyy年MM月dd日 EEEE')
        .fontSize(16)
        .fontColor('#666666')
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}
```

## 四、事件处理

### 4.1 时间变化事件

```typescript
TextClock()
  .format('HH:mm:ss')
  .onDateChange((value: Date) => {
    console.info('时间变化:', value.toLocaleString())
  })
```

## 五、最佳实践

### 5.1 格式选择

```typescript
// ✅ 推荐：使用清晰的格式
TextClock()
  .format('HH:mm:ss') // 14:30:45

// ✅ 推荐：根据场景选择合适的格式
TextClock()
  .format('yyyy-MM-dd') // 日期显示

// ❌ 避免：使用过于复杂的格式
TextClock()
  .format('yyyy年MM月dd日EEEEHH时mm分ss秒') // 过于冗长
```

### 5.2 字体大小

```typescript
// ✅ 推荐：使用合适的字体大小
TextClock()
  .format('HH:mm')
  .fontSize(24) // 清晰可读

// ❌ 避免：字体过小
TextClock()
  .fontSize(8) // 难以阅读
```

### 5.3 时区处理

```typescript
// ✅ 推荐：明确指定时区
TextClock()
  .timeZone('Asia/Shanghai')
  .format('HH:mm:ss')

// ❌ 避免：依赖默认时区
TextClock()
  .format('HH:mm:ss') // 可能在不同设备显示不一致
```

### 5.4 性能优化

```typescript
// ✅ 推荐：避免过多的 TextClock 组件
// 限制页面中的时钟数量，避免过度刷新
```

## 六、常见问题

### Q1: 如何显示星期几？

**解决方案**:
```typescript
TextClock()
  .format('yyyy-MM-dd EEEE')
  // EEEE 表示完整的星期名称（如：星期一）
  // EEE 表示简短的星期名称（如：周一）
```

### Q2: 如何实现 12 小时制？

**解决方案**:
```typescript
TextClock()
  .format('hh:mm:ss a')
  // hh: 12小时制小时
  // a: AM/PM 标记
```

### Q3: 时间不更新？

**问题**: TextClock 显示的时间不变。

**解决方案**:
```typescript
// TextClock 会自动每秒刷新
// 确保组件没有被销毁或隐藏
TextClock()
  .format('HH:mm:ss')
  .visibility(Visibility.Visible) // 确保可见
```

### Q4: 如何获取当前时间？

**解决方案**:
```typescript
TextClock()
  .onDateChange((date: Date) => {
    console.info('当前时间:', date)
  })
```

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 9+ | ✅ | 基础支持 |
| API 12+ | ✅ | 增强格式化选项 |

## 八、参考资料

- [TextClock 文本时钟 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-textclock-V5)
- [时间日期 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-time-V5)
