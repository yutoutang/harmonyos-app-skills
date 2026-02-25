/**
 * TabContent Component Examples
 * OpenHarmony TabContent Component 使用示例
 *
 * 展示 TabContent 组件的各种用法，包括不同类型的标签栏样式和内容布局
 */

/**
 * 文本标签栏示例
 * 展示最简单的文本标签栏用法
 */
@ComponentV2
export struct TextTabBarExample {
  @Local currentIndex: number = 0

  build() {
    Tabs({ index: this.currentIndex }) {
      TabContent() {
        Column() {
          Text('首页内容')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#F5F5F5')
      }
      .tabBar('首页')

      TabContent() {
        Column() {
          Text('发现内容')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#FFFFFF')
      }
      .tabBar('发现')

      TabContent() {
        Column() {
          Text('我的内容')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#F5F5F5')
      }
      .tabBar('我的')
    }
    .width('100%')
    .height(300)
    .barHeight(50)
    .onChange((index: number) => {
      this.currentIndex = index
    })
  }
}

/**
 * 图标标签栏示例
 * 展示带图标的标签栏用法
 */
@ComponentV2
export struct IconTabBarExample {
  @Local currentIndex: number = 0

  build() {
    Tabs({ index: this.currentIndex }) {
      TabContent() {
        Column() {
          Text('首页')
            .fontSize(24)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#F5F5F5')
      }
      .tabBar(this.iconTabBuilder('首页', 0, '\uE100'))

      TabContent() {
        Column() {
          Text('发现')
            .fontSize(24)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#FFFFFF')
      }
      .tabBar(this.iconTabBuilder('发现', 1, '\uE101'))

      TabContent() {
        Column() {
          Text('我的')
            .fontSize(24)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#F5F5F5')
      }
      .tabBar(this.iconTabBuilder('我的', 2, '\uE102'))
    }
    .width('100%')
    .height(300)
    .barHeight(60)
    .onChange((index: number) => {
      this.currentIndex = index
    })
  }

  @Builder
  iconTabBuilder(title: string, index: number, icon: string) {
    Column({ space: 4 }) {
      Text(icon)
        .fontSize(24)
        .fontColor(this.currentIndex === index ? '#007DFF' : '#999999')

      Text(title)
        .fontSize(12)
        .fontColor(this.currentIndex === index ? '#007DFF' : '#999999')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}

/**
 * 带角标的标签栏示例
 * 展示带消息提示的标签栏用法
 */
@ComponentV2
export struct BadgeTabBarExample {
  @Local currentIndex: number = 0

  build() {
    Tabs({ index: this.currentIndex }) {
      TabContent() {
        Column() {
          Text('消息')
            .fontSize(24)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#F5F5F5')
      }
      .tabBar(this.badgeTabBuilder('消息', 0, 5))

      TabContent() {
        Column() {
          Text('联系人')
            .fontSize(24)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#FFFFFF')
      }
      .tabBar(this.badgeTabBuilder('联系人', 1, 0))

      TabContent() {
        Column() {
          Text('动态')
            .fontSize(24)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#F5F5F5')
      }
      .tabBar(this.badgeTabBuilder('动态', 2, 99))
    }
    .width('100%')
    .height(300)
    .barHeight(60)
    .onChange((index: number) => {
      this.currentIndex = index
    })
  }

  @Builder
  badgeTabBuilder(title: string, index: number, count: number) {
    Row({ space: 8 }) {
      Text(title)
        .fontSize(16)
        .fontColor(this.currentIndex === index ? '#007DFF' : '#666666')

      if (count > 0) {
        Text(count > 99 ? '99+' : count.toString())
          .fontSize(10)
          .fontColor(Color.White)
          .backgroundColor('#FF0000')
          .borderRadius(10)
          .padding({ left: 4, right: 4, top: 2, bottom: 2 })
      }
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}

/**
 * 复杂布局标签页示例
 * 展示不同类型的标签页内容布局
 */
@ComponentV2
export struct ComplexTabContentExample {
  @Local dataList: string[] = ['项目1', '项目2', '项目3', '项目4', '项目5']

  build() {
    Tabs() {
      // 列表标签页
      TabContent() {
        Column() {
          ForEach(this.dataList, (item: string) => {
            Text(item)
              .fontSize(16)
              .width('100%')
              .padding(16)
              .backgroundColor('#FFFFFF')
              .borderRadius(8)
              .margin({ bottom: 8 })
          })
        }
        .width('100%')
        .height('100%')
        .padding(16)
        .backgroundColor('#F5F5F5')
      }
      .tabBar('列表')

      // 网格标签页
      TabContent() {
        Grid() {
          ForEach([1, 2, 3, 4, 5, 6], (item: number) => {
            GridItem() {
              Text(`项目${item}`)
                .fontSize(16)
                .width('100%')
                .height(100)
                .backgroundColor('#007DFF')
                .fontColor(Color.White)
                .textAlign(TextAlign.Center)
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(8)
        .rowsGap(8)
        .width('100%')
        .height('100%')
        .padding(16)
      }
      .tabBar('网格')

      // 表单标签页
      TabContent() {
        Column({ space: 16 }) {
          TextInput({ placeholder: '请输入用户名' })
          TextInput({ placeholder: '请输入密码' })
            .type(InputType.Password)
          Button('提交')
            .width('100%')
        }
        .width('100%')
        .height('100%')
        .padding(16)
        .justifyContent(FlexAlign.Center)
      }
      .tabBar('表单')
    }
    .width('100%')
    .height(350)
  }
}

/**
 * 条件渲染标签页示例
 * 展示如何根据条件显示不同的标签页
 */
@ComponentV2
export struct ConditionalTabContentExample {
  @Local isLoggedIn: boolean = false

  build() {
    Column({ space: 16 }) {
      Row({ space: 8 }) {
        Button('登录')
          .onClick(() => {
            this.isLoggedIn = true
          })
        Button('登出')
          .onClick(() => {
            this.isLoggedIn = false
          })
      }

      Tabs() {
        TabContent() {
          Column() {
            Text('首页')
              .fontSize(24)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
        }
        .tabBar('首页')

        // 条件显示的标签页
        if (this.isLoggedIn) {
          TabContent() {
            Column() {
              Text('个人中心')
                .fontSize(24)
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
          }
          .tabBar('个人中心')
        }

        TabContent() {
          Column() {
            Text('设置')
              .fontSize(24)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
        }
        .tabBar('设置')
      }
      .width('100%')
      .height(300)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 嵌套滚动标签页示例
 * 展示标签页内部使用可滚动组件
 */
@ComponentV2
export struct NestedScrollTabContentExample {
  @Local items: string[] = []

  aboutToAppear() {
    // 初始化数据
    for (let i = 0; i < 50; i++) {
      this.items.push(`项目 ${i + 1}`)
    }
  }

  build() {
    Tabs() {
      TabContent() {
        List({ space: 8 }) {
          ForEach(this.items, (item: string) => {
            ListItem() {
              Text(item)
                .fontSize(16)
                .width('100%')
                .padding(16)
                .backgroundColor('#FFFFFF')
                .borderRadius(8)
            }
          })
        }
        .width('100%')
        .height('100%')
        .padding(16)
      }
      .tabBar('列表')

      TabContent() {
        Scroll() {
          Column({ space: 16 }) {
            ForEach(this.items, (item: string) => {
              Text(item)
                .fontSize(16)
                .width('100%')
                .padding(16)
                .backgroundColor('#FFFFFF')
                .borderRadius(8)
            })
          }
          .width('100%')
          .padding(16)
        }
        .width('100%')
        .height('100%')
        .scrollBar(BarState.Auto)
      }
      .tabBar('滚动')
    }
    .width('100%')
    .height(350)
  }
}

/**
 * 完整的 TabContent 示例页面
 * 集成所有 TabContent 示例
 */
@ComponentV2
export struct TabContentExamplePage {
  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          Text('TabContent Component Examples')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .padding({ left: 16, right: 16, top: 16, bottom: 8 })

          TextTabBarExample()
          IconTabBarExample()
          BadgeTabBarExample()
          ComplexTabContentExample()
          ConditionalTabContentExample()
          NestedScrollTabContentExample()
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
    }
    .title('TabContent 标签内容')
    .mode(NavDestinationMode.STANDARD)
  }
}

@Builder
export function TabContentExamplePageBuilder() {
  TabContentExamplePage()
}
