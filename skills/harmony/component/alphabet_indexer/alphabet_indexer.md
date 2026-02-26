# AlphabetIndexer 组件 HarmonyOS 6.0 开发 Skill

## 概述

AlphabetIndexer 组件是 OpenHarmony 中的字母索引器组件,用于实现与列表联动显示的字母索引条。它常用于联系人、城市列表、商品分类等按字母排序的数据快速定位场景。用户点击字母索引时,列表会自动滚动到对应字母的位置。

## 重要说明

- **基础组件**: AlphabetIndexer 是 ArkUI 的基础内置组件,无需导入
- **联动列表**: 需要与 List 组件配合使用实现联动效果
- **数组值**: 必须通过 array 属性设置索引值数组
- **选中状态**: 支持自定义选中颜色和字体大小
- **位置布局**: 通常放置在屏幕右侧作为快速导航

## 模块信息

- **组件名称**: AlphabetIndexer
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [AlphabetIndexer 字母索引器 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-alphabetindexer-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// AlphabetIndexer 是内置组件,无需导入
// 直接使用即可
AlphabetIndexer({ array: ['A', 'B', 'C', ...] })
```

### 1.2 基础用法

```typescript
// 基础字母索引器
AlphabetIndexer({ array: ['A', 'B', 'C', ...] })
  .selected(0)  // 选中索引
  .onSelected((index: number) => {
    console.info('Selected: ' + index)
  })
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| array | `string[] \| Resource[]` | 是 | - | 字母索引字符串数组 |
| selected | `number` | 否 | 0 | 选中项的索引值 |

### 2.2 属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `selected` | `number` | 0 | 当前选中的索引值 |
| `color` | `ResourceColor` | - | 字母索引文字颜色 |
| `selectedColor` | `ResourceColor` | - | 选中项的文字颜色 |
| `popupColor` | `ResourceColor` | - | 弹出提示的背景颜色 |
| `popupUsing` | `boolean` | false | 是否使用弹出提示 |
| `popupItemFont` | `Font` | - | 弹出提示的字体样式 |
| `selectedFont` | `Font` | - | 选中项的字体样式 |
| `font` | `Font` | - | 字母索引的字体样式 |
| `itemSize` | `number` | - | 字母索引的每项大小 |

### 2.3 事件

| 事件 | 类型 | 描述 |
|------|------|------|
| `onSelected` | `(index: number) => void` | 字母索引选中回调 |

### 2.4 控制器方法

AlphabetIndexer 不支持控制器,直接通过 selected 属性控制选中状态。

## 三、使用示例

### 3.1 基础 AlphabetIndexer 示例

```typescript
@ComponentV2
struct BasicAlphabetIndexerExample {
  @Local selectedIndex: number = 0
  readonly alphabet: string[] = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G',
    'H', 'I', 'J', 'K', 'L', 'M', 'N',
    'O', 'P', 'Q', 'R', 'S', 'T',
    'U', 'V', 'W', 'X', 'Y', 'Z'
  ]

  build() {
    Row() {
      Column() {
        Text('AlphabetIndexer 基础示例')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)

        Text(`选中字母: ${this.alphabet[this.selectedIndex]}`)
          .fontSize(16)
          .margin({ top: 20 })
          .fontColor('#007DFF')
      }
      .layoutWeight(1)
      .padding(20)
      .alignItems(HorizontalAlign.Center)

      AlphabetIndexer({ array: this.alphabet, selected: this.selectedIndex })
        .selected(this.selectedIndex)
        .selectedColor('#FFFFFF')
        .popupUsing(true)
        .popupItemFont({ size: 20, weight: FontWeight.Bold })
        .selectedFont({ size: 16, weight: FontWeight.Bold })
        .font({ size: 14 })
        .itemSize(20)
        .onSelected((index: number) => {
          this.selectedIndex = index
          console.info('Selected: ' + this.alphabet[index])
        })
    }
    .width('100%')
    .height(300)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}
```

### 3.2 联动列表示例

```typescript
@ComponentV2
struct LinkedAlphabetIndexerExample {
  @Local selectedIndex: number = 0
  private scroller: Scroller = new Scroller()
  readonly alphabet: string[] = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G',
    'H', 'I', 'J', 'K', 'L', 'M', 'N',
    'O', 'P', 'Q', 'R', 'S', 'T',
    'U', 'V', 'W', 'X', 'Y', 'Z'
  ]

  // 模拟数据 - 按字母分组的联系人
  private contacts: Record<string, string[]> = {
    'A': ['Alice', 'Adam', 'Amy'],
    'B': ['Bob', 'Bill', 'Ben'],
    'C': ['Cathy', 'Chris', 'Carol'],
    // ... 更多数据
  }

  build() {
    Row() {
      List({ scroller: this.scroller }) {
        ForEach(this.alphabet, (letter: string) => {
          ListItemGroup({ header: this.ListHeader(letter) }) {
            ForEach(this.contacts[letter] || [], (name: string) => {
              ListItem() {
                Text(name)
                  .fontSize(16)
                  .width('100%')
                  .padding(12)
              }
            })
          }
        })
      }
      .width('100%')
      .height('100%')
      .layoutWeight(1)
      .sticky(StickyStyle.Header)

      AlphabetIndexer({ array: this.alphabet, selected: this.selectedIndex })
        .selected(this.selectedIndex)
        .selectedColor('#007DFF')
        .popupUsing(true)
        .onSelected((index: number) => {
          this.selectedIndex = index
          // 联动滚动到对应位置
          this.scroller.scrollToIndex(index)
        })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  ListHeader(letter: string) {
    Text(letter)
      .fontSize(18)
      .fontWeight(FontWeight.Bold)
      .width('100%')
      .padding(12)
      .backgroundColor('#F5F5F5')
  }
}
```

### 3.3 城市列表索引示例

```typescript
@ComponentV2
struct CityIndexerExample {
  @Local selectedIndex: number = 0
  private scroller: Scroller = new Scroller()
  readonly cityIndex: string[] = [
    '热门', 'A', 'B', 'C', 'D', 'E', 'F', 'G',
    'H', 'J', 'K', 'L', 'M', 'N', 'P', 'Q',
    'R', 'S', 'T', 'W', 'X', 'Y', 'Z'
  ]

  // 城市数据
  private cities: Record<string, string[]> = {
    '热门': ['北京', '上海', '广州', '深圳', '杭州'],
    'B': ['北京', '包头', '保定'],
    'S': ['上海', '深圳', '苏州'],
    'G': ['广州', '桂林'],
    // ... 更多城市
  }

  build() {
    Row() {
      Column() {
        // 标题栏
        Text('选择城市')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .padding(16)
          .backgroundColor('#FFFFFF')

        // 城市列表
        List({ scroller: this.scroller }) {
          ForEach(this.cityIndex, (indexKey: string, index: number) => {
            ListItemGroup({ header: this.CityHeader(indexKey) }) {
              ForEach(this.cities[indexKey] || [], (city: string) => {
                ListItem() {
                  Text(city)
                    .fontSize(16)
                    .width('100%')
                    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
                }
                .onClick(() => {
                  console.info('Selected city: ' + city)
                })
              })
            }
          })
        }
        .width('100%')
        .height('100%')
        .layoutWeight(1)
        .sticky(StickyStyle.Header)
      }
      .layoutWeight(1)

      // 字母索引器
      AlphabetIndexer({ array: this.cityIndex, selected: this.selectedIndex })
        .selected(this.selectedIndex)
        .selectedColor('#FFFFFF')
        .color('#666666')
        .popupUsing(true)
        .popupColor('#007DFF')
        .popupItemFont({ size: 24, weight: FontWeight.Bold })
        .selectedFont({ size: 18, weight: FontWeight.Bold })
        .font({ size: 12 })
        .itemSize(16)
        .onSelected((index: number) => {
          this.selectedIndex = index
          this.scroller.scrollToIndex(index)
        })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  CityHeader(indexKey: string) {
    Text(indexKey)
      .fontSize(14)
      .fontColor('#999999')
      .width('100%')
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor('#F5F5F5')
  }
}
```

### 3.4 自定义样式示例

```typescript
@ComponentV2
struct StyledAlphabetIndexerExample {
  @Local selectedIndex: number = 0
  readonly alphabet: string[] = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G',
    'H', 'I', 'J', 'K', 'L', 'M', 'N',
    'O', 'P', 'Q', 'R', 'S', 'T',
    'U', 'V', 'W', 'X', 'Y', 'Z'
  ]

  build() {
    Column({ space: 20 }) {
      Text('自定义样式')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 大字体样式
      Row() {
        Column() {
          Text('大字体索引器')
            .fontSize(14)
            .fontColor('#666666')
            .margin({ bottom: 12 })

          Row() {
            Column() {
              Text(`选中: ${this.alphabet[this.selectedIndex]}`)
                .fontSize(16)
                .fontColor('#007DFF')
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)

            AlphabetIndexer({ array: this.alphabet, selected: this.selectedIndex })
              .selected(this.selectedIndex)
              .selectedColor('#FFFFFF')
              .color('#666666')
              .popupUsing(true)
              .popupColor('#FF5722')
              .selectedFont({ size: 20, weight: FontWeight.Bold })
              .font({ size: 16 })
              .itemSize(24)
              .onSelected((index: number) => {
                this.selectedIndex = index
              })
          }
          .width('100%')
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
      }

      // 紧凑样式
      Row() {
        Column() {
          Text('紧凑索引器')
            .fontSize(14)
            .fontColor('#666666')
            .margin({ bottom: 12 })

          Row() {
            Column() {
              Text(`选中: ${this.alphabet[this.selectedIndex]}`)
                .fontSize(16)
                .fontColor('#28A745')
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)

            AlphabetIndexer({ array: this.alphabet, selected: this.selectedIndex })
              .selected(this.selectedIndex)
              .selectedColor('#FFFFFF')
              .color('#666666')
              .popupUsing(false)
              .selectedFont({ size: 14, weight: FontWeight.Bold })
              .font({ size: 10 })
              .itemSize(14)
              .onSelected((index: number) => {
                this.selectedIndex = index
              })
          }
          .width('100%')
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.5 数字索引示例

```typescript
@ComponentV2
struct NumberIndexerExample {
  @Local selectedIndex: number = 0
  private scroller: Scroller = new Scroller()
  readonly numbers: string[] = ['1', '2', '3', '4', '5', '6', '7', '8', '9']

  // 数字分组数据
  private numberGroups: Record<string, string[]> = {
    '1': ['One', '选项1', '第一组'],
    '2': ['Two', '选项2', '第二组'],
    '3': ['Three', '选项3', '第三组'],
    // ... 更多数据
  }

  build() {
    Row() {
      List({ scroller: this.scroller }) {
        ForEach(this.numbers, (num: string) => {
          ListItemGroup({ header: this.NumberHeader(num) }) {
            ForEach(this.numberGroups[num] || [], (item: string) => {
              ListItem() {
                Text(item)
                  .fontSize(16)
                  .width('100%')
                  .padding(12)
              }
            })
          }
        })
      }
      .width('100%')
      .height('100%')
      .layoutWeight(1)
      .sticky(StickyStyle.Header)

      AlphabetIndexer({ array: this.numbers, selected: this.selectedIndex })
        .selected(this.selectedIndex)
        .selectedColor('#FFFFFF')
        .popupUsing(true)
        .popupColor('#9C27B0')
        .onSelected((index: number) => {
          this.selectedIndex = index
          this.scroller.scrollToIndex(index)
        })
    }
    .width('100%')
    .height(400)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }

  @Builder
  NumberHeader(num: string) {
    Text('数字 ' + num)
      .fontSize(16)
      .fontWeight(FontWeight.Bold)
      .width('100%')
      .padding(12)
      .backgroundColor('#E1BEE7')
  }
}
```

## 四、高级用法

### 4.1 带搜索的联系人列表

```typescript
@ComponentV2
struct ContactListWithSearch {
  @Local selectedIndex: number = 0
  @Local searchValue: string = ''
  @Local filteredContacts: string[] = []
  private scroller: Scroller = new Scroller()
  readonly alphabet: string[] = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G',
    'H', 'I', 'J', 'K', 'L', 'M', 'N',
    'O', 'P', 'Q', 'R', 'S', 'T',
    'U', 'V', 'W', 'X', 'Y', 'Z'
  ]

  // 所有联系人
  private allContacts: string[] = [
    'Alice', 'Bob', 'Cathy', 'David', 'Emma',
    'Frank', 'Grace', 'Henry', 'Ivy', 'Jack'
  ]

  // 过滤联系人
  filterContacts(query: string): void {
    if (!query || query.trim() === '') {
      this.filteredContacts = this.allContacts
    } else {
      this.filteredContacts = this.allContacts.filter(contact =>
        contact.toLowerCase().includes(query.toLowerCase())
      )
    }
  }

  build() {
    Column() {
      // 搜索框
      Search({ value: this.searchValue, placeholder: '搜索联系人' })
        .searchButton('搜索')
        .onChange((value: string) => {
          this.searchValue = value
          this.filterContacts(value)
        })

      // 联系人列表和索引器
      Row() {
        List({ scroller: this.scroller }) {
          ForEach(this.filteredContacts, (contact: string) => {
            ListItem() {
              Text(contact)
                .fontSize(16)
                .width('100%')
                .padding(12)
            }
          })
        }
        .width('100%')
        .height('100%')
        .layoutWeight(1)

        AlphabetIndexer({ array: this.alphabet, selected: this.selectedIndex })
          .selected(this.selectedIndex)
          .popupUsing(true)
          .onSelected((index: number) => {
            this.selectedIndex = index
            this.scroller.scrollToIndex(index)
          })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
  }

  aboutToAppear(): void {
    this.filteredContacts = this.allContacts
  }
}
```

### 4.2 双向索引器

```typescript
@ComponentV2
struct DualAlphabetIndexerExample {
  @Local selectedLeft: number = 0
  @Local selectedRight: number = 0
  readonly alphabet: string[] = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G',
    'H', 'I', 'J', 'K', 'L', 'M', 'N',
    'O', 'P', 'Q', 'R', 'S', 'T',
    'U', 'V', 'W', 'X', 'Y', 'Z'
  ]

  build() {
    Column({ space: 20 }) {
      Text('双向索引器')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Row() {
        // 左侧索引器
        Column() {
          Text('左')
            .fontSize(14)
            .fontColor('#666666')
            .margin({ bottom: 12 })

          Row() {
            Column() {
              Text(`选中: ${this.alphabet[this.selectedLeft]}`)
                .fontSize(16)
                .fontColor('#007DFF')
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)

            AlphabetIndexer({ array: this.alphabet, selected: this.selectedLeft })
              .selected(this.selectedLeft)
              .selectedColor('#FFFFFF')
              .popupUsing(true)
              .selectedFont({ size: 16 })
              .font({ size: 12 })
              .itemSize(18)
              .onSelected((index: number) => {
                this.selectedLeft = index
              })
          }
          .width('100%')
        }
        .layoutWeight(1)

        // 右侧索引器
        Column() {
          Text('右')
            .fontSize(14)
            .fontColor('#666666')
            .margin({ bottom: 12 })

          Row() {
            Column() {
              Text(`选中: ${this.alphabet[this.selectedRight]}`)
                .fontSize(16)
                .fontColor('#28A745')
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)

            AlphabetIndexer({ array: this.alphabet, selected: this.selectedRight })
              .selected(this.selectedRight)
              .selectedColor('#FFFFFF')
              .popupUsing(true)
              .popupColor('#28A745')
              .selectedFont({ size: 16 })
              .font({ size: 12 })
              .itemSize(18)
              .onSelected((index: number) => {
                this.selectedRight = index
              })
          }
          .width('100%')
        }
        .layoutWeight(1)
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
  }
}
```

## 五、最佳实践

### 5.1 数据准备

```typescript
// ✅ 推荐:准备好完整的字母索引数组
readonly alphabet: string[] = [
  'A', 'B', 'C', 'D', 'E', 'F', 'G',
  'H', 'I', 'J', 'K', 'L', 'M', 'N',
  'O', 'P', 'Q', 'R', 'S', 'T',
  'U', 'V', 'W', 'X', 'Y', 'Z'
]

// 对于中文城市列表,可包含"热门"等特殊分类
readonly cityIndex: string[] = [
  '热门', 'A', 'B', 'C', ... , 'Z'
]
```

### 5.2 联动滚动

```typescript
// ✅ 推荐:使用 Scroller 实现双向联动
private scroller: Scroller = new Scroller()

AlphabetIndexer({ array: this.alphabet, selected: this.selectedIndex })
  .onSelected((index: number) => {
    this.selectedIndex = index
    this.scroller.scrollToIndex(index)
  })

List({ scroller: this.scroller }) {
  // ... 列表内容
}
```

### 5.3 样式优化

```typescript
// ✅ 推荐:启用弹出提示并设置合适的字体大小
AlphabetIndexer({ array: this.alphabet, selected: this.selectedIndex })
  .popupUsing(true)  // 显示选中字母的弹出提示
  .popupItemFont({ size: 20, weight: FontWeight.Bold })  // 弹出字体
  .selectedFont({ size: 16, weight: FontWeight.Bold })  // 选中项字体
  .font({ size: 12 })  // 普通项字体
  .itemSize(18)  // 每项高度
```

### 5.4 性能优化

```typescript
// ✅ 推荐:使用 ListItemGroup 和 sticky 实现高性能分组列表
List({ scroller: this.scroller }) {
  ForEach(this.alphabet, (letter: string) => {
    ListItemGroup({ header: this.GroupHeader(letter) }) {
      ForEach(this.getDataByLetter(letter), (item: ItemType) => {
        ListItem() {
          // 列表项内容
        }
      })
    }
  })
}
.sticky(StickyStyle.Header)  // 吸附效果
```

## 六、常见问题

### Q1: AlphabetIndexer 如何与 List 联动?

**解决方案**:
```typescript
@ComponentV2
struct LinkedExample {
  private scroller: Scroller = new Scroller()
  @Local selectedIndex: number = 0

  build() {
    Row() {
      List({ scroller: this.scroller }) {
        // 列表内容
      }

      AlphabetIndexer({ array: this.alphabet, selected: this.selectedIndex })
        .onSelected((index: number) => {
          this.selectedIndex = index
          this.scroller.scrollToIndex(index)  // 联动滚动
        })
    }
  }
}
```

### Q2: 如何自定义索引器的颜色?

**解决方案**:
```typescript
AlphabetIndexer({ array: this.alphabet })
  .color('#666666')  // 普通项颜色
  .selectedColor('#007DFF')  // 选中项颜色
  .popupColor('#FFFFFF')  // 弹出提示背景色
```

### Q3: 如何调整索引器的大小?

**解决方案**:
```typescript
AlphabetIndexer({ array: this.alphabet })
  .itemSize(20)  // 每项高度
  .selectedFont({ size: 16 })  // 选中项字体
  .font({ size: 12 })  // 普通项字体
```

### Q4: 如何禁用弹出提示?

**解决方案**:
```typescript
AlphabetIndexer({ array: this.alphabet })
  .popupUsing(false)  // 禁用弹出提示
```

### Q5: 如何实现中英文混合索引?

**解决方案**:
```typescript
readonly mixedIndex: string[] = [
  '热门', '★', 'A', 'B', 'C', ... , 'Z'
]

// 数据分组时包含特殊分类
private dataGroups: Record<string, DataType[]> = {
  '热门': [...],
  '★': [...],
  'A': [...],
  // ...
}
```

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 9+ | ✅ | 完全支持 |
| API 10+ | ✅ | 性能优化 |
| API 12+ | ✅ | 增加了更多自定义选项 |

## 八、参考资料

- [AlphabetIndexer 字母索引器 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-alphabetindexer-V5)
- [List 列表 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-list-V5)
- [ListItemGroup 列表项分组 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-container-listitemgroup-V5)
