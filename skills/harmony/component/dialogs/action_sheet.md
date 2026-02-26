# ActionSheet 组件 HarmonyOS 6.0 开发 Skill

## 概述

ActionSheet 是 OpenHarmony 中用于显示操作列表的底部弹出面板组件。它从屏幕底部滑出，提供一组相关操作选项供用户选择，常用于替代底部菜单或功能按钮组。

## 重要说明

- **弹出位置**: 默认从屏幕底部滑出
- **使用场景**: 提供2-5个相关操作选项
- **交互方式**: 点击选项或遮罩层关闭
- **样式定制**: 支持自定义标题、文本颜色和图标
- **响应式**: 自动适配不同屏幕尺寸

## 模块信息

- **组件名称**: ActionSheet (通过 bindSheet 属性实现)
- **SDK 版本**: HarmonyOS 6.0 (API 12+)
- **系统能力**: SystemCapability.ArkUI.ArkUI.Full
- **更新日期**: 2026-02-24
- **官方文档**:
  - [BindSheet - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-universal-methods-bind-sheet-V5)
  - [半模态转场 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-modal-transition-V5)

## 一、组件基础

### 1.1 导入方式

```typescript
// ActionSheet 通过 bindSheet 属性实现
// 无需额外导入，直接在组件上使用 .bindSheet() 方法
```

### 1.2 基础用法

```typescript
@ComponentV2
struct ActionSheetExample {
  @Local isShow: boolean = false

  build() {
    Column() {
      Button('显示操作面板')
        .onClick(() => {
          this.isShow = true
        })
    }
    .bindSheet(this.isShow, this.sheetContent(), {
      height: 200,
      onDisappear: () => {
        this.isShow = false
      }
    })
  }

  @Builder
  sheetContent() {
    Column() {
      Text('操作面板')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .padding(16)

      Divider()

      ForEach(['选项1', '选项2', '选项3'], (item: string) => {
        Text(item)
          .width('100%')
          .padding(16)
          .onClick(() => {
            console.info(`选择了: ${item}`)
            this.isShow = false
          })
      })
    }
  }
}
```

## 二、API 参数

### 2.1 bindSheet 参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| `isShow` | `boolean` | 是 | - | 控制面板显示/隐藏的状态变量 |
| `content` | `CustomBuilder` | 是 | - | 面板内容构建器 |
| `options` | `SheetOptions` | 否 | - | 面板配置选项 |

### 2.2 SheetOptions 参数

| 参数 | 类型 | 必填 | 默认值 | 描述 |
|------|------|------|--------|------|
| `height` | `number \| string \| SheetSize` | 否 | SheetSize.MEDIUM | 面板高度 |
| `width` | `number \| string` | 否 | - | 面板宽度 |
| `modalMode` | `ModalMode` | 否 | ModalMode.DEFAULT | 模态模式 |
| `backgroundColor` | `ResourceColor` | 否 | - | 背景颜色 |
| `onAppear` | `() => void` | 否 | - | 面板显示回调 |
| `onDisappear` | `() => void` | 否 | - | 面板消失回调 |
| `showClose` | `boolean` | 否 | false | 是否显示关闭按钮 |
| `shouldDismiss` | `((action: SheetDismiss) => boolean) \| boolean` | 否 | true | 是否允许关闭 |
| `preferType` | `SheetType` | 否 | SheetType.BOTTOM | 面板类型 |
| `detached` | `boolean` | 否 | false | 是否使用分离模式 |
| `blurStyle` | `BlurStyle` | 否 | - | 背景模糊样式 |
| `enableOutsideInteractive` | `boolean` | 否 | false | 遮罩层是否允许交互 |
| `maskColor` | `ResourceColor` | 否 | - | 遮罩层颜色 |

### 2.3 SheetSize 枚举

| 值 | 描述 |
|------|------|
| `SheetSize.MEDIUM` | 中等高度（默认，约50%屏幕高度） |
| `SheetSize.LARGE` | 较大高度（约80%屏幕高度） |

### 2.4 ModalMode 枚举

| 值 | 描述 |
|------|------|
| `ModalMode.DEFAULT` | 默认模式（标准模态） |
| `ModalMode.FULL_SCREEN` | 全屏模式 |

### 2.5 SheetType 枚举

| 值 | 描述 |
|------|------|
| `SheetType.BOTTOM` | 底部弹出（默认） |
| `SheetType.CENTER` | 居中弹出 |

### 2.6 SheetDismiss 枚举

| 值 | 描述 |
|------|------|
| `SheetDismiss.EDGE_DRAG` | 边缘拖动关闭 |
| `SheetDismiss.OTHER` | 其他方式关闭 |

## 三、使用示例

### 3.1 简单操作面板

```typescript
@ComponentV2
struct SimpleActionSheet {
  @Local isShow: boolean = false

  build() {
    Column() {
      Button('显示操作面板')
        .onClick(() => {
          this.isShow = true
        })
    }
    .width('100%')
    .height('100%')
    .bindSheet(this.isShow, this.sheetContent(), {
      height: 300,
      onDisappear: () => {
        this.isShow = false
      }
    })
  }

  @Builder
  sheetContent() {
    Column() {
      Text('选择操作')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding(16)

      ForEach(['拍照', '相册', '视频'], (item: string) => {
        Column() {
          Text(item)
            .fontSize(16)
            .width('100%')
            .textAlign(TextAlign.Center)
            .padding(16)
        }
        .width('100%')
        .onClick(() => {
          console.info(`选择了: ${item}`)
          this.isShow = false
        })
      })
    }
    .width('100%')
  }
}
```

### 3.2 带标题和取消按钮的操作面板

```typescript
@ComponentV2
struct ActionSheetWithTitle {
  @Local isShow: boolean = false

  build() {
    Column() {
      Button('显示完整操作面板')
        .onClick(() => {
          this.isShow = true
        })
    }
    .width('100%')
    .height('100%')
    .bindSheet(this.isShow, this.sheetContent(), {
      height: 400,
      showClose: true,
      onDisappear: () => {
        this.isShow = false
      }
    })
  }

  @Builder
  sheetContent() {
    Column() {
      // 标题
      Text('上传图片')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 8 })

      // 副标题
      Text('请选择图片来源')
        .fontSize(14)
        .fontColor('#666666')
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ bottom: 16 })

      Divider()

      // 操作选项
      ForEach(['拍照', '从相册选择', '视频'], (item: string, index: number) => {
        Column() {
          Text(item)
            .fontSize(16)
            .width('100%')
            .padding(16)
        }
        .width('100%')
        .onClick(() => {
          console.info(`选择了: ${item}`)
          this.isShow = false
        })

        if (index < 2) {
          Divider()
        }
      })

      Divider()

      // 取消按钮
      Column() {
        Text('取消')
          .fontSize(16)
          .fontColor('#FF0000')
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding(16)
      }
      .width('100%')
      .onClick(() => {
        this.isShow = false
      })
    }
    .width('100%')
  }
}
```

### 3.3 自定义高度的操作面板

```typescript
@ComponentV2
struct CustomHeightActionSheet {
  @Local isShow: boolean = false

  build() {
    Column() {
      Row({ space: 16 }) {
        Button('小面板')
          .onClick(() => {
            this.isShow = true
          })

        Button('中等面板')
          .onClick(() => {
            this.isShow = true
          })

        Button('大面板')
          .onClick(() => {
            this.isShow = true
          })
      }
    }
    .width('100%')
    .height('100%')
    .bindSheet(this.isShow, this.sheetContent(), {
      height: SheetSize.MEDIUM,  // 使用预设大小
      onDisappear: () => {
        this.isShow = false
      }
    })
  }

  @Builder
  sheetContent() {
    Column() {
      Text('操作面板')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .padding(16)

      ForEach(['选项1', '选项2', '选项3', '选项4', '选项5'], (item: string) => {
        Text(item)
          .width('100%')
          .padding(16)
          .onClick(() => {
            console.info(`选择了: ${item}`)
            this.isShow = false
          })
      })
    }
    .width('100%')
  }
}
```

### 3.4 带图标的操作面板

```typescript
@ComponentV2
struct IconActionSheet {
  @Local isShow: boolean = false

  build() {
    Column() {
      Button('显示带图标的操作面板')
        .onClick(() => {
          this.isShow = true
        })
    }
    .width('100%')
    .height('100%')
    .bindSheet(this.isShow, this.sheetContent(), {
      height: 350,
      onDisappear: () => {
        this.isShow = false
      }
    })
  }

  @Builder
  sheetContent() {
    Column() {
      Text('分享到')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding(16)

      Grid() {
        ForEach([
          { name: '微信', icon: '\ue641' },
          { name: '朋友圈', icon: '\ue642' },
          { name: 'QQ', icon: '\ue643' },
          { name: '微博', icon: '\ue644' }
        ], (item: { name: string, icon: string }) => {
          GridItem() {
            Column({ space: 8 }) {
              Text(item.icon)
                .fontSize(32)
              Text(item.name)
                .fontSize(14)
            }
            .onClick(() => {
              console.info(`分享到: ${item.name}`)
              this.isShow = false
            })
          }
        })
      }
      .columnsTemplate('1fr 1fr 1fr 1fr')
      .rowsGap(20)
      .columnsGap(10)
      .padding(16)

      Divider()

      Text('取消')
        .fontSize(16)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding(16)
        .onClick(() => {
          this.isShow = false
        })
    }
    .width('100%')
  }
}
```

### 3.5 带确认功能的操作面板

```typescript
@ComponentV2
struct ConfirmActionSheet {
  @Local isShow: boolean = false
  @Local selectedOption: string = ''

  build() {
    Column() {
      Text(`已选择: ${this.selectedOption}`)
        .fontSize(16)
        .padding(16)

      Button('选择选项')
        .onClick(() => {
          this.isShow = true
        })
    }
    .width('100%')
    .height('100%')
    .bindSheet(this.isShow, this.sheetContent(), {
      height: 400,
      onDisappear: () => {
        this.isShow = false
      }
    })
  }

  @Builder
  sheetContent() {
    Column() {
      Text('请选择一个选项')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding(16)

      Divider()

      ForEach(['选项A', '选项B', '选项C'], (item: string) => {
        Row() {
          Text(item)
            .fontSize(16)

          if (this.selectedOption === item) {
            Text('✓')
              .fontSize(18)
              .fontColor('#007DFF')
              .margin({ left: 'auto' })
          }
        }
        .width('100%')
        .padding(16)
        .onClick(() => {
          this.selectedOption = item
          console.info(`选择了: ${item}`)
        })
      })

      Divider()

      Row() {
        Button('取消')
          .type(ButtonType.Normal)
          .layoutWeight(1)
          .onClick(() => {
            this.isShow = false
          })

        Button('确定')
          .type(ButtonType.Normal)
          .backgroundColor('#007DFF')
          .fontColor(Color.White)
          .layoutWeight(1)
          .onClick(() => {
            console.info(`确认选择: ${this.selectedOption}`)
            this.isShow = false
          })
      }
      .width('100%')
      .padding(16)
    }
    .width('100%')
  }
}
```

### 3.6 屏幕遮罩层交互

```typescript
@ComponentV2
struct InteractiveMaskActionSheet {
  @Local isShow: boolean = false
  @Local clickCount: number = 0

  build() {
    Column() {
      Text(`点击遮罩层次数: ${this.clickCount}`)
        .fontSize(16)
        .padding(16)

      Button('显示操作面板')
        .onClick(() => {
          this.isShow = true
        })
    }
    .width('100%')
    .height('100%')
    .bindSheet(this.isShow, this.sheetContent(), {
      height: 300,
      enableOutsideInteractive: true,  // 允许遮罩层交互
      maskColor: 'rgba(0, 0, 0, 0.5)',  // 半透明遮罩
      onDisappear: () => {
        this.isShow = false
      }
    })
    .onClick(() => {
      if (this.isShow) {
        this.clickCount++
        console.info(`点击遮罩层: ${this.clickCount}`)
      }
    })
  }

  @Builder
  sheetContent() {
    Column() {
      Text('操作面板')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .padding(16)

      ForEach(['选项1', '选项2', '选项3'], (item: string) => {
        Text(item)
          .width('100%')
          .padding(16)
          .onClick(() => {
            console.info(`选择了: ${item}`)
            this.isShow = false
          })
      })
    }
    .width('100%')
  }
}
```

### 3.7 完整的分享操作面板

```typescript
@ComponentV2
struct ShareActionSheet {
  @Local isShow: boolean = false

  build() {
    Column() {
      Button('分享')
        .onClick(() => {
          this.isShow = true
        })
    }
    .width('100%')
    .height('100%')
    .bindSheet(this.isShow, this.shareContent(), {
      height: 380,
      backgroundColor: '#F5F5F5',
      showClose: false,
      onDisappear: () => {
        this.isShow = false
      }
    })
  }

  @Builder
  shareContent() {
    Column() {
      // 标题栏
      Row() {
        Text('取消')
          .fontSize(16)
          .fontColor('#666666')
          .onClick(() => {
            this.isShow = false
          })

        Text('分享到')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('')  // 占位，保持标题居中
          .width(60)
      }
      .width('100%')
      .padding(16)

      // 图标网格
      Grid() {
        ForEach([
          { name: '微信', icon: '\ue641' },
          { name: '朋友圈', icon: '\ue642' },
          { name: 'QQ', icon: '\ue643' },
          { name: 'QQ空间', icon: '\ue644' },
          { name: '微博', icon: '\ue645' },
          { name: '链接', icon: '\ue646' },
          { name: '邮件', icon: '\ue647' },
          { name: '更多', icon: '\ue648' }
        ], (item: { name: string, icon: string }) => {
          GridItem() {
            Column({ space: 8 }) {
              Text(item.icon)
                .fontSize(32)
              Text(item.name)
                .fontSize(14)
                .fontColor('#333333')
            }
            .onClick(() => {
              console.info(`分享到: ${item.name}`)
              this.isShow = false
            })
          }
        })
      }
      .columnsTemplate('1fr 1fr 1fr 1fr')
      .rowsGap(20)
      .columnsGap(10)
      .padding(16)
      .backgroundColor(Color.White)
      .borderRadius(12)

      Blank()

      // 收藏和举报
      Row({ space: 20 }) {
        Row({ space: 8 }) {
          Text('\ue649')
            .fontSize(20)
          Text('收藏')
            .fontSize(16)
        }
        .onClick(() => {
          console.info('收藏')
          this.isShow = false
        })

        Row({ space: 8 }) {
          Text('\ue64a')
            .fontSize(20)
          Text('举报')
            .fontSize(16)
        }
        .onClick(() => {
          console.info('举报')
          this.isShow = false
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding(20)
    }
    .width('100%')
    .height('100%')
  }
}
```

## 四、高级用法

### 4.1 带输入框的操作面板

```typescript
@ComponentV2
struct InputActionSheet {
  @Local isShow: boolean = false
  @Local inputText: string = ''

  build() {
    Column() {
      Text(`输入内容: ${this.inputText}`)
        .fontSize(16)
        .padding(16)

      Button('显示输入面板')
        .onClick(() => {
          this.isShow = true
        })
    }
    .width('100%')
    .height('100%')
    .bindSheet(this.isShow, this.inputContent(), {
      height: 350,
      onDisappear: () => {
        this.isShow = false
      }
    })
  }

  @Builder
  inputContent() {
    Column() {
      Text('请输入内容')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .padding(16)

      TextInput({ placeholder: '请输入...', text: this.inputText })
        .onChange((value: string) => {
          this.inputText = value
        })
        .margin(16)

      Row() {
        Button('取消')
          .layoutWeight(1)
          .onClick(() => {
            this.isShow = false
          })

        Button('确定')
          .layoutWeight(1)
          .backgroundColor('#007DFF')
          .fontColor(Color.White)
          .onClick(() => {
            console.info(`输入内容: ${this.inputText}`)
            this.isShow = false
          })
      }
      .width('100%')
      .padding(16)
    }
    .width('100%')
  }
}
```

### 4.2 阻止关闭的操作面板

```typescript
@ComponentV2
struct PreventCloseActionSheet {
  @Local isShow: boolean = false
  @Local hasConfirmed: boolean = false

  build() {
    Column() {
      Button('显示必须确认的面板')
        .onClick(() => {
          this.isShow = true
          this.hasConfirmed = false
        })
    }
    .width('100%')
    .height('100%')
    .bindSheet(this.isShow, this.sheetContent(), {
      height: 300,
      shouldDismiss: (action: SheetDismiss) => {
        // 只允许通过点击确定按钮关闭
        return this.hasConfirmed
      },
      onDisappear: () => {
        this.isShow = false
      }
    })
  }

  @Builder
  sheetContent() {
    Column() {
      Text('重要提示')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .padding(16)

      Text('请仔细阅读以下内容，必须点击确定才能关闭')
        .fontSize(14)
        .fontColor('#666666')
        .padding({ left: 16, right: 16 })

      Button('我已阅读并确定')
        .width('90%')
        .margin(16)
        .onClick(() => {
          this.hasConfirmed = true
          this.isShow = false
        })
    }
    .width('100%')
  }
}
```

### 4.3 模糊背景效果

```typescript
@ComponentV2
struct BlurActionSheet {
  @Local isShow: boolean = false

  build() {
    Column() {
      Button('显示模糊背景面板')
        .onClick(() => {
          this.isShow = true
        })
    }
    .width('100%')
    .height('100%')
    .bindSheet(this.isShow, this.sheetContent(), {
      height: 350,
      blurStyle: BlurStyle.COMPONENT_ULTRA_THICK,  // 超厚模糊效果
      maskColor: 'rgba(0, 0, 0, 0.3)',
      onDisappear: () => {
        this.isShow = false
      }
    })
  }

  @Builder
  sheetContent() {
    Column() {
      Text('模糊背景效果')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .padding(16)

      ForEach(['选项1', '选项2', '选项3'], (item: string) => {
        Text(item)
          .width('100%')
          .padding(16)
          .onClick(() => {
            console.info(`选择了: ${item}`)
            this.isShow = false
          })
      })
    }
    .width('100%')
  }
}
```

## 五、最佳实践

### 5.1 选项数量控制

```typescript
// ✅ 推荐：2-5个选项
@ComponentV2
struct GoodActionSheet {
  @Local isShow: boolean = false

  build() {
    Column() {
      Button('显示操作')
        .onClick(() => {
          this.isShow = true
        })
    }
    .bindSheet(this.isShow, this.content(), {
      height: 300,
      onDisappear: () => {
        this.isShow = false
      }
    })
  }

  @Builder
  content() {
    Column() {
      ForEach(['拍照', '相册', '视频'], (item: string) => {
        Text(item)
          .width('100%')
          .padding(16)
          .onClick(() => {
            this.isShow = false
          })
      })
    }
  }
}

// ❌ 避免：选项过多
// 应该使用列表或其他组件
```

### 5.2 取消按钮设计

```typescript
// ✅ 推荐：底部始终有取消按钮
@Builder
content() {
  Column() {
    // 操作选项
    ForEach(['选项1', '选项2', '选项3'], (item: string) => {
      Text(item)
        .width('100%')
        .padding(16)
        .onClick(() => {
          this.isShow = false
        })
    })

    Divider()

    // 取消按钮
    Text('取消')
      .width('100%')
      .textAlign(TextAlign.Center)
      .padding(16)
      .fontColor('#FF0000')
      .onClick(() => {
        this.isShow = false
      })
  }
}
```

### 5.3 标题使用

```typescript
// ✅ 推荐：清晰的标题说明
@Builder
content() {
  Column() {
    Text('选择图片来源')
      .fontSize(18)
      .fontWeight(FontWeight.Bold)
      .width('100%')
      .textAlign(TextAlign.Center)
      .padding(16)

    Divider()

    // 选项...
  }
}
```

### 5.4 关闭动画和交互

```typescript
// ✅ 推荐：提供平滑的关闭体验
.bindSheet(this.isShow, this.content(), {
  height: 300,
  onDisappear: () => {
    // 执行清理操作
    this.isShow = false
    console.info('面板已关闭')
  }
})
```

## 六、常见问题

### Q1: ActionSheet 不显示？

**问题**: 设置 isShow 为 true 但面板不显示。

**解决方案**:
```typescript
// 1. 确保使用 @Local 装饰器
@ComponentV2
struct MyComponent {
  @Local isShow: boolean = false  // ✅ 正确

  build() {
    Column() {
      Button('显示')
        .onClick(() => {
          this.isShow = true  // 修改状态
        })
    }
    .bindSheet(this.isShow, this.content(), {
      onDisappear: () => {
        this.isShow = false
      }
    })
  }
}
```

### Q2: 如何阻止面板被拖动关闭？

**解决方案**:
```typescript
.bindSheet(this.isShow, this.content(), {
  height: 300,
  shouldDismiss: (action: SheetDismiss) => {
    // 阻止边缘拖动关闭
    if (action === SheetDismiss.EDGE_DRAG) {
      return false
    }
    return true
  },
  onDisappear: () => {
    this.isShow = false
  }
})
```

### Q3: 如何设置面板背景模糊？

**解决方案**:
```typescript
.bindSheet(this.isShow, this.content(), {
  height: 300,
  blurStyle: BlurStyle.COMPONENT_ULTRA_THICK,  // 模糊样式
  maskColor: 'rgba(0, 0, 0, 0.5)',  // 遮罩颜色
  onDisappear: () => {
    this.isShow = false
  }
})
```

### Q4: 如何实现全屏面板？

**解决方案**:
```typescript
.bindSheet(this.isShow, this.fullScreenContent(), {
  height: '100%',
  modalMode: ModalMode.FULL_SCREEN,
  onDisappear: () => {
    this.isShow = false
  }
})
```

### Q5: 面板内容如何自适应高度？

**解决方案**:
```typescript
// 使用百分比或自适应高度
.bindSheet(this.isShow, this.content(), {
  height: '60%',  // 百分比高度
  // 或
  height: SheetSize.LARGE,  // 预设大小
  onDisappear: () => {
    this.isShow = false
  }
})
```

## 七、版本兼容性

| API 版本 | 支持状态 | 备注 |
|----------|----------|------|
| API 10+ | ✅ | 基础功能支持 |
| API 11+ | ✅ | 增加了 preferType, detached 等属性 |
| API 12+ | ✅ | 增加了 shouldDismiss 回调增强 |

## 八、参考资料

- [BindSheet 绑定面板 - 华为开发者官方文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-universal-methods-bind-sheet-V5)
- [半模态转场 - 华为开发者](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-modal-transition-V5)
- [底部面板设计规范 - HarmonyOS 设计指南](https://developer.huawei.com/consumer/cn/design/harmonyos-/guidelines/bottom-sheet.html)
