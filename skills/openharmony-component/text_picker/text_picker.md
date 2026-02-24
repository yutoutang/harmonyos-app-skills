# TextPicker 组件 HarmonyOS 6.0 开发 Skill

## 概述

TextPicker 组件是 OpenHarmony 中的文本选择器组件，用于让用户从预定义的选项列表中选择一个值。它提供了滑动选择交互方式，适用于单选场景，如选择城市、分类、选项等。

## 重要说明

- **基础组件**: TextPicker 是 ArkUI 的基础内置组件，无需导入
- **数据类型**: 使用数组或范围作为数据源
- **响应式**: 配合 @State/@Local 使用实现响应式更新
- **选择对象**: 返回选中的值、索引等信息

## 模块信息

- **组件名称**: TextPicker
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [TextPicker - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-textpicker-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// TextPicker 是内置组件，无需导入
// 直接使用即可
TextPicker({ range: ['选项1', '选项2', '选项3'], selected: 0 })
```

### 1.2 基础用法

```typescript
// 使用数组作为数据源
TextPicker({ range: ['北京', '上海', '广州', '深圳'], selected: 0 })
  .onChange((value: TextPickerResult) => {
    console.info('Selected: ' + value.value)
    console.info('Index: ' + value.index)
  })

// 使用范围作为数据源
TextPicker({ range: [1, 100], selected: 0 })
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| range | `Array<string \| number> \| Array<Array<string \| number>> \| Array<{value: string \| number, icon?: Resource \| string}>` | 是 | - | 选择器数据源 |
| selected | `number \| number[]` | 否 | 0 | 选中项索引 |

### 2.2 TextPickerResult 接口

| 属性 | 类型 | 描述 |
|------|------|------|
| value | `string \| number` | 选中的值 |
| index | `number` | 选中的索引 |

### 2.3 TextPicker 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `canLoop` | `boolean` | false | 是否循环显示 |
| `disappearTextStyle` | `TextPickerTextStyle` | - | 不可选文本样式 |
| `textStyle` | `TextPickerTextStyle` | - | 可选文本样式 |
| `selectedTextStyle` | `TextPickerTextStyle` | - | 选中文本样式 |
| `gradient` | `boolean` | false | 是否启用渐变效果 |

### 2.4 TextPickerTextStyle 接口

| 属性 | 类型 | 描述 |
|------|------|------|
| color | `ResourceColor` | 文本颜色 |
| font | `Font` | 字体样式 |
| weight | `number \| FontWeight` | 字体粗细 |

## 三、使用示例

### 3.1 基础文本选择器示例

```typescript
@ComponentV2
struct BasicTextPickerExample {
  @Local selectedIdx: number = 0
  @Local fruits: string[] = ['苹果', '香蕉', '橙子', '葡萄', '西瓜']

  build() {
    Column({ space: 16 }) {
      Text('选择水果')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      TextPicker({ range: this.fruits, selected: this.selectedIdx })
        .onChange((value: TextPickerResult) => {
          this.selectedIdx = value.index
          console.info('Selected: ' + value.value)
        })

      Text(`选中: ${this.fruits[this.selectedIdx]}`)
        .fontSize(16)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.2 数字范围选择器示例

```typescript
@ComponentV2
struct NumberRangePickerExample {
  @Local selectedAge: number = 25

  build() {
    Column({ space: 16 }) {
      Text('选择年龄')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 生成年龄范围 1-100
      TextPicker({ range: Array.from({ length: 100 }, (_, i) => i + 1), selected: this.selectedAge - 1 })
        .onChange((value: TextPickerResult) => {
          this.selectedAge = value.value as number
        })

      Text(`年龄: ${this.selectedAge} 岁`)
        .fontSize(16)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.3 城市选择器示例

```typescript
@ComponentV2
struct CityPickerExample {
  @Local selectedCity: string = '北京'
  @Local cities: string[] = ['北京', '上海', '广州', '深圳', '杭州', '南京', '成都', '重庆']

  build() {
    Column({ space: 16 }) {
      Text('选择城市')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      TextPicker({ range: this.cities, selected: 0 })
        .onChange((value: TextPickerResult) => {
          this.selectedCity = value.value as string
        })

      Row({ space: 8 }) {
        Text('当前城市:')
          .fontSize(14)
          .fontColor('#666666')
        Text(this.selectedCity)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#007DFF')
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.4 自定义样式示例

```typescript
@ComponentV2
struct CustomStyleTextPickerExample {
  @Local selectedIdx: number = 0
  @Local options: string[] = ['选项1', '选项2', '选项3', '选项4', '选项5']

  build() {
    Column({ space: 16 }) {
      Text('自定义样式')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      TextPicker({ range: this.options, selected: this.selectedIdx })
        .selectedTextStyle({
          color: '#007DFF',
          font: { size: 22, weight: FontWeight.Bold }
        })
        .textStyle({
          color: '#333333',
          font: { size: 18 }
        })
        .disappearTextStyle({
          color: '#CCCCCC',
          font: { size: 14 }
        })
        .onChange((value: TextPickerResult) => {
          this.selectedIdx = value.index
        })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.5 循环滚动示例

```typescript
@ComponentV2
struct CanLoopTextPickerExample {
  @Local selectedIdx: number = 0
  @Local weekdays: string[] = ['周一', '周二', '周三', '周四', '周五', '周六', '周日']

  build() {
    Column({ space: 16 }) {
      Text('选择星期（循环）')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      TextPicker({ range: this.weekdays, selected: this.selectedIdx })
        .canLoop(true) // 启用循环滚动
        .onChange((value: TextPickerResult) => {
          this.selectedIdx = value.index
        })

      Text(`选中: ${this.weekdays[this.selectedIdx]}`)
        .fontSize(16)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.6 渐变效果示例

```typescript
@ComponentV2
struct GradientTextPickerExample {
  @Local selectedIdx: number = 0
  @Local items: string[] = ['项目1', '项目2', '项目3', '项目4', '项目5']

  build() {
    Column({ space: 16 }) {
      Text('渐变效果')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      TextPicker({ range: this.items, selected: this.selectedIdx })
        .gradient(true) // 启用渐变效果
        .onChange((value: TextPickerResult) => {
          this.selectedIdx = value.index
        })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.7 评分选择器示例

```typescript
@ComponentV2
struct RatingPickerExample {
  @Local selectedRating: number = 5

  build() {
    Column({ space: 16 }) {
      Text('选择评分')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      TextPicker({ range: Array.from({ length: 10 }, (_, i) => i + 1), selected: 4 })
        .onChange((value: TextPickerResult) => {
          this.selectedRating = value.value as number
        })

      Row({ space: 8 }) {
        ForEach([1, 2, 3, 4, 5], (star: number) => {
          Text(star <= this.selectedRating ? '\u2605' : '\u2606')
            .fontSize(32)
            .fontColor(star <= this.selectedRating ? '#FFC107' : '#CCCCCC')
        })
      }
      .margin({ top: 8 })

      Text(`${this.selectedRating} 分`)
        .fontSize(16)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.8 时区选择器示例

```typescript
@ComponentV2
struct TimezonePickerExample {
  @Local selectedTimezone: string = 'GMT+8'
  @Local timezones: string[] = ['GMT+8', 'GMT+9', 'GMT+10', 'GMT-5', 'GMT-8']

  build() {
    Column({ space: 16 }) {
      Text('选择时区')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      TextPicker({ range: this.timezones, selected: 0 })
        .onChange((value: TextPickerResult) => {
          this.selectedTimezone = value.value as string
        })

      Text(`当前时区: ${this.selectedTimezone}`)
        .fontSize(16)
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(16)
  }
}
```

## 四、高级用法

### 4.1 动态更新选项

```typescript
@ComponentV2
struct DynamicTextPickerExample {
  @Local categories: string[] = ['电子产品', '服装', '食品']
  @Local selectedCategory: string = '电子产品'
  @Local newCategory: string = ''

  build() {
    Column({ space: 16 }) {
      Text('动态选择器')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      TextPicker({ range: this.categories, selected: 0 })
        .onChange((value: TextPickerResult) => {
          this.selectedCategory = value.value as string
        })

      Row({ space: 8 }) {
        TextInput({ placeholder: '新分类' })
          .layoutWeight(1)
          .onChange((value: string) => {
            this.newCategory = value
          })

        Button('添加')
          .onClick(() => {
            if (this.newCategory) {
              this.categories.push(this.newCategory)
              this.newCategory = ''
            }
          })
      }

      Text(`选中: ${this.selectedCategory}`)
        .fontSize(16)
    }
    .width('100%')
    .padding(16)
  }
}
```

### 4.2 联动选择器（省市区）

```typescript
@ComponentV2
struct LinkedTextPickerExample {
  @Local selectedProvince: number = 0
  @Local selectedCity: number = 0

  @Local provinces: string[] = ['北京', '上海', '广东']
  @Local cities: string[][] = [
    ['东城区', '西城区', '朝阳区'],
    ['黄浦区', '徐汇区', '浦东新区'],
    ['广州', '深圳', '珠海']
  ]

  build() {
    Column({ space: 16 }) {
      Text('省市区选择')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 省份选择
      Column({ space: 8 }) {
        Text('省份')
          .fontSize(14)
          .fontColor('#666666')
        TextPicker({ range: this.provinces, selected: this.selectedProvince })
          .onChange((value: TextPickerResult) => {
            this.selectedProvince = value.index
            this.selectedCity = 0 // 重置城市选择
          })
      }

      // 城市选择
      Column({ space: 8 }) {
        Text('城市')
          .fontSize(14)
          .fontColor('#666666')
        TextPicker({ range: this.cities[this.selectedProvince], selected: this.selectedCity })
          .onChange((value: TextPickerResult) => {
            this.selectedCity = value.index
          })
      }

      Text(`选择: ${this.provinces[this.selectedProvince]} - ${this.cities[this.selectedProvince][this.selectedCity]}`)
        .fontSize(16)
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 4.3 搜索过滤选择器

```typescript
@ComponentV2
struct FilteredTextPickerExample {
  @Local allItems: string[] = ['苹果', '香蕉', '橙子', '葡萄', '西瓜', '芒果', '菠萝', '草莓']
  @Local filteredItems: string[] = []
  @Local selectedItem: string = ''
  @Local searchText: string = ''

  aboutToAppear() {
    this.filteredItems = this.allItems
  }

  build() {
    Column({ space: 16 }) {
      Text('搜索选择')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 搜索框
      TextInput({ placeholder: '搜索水果' })
        .onChange((value: string) => {
          this.searchText = value
          this.filteredItems = this.allItems.filter(item =>
            item.toLowerCase().includes(value.toLowerCase())
          )
        })

      // 选择器
      if (this.filteredItems.length > 0) {
        TextPicker({ range: this.filteredItems, selected: 0 })
          .onChange((value: TextPickerResult) => {
            this.selectedItem = value.value as string
          })
      } else {
        Text('无匹配项')
          .fontSize(14)
          .fontColor('#999999')
          .textAlign(TextAlign.Center)
          .width('100%')
          .height(200)
      }

      if (this.selectedItem) {
        Text(`选中: ${this.selectedItem}`)
          .fontSize(16)
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

## 五、最佳实践

### 5.1 数据源准备

```typescript
// ✅ 推荐：使用常量或状态管理
const FRUITS = ['苹果', '香蕉', '橙子']

@ComponentV2
struct GoodPicker {
  @Local items: string[] = FRUITS

  build() {
    TextPicker({ range: this.items, selected: 0 })
  }
}

// ❌ 避免：每次构建都创建新数组
@ComponentV2
struct BadPicker {
  build() {
    TextPicker({ range: ['选项1', '选项2'], selected: 0 })
  }
}
```

### 5.2 选项数量控制

```typescript
// ✅ 推荐：选项数量适中（3-10个）
TextPicker({ range: ['选项1', '选项2', '选项3'], selected: 0 })

// ⚠️ 注意：选项过多时考虑其他组件
// 如：选择器或搜索列表
```

### 5.3 样式一致性

```typescript
// ✅ 推荐：统一样式风格
TextPicker({ range: items, selected: 0 })
  .selectedTextStyle({
    color: $r('app.color.primary'),
    font: { size: 22, weight: FontWeight.Bold }
  })
  .textStyle({
    color: $r('app.color.text_primary'),
    font: { size: 18 }
  })
```

## 六、常见问题

### Q1: TextPicker 数据不更新？

**问题**: 修改 range 数组后选择器内容不变。

**解决方案**:
```typescript
// ✅ 正确：使用 @Local 管理数据
@ComponentV2
struct CorrectPicker {
  @Local items: string[] = ['选项1', '选项2', '选项3']

  build() {
    TextPicker({ range: this.items, selected: 0 })
  }

  updateItems() {
    this.items = ['新选项1', '新选项2', '新选项3']
  }
}
```

### Q2: 如何实现默认选中？

**解决方案**:
```typescript
@Local selectedIdx: number = 2 // 默认选中第三个

TextPicker({ range: items, selected: this.selectedIdx })
  .onChange((value: TextPickerResult) => {
    this.selectedIdx = value.index
  })
```

### Q3: 如何实现循环滚动？

**解决方案**:
```typescript
TextPicker({ range: items, selected: 0 })
  .canLoop(true) // 启用循环滚动
```

### Q4: 如何获取选中的值和索引？

**解决方案**:
```typescript
.onChange((value: TextPickerResult) => {
  console.info('Value:', value.value) // 选中的值
  console.info('Index:', value.index) // 选中的索引
})
```

### Q5: 如何实现联动选择器？

**解决方案**:
```typescript
// 第一个选择器变化时更新第二个的数据源
TextPicker({ range: provinces, selected: selectedProvince })
  .onChange((value: TextPickerResult) => {
    this.selectedProvince = value.index
    this.selectedCity = 0 // 重置第二个选择器
  })

TextPicker({ range: cities[selectedProvince], selected: selectedCity })
  .onChange((value: TextPickerResult) => {
    this.selectedCity = value.index
  })
```

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 9+ | ✅ | 完全支持 |
| API 10+ | ✅ | 增加了更多样式选项 |
| API 12+ | ✅ | 性能优化 |

## 八、参考资料

- [TextPicker 组件 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-textpicker-V5)
