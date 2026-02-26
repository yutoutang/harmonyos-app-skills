# Counter 组件 HarmonyOS 6.0 开发 Skill

## 概述

Counter 组件是 OpenHarmony 中的计数器组件，用于实现数量的增减操作。它提供了一组内置的按钮（增加和减少），配合数字显示，常用于商品数量选择、数值调整等场景。Counter 支持自定义按钮样式、事件回调等属性。

## 重要说明

- **内置按钮**: Counter 内置了增加和减少按钮，无需手动创建
- **数值显示**: 自动显示当前数值，支持自定义样式
- **范围限制**: 支持设置最小值和最大值
- **步长设置**: 支持设置每次增减的步长
- **响应式**: 配合 @Local 使用实现响应式更新

## 模块信息

- **组件名称**: Counter
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [Counter - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-counter-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// Counter 是内置组件，无需导入
// 直接使用即可
Counter() {
  // 可选的自定义内容
}
```

### 1.2 基础用法

```typescript
// 基础计数器
Counter() {
  // 默认显示数值
}
.onInc(() => {
  console.info('增加')
})
.onDec(() => {
  console.info('减少')
})
```

## 二、API 参数

### 2.1 构造参数

Counter 组件没有必需的构造参数。

### 2.2 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `src` | `string \| Resource` | - | 自定义图标资源 |
| `backgroundColor` | `ResourceColor` | - | 背景色 |
| `scaleNum` | `number` | 1.0 | 缩放比例 |

### 2.3 事件

| 事件 | 类型 | 描述 |
|------|------|------|
| `onInc` | `() => void` | 增加按钮点击回调 |
| `onDec` | `() => void` | 减少按钮点击回调 |

## 三、使用示例

### 3.1 基础 Counter 示例

```typescript
@ComponentV2
struct BasicCounterExample {
  @Local count: number = 1

  build() {
    Column({ space: 16 }) {
      Text('基础 Counter')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 基础计数器
      Counter() {
        Text(`${this.count}`)
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
      }
      .height(40)
      .onInc(() => {
        this.count++
      })
      .onDec(() => {
        if (this.count > 1) {
          this.count--
        }
      })

      Text(`当前数量: ${this.count}`)
        .fontSize(16)
        .fontColor('#666666')
    }
    .padding(16)
  }
}
```

### 3.2 商品数量选择示例

```typescript
@ComponentV2
struct ProductCounterExample {
  @Local quantity: number = 1
  readonly price: number = 99
  readonly maxQuantity: number = 10

  // 计算总价
  getTotalPrice(): number {
    return this.quantity * this.price
  }

  build() {
    Column({ space: 20 }) {
      Text('商品数量选择')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)

      // 商品信息
      Row() {
        Column({ space: 8 }) {
          Text('精选商品')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)

          Text(`¥${this.price}`)
            .fontSize(20)
            .fontColor('#FF5722')
            .fontWeight(FontWeight.Bold)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Counter() {
          Text(`${this.quantity}`)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .width(40)
            .textAlign(TextAlign.Center)
        }
        .height(36)
        .backgroundColor('#F5F5F5')
        .onInc(() => {
          if (this.quantity < this.maxQuantity) {
            this.quantity++
          }
        })
        .onDec(() => {
          if (this.quantity > 1) {
            this.quantity--
          }
        })
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FAFAFA')
      .borderRadius(8)

      // 总价显示
      Row() {
        Text('总价:')
          .fontSize(16)
          .fontColor('#666666')

        Text(`¥${this.getTotalPrice()}`)
          .fontSize(24)
          .fontColor('#FF5722')
          .fontWeight(FontWeight.Bold)
          .margin({ left: 8 })
      }

      Text(`库存: ${this.maxQuantity} 件`)
        .fontSize(14)
        .fontColor('#999999')
    }
    .padding(16)
  }
}
```

### 3.3 带范围限制的 Counter

```typescript
@ComponentV2
struct RangedCounterExample {
  @Local count: number = 5
  readonly minValue: number = 0
  readonly maxValue: number = 100

  build() {
    Column({ space: 16 }) {
      Text('范围限制 Counter')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 显示范围
      Text(`范围: ${this.minValue} - ${this.maxValue}`)
        .fontSize(14)
        .fontColor('#666666')

      Counter() {
        Text(`${this.count}`)
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .width(60)
          .textAlign(TextAlign.Center)
      }
      .height(45)
      .onInc(() => {
        if (this.count < this.maxValue) {
          this.count++
        }
      })
      .onDec(() => {
        if (this.count > this.minValue) {
          this.count--
        }
      })

      // 进度条显示
      Progress({
        value: this.count,
        total: this.maxValue,
        type: ProgressType.Linear
      })
        .width('100%')
        .color('#007DFF')

      Text(`当前值: ${this.count}`)
        .fontSize(16)
        .fontColor('#666666')
    }
    .padding(16)
  }
}
```

### 3.4 自定义样式 Counter

```typescript
@ComponentV2
struct CustomStyleCounterExample {
  @Local count1: number = 1
  @Local count2: number = 10

  build() {
    Column({ space: 20 }) {
      Text('自定义样式 Counter')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 小尺寸
      Column({ space: 8 }) {
        Text('小尺寸')
          .fontSize(14)
          .fontColor('#666666')

        Counter() {
          Text(`${this.count1}`)
            .fontSize(16)
            .width(30)
            .textAlign(TextAlign.Center)
        }
        .height(32)
        .onInc(() => {
          this.count1++
        })
        .onDec(() => {
          if (this.count1 > 1) {
            this.count1--
          }
        })
      }
      .alignItems(HorizontalAlign.Start)

      // 大尺寸
      Column({ space: 8 }) {
        Text('大尺寸')
          .fontSize(14)
          .fontColor('#666666')

        Counter() {
          Text(`${this.count2}`)
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width(50)
            .textAlign(TextAlign.Center)
        }
        .height(50)
        .backgroundColor('#E3F2FD')
        .onInc(() => {
          this.count2++
        })
        .onDec(() => {
          if (this.count2 > 0) {
            this.count2--
          }
        })
      }
      .alignItems(HorizontalAlign.Start)

      // 带背景色
      Column({ space: 8 }) {
        Text('自定义背景色')
          .fontSize(14)
          .fontColor('#666666')

        Counter() {
          Text('5')
            .fontSize(18)
            .width(40)
            .textAlign(TextAlign.Center)
        }
        .height(40)
        .backgroundColor('#FFF3E0')
      }
      .alignItems(HorizontalAlign.Start)
    }
    .padding(16)
  }
}
```

### 3.5 步长设置示例

```typescript
@ComponentV2
struct StepSizeCounterExample {
  @Local count1: number = 0
  @Local count2: number = 0
  @Local count3: number = 0

  build() {
    Column({ space: 20 }) {
      Text('步长设置 Counter')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 步长 1
      Column({ space: 8 }) {
        Text('步长: 1')
          .fontSize(14)
          .fontColor('#666666')

        Counter() {
          Text(`${this.count1}`)
            .fontSize(18)
            .width(40)
            .textAlign(TextAlign.Center)
        }
        .height(40)
        .onInc(() => {
          this.count1 += 1
        })
        .onDec(() => {
          this.count1 = Math.max(0, this.count1 - 1)
        })
      }
      .alignItems(HorizontalAlign.Start)

      // 步长 5
      Column({ space: 8 }) {
        Text('步长: 5')
          .fontSize(14)
          .fontColor('#666666')

        Counter() {
          Text(`${this.count2}`)
            .fontSize(18)
            .width(40)
            .textAlign(TextAlign.Center)
        }
        .height(40)
        .onInc(() => {
          this.count2 += 5
        })
        .onDec(() => {
          this.count2 = Math.max(0, this.count2 - 5)
        })
      }
      .alignItems(HorizontalAlign.Start)

      // 步长 10
      Column({ space: 8 }) {
        Text('步长: 10')
          .fontSize(14)
          .fontColor('#666666')

        Counter() {
          Text(`${this.count3}`)
            .fontSize(18)
            .width(40)
            .textAlign(TextAlign.Center)
        }
        .height(40)
        .onInc(() => {
          this.count3 += 10
        })
        .onDec(() => {
          this.count3 = Math.max(0, this.count3 - 10)
        })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .padding(16)
  }
}
```

## 四、高级用法

### 4.1 购物车商品数量管理

```typescript
@ComponentV2
struct CartItemCounter {
  @Local quantity: number = 1
  @Param productName: string = ''
  @Param price: number = 0
  @Param stock: number = 100

  build() {
    Row({ space: 12 }) {
      Column({ space: 4 }) {
        Text(this.productName)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)

        Text(`库存 ${this.stock} 件`)
          .fontSize(12)
          .fontColor('#999999')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Column({ space: 8 }) {
        Text(`¥${this.price}`)
          .fontSize(16)
          .fontColor('#FF5722')
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .textAlign(TextAlign.End)

        Counter() {
          Text(`${this.quantity}`)
            .fontSize(14)
            .width(30)
            .textAlign(TextAlign.Center)
        }
        .height(32)
        .backgroundColor('#F5F5F5')
        .onInc(() => {
          if (this.quantity < this.stock) {
            this.quantity++
          }
        })
        .onDec(() => {
          if (this.quantity > 1) {
            this.quantity--
          }
        })
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#FAFAFA')
    .borderRadius(8)
  }
}
```

### 4.2 时间调整 Counter

```typescript
@ComponentV2
struct TimeAdjustCounter {
  @Local hours: number = 0
  @Local minutes: number = 0
  @Local seconds: number = 0

  // 格式化时间
  formatTime(): string {
    const h = this.hours.toString().padStart(2, '0')
    const m = this.minutes.toString().padStart(2, '0')
    const s = this.seconds.toString().padStart(2, '0')
    return `${h}:${m}:${s}`
  }

  build() {
    Column({ space: 20 }) {
      Text('时间调整')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 时间显示
      Text(this.formatTime())
        .fontSize(36)
        .fontWeight(FontWeight.Bold)
        .fontFamily('monospace')

      // 小时调整
      Row({ space: 12 }) {
        Text('小时')
          .fontSize(16)
          .width(60)

        Counter() {
          Text(`${this.hours}`)
            .fontSize(18)
            .width(40)
            .textAlign(TextAlign.Center)
        }
        .height(36)
        .onInc(() => {
          this.hours = (this.hours + 1) % 24
        })
        .onDec(() => {
          this.hours = (this.hours + 23) % 24
        })
      }
      .width('100%')

      // 分钟调整
      Row({ space: 12 }) {
        Text('分钟')
          .fontSize(16)
          .width(60)

        Counter() {
          Text(`${this.minutes}`)
            .fontSize(18)
            .width(40)
            .textAlign(TextAlign.Center)
        }
        .height(36)
        .onInc(() => {
          this.minutes = (this.minutes + 1) % 60
        })
        .onDec(() => {
          this.minutes = (this.minutes + 59) % 60
        })
      }
      .width('100%')

      // 秒钟调整
      Row({ space: 12 }) {
        Text('秒钟')
          .fontSize(16)
          .width(60)

        Counter() {
          Text(`${this.seconds}`)
            .fontSize(18)
            .width(40)
            .textAlign(TextAlign.Center)
        }
        .height(36)
        .onInc(() => {
          this.seconds = (this.seconds + 1) % 60
        })
        .onDec(() => {
          this.seconds = (this.seconds + 59) % 60
        })
      }
      .width('100%')
    }
    .padding(16)
  }
}
```

## 五、最佳实践

### 5.1 合理设置范围

```typescript
// ✅ 推荐：明确设置最小值和最大值
Counter() {
  Text(`${this.count}`)
}
.onInc(() => {
  if (this.count < this.max) {
    this.count++
  }
})
.onDec(() => {
  if (this.count > this.min) {
    this.count--
  }
})

// ❌ 避免：不设置范围限制
Counter() {
  Text(`${this.count}`)
}
.onInc(() => {
  this.count++ // 可能无限增加
})
```

### 5.2 显示库存状态

```typescript
// ✅ 推荐：显示库存信息
@ComponentV2
struct StockAwareCounter {
  @Local quantity: number = 1
  @Param stock: number = 10

  build() {
    Column({ space: 8 }) {
      Counter() {
        Text(`${this.quantity}`)
      }
      .enabled(this.stock > 0) // 库存为0时禁用
      .onInc(() => {
        if (this.quantity < this.stock) {
          this.quantity++
        }
      })

      if (this.stock === 0) {
        Text('暂时缺货')
          .fontSize(14)
          .fontColor('#DC3545')
      } else if (this.quantity >= this.stock) {
        Text('已达最大库存')
          .fontSize(14)
          .fontColor('#FFC107')
      }
    }
  }
}
```

### 5.3 数值格式化

```typescript
// ✅ 推荐：格式化显示数值
@ComponentV2
struct FormattedCounter {
  @Local price: number = 100

  build() {
    Counter() {
      // 格式化价格显示
      Text(`¥${this.price}`)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .width(80)
        .textAlign(TextAlign.Center)
    }
    .height(40)
    .onInc(() => {
      this.price += 10
    })
    .onDec(() => {
      this.price = Math.max(0, this.price - 10)
    })
  }
}
```

## 六、常见问题

### Q1: 如何防止数量减到 0 以下？

**解决方案**:
```typescript
Counter() {
  Text(`${this.count}`)
}
.onDec(() => {
  if (this.count > 1) { // 保持最小值为 1
    this.count--
  }
})
```

### Q2: 如何实现批量增减？

**解决方案**:
```typescript
Counter() {
  Text(`${this.count}`)
}
.onInc(() => {
  this.count += 10 // 每次增加10
})
.onDec(() => {
  this.count = Math.max(0, this.count - 10) // 每次减少10
})
```

### Q3: 如何禁用 Counter？

**解决方案**:
```typescript
Counter() {
  Text(`${this.count}`)
}
.enabled(false) // 禁用组件
```

### Q4: 如何自定义 Counter 的外观？

**解决方案**:
```typescript
Counter() {
  Text(`${this.count}`)
    .fontSize(20)
    .fontWeight(FontWeight.Bold)
    .fontColor('#007DFF')
}
.height(45)
.backgroundColor('#E3F2FD')
```

### Q5: 如何实现多个 Counter 的联动？

**解决方案**:
```typescript
@ComponentV2
struct LinkedCounters {
  @Local count1: number = 1
  @Local count2: number = 2

  getTotal(): number {
    return this.count1 + this.count2
  }

  build() {
    Column({ space: 16 }) {
      Counter() {
        Text(`${this.count1}`)
      }
      .onInc(() => {
        this.count1++
      })

      Counter() {
        Text(`${this.count2}`)
      }
      .onInc(() => {
        this.count2++
      })

      Text(`总计: ${this.getTotal()}`)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
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

- [Counter 计数器 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-counter-V5)
- [通用属性 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-universal-attributes-size-V5)
