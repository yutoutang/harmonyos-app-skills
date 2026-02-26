# Select 组件 HarmonyOS 6.0 开发 Skill

## 概述

Select 组件是 OpenHarmony 中用于实现下拉选择功能的组件。它提供了一种节省空间的方式来让用户从多个选项中选择一个。Select 广泛应用于表单填写、筛选条件、设置选项等场景。

## 重要说明

- **基础组件**: Select 是 ArkUI 的基础内置组件，无需导入
- **下拉选择**: 点击后展开选项列表，用户可从中选择
- **单选模式**: Select 只能选择一个选项
- **选项内容**: 支持纯文本或自定义内容
- **默认值**: 通过 selected 选项设置默认选中项

## 模块信息

- **组件名称**: Select
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [Select 下拉选择 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-select-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// Select 是内置组件，无需导入
// 直接使用即可
Select([{ value: 'option1' }, { value: 'option2' }])
```

### 1.2 基础用法

```typescript
// 简单下拉选择
Select([
  { value: '选项1' },
  { value: '选项2' },
  { value: '选项3' }
])

// 设置默认选中
Select([
  { value: '选项1', icon: '\uE641' },
  { value: '选项2', icon: '\uE8EF', selected: true }
])

// 监听选择变化
Select(options)
  .onSelect((index: number, value: string) => {
    console.info('选中: ' + value + ', 索引: ' + index)
  })
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| options | `Array<SelectOption>` | 是 | - | 下拉选项数组 |

### 2.2 SelectOption 结构

| 属性 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| value | `string` | 是 | - | 选项的值 |
| icon | `string \| Resource` | 否 | - | 选项的图标 |
| selected | `boolean` | 否 | false | 是否默认选中 |

### 2.3 常用属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `selected` | `number` | 0 | 设置默认选中项的索引 |
| `value` | `string` | - | 设置默认选中项的值 |
| `font` | `Font` | - | 下拉框文本字体样式 |
| `fontColor` | `ResourceColor` | - | 下拉框文本颜色 |
| `selectedOptionBgColor` | `ResourceColor` | '#F5F5F5' | 选项选中时的背景颜色 |
| `optionFont` | `Font` | - | 选项文本字体样式 |
| `optionFontColor` | `ResourceColor` | - | 选项文本颜色 |

### 2.4 事件

| 事件 | 类型 | 描述 |
|------|------|------|
| `onSelect` | `(index: number, value?: string) => void` | 选中选项时触发 |
| `onValueChange` | `(value: string) => void` | 选项值改变时触发（API 10+） |

## 三、使用示例

### 3.1 基础下拉选择

```typescript
@ComponentV2
struct BasicSelectExample {
  @Local selectedIndex: number = 0
  @Local selectedValue: string = '选项1'

  build() {
    Column({ space: 16 }) {
      Text('基础下拉选择')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Select([
        { value: '选项1' },
        { value: '选项2' },
        { value: '选项3' }
      ])
        .selected(0)
        .value('选项1')
        .onSelect((index: number, value?: string) => {
          this.selectedIndex = index
          if (value) {
            this.selectedValue = value
          }
          console.info('选中索引: ' + index + ', 值: ' + value)
        })

      Text(`选中: ${this.selectedValue}`)
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.2 带图标的选项

```typescript
@ComponentV2
struct IconSelectExample {
  @Local selectedValue: string = '微信'

  build() {
    Column({ space: 16 }) {
      Text('带图标的选项')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Select([
        { value: '微信', icon: '\uE641' },
        { value: '支付宝', icon: '\uE8EF' },
        { value: '银行卡', icon: '\uE6D9' }
      ])
        .selectedOptionBgColor('#E3F2FD')
        .onSelect((index: number, value?: string) => {
          if (value) {
            this.selectedValue = value
          }
        })

      Text(`选择支付方式: ${this.selectedValue}`)
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.3 城市选择

```typescript
@ComponentV2
struct CitySelectExample {
  @Local selectedCity: string = '北京'

  private cities: string[] = ['北京', '上海', '广州', '深圳', '杭州', '成都', '西安', '南京']

  build() {
    Column({ space: 16 }) {
      Text('选择城市')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Select(this.cities.map(city => ({ value: city })))
        .selected(0)
        .onSelect((index: number, value?: string) => {
          if (value) {
            this.selectedCity = value
          }
        })

      Text(`当前城市: ${this.selectedCity}`)
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.4 排序方式选择

```typescript
@ComponentV2
struct SortSelectExample {
  @Local sortType: string = '综合排序'

  private sortOptions: Array<{ value: string, icon: string }> = [
    { value: '综合排序', icon: '🔀' },
    { value: '价格从低到高', icon: '📈' },
    { value: '价格从高到低', icon: '📉' },
    { value: '销量优先', icon: '🔥' },
    { value: '最新上架', icon: '🆕' }
  ]

  build() {
    Column({ space: 16 }) {
      Text('排序方式')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Row({ space: 12 }) {
        Text('排序:')
          .fontSize(16)

        Select(this.sortOptions.map(opt => ({ value: opt.value, icon: opt.icon })))
          .selected(0)
          .onSelect((index: number, value?: string) => {
            if (value) {
              this.sortType = value
            }
          })
      }
      .width('100%')

      Text(`当前排序: ${this.sortType}`)
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.5 数量选择

```typescript
@ComponentV2
struct QuantitySelectExample {
  @Local quantity: number = 1

  build() {
    Column({ space: 16 }) {
      Text('选择数量')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Select(
        Array.from({ length: 10 }, (_, i) => ({ value: `${i + 1}` }))
      )
        .selected(0)
        .onSelect((index: number, value?: string) => {
          if (value) {
            this.quantity = parseInt(value)
          }
        })

      Row({ space: 8 }) {
        Text('购买数量:')
          .fontSize(16)

        Text(`${this.quantity} 件`)
          .fontSize(16)
          .fontColor('#FF6B6B')
          .fontWeight(FontWeight.Bold)
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.6 自定义样式

```typescript
@ComponentV2
struct CustomStyleSelectExample {
  @Local selectedValue: string = '标准版'

  build() {
    Column({ space: 16 }) {
      Text('自定义样式')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 蓝色主题
      Select([
        { value: '标准版' },
        { value: '专业版' },
        { value: '企业版' }
      ])
        .selected(0)
        .font({ size: 16, weight: FontWeight.Medium })
        .fontColor('#007DFF')
        .selectedOptionBgColor('#E3F2FD')
        .optionFont({ size: 16 })
        .optionFontColor('#333333')
        .onSelect((index: number, value?: string) => {
          if (value) {
            this.selectedValue = value
          }
        })

      Text(`选择版本: ${this.selectedValue}`)
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.7 表单中的 Select

```typescript
@ComponentV2
struct FormSelectExample {
  @Local name: string = ''
  @Local gender: string = '男'
  @Local city: string = '北京'
  @Local occupation: string = 'IT'

  private cities: string[] = ['北京', '上海', '广州', '深圳', '杭州']
  private occupations: string[] = ['IT', '金融', '教育', '医疗', '其他']

  build() {
    Column({ space: 16 }) {
      Text('用户信息')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 姓名
      Column({ space: 8 }) {
        Text('姓名')
          .fontSize(14)
          .fontColor('#666666')

        TextInput({ placeholder: '请输入姓名' })
          .onChange((value: string) => {
            this.name = value
          })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      // 性别
      Column({ space: 8 }) {
        Text('性别')
          .fontSize(14)
          .fontColor('#666666')

        Select([{ value: '男' }, { value: '女' }])
          .selected(0)
          .onSelect((index: number, value?: string) => {
            if (value) {
              this.gender = value
            }
          })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      // 城市
      Column({ space: 8 }) {
        Text('城市')
          .fontSize(14)
          .fontColor('#666666')

        Select(this.cities.map(city => ({ value: city })))
          .onSelect((index: number, value?: string) => {
            if (value) {
              this.city = value
            }
          })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      // 职业
      Column({ space: 8 }) {
        Text('职业')
          .fontSize(14)
          .fontColor('#666666')

        Select(this.occupations.map(occ => ({ value: occ })))
          .onSelect((index: number, value?: string) => {
            if (value) {
              this.occupation = value
            }
          })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      Button('提交')
        .width('100%')
        .backgroundColor('#007DFF')
        .onClick(() => {
          console.info(`提交: ${this.name}, ${this.gender}, ${this.city}, ${this.occupation}`)
        })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.8 筛选器

```typescript
@ComponentV2
struct FilterSelectExample {
  @Local category: string = '全部'
  @Local priceRange: string = '全部'
  @Local brand: string = '全部'

  private categories: string[] = ['全部', '电子产品', '服装', '食品', '图书']
  private priceRanges: string[] = ['全部', '0-100', '100-500', '500-1000', '1000以上']
  private brands: string[] = ['全部', '苹果', '华为', '小米', '三星']

  build() {
    Column({ space: 16 }) {
      Text('商品筛选')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 分类筛选
      Row({ space: 12 }) {
        Text('分类:')
          .fontSize(16)

        Select(this.categories.map(cat => ({ value: cat })))
          .selected(0)
          .onSelect((index: number, value?: string) => {
            if (value) {
              this.category = value
            }
          })
      }
      .width('100%')

      // 价格筛选
      Row({ space: 12 }) {
        Text('价格:')
          .fontSize(16)

        Select(this.priceRanges.map(range => ({ value: range })))
          .selected(0)
          .onSelect((index: number, value?: string) => {
            if (value) {
              this.priceRange = value
            }
          })
      }
      .width('100%')

      // 品牌筛选
      Row({ space: 12 }) {
        Text('品牌:')
          .fontSize(16)

        Select(this.brands.map(brand => ({ value: brand })))
          .selected(0)
          .onSelect((index: number, value?: string) => {
            if (value) {
              this.brand = value
            }
          })
      }
      .width('100%')

      Button('应用筛选')
        .width('100%')
        .backgroundColor('#007DFF')
        .onClick(() => {
          console.info(`筛选条件: ${this.category}, ${this.priceRange}, ${this.brand}`)
        })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.9 语言设置

```typescript
@ComponentV2
struct LanguageSelectExample {
  @Local currentLanguage: string = '简体中文'

  private languages: Array<{ code: string, name: string }> = [
    { code: 'zh', name: '简体中文' },
    { code: 'zh-TW', name: '繁體中文' },
    { code: 'en', name: 'English' },
    { code: 'ja', name: '日本語' },
    { code: 'ko', name: '한국어' },
    { code: 'fr', name: 'Français' },
    { code: 'de', name: 'Deutsch' },
    { code: 'es', name: 'Español' }
  ]

  build() {
    Column({ space: 16 }) {
      Text('语言设置')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Column({ space: 8 }) {
        Text('显示语言')
          .fontSize(14)
          .fontColor('#666666')

        Select(this.languages.map(lang => ({ value: lang.name })))
          .selected(0)
          .onSelect((index: number, value?: string) => {
            if (value) {
              this.currentLanguage = value
            }
          })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      Text(`当前语言: ${this.currentLanguage}`)
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.10 时间段选择

```typescript
@ComponentV2
struct TimeRangeSelectExample {
  @Local timeRange: string = '最近7天'

  private timeRanges: Array<{ value: string, days: number }> = [
    { value: '今天', days: 1 },
    { value: '最近3天', days: 3 },
    { value: '最近7天', days: 7 },
    { value: '最近30天', days: 30 },
    { value: '最近90天', days: 90 },
    { value: '最近一年', days: 365 }
  ]

  build() {
    Column({ space: 16 }) {
      Text('选择时间范围')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Row({ space: 12 }) {
        Text('时间:')
          .fontSize(16)

        Select(this.timeRanges.map(range => ({ value: range.value })))
          .selected(2)  // 默认选中"最近7天"
          .onSelect((index: number, value?: string) => {
            if (value) {
              this.timeRange = value
              console.info('选择时间范围: ' + value)
            }
          })
      }
      .width('100%')

      Text(`当前选择: ${this.timeRange}`)
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(16)
  }
}
```

## 四、高级用法

### 4.1 联动选择

```typescript
@ComponentV2
struct LinkedSelectExample {
  @Local selectedProvince: string = '北京'
  @Local selectedCity: string = '北京市'

  private data: Record<string, string[]> = {
    '北京': ['北京市'],
    '上海': ['上海市'],
    '广东': ['广州', '深圳', '珠海', '东莞'],
    '浙江': ['杭州', '宁波', '温州', '嘉兴']
  }

  build() {
    Column({ space: 16 }) {
      Text('省市联动')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 省份选择
      Column({ space: 8 }) {
        Text('省份')
          .fontSize(14)
          .fontColor('#666666')

        Select(Object.keys(this.data).map(prov => ({ value: prov })))
          .selected(0)
          .onSelect((index: number, value?: string) => {
            if (value) {
              this.selectedProvince = value
              // 切换省份时，重置城市
              this.selectedCity = this.data[value][0]
            }
          })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      // 城市选择
      Column({ space: 8 }) {
        Text('城市')
          .fontSize(14)
          .fontColor('#666666')

        Select(this.data[this.selectedProvince].map(city => ({ value: city })))
          .selected(0)
          .onSelect((index: number, value?: string) => {
            if (value) {
              this.selectedCity = value
            }
          })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      Text(`${this.selectedProvince} - ${this.selectedCity}`)
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 4.2 动态选项

```typescript
@ComponentV2
struct DynamicOptionsExample {
  @Local customOptions: string[] = ['选项1', '选项2', '选项3']
  @Local newOption: string = ''
  @Local selectedValue: string = '选项1'

  addOption(): void {
    if (this.newOption.trim()) {
      this.customOptions.push(this.newOption)
      this.newOption = ''
    }
  }

  build() {
    Column({ space: 16 }) {
      Text('动态选项')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 添加新选项
      Row({ space: 8 }) {
        TextInput({ placeholder: '输入新选项' })
          .layoutWeight(1)
          .onChange((value: string) => {
            this.newOption = value
          })

        Button('添加')
          .onClick(() => {
            this.addOption()
          })
      }
      .width('100%')

      // 选择框
      Select(this.customOptions.map(opt => ({ value: opt })))
        .selected(0)
        .onSelect((index: number, value?: string) => {
          if (value) {
            this.selectedValue = value
          }
        })

      Text(`选项列表: ${this.customOptions.join(', ')}`)
        .fontSize(12)
        .fontColor('#999999')

      Text(`当前选择: ${this.selectedValue}`)
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(16)
  }
}
```

## 五、最佳实践

### 5.1 默认值设置

```typescript
// ✅ 推荐：设置合理的默认值
Select(options)
  .selected(0)  // 默认选中第一项

// ✅ 使用 value 设置默认值
Select([{ value: 'option1' }, { value: 'option2' }])
  .value('option1')
```

### 5.2 选项数量控制

```typescript
// ✅ 推荐：选项数量适中（5-10个）
const goodOptions = ['选项1', '选项2', '选项3', '选项4', '选项5']

// ⚠️ 考虑：选项过多时使用搜索或分组
const tooManyOptions = Array.from({ length: 50 }, (_, i) => `选项${i + 1}`)
// 这种情况下考虑使用 Picker 或搜索组件
```

### 5.3 选项文本长度

```typescript
// ✅ 推荐：选项文本简洁明了
Select([
  { value: '北京' },
  { value: '上海' },
  { value: '广州' }
])

// ❌ 避免：选项文本过长
Select([
  { value: '北京市中华人民共和国首都' },
  { value: '上海市中华人民共和国直辖市' }
])
```

### 5.4 样式一致性

```typescript
// ✅ 推荐：使用统一样式
Select(options)
  .font({ size: 16 })
  .fontColor('#333333')
  .optionFont({ size: 16 })
  .optionFontColor('#333333')
```

## 六、常见问题

### Q1: Select 如何设置默认选中项？

**解决方案**:
```typescript
// 方法 1: 使用索引
Select([{ value: 'A' }, { value: 'B' }, { value: 'C' }])
  .selected(1)  // 选中第二个（索引从0开始）

// 方法 2: 使用值
Select([{ value: 'A' }, { value: 'B' }, { value: 'C' }])
  .value('B')  // 选中值为 'B' 的项

// 方法 3: 在选项中设置
Select([
  { value: 'A' },
  { value: 'B', selected: true },
  { value: 'C' }
])
```

### Q2: Select 的选项可以动态更新吗？

**答案**: 可以，但需要重新创建 Select 组件或使用 @ObservedV2 装饰的数据源。

```typescript
@ComponentV2
struct DynamicSelectExample {
  @Local options: Array<{ value: string }> = [{ value: 'A' }, { value: 'B' }]

  build() {
    Column({ space: 12 }) {
      Select(this.options)

      Button('添加选项')
        .onClick(() => {
          this.options.push({ value: `选项${this.options.length + 1}` })
        })
    }
  }
}
```

### Q3: 如何实现 Select 的占位符？

**解决方案**:
```typescript
@ComponentV2
struct PlaceholderSelectExample {
  @Local selectedValue: string = ''
  @Local hasSelected: boolean = false

  build() {
    Select([
      { value: '选项1' },
      { value: '选项2' },
      { value: '选项3' }
    ])
      .onSelect((index: number, value?: string) => {
        if (value) {
          this.selectedValue = value
          this.hasSelected = true
        }
      })

    if (!this.hasSelected) {
      Text('请选择...')
        .fontSize(14)
        .fontColor('#999999')
    }
  }
}
```

### Q4: Select 选项太多如何处理？

**答案**: 选项过多时建议：
1. 使用分组
2. 使用 Picker 组件（更适合大量数据）
3. 使用搜索框 + 列表

```typescript
// 考虑使用 Picker
Picker([{ value: '选项1' }, { value: '选项2' }, ... /* 更多选项 */])
```

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 9+ | ✅ | 完全支持 |
| API 10+ | ✅ | 增加了 onValueChange 事件 |
| API 12+ | ✅ | 优化了样式和交互 |

## 八、参考资料

- [Select 下拉选择 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-select-V5)
- [Picker 选择器 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-picker-V5)
- [通用属性 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-universal-attributes-size-V5)
