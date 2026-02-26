# Search 组件 HarmonyOS 6.0 开发 Skill

## 概述

Search 组件是 OpenHarmony 中的搜索框组件，用于提供搜索输入功能。它提供了搜索图标、清除按钮、占位符文本等搜索相关的 UI 元素，支持文本输入、搜索触发、内容清除等交互操作，常用于应用内搜索、内容过滤、数据查询等场景。

## 重要说明

- **基础组件**: Search 是 ArkUI 的基础内置组件，无需导入
- **搜索图标**: 自动显示搜索图标
- **清除按钮**: 输入内容后自动显示清除按钮
- **占位符**: 支持自定义占位符文本
- **回调事件**: 支持输入变化、搜索触发、清除等事件
- **样式自定义**: 支持自定义背景、边框、文本等样式

## 模块信息

- **组件名称**: Search
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [Search 搜索框 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-search-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// Search 是内置组件，无需导入
// 直接使用即可
Search({ placeholder: '请输入搜索内容' })
```

### 1.2 基础用法

```typescript
// 基础搜索框
Search({ placeholder: '搜索' })
  .searchButton('搜索')
  .onSubmit((value: string) => {
    console.info('Search: ' + value)
  })

// 带默认值
Search({
  value: '默认内容',
  placeholder: '搜索'
})

// 监听输入变化
Search({ placeholder: '搜索' })
  .onChange((value: string) => {
    console.info('Input: ' + value)
  })
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| value | `string` | 否 | '' | 文本值 |
| placeholder | `ResourceStr` | 否 | '' | 占位符文本 |
| controller | `SearchController` | 否 | - | 搜索框控制器 |

### 2.2 样式属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `searchButton` | `string` | - | 搜索按钮文本 |
| `placeholderColor` | `ResourceColor` | - | 占位符颜色 |
| `placeholderFont` | `Font` | - | 占位符字体样式 |
| `textFont` | `Font` | - | 输入文本字体样式 |
| `backgroundColor` | `ResourceColor` | - | 背景色 |
| `borderRadius` | `Length` | - | 圆角半径 |

### 2.3 交互属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `onChange` | `(value: string) => void` | - | 输入变化回调 |
| `onSubmit` | `(value: string) => void` | - | 搜索提交回调 |
| `onContentChanged` | `() => void` | - | 内容变化回调 |

### 2.4 控制器方法

| 方法 | 描述 |
|------|------|
| `setText(value: string)` | 设置文本内容 |
| `getText(): string` | 获取文本内容 |
| `clear()` | 清空内容 |

## 三、使用示例

### 3.1 基础 Search 示例

```typescript
@ComponentV2
struct BasicSearchExample {
  @Local searchText: string = ''

  build() {
    Column({ space: 16 }) {
      Text('基础搜索框')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 基础搜索框
      Search({ placeholder: '请输入搜索内容' })
        .searchButton('搜索')
        .onChange((value: string) => {
          this.searchText = value
        })
        .onSubmit((value: string) => {
          console.info('搜索内容: ' + value)
        })

      Text(`输入内容: ${this.searchText}`)
        .fontSize(16)
        .fontColor('#666666')
    }
    .padding(16)
  }
}
```

### 3.2 自定义样式示例

```typescript
@ComponentV2
struct StyledSearchExample {
  @Local value: string = ''

  build() {
    Column({ space: 20 }) {
      Text('自定义样式')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 自定义背景色和圆角
      Search({ placeholder: '自定义样式' })
        .backgroundColor('#F5F5F5')
        .borderRadius(20)

      // 自定义文本颜色
      Search({ placeholder: '自定义文本颜色' })
        .placeholderColor('#999999')
        .textFont({ size: 16, weight: FontWeight.Medium })

      // 深色主题
      Search({ placeholder: '深色主题' })
        .backgroundColor('#333333')
        .placeholderColor('#CCCCCC')
        .borderRadius(8)
    }
    .padding(16)
  }
}
```

### 3.3 搜索控制器示例

```typescript
@ComponentV2
struct SearchControllerExample {
  searchController: SearchController = new SearchController()
  @Local searchText: string = ''

  build() {
    Column({ space: 16 }) {
      Text('搜索控制器')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 带控制器的搜索框
      Search({
        placeholder: '带控制器的搜索框',
        controller: this.searchController
      })
        .searchButton('搜索')
        .onChange((value: string) => {
          this.searchText = value
        })

      // 操作按钮
      Row({ space: 12 }) {
        Button('设置文本')
          .onClick(() => {
            this.searchController.setText('预设内容')
          })

        Button('获取文本')
          .onClick(() => {
            const text = this.searchController.getText()
            console.info('当前文本: ' + text)
          })

        Button('清空')
          .onClick(() => {
            this.searchController.clear()
          })
      }

      Text(`当前文本: ${this.searchText}`)
        .fontSize(14)
        .fontColor('#666666')
    }
    .padding(16)
  }
}
```

### 3.4 实时搜索示例

```typescript
@ComponentV2
struct RealTimeSearchExample {
  @Local searchText: string = ''
  @Local filteredResults: string[] = []

  // 模拟数据
  private allItems: string[] = [
    '苹果', '香蕉', '橙子', '葡萄', '西瓜',
    '苹果手机', '苹果电脑', '香蕉牛奶', '橙汁'
  ]

  // 过滤数据
  filterResults(query: string): void {
    if (!query || query.trim() === '') {
      this.filteredResults = []
      return
    }

    this.filteredResults = this.allItems.filter(item =>
      item.toLowerCase().includes(query.toLowerCase())
    )
  }

  build() {
    Column({ space: 16 }) {
      Text('实时搜索')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 搜索框
      Search({ placeholder: '搜索水果' })
        .searchButton('搜索')
        .onChange((value: string) => {
          this.searchText = value
          this.filterResults(value)
        })

      // 搜索结果
      if (this.filteredResults.length > 0) {
        Column({ space: 8 }) {
          ForEach(this.filteredResults, (item: string, index: number) => {
            Text(item)
              .width('100%')
              .padding(12)
              .backgroundColor('#F5F5F5')
              .borderRadius(8)
          })
        }
        .width('100%')
      } else if (this.searchText) {
        Text('无搜索结果')
          .fontSize(14)
          .fontColor('#999999')
      }
    }
    .padding(16)
  }
}
```

### 3.5 搜索历史示例

```typescript
@ComponentV2
struct SearchHistoryExample {
  @Local searchText: string = ''
  @Local searchHistory: string[] = []
  @Local showHistory: boolean = false

  build() {
    Column({ space: 16 }) {
      Text('搜索历史')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 搜索框
      Search({ value: this.searchText, placeholder: '搜索' })
        .searchButton('搜索')
        .onChange((value: string) => {
          this.searchText = value
          this.showHistory = value.length === 0 && this.searchHistory.length > 0
        })
        .onSubmit((value: string) => {
          if (value && value.trim() !== '') {
            // 添加到历史记录
            this.searchHistory = [value, ...this.searchHistory.filter(item => item !== value)].slice(0, 10)
            this.showHistory = false
          }
        })
        .onContentChanged(() => {
          this.showHistory = true
        })

      // 搜索历史
      if (this.showHistory && this.searchHistory.length > 0) {
        Column({ space: 12 }) {
          Row() {
            Text('搜索历史')
              .fontSize(14)
              .fontColor('#666666')

            Blank()

            Text('清空')
              .fontSize(14)
              .fontColor('#007DFF')
              .onClick(() => {
                this.searchHistory = []
              })
          }
          .width('100%')

          Flex({ wrap: FlexWrap.Wrap }) {
            ForEach(this.searchHistory, (item: string) => {
              Text(item)
                .padding(8)
                .backgroundColor('#F5F5F5')
                .borderRadius(4)
                .fontSize(14)
                .onClick(() => {
                  this.searchText = item
                  this.showHistory = false
                })
            })
          }
        }
        .width('100%')
        .padding(12)
        .backgroundColor('#FAFAFA')
        .borderRadius(8)
      }
    }
    .padding(16)
  }
}
```

### 3.6 实际应用场景

```typescript
@ComponentV2
struct ProductSearchPage {
  @Local keyword: string = ''
  @Local hotSearches: string[] = ['手机', '电脑', '耳机', '充电器', '数据线']
  @Local searchHistory: string[] = []

  build() {
    Column({ space: 20 }) {
      // 搜索框
      Search({ value: this.keyword, placeholder: '搜索商品' })
        .searchButton('搜索')
        .backgroundColor('#F5F5F5')
        .borderRadius(20)
        .placeholderColor('#999999')
        .onChange((value: string) => {
          this.keyword = value
        })
        .onSubmit((value: string) => {
          if (value && value.trim() !== '') {
            // 执行搜索
            this.performSearch(value)
          }
        })

      // 热门搜索
      Column({ space: 12 }) {
        Text('热门搜索')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)

        Flex({ wrap: FlexWrap.Wrap }) {
          ForEach(this.hotSearches, (item: string) => {
            Text(item)
              .padding({ left: 12, right: 12, top: 8, bottom: 8 })
              .backgroundColor('#FFF5E6')
              .borderRadius(16)
              .fontSize(14)
              .fontColor('#FF6600')
              .onClick(() => {
                this.keyword = item
                this.performSearch(item)
              })
          })
        }
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      // 搜索历史
      if (this.searchHistory.length > 0) {
        Column({ space: 12 }) {
          Row() {
            Text('搜索历史')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)

            Blank()

            Text('清空')
              .fontSize(14)
              .fontColor('#999999')
              .onClick(() => {
                this.searchHistory = []
              })
          }
          .width('100%')

          Flex({ wrap: FlexWrap.Wrap }) {
            ForEach(this.searchHistory, (item: string) => {
              Row({ space: 8 }) {
                Text(item)
                  .fontSize(14)

                Text('×')
                  .fontSize(18)
                  .fontColor('#CCCCCC')
                  .onClick(() => {
                    this.searchHistory = this.searchHistory.filter(h => h !== item)
                  })
              }
              .padding({ left: 12, right: 12, top: 8, bottom: 8 })
              .backgroundColor('#F5F5F5')
              .borderRadius(16)
            })
          }
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
    }
    .padding(16)
  }

  performSearch(keyword: string): void {
    // 添加到历史
    this.searchHistory = [keyword, ...this.searchHistory.filter(item => item !== keyword)].slice(0, 10)

    // 执行搜索逻辑
    console.info('搜索商品: ' + keyword)
  }
}
```

## 四、高级用法

### 4.1 搜索建议

```typescript
@ComponentV2
struct SearchSuggestions {
  @Local searchText: string = ''
  @Local suggestions: string[] = []
  @Local showSuggestions: boolean = false

  // 模拟搜索建议
  private allSuggestions: string[] = [
    '苹果手机', '苹果电脑', '苹果平板',
    '苹果手表', '苹果耳机', '苹果配件'
  ]

  // 获取搜索建议
  getSuggestions(query: string): string[] {
    if (!query || query.trim() === '') {
      return []
    }
    return this.allSuggestions.filter(item =>
      item.toLowerCase().includes(query.toLowerCase())
    ).slice(0, 5)
  }

  build() {
    Column({ space: 0 }) {
      // 搜索框
      Search({ value: this.searchText, placeholder: '搜索' })
        .searchButton('搜索')
        .onChange((value: string) => {
          this.searchText = value
          this.suggestions = this.getSuggestions(value)
          this.showSuggestions = this.suggestions.length > 0
        })
        .onSubmit((value: string) => {
          this.showSuggestions = false
          console.info('搜索: ' + value)
        })

      // 搜索建议列表
      if (this.showSuggestions) {
        Column() {
          ForEach(this.suggestions, (item: string) => {
            Row() {
              Text(item)
                .fontSize(14)
                .fontColor('#333333')

              Blank()
            }
            .width('100%')
            .padding(12)
            .backgroundColor(Color.White)
            .borderRadius(8)
            .onClick(() => {
              this.searchText = item
              this.showSuggestions = false
            })
          })
        }
        .width('100%')
        .padding({ top: 8 })
      }
    }
    .padding(16)
  }
}
```

### 4.2 防抖搜索

```typescript
@ComponentV2
struct DebouncedSearch {
  @Local searchText: string = ''
  @Local result: string = ''
  private searchTimer: number = -1

  // 防抖搜索
  debouncedSearch(query: string): void {
    if (this.searchTimer !== -1) {
      clearTimeout(this.searchTimer)
    }

    this.searchTimer = setTimeout(() => {
      this.performSearch(query)
    }, 500) // 500ms 延迟
  }

  // 执行搜索
  performSearch(query: string): void {
    console.info('搜索: ' + query)
    this.result = `搜索结果: ${query}`
  }

  build() {
    Column({ space: 16 }) {
      Search({ value: this.searchText, placeholder: '搜索' })
        .searchButton('搜索')
        .onChange((value: string) => {
          this.searchText = value
          this.debouncedSearch(value)
        })

      if (this.result) {
        Text(this.result)
          .fontSize(16)
          .fontColor('#666666')
      }
    }
    .padding(16)
  }
}
```

## 五、最佳实践

### 5.1 合理使用占位符

```typescript
// ✅ 推荐：明确的占位符
Search({ placeholder: '搜索商品名称' })

// ❌ 避免：模糊的占位符
Search({ placeholder: '搜索' })
```

### 5.2 提供搜索按钮

```typescript
// ✅ 推荐：设置搜索按钮文本
Search({ placeholder: '搜索' })
  .searchButton('搜索')
  .onSubmit((value: string) => {
    // 执行搜索
  })
```

### 5.3 处理空输入

```typescript
Search({ placeholder: '搜索' })
  .onSubmit((value: string) => {
    if (value && value.trim() !== '') {
      // 执行搜索
      this.performSearch(value)
    } else {
      // 提示用户输入内容
      console.info('请输入搜索内容')
    }
  })
```

### 5.4 清晰的样式

```typescript
// ✅ 推荐：使用浅色背景和圆角
Search({ placeholder: '搜索' })
  .backgroundColor('#F5F5F5')
  .borderRadius(20)
  .placeholderColor('#999999')
```

## 六、常见问题

### Q1: 如何获取搜索框内容？

**解决方案**:
```typescript
// 方式 1: 通过 onChange 回调
@Local searchText: string = ''

Search({ placeholder: '搜索' })
  .onChange((value: string) => {
    this.searchText = value
  })

// 方式 2: 通过控制器
let controller = new SearchController()

Search({ placeholder: '搜索', controller: controller })
  .onSubmit(() => {
    const text = controller.getText()
    console.info('搜索内容: ' + text)
  })
```

### Q2: 如何清除搜索框？

**解决方案**:
```typescript
// 方式 1: 使用控制器
let controller = new SearchController()
Button('清除').onClick(() => {
  controller.clear()
})

// 方式 2: 更新 value
@Local searchText: string = ''

Search({ value: this.searchText, placeholder: '搜索' })
  .onChange((value: string) => {
    this.searchText = value
  })

Button('清除').onClick(() => {
  this.searchText = ''
})
```

### Q3: 如何实现实时搜索？

**解决方案**:
```typescript
@ComponentV2
struct RealTimeSearch {
  @Local searchText: string = ''

  build() {
    Search({ placeholder: '搜索' })
      .onChange((value: string) => {
        this.searchText = value
        this.performSearch(value) // 实时搜索
      })
  }

  performSearch(query: string): void {
    // 搜索逻辑
  }
}
```

### Q4: 如何防止频繁搜索？

**解决方案**:
```typescript
// 使用防抖
@ComponentV2
struct DebouncedSearch {
  @Local searchText: string = ''
  private searchTimer: number = -1

  build() {
    Search({ placeholder: '搜索' })
      .onChange((value: string) => {
        this.searchText = value

        if (this.searchTimer !== -1) {
          clearTimeout(this.searchTimer)
        }

        this.searchTimer = setTimeout(() => {
          this.performSearch(value)
        }, 500)
      })
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

- [Search 搜索框 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-search-V5)
- [通用属性 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-universal-attributes-size-V5)
