# Rating 组件 HarmonyOS 6.0 开发 Skill

## 概述

Rating 组件是 OpenHarmony 中的评分组件，用于让用户通过星星图标进行评分。它支持设置星星数量、默认评分、步长等属性，常用于商品评价、内容评分、服务反馈等场景。

## 重要说明

- **基础组件**: Rating 是 ArkUI 的基础内置组件，无需导入
- **星星数量**: 支持自定义星星数量（默认 5 颗）
- **步长设置**: 支持设置评分步长，实现半星或更精细的评分
- **方向支持**: 支持水平和垂直两个方向
- **样式自定义**: 支持自定义星星颜色、大小等样式
- **只读模式**: 支持设置为只读，仅显示不交互

## 模块信息

- **组件名称**: Rating
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [Rating 评分 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-rating-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// Rating 是内置组件，无需导入
// 直接使用即可
Rating({ rating: 3.5, stars: 5 })
```

### 1.2 基础用法

```typescript
// 基础评分
Rating({ rating: 4, stars: 5 })
  .onChange((value: number) => {
    console.info('Rating: ' + value)
  })

// 设置步长（支持半星）
Rating({ rating: 3.5, stars: 5, stepSize: 0.5 })

// 只读模式
Rating({ rating: 4.5, stars: 5 })
  .readonly(true)
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| rating | `number` | 是 | - | 当前评分数 |
| stars | `number` | 否 | 5 | 星星总数 |
| stepSize | `number` | 否 | 1 | 评分步长 |
| isLandscape | `boolean` | 否 | true | 是否水平方向 |

### 2.2 样式属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `starColor` | `ResourceColor` | - | 星星颜色 |
| `unlabeledColor` | `ResourceColor` | - | 未选中星星颜色 |
| `ratingStyle` | `RatingStyle` | - | 自定义星星样式 |

### 2.3 交互属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `readonly` | `boolean` | false | 是否只读 |
| `onChange` | `(value: number) => void` | - | 评分变化回调 |

## 三、使用示例

### 3.1 基础 Rating 示例

```typescript
@ComponentV2
struct BasicRatingExample {
  @Local rating: number = 3

  build() {
    Column({ space: 16 }) {
      Text('基础 Rating')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 基础评分（整星）
      Rating({ rating: this.rating, stars: 5 })
        .onChange((value: number) => {
          this.rating = value
          console.info('Rating: ' + value)
        })

      Text(`当前评分: ${this.rating}`)
        .fontSize(16)
        .fontColor('#666666')
    }
    .padding(16)
  }
}
```

### 3.2 半星评分示例

```typescript
@ComponentV2
struct HalfStarRatingExample {
  @Local rating: number = 3.5

  build() {
    Column({ space: 16 }) {
      Text('半星评分')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 支持半星评分
      Rating({
        rating: this.rating,
        stars: 5,
        stepSize: 0.5
      })
        .starColor('#FFC107')
        .onChange((value: number) => {
          this.rating = value
        })

      Text(`当前评分: ${this.rating}`)
        .fontSize(16)
        .fontColor('#666666')

      // 更精细的评分（0.1 步长）
      Rating({
        rating: 3.7,
        stars: 5,
        stepSize: 0.1
      })
        .starColor('#FF5722')
    }
    .padding(16)
  }
}
```

### 3.3 自定义星星数量示例

```typescript
@ComponentV2
struct CustomStarsRatingExample {
  @Local rating1: number = 3
  @Local rating2: number = 7
  @Local rating3: number = 8

  build() {
    Column({ space: 20 }) {
      Text('自定义星星数量')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 3 星评分
      Column({ space: 8 }) {
        Text('3 星评分')
          .fontSize(14)
        Rating({ rating: this.rating1, stars: 3 })
          .starColor('#007DFF')
          .onChange((value: number) => {
            this.rating1 = value
          })
      }

      // 7 星评分
      Column({ space: 8 }) {
        Text('7 星评分')
          .fontSize(14)
        Rating({ rating: this.rating2, stars: 7 })
          .starColor('#28A745')
          .onChange((value: number) => {
            this.rating2 = value
          })
      }

      // 10 星评分
      Column({ space: 8 }) {
        Text('10 星评分')
          .fontSize(14)
        Rating({ rating: this.rating3, stars: 10 })
          .starColor('#FFC107')
          .onChange((value: number) => {
            this.rating3 = value
          })
      }
    }
    .padding(16)
  }
}
```

### 3.4 只读评分示例

```typescript
@ComponentV2
struct ReadonlyRatingExample {
  build() {
    Column({ space: 20 }) {
      Text('只读评分')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 只读模式
      Column({ space: 8 }) {
        Text('商品评分: 4.5')
          .fontSize(16)

        Row({ space: 8 }) {
          Rating({ rating: 4.5, stars: 5, stepSize: 0.5 })
            .starColor('#FFC107')
            .readonly(true) // 只读模式

          Text('4.5')
            .fontSize(18)
            .fontColor('#FFC107')
            .fontWeight(FontWeight.Bold)
        }
      }

      // 显示评分和人数
      Column({ space: 8 }) {
        Text('服务评分')
          .fontSize(16)

        Row({ space: 8 }) {
          Rating({ rating: 5, stars: 5 })
            .starColor('#28A745')
            .readonly(true)

          Text('5.0')
            .fontSize(18)
            .fontColor('#28A745')
            .fontWeight(FontWeight.Bold)

          Text('(256人评价)')
            .fontSize(14)
            .fontColor('#666666')
        }
      }
    }
    .padding(16)
  }
}
```

### 3.5 垂直 Rating 示例

```typescript
@ComponentV2
struct VerticalRatingExample {
  @Local rating: number = 3.5

  build() {
    Row({ space: 40 }) {
      // 水平方向
      Column({ space: 8 }) {
        Text('水平')
          .fontSize(14)
        Rating({
          rating: this.rating,
          stars: 5,
          isLandscape: true
        })
          .starColor('#007DFF')
          .onChange((value: number) => {
            this.rating = value
          })
      }

      // 垂直方向
      Column({ space: 8 }) {
        Text('垂直')
          .fontSize(14)
        Rating({
          rating: this.rating,
          stars: 5,
          isLandscape: false
        })
          .starColor('#28A745')
          .onChange((value: number) => {
            this.rating = value
          })
      }
    }
    .padding(16)
  }
}
```

### 3.6 实际应用场景

```typescript
@ComponentV2
struct ProductReviewCard {
  @Local productRating: number = 4.5
  @Local serviceRating: number = 5
  @Local deliveryRating: number = 4

  build() {
    Column({ space: 20 }) {
      Text('商品评价')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)

      // 商品质量评分
      Column({ space: 8 }) {
        Text('商品质量')
          .fontSize(16)

        Row({ space: 12 }) {
          Rating({
            rating: this.productRating,
            stars: 5,
            stepSize: 0.5
          })
            .starColor('#FFC107')
            .onChange((value: number) => {
              this.productRating = value
            })

          Text(`${this.productRating}`)
            .fontSize(18)
            .fontColor('#FFC107')
            .fontWeight(FontWeight.Bold)
        }
      }

      // 服务态度评分
      Column({ space: 8 }) {
        Text('服务态度')
          .fontSize(16)

        Row({ space: 12 }) {
          Rating({
            rating: this.serviceRating,
            stars: 5,
            stepSize: 0.5
          })
            .starColor('#28A745')
            .onChange((value: number) => {
              this.serviceRating = value
            })

          Text(`${this.serviceRating}`)
            .fontSize(18)
            .fontColor('#28A745')
            .fontWeight(FontWeight.Bold)
        }
      }

      // 物流速度评分
      Column({ space: 8 }) {
        Text('物流速度')
          .fontSize(16)

        Row({ space: 12 }) {
          Rating({
            rating: this.deliveryRating,
            stars: 5,
            stepSize: 0.5
          })
            .starColor('#007DFF')
            .onChange((value: number) => {
              this.deliveryRating = value
            })

          Text(`${this.deliveryRating}`)
            .fontSize(18)
            .fontColor('#007DFF')
            .fontWeight(FontWeight.Bold)
        }
      }

      // 提交按钮
      Button('提交评价')
        .width('100%')
        .height(45)
        .type(ButtonType.Capsule)
        .backgroundColor('#007DFF')
        .fontColor(Color.White)
        .onClick(() => {
          console.info(`商品: ${this.productRating}, 服务: ${this.serviceRating}, 物流: ${this.deliveryRating}`)
        })
    }
    .padding(16)
  }
}
```

## 四、高级用法

### 4.1 评分统计

```typescript
@ComponentV2
struct RatingStatistics {
  @Local ratings: number[] = [5, 4, 5, 3, 4, 5, 4, 5]
  @Local userRating: number = 0

  // 计算平均分
  getAverageRating(): number {
    if (this.ratings.length === 0) return 0
    const sum = this.ratings.reduce((a, b) => a + b, 0)
    return Math.round((sum / this.ratings.length) * 10) / 10
  }

  // 计算评分分布
  getRatingDistribution(): Map<number, number> {
    const distribution = new Map<number, number>()
    for (let i = 1; i <= 5; i++) {
      distribution.set(i, 0)
    }
    this.ratings.forEach(rating => {
      const count = distribution.get(rating) || 0
      distribution.set(rating, count + 1)
    })
    return distribution
  }

  build() {
    Column({ space: 20 }) {
      Text('评分统计')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)

      // 平均分
      Column({ space: 8 }) {
        Text('平均评分')
          .fontSize(14)
          .fontColor('#666666')

        Row({ space: 12 }) {
          Text(`${this.getAverageRating()}`)
            .fontSize(48)
            .fontColor('#FFC107')
            .fontWeight(FontWeight.Bold)

          Column({ space: 4 }) {
            Rating({
              rating: this.getAverageRating(),
              stars: 5,
              stepSize: 0.5
            })
              .starColor('#FFC107')
              .readonly(true)

            Text(`共 ${this.ratings.length} 人评价`)
              .fontSize(14)
              .fontColor('#666666')
          }
          .alignItems(HorizontalAlign.Start)
        }
      }

      // 用户评分
      Column({ space: 8 }) {
        Text('您的评分')
          .fontSize(16)

        Rating({
          rating: this.userRating,
          stars: 5,
          stepSize: 1
        })
          .starColor('#007DFF')
          .onChange((value: number) => {
            this.userRating = value
            if (value > 0) {
              this.ratings.push(value)
            }
          })
      }
    }
    .padding(16)
  }
}
```

### 4.2 评分等级显示

```typescript
@ComponentV2
struct RatingWithLevel {
  @Local rating: number = 4.5

  // 获取评价等级
  getRatingLevel(): string {
    if (this.rating >= 5) return '非常满意'
    if (this.rating >= 4) return '满意'
    if (this.rating >= 3) return '一般'
    if (this.rating >= 2) return '不满意'
    return '非常不满意'
  }

  // 获取评价颜色
  getRatingColor(): string {
    if (this.rating >= 4.5) return '#FFC107'
    if (this.rating >= 3.5) return '#28A745'
    if (this.rating >= 2.5) return '#FFC107'
    if (this.rating >= 1.5) return '#FF8C00'
    return '#DC3545'
  }

  build() {
    Column({ space: 16 }) {
      Text('评分等级')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 评分和等级
      Column({ space: 12 }) {
        Rating({
          rating: this.rating,
          stars: 5,
          stepSize: 0.5
        })
          .starColor(this.getRatingColor())
          .onChange((value: number) => {
            this.rating = value
          })

        Text(this.getRatingLevel())
          .fontSize(20)
          .fontColor(this.getRatingColor())
          .fontWeight(FontWeight.Bold)

        Text(`${this.rating} 分`)
          .fontSize(14)
          .fontColor('#666666')
      }
    }
    .padding(16)
  }
}
```

## 五、最佳实践

### 5.1 合理设置步长

```typescript
// ✅ 推荐：根据场景选择步长
// 整星评分（快速评价）
Rating({ rating: 4, stars: 5, stepSize: 1 })

// 半星评分（更精确）
Rating({ rating: 4.5, stars: 5, stepSize: 0.5 })

// 精确评分（专业评价）
Rating({ rating: 4.7, stars: 5, stepSize: 0.1 })
```

### 5.2 显示评分数值

```typescript
// ✅ 推荐：同时显示星星和数值
@ComponentV2
struct GoodRatingDisplay {
  @Local rating: number = 4.5

  build() {
    Row({ space: 8 }) {
      Rating({ rating: this.rating, stars: 5, stepSize: 0.5 })
        .starColor('#FFC107')

      Text(`${this.rating}`)
        .fontSize(18)
        .fontColor('#FFC107')
        .fontWeight(FontWeight.Bold)
    }
  }
}
```

### 5.3 使用只读模式

```typescript
// ✅ 显示已提交的评价
Rating({ rating: 4.5, stars: 5 })
  .starColor('#FFC107')
  .readonly(true) // 防止修改

// ✅ 允许用户评价
Rating({ rating: 0, stars: 5 })
  .starColor('#FFC107')
  .readonly(false) // 允许交互
```

### 5.4 颜色选择

```typescript
// ✅ 推荐：使用黄色作为星星颜色
Rating({ rating: 4.5, stars: 5 })
  .starColor('#FFC107') // 经典的星星黄

// ✅ 根据评分等级使用不同颜色
Rating({ rating: 5, stars: 5 })
  .starColor('#28A745') // 优秀用绿色
```

## 六、常见问题

### Q1: 评分不准确？

**问题**: 点击某个星星，但评分与预期不符。

**解决方案**:
```typescript
// 确保步长设置正确
// ✅ 整星评分
Rating({ rating: 4, stars: 5, stepSize: 1 })

// ✅ 半星评分
Rating({ rating: 4.5, stars: 5, stepSize: 0.5 })
```

### Q2: 如何防止用户重复评分？

**解决方案**:
```typescript
@ComponentV2
struct PreventDuplicateRating {
  @Local rating: number = 0
  @Local hasRated: boolean = false

  build() {
    Column() {
      Rating({
        rating: this.rating,
        stars: 5
      })
        .readonly(this.hasRated) // 评分后设为只读
        .onChange((value: number) => {
          if (!this.hasRated) {
            this.rating = value
            this.hasRated = true
          }
        })

      if (this.hasRated) {
        Text('您已评价')
          .fontSize(14)
          .fontColor('#666666')
      }
    }
  }
}
```

### Q3: 如何实现多维度评分？

**解决方案**:
```typescript
// ✅ 为每个维度创建独立的 Rating
@ComponentV2
struct MultiDimensionRating {
  @Local qualityRating: number = 0
  @Local serviceRating: number = 0
  @Local deliveryRating: number = 0

  build() {
    Column() {
      // 商品质量
      Rating({ rating: this.qualityRating, stars: 5 })
        .onChange((value: number) => {
          this.qualityRating = value
        })

      // 服务态度
      Rating({ rating: this.serviceRating, stars: 5 })
        .onChange((value: number) => {
          this.serviceRating = value
        })

      // 物流速度
      Rating({ rating: this.deliveryRating, stars: 5 })
        .onChange((value: number) => {
          this.deliveryRating = value
        })
    }
  }
}
```

### Q4: 如何清除评分？

**解决方案**:
```typescript
@ComponentV2
struct ClearableRating {
  @Local rating: number = 4.5

  build() {
    Column({ space: 16 }) {
      Rating({
        rating: this.rating,
        stars: 5,
        stepSize: 0.5
      })
        .onChange((value: number) => {
          this.rating = value
        })

      Button('清除评分')
        .onClick(() => {
          this.rating = 0 // 重置为 0
        })
    }
  }
}
```

### Q5: 如何实现自定义星星样式？

**解决方案**:
```typescript
// Rating 组件支持自定义样式
Rating({
  rating: 4.5,
  stars: 5,
  stepSize: 0.5
})
  .starColor('#FFC107') // 星星颜色
  .unlabeledColor('#E0E0E0') // 未选中颜色
```

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 9+ | ✅ | 完全支持 |
| API 10+ | ✅ | 性能优化 |
| API 12+ | ✅ | 增加了更多自定义选项 |

## 八、参考资料

- [Rating 评分 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-rating-V5)
- [通用属性 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-universal-attributes-size-V5)
