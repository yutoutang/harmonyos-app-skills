# PatternLock 组件 HarmonyOS 6.0 开发 Skill

## 概述

PatternLock 组件是 OpenHarmony 中的图案密码锁组件，用于让用户通过连接点来绘制图案进行身份验证或设置密码。它通常用于手机解锁、应用锁、隐私保护等场景。PatternLock 提供了完整的图案绘制、验证和自定义功能。

## 重要说明

- **手势绘制**: 用户通过连接至少4个点来创建图案
- **自动验证**: 支持自动验证和手动验证两种模式
- **图案重置**: 支持用户重新绘制图案
- **高度可定制**: 支持自定义点的颜色、大小、路径样式等
- **安全场景**: 常用于锁屏、隐私保护、支付验证等

## 模块信息

- **组件名称**: PatternLock
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [PatternLock - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-pattern-lock-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// PatternLock 是内置组件，无需导入
// 直接使用即可
PatternLock()
```

### 1.2 基础用法

```typescript
// 基础图案锁
PatternLock()
  .sideLength(300)
  .onPatternChange((input: Array<number>) => {
    console.info('图案: ' + JSON.stringify(input))
  })
```

## 二、API 参数

### 2.1 构造参数

PatternLock 组件没有必需的构造参数。

### 2.2 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `sideLength` | `number \| string` | - | 组件宽度 |
| `circleRadius` | `number` | - | 圆点半径 |
| `regularColor` | `ResourceColor` | - | 未选中圆点颜色 |
| `selectedColor` | `ResourceColor` | - | 选中圆点颜色 |
| `activeColor` | `ResourceColor` | - | 激活状态圆点颜色 |
| `pathColor` | `ResourceColor` | - | 路径颜色 |
| `pathStrokeWidth` | `number` | - | 路径宽度 |
| `autoReset` | `boolean` | true | 是否自动重置 |

### 2.3 事件

| 事件 | 类型 | 描述 |
|------|------|------|
| `onPatternChange` | `(input: Array<number>) => void` | 图案变化回调 |
| `onDotConnect` | `(input: Array<number>) => void` | 点连接回调 |

## 三、使用示例

### 3.1 基础 PatternLock 示例

```typescript
@ComponentV2
struct BasicPatternLockExample {
  @Local pattern: Array<number> = []

  build() {
    Column({ space: 20 }) {
      Text('图案锁')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)

      // 基础图案锁
      PatternLock()
        .sideLength(300)
        .circleRadius(8)
        .regularColor('#CCCCCC')
        .selectedColor('#007DFF')
        .pathColor('#007DFF')
        .pathStrokeWidth(3)
        .onPatternChange((input: Array<number>) => {
          this.pattern = input
          console.info('图案: ' + JSON.stringify(input))
        })

      // 显示当前图案
      if (this.pattern.length > 0) {
        Text(`已连接 ${this.pattern.length} 个点`)
          .fontSize(16)
          .fontColor('#666666')

        Text(`图案: ${this.pattern.join(' → ')}`)
          .fontSize(14)
          .fontColor('#999999')
      }
    }
    .width('100%')
    .padding(20)
    .justifyContent(FlexAlign.Center)
  }
}
```

### 3.2 设置图案密码示例

```typescript
@ComponentV2
struct SetPatternPasswordExample {
  @Local step: number = 1
  @Local firstPattern: Array<number> = []
  @Local secondPattern: Array<number> = []
  @Local message: string = '请绘制图案密码'

  build() {
    Column({ space: 20 }) {
      Text('设置图案密码')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)

      // 提示信息
      Column({ space: 8 }) {
        Text(this.message)
          .fontSize(16)
          .fontColor('#666666')

        if (this.step === 1) {
          Text('至少连接4个点')
            .fontSize(14)
            .fontColor('#999999')
        }
      }
      .width('100%')

      // 图案锁
      PatternLock()
        .sideLength(300)
        .circleRadius(10)
        .regularColor('#DDDDDD')
        .selectedColor('#007DFF')
        .activeColor('#007DFF')
        .pathColor('#007DFF')
        .pathStrokeWidth(4)
        .autoReset(false)
        .onDotConnect((input: Array<number>) => {
          if (input.length < 4) {
            this.message = '图案太简单，至少连接4个点'
            return
          }

          if (this.step === 1) {
            this.firstPattern = input
            this.step = 2
            this.message = '请再次绘制图案以确认'
          } else if (this.step === 2) {
            this.secondPattern = input

            // 验证两次图案是否一致
            if (this.comparePatterns(this.firstPattern, this.secondPattern)) {
              this.step = 3
              this.message = '图案密码设置成功！'
            } else {
              this.step = 1
              this.firstPattern = []
              this.secondPattern = []
              this.message = '两次图案不一致，请重新设置'
            }
          }
        })

      // 操作按钮
      if (this.step === 3) {
        Button('完成')
          .width(120)
          .height(40)
          .type(ButtonType.Capsule)
          .backgroundColor('#007DFF')
          .fontColor(Color.White)
          .onClick(() => {
            console.info('密码设置完成:', JSON.stringify(this.firstPattern))
            this.step = 1
            this.firstPattern = []
            this.secondPattern = []
            this.message = '请绘制图案密码'
          })
      }

      // 重新设置按钮
      if (this.step === 2 || (this.step === 1 && this.firstPattern.length > 0)) {
        Button('重新设置')
          .width(120)
          .height(40)
          .type(ButtonType.Capsule)
          .backgroundColor('#6C757D')
          .fontColor(Color.White)
          .onClick(() => {
            this.step = 1
            this.firstPattern = []
            this.secondPattern = []
            this.message = '请绘制图案密码'
          })
      }
    }
    .width('100%')
    .height('100%')
    .padding(20)
  }

  // 比较两个图案是否相同
  comparePatterns(pattern1: Array<number>, pattern2: Array<number>): boolean {
    if (pattern1.length !== pattern2.length) {
      return false
    }
    for (let i = 0; i < pattern1.length; i++) {
      if (pattern1[i] !== pattern2[i]) {
        return false
      }
    }
    return true
  }
}
```

### 3.3 验证图案密码示例

```typescript
@ComponentV2
struct VerifyPatternPasswordExample {
  @Local inputPattern: Array<number> = []
  @Local correctPattern: Array<number> = [0, 1, 2, 4, 6, 7, 8]
  @Local message: string = '请绘制图案解锁'
  @Local isError: boolean = false
  @Local isSuccess: boolean = false

  build() {
    Column({ space: 20 }) {
      Text('图案解锁')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)

      // 状态显示
      Row({ space: 8 }) {
        if (this.isSuccess) {
          Text('✓')
            .fontSize(24)
            .fontColor('#28A745')
        } else if (this.isError) {
          Text('✗')
            .fontSize(24)
            .fontColor('#DC3545')
        }

        Text(this.message)
          .fontSize(16)
          .fontColor(this.isError ? '#DC3545' : '#666666')
      }
      .width('100%')

      // 图案锁
      PatternLock()
        .sideLength(300)
        .circleRadius(10)
        .regularColor('#DDDDDD')
        .selectedColor(this.isError ? '#DC3545' : '#007DFF')
        .activeColor(this.isSuccess ? '#28A745' : '#007DFF')
        .pathColor(this.isError ? '#DC3545' : '#007DFF')
        .pathStrokeWidth(4)
        .autoReset(false)
        .onDotConnect((input: Array<number>) => {
          if (input.length < 4) {
            this.message = '图案太简单'
            this.isError = false
            return
          }

          this.inputPattern = input

          // 验证图案
          if (this.comparePatterns(this.inputPattern, this.correctPattern)) {
            this.isError = false
            this.isSuccess = true
            this.message = '解锁成功！'

            // 2秒后重置
            setTimeout(() => {
              this.isSuccess = false
              this.inputPattern = []
              this.message = '请绘制图案解锁'
            }, 2000)
          } else {
            this.isError = true
            this.isSuccess = false
            this.message = '图案错误，请重试'

            // 2秒后重置
            setTimeout(() => {
              this.isError = false
              this.inputPattern = []
              this.message = '请绘制图案解锁'
            }, 2000)
          }
        })

      // 忘记密码
      Button('忘记密码？')
        .fontSize(14)
        .fontColor('#007DFF')
        .backgroundColor(Color.Transparent)
        .onClick(() => {
          console.info('忘记密码')
        })
    }
    .width('100%')
    .height('100%')
    .padding(20)
  }

  comparePatterns(pattern1: Array<number>, pattern2: Array<number>): boolean {
    if (pattern1.length !== pattern2.length) {
      return false
    }
    for (let i = 0; i < pattern1.length; i++) {
      if (pattern1[i] !== pattern2[i]) {
        return false
      }
    }
    return true
  }
}
```

### 3.4 自定义样式 PatternLock

```typescript
@ComponentV2
struct CustomStylePatternLockExample {
  @Local pattern: Array<number> = []

  build() {
    Column({ space: 20 }) {
      Text('自定义样式')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)

      // 大圆点样式
      Column({ space: 12 }) {
        Text('大圆点')
          .fontSize(16)
          .fontColor('#666666')

        PatternLock()
          .sideLength(280)
          .circleRadius(15)
          .regularColor('#E0E0E0')
          .selectedColor('#FF5722')
          .pathColor('#FF5722')
          .pathStrokeWidth(5)
          .onPatternChange((input: Array<number>) => {
            this.pattern = input
          })
      }

      // 细线条样式
      Column({ space: 12 }) {
        Text('细线条')
          .fontSize(16)
          .fontColor('#666666')

        PatternLock()
          .sideLength(280)
          .circleRadius(8)
          .regularColor('#CCCCCC')
          .selectedColor('#28A745')
          .pathColor('#28A745')
          .pathStrokeWidth(2)
          .onPatternChange((input: Array<number>) => {
            this.pattern = input
          })
      }

      // 紫色主题
      Column({ space: 12 }) {
        Text('紫色主题')
          .fontSize(16)
          .fontColor('#666666')

        PatternLock()
          .sideLength(280)
          .circleRadius(10)
          .regularColor('#E1BEE7')
          .selectedColor('#9C27B0')
          .pathColor('#9C27B0')
          .pathStrokeWidth(4)
          .onPatternChange((input: Array<number>) => {
            this.pattern = input
          })
      }
    }
    .width('100%')
    .height('100%')
    .padding(20)
  }
}
```

### 3.5 图案复杂度提示

```typescript
@ComponentV2
struct PatternComplexityExample {
  @Local pattern: Array<number> = []

  // 计算图案复杂度
  getComplexity(): string {
    if (this.pattern.length < 4) {
      return '图案太简单'
    } else if (this.pattern.length < 6) {
      return '图案复杂度：一般'
    } else if (this.pattern.length < 8) {
      return '图案复杂度：良好'
    } else {
      return '图案复杂度：优秀'
    }
  }

  // 获取复杂度颜色
  getComplexityColor(): string {
    if (this.pattern.length < 4) {
      return '#DC3545'
    } else if (this.pattern.length < 6) {
      return '#FFC107'
    } else if (this.pattern.length < 8) {
      return '#28A745'
    } else {
      return '#007DFF'
    }
  }

  build() {
    Column({ space: 20 }) {
      Text('图案复杂度')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)

      // 图案锁
      PatternLock()
        .sideLength(300)
        .circleRadius(10)
        .regularColor('#DDDDDD')
        .selectedColor('#007DFF')
        .pathColor('#007DFF')
        .pathStrokeWidth(4)
        .autoReset(true)
        .onDotConnect((input: Array<number>) => {
          this.pattern = input
        })

      // 复杂度显示
      Column({ space: 12 }) {
        Text('图案强度')
          .fontSize(16)
          .fontColor('#666666')

        Text(this.getComplexity())
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.getComplexityColor())

        // 强度指示条
        Row() {
          ForEach([1, 2, 3, 4], (level: number) => {
            Column()
              .width(60)
              .height(8)
              .backgroundColor(level <= this.pattern.length - 3 ? this.getComplexityColor() : '#E0E0E0')
              .borderRadius(4)
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      // 点数统计
      Text(`已连接 ${this.pattern.length} 个点`)
        .fontSize(14)
        .fontColor('#999999')
    }
    .width('100%')
    .height('100%')
    .padding(20)
  }
}
```

## 四、高级用法

### 4.1 图案管理

```typescript
@ComponentV2
struct PatternManagerExample {
  @Local currentPattern: Array<number> = []
  @Local savedPatterns: Map<string, Array<number>> = new Map()

  // 保存图案
  savePattern(name: string, pattern: Array<number>) {
    this.savedPatterns.set(name, pattern)
    console.info(`已保存图案: ${name}`)
  }

  // 验证图案
  verifyPattern(name: string, input: Array<number>): boolean {
    const saved = this.savedPatterns.get(name)
    if (!saved) return false
    return JSON.stringify(saved) === JSON.stringify(input)
  }

  build() {
    Column({ space: 20 }) {
      Text('图案管理')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)

      PatternLock()
        .sideLength(300)
        .onDotConnect((input: Array<number>) => {
          if (input.length >= 4) {
            this.currentPattern = input
            // 保存或验证逻辑
          }
        })
    }
    .padding(20)
  }
}
```

## 五、最佳实践

### 5.1 最小点数限制

```typescript
// ✅ 推荐：要求至少连接4个点
PatternLock()
  .onDotConnect((input: Array<number>) => {
    if (input.length < 4) {
      this.message = '图案太简单，至少连接4个点'
      return
    }
    // 处理有效图案
  })

// ❌ 避免：接受任意长度的图案
PatternLock()
  .onDotConnect((input: Array<number>) => {
    // 不验证点数
  })
```

### 5.2 二次确认

```typescript
// ✅ 推荐：设置密码时要求二次确认
@ComponentV2
struct SecurePatternSetup {
  @Local step: number = 1
  @Local firstPattern: Array<number> = []
  @Local secondPattern: Array<number> = []

  build() {
    PatternLock()
      .onDotConnect((input: Array<number>) => {
        if (this.step === 1) {
          this.firstPattern = input
          this.step = 2
        } else if (this.step === 2) {
          this.secondPattern = input
          // 验证两次图案是否一致
          if (JSON.stringify(this.firstPattern) === JSON.stringify(this.secondPattern)) {
            // 保存密码
          }
        }
      })
  }
}
```

### 5.3 错误反馈

```typescript
// ✅ 推荐：提供清晰的错误反馈
PatternLock()
  .selectedColor(this.isError ? '#DC3545' : '#007DFF')
  .pathColor(this.isError ? '#DC3545' : '#007DFF')
  .onDotConnect((input: Array<number>) => {
    if (!this.verifyPattern(input)) {
      this.isError = true
      this.message = '图案错误'

      // 2秒后重置
      setTimeout(() => {
        this.isError = false
      }, 2000)
    }
  })
```

## 六、常见问题

### Q1: 如何重置图案锁？

**解决方案**:
```typescript
@ComponentV2
struct ResetPatternLock {
  @Local reset: boolean = false

  build() {
    Column() {
      PatternLock()
        .autoReset(false) // 禁用自动重置

      Button('重置')
        .onClick(() => {
          this.reset = !this.reset // 触发重新渲染
        })
    }
  }
}
```

### Q2: 如何保存和验证图案密码？

**解决方案**:
```typescript
// 保存图案
const pattern = [0, 1, 2, 4, 6, 7, 8]
preferences.put('pattern_password', JSON.stringify(pattern))

// 验证图案
const saved = JSON.parse(preferences.get('pattern_password', '[]'))
const isValid = JSON.stringify(input) === JSON.stringify(saved)
```

### Q3: 如何实现图案的可视化显示？

**解决方案**:
```typescript
// 显示已连接的点
Column() {
  Text(`图案: ${this.pattern.join(' → ')}`)
    .fontSize(14)

  ForEach([0, 1, 2, 3, 4, 5, 6, 7, 8], (index: number) => {
    Column()
      .width(20)
      .height(20)
      .backgroundColor(this.pattern.includes(index) ? '#007DFF' : '#E0E0E0')
      .borderRadius(10)
  })
  .columnsTemplate('1fr 1fr 1fr')
  .rowsTemplate('1fr 1fr 1fr')
  .width(90)
  .height(90)
}
```

### Q4: 如何防止图案过于简单？

**解决方案**:
```typescript
// 检查图案复杂度
function validatePattern(pattern: Array<number>): boolean {
  // 至少4个点
  if (pattern.length < 4) return false

  // 检查是否使用连续的点
  let consecutiveCount = 1
  for (let i = 1; i < pattern.length; i++) {
    if (pattern[i] === pattern[i - 1] + 1) {
      consecutiveCount++
    }
  }

  // 避免过于简单的连续图案
  return !(pattern.length === consecutiveCount && pattern.length < 6)
}
```

### Q5: 如何实现生物识别备选方案？

**解决方案**:
```typescript
@ComponentV2
struct BiometricFallback {
  @Local showPattern: boolean = false

  build() {
    Column() {
      if (!this.showPattern) {
        Button('使用图案密码')
          .onClick(() => {
            this.showPattern = true
          })
      } else {
        PatternLock()
          .onDotConnect((input: Array<number>) => {
            // 验证图案
          })

        Button('返回')
          .onClick(() => {
            this.showPattern = false
          })
      }
    }
  }
}
```

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 9+ | ✅ | 完全支持 |
| API 10+ | ✅ | 性能优化 |
| API 12+ | ✅ | 增加了更多自定义选项 |

## 八、参考资料

- [PatternLock 图案锁 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-pattern-lock-V5)
- [安全能力 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/security-app-permissions-V5)
