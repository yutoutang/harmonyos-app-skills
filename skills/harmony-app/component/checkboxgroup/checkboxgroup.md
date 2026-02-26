# CheckboxGroup 组件 HarmonyOS 6.0 开发 Skill

## 概述

CheckboxGroup 组件是 OpenHarmony 中用于管理一组 Checkbox 的容器组件。它提供了统一的事件处理和状态管理，可以方便地获取组内所有选中的复选框。CheckboxGroup 通常用于多选场景，如兴趣爱好、技能标签等。

## 重要说明

- **基础组件**: CheckboxGroup 是 ArkUI 的基础内置组件，无需导入
- **分组管理**: 统一管理组内的所有 Checkbox
- **事件监听**: 可以监听组内任意 Checkbox 的状态变化
- **名称匹配**: 通过 Checkbox 的 group 属性与 CheckboxGroup 的 groupName 关联
- **全选支持**: 配合全选逻辑可以方便地实现全选/取消全选功能

## 模块信息

- **组件名称**: CheckboxGroup
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [CheckboxGroup 复选框组 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-checkboxgroup-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// CheckboxGroup 是内置组件，无需导入
// 直接使用即可
CheckboxGroup({ group: 'myGroup' }) {
  Checkbox({ name: 'check1', group: 'myGroup' })
  Checkbox({ name: 'check2', group: 'myGroup' })
}
```

### 1.2 基础用法

```typescript
// 基础分组
CheckboxGroup({ group: 'fruits' }) {
  Checkbox({ name: 'apple', group: 'fruits' })
  Checkbox({ name: 'banana', group: 'fruits' })
  Checkbox({ name: 'orange', group: 'fruits' })
}
.onChange((itemNames: string[]) => {
  console.info('选中的项: ' + itemNames.join(', '))
})

// 监听所有选中项
CheckboxGroup({ group: 'options' }) {
  // ... 子 Checkbox
}
.onSelect((itemNames: string[]) => {
  console.info('当前所有选中项: ' + itemNames.join(', '))
})
```

## 二、API 参数

### 2.1 构造参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| group | `string` | 是 | - | 分组名称 |
| options | `CheckboxGroupOptions` | 否 | - | 选项配置 |

### 2.2 常用属性

| 属性 | 类型 | 默认值 | 描述 |
|------|------|--------|------|
| `selectAll` | `boolean` | false | 是否全选组内所有复选框 |

### 2.3 事件

| 事件 | 类型 | 描述 |
|------|------|------|
| `onChange` | `(itemNames: string[]) => void` | 组内复选框状态改变时触发，返回所有选中的 name 数组 |
| `onSelect` | `(itemNames: string[]) => void` | 获取当前组内所有选中的 name 数组 |

## 三、使用示例

### 3.1 基础分组

```typescript
@ComponentV2
struct BasicGroupExample {
  @Local selectedItems: string[] = []

  build() {
    Column({ space: 16 }) {
      Text('基础分组')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      CheckboxGroup({ group: 'colors' }) {
        Row({ space: 20 }) {
          Row({ space: 8 }) {
            Checkbox({ name: 'red', group: 'colors' })
            Text('红色')
          }

          Row({ space: 8 }) {
            Checkbox({ name: 'green', group: 'colors' })
            Text('绿色')
          }

          Row({ space: 8 }) {
            Checkbox({ name: 'blue', group: 'colors' })
            Text('蓝色')
          }
        }
      }
      .onChange((itemNames: string[]) => {
        this.selectedItems = itemNames
        console.info('选中的颜色: ' + itemNames.join(', '))
      })

      Text(`选中项: ${this.selectedItems.join(', ')}`)
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.2 兴趣标签选择

```typescript
@ComponentV2
struct InterestGroupExample {
  @Local selectedInterests: string[] = []

  build() {
    Column({ space: 16 }) {
      Text('兴趣标签选择')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      CheckboxGroup({ group: 'interests' }) {
        Flex({ wrap: FlexWrap.Wrap, space: { main: 12, cross: 8 } }) {
          Row({ space: 8 }) {
            Checkbox({ name: 'tech', group: 'interests' })
            Text('科技')
          }
          .padding(8)
          .backgroundColor('#F5F5F5')
          .borderRadius(16)

          Row({ space: 8 }) {
            Checkbox({ name: 'sports', group: 'interests' })
            Text('运动')
          }
          .padding(8)
          .backgroundColor('#F5F5F5')
          .borderRadius(16)

          Row({ space: 8 }) {
            Checkbox({ name: 'music', group: 'interests' })
            Text('音乐')
          }
          .padding(8)
          .backgroundColor('#F5F5F5')
          .borderRadius(16)

          Row({ space: 8 }) {
            Checkbox({ name: 'travel', group: 'interests' })
            Text('旅行')
          }
          .padding(8)
          .backgroundColor('#F5F5F5')
          .borderRadius(16)

          Row({ space: 8 }) {
            Checkbox({ name: 'reading', group: 'interests' })
            Text('阅读')
          }
          .padding(8)
          .backgroundColor('#F5F5F5')
          .borderRadius(16)
        }
      }
      .onChange((itemNames: string[]) => {
        this.selectedInterests = itemNames
      })

      Text(`已选择 ${this.selectedInterests.length} 个兴趣标签`)
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.3 全选/取消全选

```typescript
@ComponentV2
struct SelectAllGroupExample {
  @Local allSelected: boolean = false
  @Local selectedItems: string[] = []

  build() {
    Column({ space: 16 }) {
      Text('全选功能')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 全选按钮
      Row({ space: 8 }) {
        Checkbox({ name: 'selectAll' })
          .select(this.allSelected)
          .onChange((value: boolean) => {
            this.allSelected = value
          })

        Text('全选')
          .fontSize(16)
      }
      .onClick(() => {
        this.allSelected = !this.allSelected
      })

      // 复选框组
      CheckboxGroup({ group: 'items' }) {
        Column({ space: 12 }) {
          Row({ space: 8 }) {
            Checkbox({ name: 'item1', group: 'items' })
              .select(this.allSelected)
            Text('选项 1')
          }

          Row({ space: 8 }) {
            Checkbox({ name: 'item2', group: 'items' })
              .select(this.allSelected)
            Text('选项 2')
          }

          Row({ space: 8 }) {
            Checkbox({ name: 'item3', group: 'items' })
              .select(this.allSelected)
            Text('选项 3')
          }

          Row({ space: 8 }) {
            Checkbox({ name: 'item4', group: 'items' })
              .select(this.allSelected)
            Text('选项 4')
          }
        }
      }
      .onChange((itemNames: string[]) => {
        this.selectedItems = itemNames
      })

      Text(`已选 ${this.selectedItems.length} 项`)
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.4 购物车

```typescript
@ComponentV2
struct ShoppingCartExample {
  @Local selectedItems: string[] = []
  @Local totalAmount: number = 0

  private products: Array<{ id: string, name: string, price: number }> = [
    { id: 'p1', name: '机械键盘', price: 299 },
    { id: 'p2', name: '无线鼠标', price: 99 },
    { id: 'p3', name: '显示器', price: 1299 },
    { id: 'p4', name: '耳机', price: 199 }
  ]

  build() {
    Column({ space: 16 }) {
      Text('购物车')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      CheckboxGroup({ group: 'products' }) {
        Column({ space: 12 }) {
          ForEach(this.products, (product: { id: string, name: string, price: number }) => {
            Row({ space: 12 }) {
              Checkbox({ name: product.id, group: 'products' })
                .selectedColor('#FF6B6B')

              Text(product.name)
                .fontSize(16)
                .layoutWeight(1)

              Text(`¥${product.price}`)
                .fontSize(16)
                .fontColor('#FF6B6B')
                .fontWeight(FontWeight.Bold)
            }
            .width('100%')
            .padding(12)
            .backgroundColor('#F5F5F5')
            .borderRadius(8)
          })
        }
      }
      .onChange((itemNames: string[]) => {
        this.selectedItems = itemNames
        this.totalAmount = this.products
          .filter(p => itemNames.includes(p.id))
          .reduce((sum, p) => sum + p.price, 0)
      })

      // 底部结算栏
      Row() {
        Text(`已选 ${this.selectedItems.length} 件`)
          .fontSize(14)
          .fontColor('#666666')

        Spacer()

        Text(`合计: ¥${this.totalAmount}`)
          .fontSize(18)
          .fontColor('#FF6B6B')
          .fontWeight(FontWeight.Bold)

        Button('结算')
          .margin({ left: 16 })
          .enabled(this.selectedItems.length > 0)
          .backgroundColor('#FF6B6B')
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .border({ width: { top: 1 }, color: '#E0E0E0' })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.5 权限设置

```typescript
@ComponentV2
struct PermissionGroupExample {
  @Local permissions: string[] = []

  build() {
    Column({ space: 16 }) {
      Text('权限设置')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      CheckboxGroup({ group: 'permissions' }) {
        Column({ space: 12 }) {
          Text('基础权限')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)

          Row({ space: 8 }) {
            Checkbox({ name: 'read', group: 'permissions' })
            Text('读取权限')
          }
          .width('100%')

          Row({ space: 8 }) {
            Checkbox({ name: 'write', group: 'permissions' })
            Text('写入权限')
          }
          .width('100%')

          Text('高级权限')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ top: 8 })

          Row({ space: 8 }) {
            Checkbox({ name: 'delete', group: 'permissions' })
            Text('删除权限')
          }
          .width('100%')

          Row({ space: 8 }) {
            Checkbox({ name: 'admin', group: 'permissions' })
            Text('管理权限')
          }
          .width('100%')
        }
      }
      .onChange((itemNames: string[]) => {
        this.permissions = itemNames
        console.info('已授权权限: ' + itemNames.join(', '))
      })

      Text(`已授予 ${this.permissions.length} 项权限`)
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.6 多组复选框

```typescript
@ComponentV2
struct MultipleGroupsExample {
  @Local selectedFruits: string[] = []
  @Local selectedVegetables: string[] = []

  build() {
    Column({ space: 20 }) {
      Text('多组复选框')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 水果组
      Column({ space: 12 }) {
        Text('水果')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)

        CheckboxGroup({ group: 'fruits' }) {
          Row({ space: 16 }) {
            Row({ space: 8 }) {
              Checkbox({ name: 'apple', group: 'fruits' })
              Text('苹果')
            }

            Row({ space: 8 }) {
              Checkbox({ name: 'banana', group: 'fruits' })
              Text('香蕉')
            }

            Row({ space: 8 }) {
              Checkbox({ name: 'orange', group: 'fruits' })
              Text('橙子')
            }
          }
        }
        .onChange((itemNames: string[]) => {
          this.selectedFruits = itemNames
        })
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      // 蔬菜组
      Column({ space: 12 }) {
        Text('蔬菜')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)

        CheckboxGroup({ group: 'vegetables' }) {
          Row({ space: 16 }) {
            Row({ space: 8 }) {
              Checkbox({ name: 'carrot', group: 'vegetables' })
              Text('胡萝卜')
            }

            Row({ space: 8 }) {
              Checkbox({ name: 'cabbage', group: 'vegetables' })
              Text('白菜')
            }

            Row({ space: 8 }) {
              Checkbox({ name: 'tomato', group: 'vegetables' })
              Text('番茄')
            }
          }
        }
        .onChange((itemNames: string[]) => {
          this.selectedVegetables = itemNames
        })
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      Text(`水果: ${this.selectedFruits.join(', ')}`)
        .fontSize(14)
        .fontColor('#666666')

      Text(`蔬菜: ${this.selectedVegetables.join(', ')}`)
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.7 带图标的选项组

```typescript
@ComponentV2
struct IconGroupExample {
  @Local selectedFeatures: string[] = []

  build() {
    Column({ space: 16 }) {
      Text('功能选择')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      CheckboxGroup({ group: 'features' }) {
        Column({ space: 12 }) {
          Row({ space: 12 }) {
            Checkbox({ name: 'wifi', group: 'features' })
              .selectedColor('#007DFF')

            Text('\uE8EF')
              .fontSize(24)

            Column({ space: 4 }) {
              Text('WiFi')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
              Text('无线网络连接')
                .fontSize(12)
                .fontColor('#999999')
            }
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding(12)
          .backgroundColor(this.selectedFeatures.includes('wifi') ? '#E3F2FD' : '#F5F5F5')
          .borderRadius(8)

          Row({ space: 12 }) {
            Checkbox({ name: 'bluetooth', group: 'features' })
              .selectedColor('#007DFF')

            Text('\uE6D9')
              .fontSize(24)

            Column({ space: 4 }) {
              Text('蓝牙')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
              Text('蓝牙设备连接')
                .fontSize(12)
                .fontColor('#999999')
            }
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding(12)
          .backgroundColor(this.selectedFeatures.includes('bluetooth') ? '#E3F2FD' : '#F5F5F5')
          .borderRadius(8)

          Row({ space: 12 }) {
            Checkbox({ name: 'nfc', group: 'features' })
              .selectedColor('#007DFF')

            Text('\uE641')
              .fontSize(24)

            Column({ space: 4 }) {
              Text('NFC')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
              Text('近场通信')
                .fontSize(12)
                .fontColor('#999999')
            }
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding(12)
          .backgroundColor(this.selectedFeatures.includes('nfc') ? '#E3F2FD' : '#F5F5F5')
          .borderRadius(8)
        }
      }
      .onChange((itemNames: string[]) => {
        this.selectedFeatures = itemNames
      })
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.8 技能选择器

```typescript
@ComponentV2
struct SkillsGroupExample {
  @Local selectedSkills: string[] = []
  @Local allSelected: boolean = false

  private skillCategories: Record<string, { name: string, skills: string[] }> = {
    'frontend': { name: '前端开发', skills: ['React', 'Vue', 'Angular', 'TypeScript'] },
    'backend': { name: '后端开发', skills: ['Node.js', 'Python', 'Java', 'Go'] },
    'mobile': { name: '移动开发', skills: ['iOS', 'Android', 'HarmonyOS'] }
  }

  build() {
    Column({ space: 16 }) {
      Text('技能选择')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 全选控制
      Row({ space: 8 }) {
        Checkbox({ name: 'selectAll' })
          .select(this.allSelected)
          .onChange((value: boolean) => {
            this.allSelected = value
          })

        Text('全选')
          .fontSize(16)

        Spacer()

        Text(`已选 ${this.selectedSkills.length} 项`)
          .fontSize(14)
          .fontColor('#666666')
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      // 技能分组
      Column({ space: 12 }) {
        ForEach(Object.keys(this.skillCategories), (category: string) => {
          Column({ space: 8 }) {
            Text(this.skillCategories[category].name)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)

            CheckboxGroup({ group: category }) {
              Flex({ wrap: FlexWrap.Wrap, space: 8 }) {
                ForEach(this.skillCategories[category].skills, (skill: string) => {
                  Row({ space: 8 }) {
                    Checkbox({ name: skill, group: category })
                      .select(this.allSelected)
                      .selectedColor('#007DFF')

                    Text(skill)
                      .fontSize(14)
                  }
                  .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                  .backgroundColor(this.selectedSkills.includes(skill) ? '#E3F2FD' : '#FFFFFF')
                  .border({ width: 1, color: '#E0E0E0' })
                  .borderRadius(16)
                })
              }
            }
            .onChange((itemNames: string[]) => {
              // 更新选中的技能
              const otherCategories = Object.keys(this.skillCategories).filter(c => c !== category)
              let otherSkills: string[] = []
              otherCategories.forEach(c => {
                otherSkills = otherSkills.concat(
                  this.selectedSkills.filter(s => this.skillCategories[c].skills.includes(s))
                )
              })
              this.selectedSkills = otherSkills.concat(itemNames)
            })
          }
          .width('100%')
          .padding(12)
          .backgroundColor('#FAFAFA')
          .borderRadius(8)
        })
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.9 获取选中项详情

```typescript
@ComponentV2
struct SelectedItemsDetailExample {
  @Local selectedItems: string[] = []

  private items: Record<string, { name: string, description: string }> = {
    'item1': { name: '选项1', description: '这是选项1的详细说明' },
    'item2': { name: '选项2', description: '这是选项2的详细说明' },
    'item3': { name: '选项3', description: '这是选项3的详细说明' }
  }

  build() {
    Column({ space: 16 }) {
      Text('获取选中项详情')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      CheckboxGroup({ group: 'items' }) {
        Column({ space: 12 }) {
          ForEach(Object.keys(this.items), (key: string) => {
            Row({ space: 8 }) {
              Checkbox({ name: key, group: 'items' })
              Text(this.items[key].name)
            }
          })
        }
      }
      .onChange((itemNames: string[]) => {
        this.selectedItems = itemNames
      })

      // 显示选中项详情
      if (this.selectedItems.length > 0) {
        Column({ space: 8 }) {
          Text('已选项详情:')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)

          ForEach(this.selectedItems, (key: string) => {
            Column({ space: 4 }) {
              Text(this.items[key].name)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)

              Text(this.items[key].description)
                .fontSize(12)
                .fontColor('#999999')
            }
            .width('100%')
            .padding(12)
            .backgroundColor('#F5F5F5')
            .borderRadius(8)
          })
        }
        .width('100%')
      }
    }
    .width('100%')
    .padding(16)
  }
}
```

### 3.10 动态复选框组

```typescript
@ComponentV2
struct DynamicGroupExample {
  @Local users: Array<{ id: string, name: string, avatar: string }> = []
  @Local selectedUsers: string[] = []
  @Local newUser: string = ''

  addUser(): void {
    if (this.newUser.trim()) {
      this.users.push({
        id: `user_${Date.now()}`,
        name: this.newUser,
        avatar: '\uE641' // 用户图标
      })
      this.newUser = ''
    }
  }

  build() {
    Column({ space: 16 }) {
      Text('动态用户组')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      // 添加用户
      Row({ space: 8 }) {
        TextInput({ placeholder: '输入用户名' })
          .layoutWeight(1)
          .onChange((value: string) => {
            this.newUser = value
          })

        Button('添加')
          .onClick(() => {
            this.addUser()
          })
      }
      .width('100%')

      // 用户列表
      CheckboxGroup({ group: 'users' }) {
        Column({ space: 12 }) {
          if (this.users.length === 0) {
            Text('暂无用户')
              .fontSize(14)
              .fontColor('#999999')
              .width('100%')
              .textAlign(TextAlign.Center)
          } else {
            ForEach(this.users, (user: { id: string, name: string, avatar: string }) => {
              Row({ space: 12 }) {
                Checkbox({ name: user.id, group: 'users' })
                  .selectedColor('#007DFF')

                Text(user.avatar)
                  .fontSize(24)

                Text(user.name)
                  .fontSize(16)
                  .layoutWeight(1)
              }
              .width('100%')
              .padding(12)
              .backgroundColor('#F5F5F5')
              .borderRadius(8)
            })
          }
        }
      }
      .onChange((itemNames: string[]) => {
        this.selectedUsers = itemNames
      })

      if (this.selectedUsers.length > 0) {
        Text(`已选择 ${this.selectedUsers.length} 个用户`)
          .fontSize(14)
          .fontColor('#666666')
      }
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
struct LinkedSelectionExample {
  @Local categories: Record<string, boolean> = {
    'frontend': false,
    'backend': false,
    'mobile': false
  }
  @Local skills: Record<string, boolean> = {}

  private categorySkills: Record<string, string[]> = {
    'frontend': ['React', 'Vue', 'Angular'],
    'backend': ['Node.js', 'Python', 'Java'],
    'mobile': ['iOS', 'Android', 'HarmonyOS']
  }

  aboutToAppear(): void {
    // 初始化所有技能
    Object.values(this.categorySkills).forEach(skillList => {
      skillList.forEach(skill => {
        this.skills[skill] = false
      })
    })
  }

  toggleCategory(category: string): void {
    this.categories[category] = !this.categories[category]
    // 联动选择该分类下的所有技能
    this.categorySkills[category].forEach(skill => {
      this.skills[skill] = this.categories[category]
    })
  }

  build() {
    Column({ space: 16 }) {
      Text('联动选择')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      ForEach(Object.keys(this.categories), (category: string) => {
        Column({ space: 8 }) {
          Row({ space: 8 }) {
            Checkbox({ name: category })
              .select(this.categories[category])
              .onChange(() => {
                this.toggleCategory(category)
              })

            Text(category.toUpperCase())
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
          }

          CheckboxGroup({ group: category }) {
            Flex({ wrap: FlexWrap.Wrap, space: 8 }) {
              ForEach(this.categorySkills[category], (skill: string) => {
                Row({ space: 8 }) {
                  Checkbox({ name: skill, group: category })
                    .select(this.skills[skill])
                  Text(skill)
                    .fontSize(14)
                }
              })
            }
          }
        }
        .width('100%')
        .padding(12)
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
      })
    }
    .width('100%')
    .padding(16)
  }
}
```

## 五、最佳实践

### 5.1 GroupName 命名

```typescript
// ✅ 推荐：使用有意义的组名
CheckboxGroup({ group: 'user_permissions' }) { }
CheckboxGroup({ group: 'product_categories' }) { }

// ❌ 避免：使用无意义的组名
CheckboxGroup({ group: 'group1' }) { }
CheckboxGroup({ group: 'abc' }) { }
```

### 5.2 统一事件处理

```typescript
// ✅ 推荐：使用 CheckboxGroup 统一处理事件
CheckboxGroup({ group: 'items' }) {
  // ... 子 Checkbox
}
.onChange((names: string[]) => {
  // 集中处理所有选中项
})

// ❌ 避免：为每个 Checkbox 单独设置事件
ForEach(items, (item) => {
  Checkbox({ name: item.id })
    .onChange(() => {
      // 分散处理
    })
})
```

### 5.3 选中数量限制

```typescript
@ComponentV2
struct LimitSelectionExample {
  @Local selectedItems: string[] = []
  readonly maxSelection: number = 3

  build() {
    CheckboxGroup({ group: 'items' }) {
      // ... 子 Checkbox
    }
    .onChange((names: string[]) => {
      if (names.length > this.maxSelection) {
        // 提示超过最大选择数
        console.info('最多只能选择 ' + this.maxSelection + ' 项')
        // 取消最后一次选择
        return
      }
      this.selectedItems = names
    })
  }
}
```

## 六、常见问题

### Q1: CheckboxGroup 和单独的 Checkbox 有什么区别？

**答案**:
- **CheckboxGroup**: 提供统一的事件处理，可以一次性获取所有选中的项
- **单独 Checkbox**: 需要为每个 Checkbox 单独设置事件处理

```typescript
// 使用 CheckboxGroup - 推荐
CheckboxGroup({ group: 'items' }) {
  Checkbox({ name: 'item1', group: 'items' })
  Checkbox({ name: 'item2', group: 'items' })
}
.onChange((names) => console.info(names)) // 一次性获取所有选中项
```

### Q2: 如何实现最多选择 N 项？

**解决方案**:
```typescript
@ComponentV2
struct MaxSelectionExample {
  @Local selectedItems: string[] = []
  readonly maxItems: number = 3

  build() {
    CheckboxGroup({ group: 'items' }) {
      // ... 子 Checkbox
    }
    .onChange((names: string[]) => {
      if (names.length <= this.maxItems) {
        this.selectedItems = names
      } else {
        console.info('最多选择 ' + this.maxItems + ' 项')
      }
    })
  }
}
```

### Q3: 如何获取 CheckboxGroup 中所有选项的 name？

**解决方案**:
```typescript
// 在组件中维护一个数组
@ComponentV2
struct GetAllNamesExample {
  @Local allNames: string[] = ['item1', 'item2', 'item3']
  @Local selectedItems: string[] = []

  build() {
    CheckboxGroup({ group: 'items' }) {
      ForEach(this.allNames, (name: string) => {
        Checkbox({ name: name, group: 'items' })
      })
    }
    .onChange((names) => {
      this.selectedItems = names
    })
  }
}
```

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 9+ | ✅ | 完全支持 |
| API 10+ | ✅ | 增强了事件处理 |
| API 12+ | ✅ | 优化了性能 |

## 八、参考资料

- [CheckboxGroup 复选框组 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-checkboxgroup-V5)
- [Checkbox 复选框 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-checkbox-V5)
- [通用属性 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-universal-attributes-size-V5)
