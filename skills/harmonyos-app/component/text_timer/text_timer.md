# TextTimer 组件 HarmonyOS 6.0 开发 Skill

## 概述

TextTimer 组件是 OpenHarmony 中用于显示计时器的文本组件，支持从指定时间开始倒计时或正计时。常用于秒表、倒计时、定时器等场景。

## 重要说明

- **计时模式**: 支持正计时和倒计时两种模式
- **控制接口**: 需要配合 TextTimerController 使用
- **格式化**: 支持自定义时间显示格式
- **精度**: 支持毫秒级计时

## 模块信息

- **组件名称**: TextTimer
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [TextTimer 文本计时器 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-texttimer-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// TextTimer 是内置组件，无需导入
// 直接使用即可
TextTimer()
```

### 1.2 基础用法

```typescript
@ComponentV2
struct BasicTextTimerExample {
  controller: TextTimerController = new TextTimerController()

  build() {
    TextTimer({ controller: this.controller })
      .format('mm:ss')
  }
}
```

### 1.3 控制器使用

```typescript
@ComponentV2
struct TextTimerControlExample {
  controller: TextTimerController = new TextTimerController()

  build() {
    Column({ space: 16 }) {
      TextTimer({ controller: this.controller })
        .format('mm:ss')

      Button('开始')
        .onClick(() => {
          this.controller.start()
        })

      Button('暂停')
        .onClick(() => {
          this.controller.pause()
        })

      Button('重置')
        .onClick(() => {
          this.controller.reset()
        })
    }
  }
}
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| options | `TextTimerOptions` | 否 | - | 计时器选项，如 controller, isCountDown, count |

### 2.2 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `format` | `string` | 'mm:ss' | 时间格式 |
| `isCountDown` | `boolean` | false | 是否倒计时 |
| `fontColor` | `ResourceColor` | - | 文本颜色 |
| `fontSize` | `number \| string \| Resource` | - | 字体大小 |
| `fontWeight` | `number \| FontWeight \| string` | - | 字体粗细 |
| `onTimer` | `(utc: number) => void` | - | 计时回调事件 |

### 2.3 时间格式占位符

| 占位符 | 描述 | 示例 |
|--------|------|------|
| `HH` | 小时（补零） | 02 |
| `H` | 小时（不补零） | 2 |
| `mm` | 分钟（补零） | 30 |
| `m` | 分钟（不补零） | 30 |
| `ss` | 秒（补零） | 45 |
| `s` | 秒（不补零） | 45 |
| `SS` | 毫秒（3位） | 123 |
| `S` | 毫秒（1位） | 1 |

### 2.4 TextTimerController 方法

| 方法 | 参数 | 返回值 | 描述 |
|------|------|--------|------|
| `start` | - | `void` | 开始计时 |
| `pause` | - | `void` | 暂停计时 |
| `reset` | - | `void` | 重置计时器 |
| `stop` | - | `void` | 停止计时 |

## 三、使用示例

### 3.1 基础计时器示例

```typescript
@ComponentV2
struct BasicTextTimerExample {
  controller: TextTimerController = new TextTimerController()

  build() {
    Column({ space: 16 }) {
      Text('基础计时器')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      TextTimer({ controller: this.controller })
        .format('mm:ss')
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .fontColor('#007DFF')

      Row({ space: 12 }) {
        Button('开始')
          .onClick(() => {
            this.controller.start()
          })

        Button('暂停')
          .onClick(() => {
            this.controller.pause()
          })

        Button('重置')
          .onClick(() => {
            this.controller.reset()
          })
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.2 倒计时示例

```typescript
@ComponentV2
struct CountdownTimerExample {
  controller: TextTimerController = new TextTimerController()
  @Local isRunning: boolean = false

  build() {
    Column({ space: 16 }) {
      Text('倒计时（60秒）')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      TextTimer({
        controller: this.controller,
        isCountDown: true,
        count: 60000 // 60秒，单位毫秒
      })
        .format('ss')
        .fontSize(72)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FF6B6B')
        .onTimer((utc: number) => {
          console.info('剩余时间:', utc)
          if (utc <= 0) {
            this.isRunning = false
            console.info('倒计时结束')
          }
        })

      Button(this.isRunning ? '暂停' : '开始')
        .onClick(() => {
          if (this.isRunning) {
            this.controller.pause()
            this.isRunning = false
          } else {
            this.controller.start()
            this.isRunning = true
          }
        })

      Button('重置')
        .onClick(() => {
          this.controller.reset()
          this.isRunning = false
        })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.3 秒表示例

```typescript
@ComponentV2
struct StopwatchExample {
  controller: TextTimerController = new TextTimerController()
  @Local elapsedTime: number = 0
  @Local isRunning: boolean = false

  build() {
    Column({ space: 16 }) {
      Text('秒表')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      TextTimer({ controller: this.controller })
        .format('HH:mm:ss.S')
        .fontSize(56)
        .fontWeight(FontWeight.Bold)
        .fontColor('#28A745')
        .onTimer((utc: number) => {
          this.elapsedTime = utc
        })

      Text(`${this.elapsedTime} 毫秒`)
        .fontSize(14)
        .fontColor('#666666')

      Row({ space: 12 }) {
        Button(this.isRunning ? '暂停' : '开始')
          .onClick(() => {
            if (this.isRunning) {
              this.controller.pause()
              this.isRunning = false
            } else {
              this.controller.start()
              this.isRunning = true
            }
          })

        Button('重置')
          .onClick(() => {
            this.controller.reset()
            this.elapsedTime = 0
            this.isRunning = false
          })
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.4 番茄钟示例

```typescript
@ComponentV2
struct PomodoroTimerExample {
  controller: TextTimerController = new TextTimerController()
  @Local isWorkTime: boolean = true
  @Local isRunning: boolean = false
  private readonly WORK_TIME = 25 * 60 * 1000 // 25分钟
  private readonly BREAK_TIME = 5 * 60 * 1000 // 5分钟

  build() {
    Column({ space: 16 }) {
      Text(this.isWorkTime ? '工作时间' : '休息时间')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.isWorkTime ? '#007DFF' : '#28A745')

      TextTimer({
        controller: this.controller,
        isCountDown: true,
        count: this.isWorkTime ? this.WORK_TIME : this.BREAK_TIME
      })
        .format('mm:ss')
        .fontSize(72)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.isWorkTime ? '#007DFF' : '#28A745')
        .onTimer((utc: number) => {
          if (utc <= 0 && this.isRunning) {
            this.isRunning = false
            console.info(this.isWorkTime ? '工作时间结束' : '休息时间结束')
          }
        })

      Row({ space: 12 }) {
        Button(this.isRunning ? '暂停' : '开始')
          .onClick(() => {
            if (this.isRunning) {
              this.controller.pause()
              this.isRunning = false
            } else {
              this.controller.start()
              this.isRunning = true
            }
          })

        Button('切换')
          .onClick(() => {
            this.controller.reset()
            this.isWorkTime = !this.isWorkTime
            this.isRunning = false
          })

        Button('重置')
          .onClick(() => {
            this.controller.reset()
            this.isRunning = false
          })
      }
    }
    .width('100%')
    .padding(24)
    .backgroundColor(this.isWorkTime ? '#E3F2FD' : '#E8F5E9')
    .borderRadius(16)
  }
}
```

### 3.5 多个计时器示例

```typescript
@ComponentV2
struct MultipleTimersExample {
  controller1: TextTimerController = new TextTimerController()
  controller2: TextTimerController = new TextTimerController()
  @Local time1: number = 0
  @Local time2: number = 0

  build() {
    Column({ space: 16 }) {
      Text('多个计时器')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 计时器1
      Column({ space: 8 }) {
        Text('计时器 1')
          .fontSize(14)
          .fontColor('#666666')
        TextTimer({ controller: this.controller1 })
          .format('mm:ss')
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
          .fontColor('#007DFF')
          .onTimer((utc: number) => {
            this.time1 = utc
          })
        Text(`${Math.floor(this.time1 / 1000)} 秒`)
          .fontSize(12)
          .fontColor('#999999')

        Row({ space: 8 }) {
          Button('开始')
            .fontSize(12)
            .onClick(() => this.controller1.start())
          Button('暂停')
            .fontSize(12)
            .onClick(() => this.controller1.pause())
          Button('重置')
            .fontSize(12)
            .onClick(() => this.controller1.reset())
        }
      }
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      // 计时器2
      Column({ space: 8 }) {
        Text('计时器 2')
          .fontSize(14)
          .fontColor('#666666')
        TextTimer({ controller: this.controller2 })
          .format('mm:ss')
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
          .fontColor('#28A745')
          .onTimer((utc: number) => {
            this.time2 = utc
          })
        Text(`${Math.floor(this.time2 / 1000)} 秒`)
          .fontSize(12)
          .fontColor('#999999')

        Row({ space: 8 }) {
          Button('开始')
            .fontSize(12)
            .onClick(() => this.controller2.start())
          Button('暂停')
            .fontSize(12)
            .onClick(() => this.controller2.pause())
          Button('重置')
            .fontSize(12)
            .onClick(() => this.controller2.reset())
        }
      }
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.6 圆形进度计时器示例

```typescript
@ComponentV2
struct CircularTimerExample {
  controller: TextTimerController = new TextTimerController()
  @Local progress: number = 100
  private readonly TOTAL_TIME = 60000 // 60秒

  build() {
    Column({ space: 16 }) {
      Stack() {
        // 背景圆环
        Circle({ width: 200, height: 200 })
          .fill(Color.Transparent)
          .stroke('#E0E0E0')
          .strokeWidth(8)

        // 进度圆环
        Circle({ width: 200, height: 200 })
          .fill(Color.Transparent)
          .stroke('#007DFF')
          .strokeWidth(8)
          .strokeDasharray([2 * Math.PI * 95 * this.progress / 100, 2 * Math.PI * 95])
          .rotation(-90)

        // 中心时间显示
        Column() {
          TextTimer({
            controller: this.controller,
            isCountDown: true,
            count: this.TOTAL_TIME
          })
            .format('mm:ss')
            .fontSize(48)
            .fontWeight(FontWeight.Bold)
            .fontColor('#007DFF')
            .onTimer((utc: number) => {
              this.progress = (utc / this.TOTAL_TIME) * 100
            })

          Text('剩余时间')
            .fontSize(14)
            .fontColor('#666666')
        }
        .justifyContent(FlexAlign.Center)
      }
      .width(220)
      .height(220)

      Row({ space: 12 }) {
        Button('开始')
          .onClick(() => this.controller.start())
        Button('暂停')
          .onClick(() => this.controller.pause())
        Button('重置')
          .onClick(() => {
            this.controller.reset()
            this.progress = 100
          })
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.7 定时提醒示例

```typescript
@ComponentV2
struct TimerWithAlertExample {
  controller: TextTimerController = new TextTimerController()
  @Local message: string = '设置计时时间'
  @Local showAlert: boolean = false

  build() {
    Column({ space: 16 }) {
      Text('定时提醒')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      TextTimer({
        controller: this.controller,
        isCountDown: true,
        count: 10000 // 10秒
      })
        .format('ss')
        .fontSize(72)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FF6B6B')
        .onTimer((utc: number) => {
          if (utc <= 0) {
            this.showAlert = true
            this.message = '时间到！'
          } else {
            this.message = `剩余 ${Math.ceil(utc / 1000)} 秒`
          }
        })

      Text(this.message)
        .fontSize(16)
        .fontColor('#666666')

      Row({ space: 12 }) {
        Button('开始')
          .onClick(() => {
            this.controller.start()
            this.showAlert = false
          })
        Button('暂停')
          .onClick(() => this.controller.pause())
        Button('重置')
          .onClick(() => {
            this.controller.reset()
            this.showAlert = false
            this.message = '设置计时时间'
          })
      }

      if (this.showAlert) {
        Text('⏰ 时间到！')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF6B6B')
          .padding(16)
          .backgroundColor('#FFEBEE')
          .borderRadius(8)
          .margin({ top: 16 })
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.8 自定义格式示例

```typescript
@ComponentV2
struct CustomFormatTimerExample {
  controller: TextTimerController = new TextTimerController()

  build() {
    Column({ space: 16 }) {
      Text('自定义时间格式')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 格式1: HH:mm:ss
      Column({ space: 8 }) {
        Text('HH:mm:ss')
          .fontSize(14)
          .fontColor('#666666')
        TextTimer({ controller: this.controller })
          .format('HH:mm:ss')
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
      }
      .padding(16)
      .backgroundColor('#E3F2FD')
      .borderRadius(8)

      // 格式2: mm:ss.S
      Column({ space: 8 }) {
        Text('mm:ss.S (毫秒)')
          .fontSize(14)
          .fontColor('#666666')
        TextTimer({ controller: this.controller })
          .format('mm:ss.S')
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
      }
      .padding(16)
      .backgroundColor('#F3E5F5')
      .borderRadius(8)

      // 格式3: 总秒数
      Column({ space: 8 }) {
        Text('总秒数')
          .fontSize(14)
          .fontColor('#666666')
        TextTimer({ controller: this.controller })
          .format('s')
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
      }
      .padding(16)
      .backgroundColor('#FFF3E0')
      .borderRadius(8)

      Row({ space: 12 }) {
        Button('开始')
          .onClick(() => this.controller.start())
        Button('暂停')
          .onClick(() => this.controller.pause())
        Button('重置')
          .onClick(() => this.controller.reset())
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

## 四、事件处理

### 4.1 计时事件

```typescript
TextTimer({ controller: this.controller })
  .onTimer((utc: number) => {
    console.info('当前时间:', utc)
    // utc 是从开始到现在的毫秒数
  })
```

### 4.2 控制器事件

```typescript
this.controller.start()   // 开始计时
this.controller.pause()   // 暂停计时
this.controller.reset()   // 重置计时器
this.controller.stop()    // 停止计时
```

## 五、最佳实践

### 5.1 控制器管理

```typescript
// ✅ 推荐：每个 TextTimer 使用独立的控制器
@ComponentV2
struct MyComponent {
  controller1: TextTimerController = new TextTimerController()
  controller2: TextTimerController = new TextTimerController()

  build() {
    Column() {
      TextTimer({ controller: this.controller1 })
      TextTimer({ controller: this.controller2 })
    }
  }

  // ❌ 避免：共享控制器
  // 多个组件共享同一个控制器会导致状态混乱
}
```

### 5.2 格式选择

```typescript
// ✅ 推荐：使用清晰的格式
TextTimer()
  .format('mm:ss') // 分钟:秒

// ✅ 推荐：根据需要选择合适的精度
TextTimer()
  .format('mm:ss.SS') // 需要毫秒精度时

// ❌ 避免：使用过于复杂的格式
TextTimer()
  .format('HH时mm分ss秒SSS毫秒') // 过于冗长
```

### 5.3 资源释放

```typescript
// ✅ 推荐：页面销毁时停止计时器
aboutToDisappear() {
  this.controller.stop()
}
```

### 5.4 状态管理

```typescript
// ✅ 推荐：使用状态变量记录运行状态
@ComponentV2
struct MyTimer {
  controller: TextTimerController = new TextTimerController()
  @Local isRunning: boolean = false

  toggleTimer() {
    if (this.isRunning) {
      this.controller.pause()
    } else {
      this.controller.start()
    }
    this.isRunning = !this.isRunning
  }
}
```

## 六、常见问题

### Q1: 计时器不工作？

**问题**: TextTimer 不显示时间或时间不更新。

**解决方案**:
```typescript
@ComponentV2
struct MyTimer {
  controller: TextTimerController = new TextTimerController()

  build() {
    TextTimer({ controller: this.controller })
      .format('mm:ss')
  }

  // 确保调用 start() 方法
  startTimer() {
    this.controller.start()
  }
}
```

### Q2: 如何实现倒计时？

**解决方案**:
```typescript
TextTimer({
  controller: this.controller,
  isCountDown: true, // 设置为倒计时模式
  count: 60000 // 60秒，单位毫秒
})
```

### Q3: 如何获取当前计时时间？

**解决方案**:
```typescript
TextTimer({ controller: this.controller })
  .onTimer((utc: number) => {
    console.info('已过时间(毫秒):', utc)
    console.info('已过时间(秒):', Math.floor(utc / 1000))
  })
```

### Q4: 如何暂停后继续计时？

**解决方案**:
```typescript
// pause() 会暂停计时，start() 会继续计时
this.controller.pause() // 暂停
this.controller.start()  // 继续

// reset() 会重置计时器
this.controller.reset() // 重置
```

### Q5: 如何实现毫秒级计时？

**解决方案**:
```typescript
TextTimer({ controller: this.controller })
  .format('mm:ss.SS') // SS 显示3位毫秒
  // 或
  .format('mm:ss.S')  // S 显示1位毫秒
```

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 9+ | ✅ | 基础支持 |
| API 12+ | ✅ | 增强控制器功能 |

## 八、参考资料

- [TextTimer 文本计时器 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-texttimer-V5)
- [计时器开发指南 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/timer-development-V5)
