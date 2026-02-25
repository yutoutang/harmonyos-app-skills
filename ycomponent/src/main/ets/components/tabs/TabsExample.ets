/**
 * Tabs & TabContent Component Examples
 * OpenHarmony Tabs and TabContent Component 使用示例
 *
 * 展示 Tabs 和 TabContent 组件的各种用法，包括不同布局模式、样式和交互
 */

/**
 * 基础标签页示例
 * 展示最简单的标签页用法
 */
@ComponentV2
export struct BasicTabsExample {
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
      console.info('Selected tab: ' + index)
    })
  }
}

/**
 * 底部导航栏示例
 * 展示类似主应用的底部导航效果
 */
@ComponentV2
export struct BottomTabsExample {
  @Local currentIndex: number = 0

  build() {
    Tabs({ barPosition: BarPosition.End, index: this.currentIndex }) {
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
      .tabBar(this.tabBuilder('首页', 0, '\uE100'))

      TabContent() {
        Column() {
          Text('订单')
            .fontSize(24)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#FFFFFF')
      }
      .tabBar(this.tabBuilder('订单', 1, '\uE101'))

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
      .tabBar(this.tabBuilder('我的', 2, '\uE102'))
    }
    .width('100%')
    .height(350)
    .barHeight(60)
    .onChange((index: number) => {
      this.currentIndex = index
    })
  }

  @Builder
  tabBuilder(title: string, index: number, icon: string) {
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
 * 可滚动标签栏示例
 * 展示标签较多时的滚动效果
 */
@ComponentV2
export struct ScrollableTabsExample {
  @Local currentIndex: number = 0

  build() {
    Tabs({ barPosition: BarPosition.Start, index: this.currentIndex }) {
      ForEach(['推荐', '热门', '视频', '音乐', '图片', '新闻', '体育', '科技'], (title: string, index: number) => {
        TabContent() {
          Column() {
            Text(`${title}内容`)
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .backgroundColor('#F5F5F5')
        }
        .tabBar(title)
      })
    }
    .width('100%')
    .height(300)
    .barMode(BarMode.Scrollable)
    .barHeight(50)
    .onChange((index: number) => {
      this.currentIndex = index
    })
  }
}

/**
 * 垂直标签页示例
 * 展示左右布局的标签页
 */
@ComponentV2
export struct VerticalTabsExample {
  @Local currentIndex: number = 0

  build() {
    Tabs({ barPosition: BarPosition.Start, index: this.currentIndex }) {
      TabContent() {
        Column() {
          Text('标签页 1 内容')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#F5F5F5')
      }
      .tabBar('标签 1')

      TabContent() {
        Column() {
          Text('标签页 2 内容')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#FFFFFF')
      }
      .tabBar('标签 2')

      TabContent() {
        Column() {
          Text('标签页 3 内容')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#F5F5F5')
      }
      .tabBar('标签 3')
    }
    .width('100%')
    .height(300)
    .vertical(true)
    .barWidth(100)
    .onChange((index: number) => {
      this.currentIndex = index
    })
  }
}

/**
 * 自定义样式标签页示例
 * 展示如何自定义标签栏样式
 */
@ComponentV2
export struct CustomStyleTabsExample {
  @Local currentIndex: number = 0

  build() {
    Tabs({ index: this.currentIndex }) {
      TabContent() {
        Column() {
          Text('聊天')
            .fontSize(24)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#F5F5F5')
      }
      .tabBar(this.customTabBuilder('聊天', 0))

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
      .tabBar(this.customTabBuilder('联系人', 1))

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
      .tabBar(this.customTabBuilder('动态', 2))
    }
    .width('100%')
    .height(300)
    .barHeight(60)
    .barBackgroundColor('#FFFFFF')
    .onChange((index: number) => {
      this.currentIndex = index
    })
  }

  @Builder
  customTabBuilder(title: string, index: number) {
    Column({ space: 4 }) {
      Text(title)
        .fontSize(16)
        .fontWeight(this.currentIndex === index ? FontWeight.Bold : FontWeight.Normal)
        .fontColor(this.currentIndex === index ? '#007DFF' : '#666666')

      if (this.currentIndex === index) {
        Divider()
          .strokeWidth(3)
          .color('#007DFF')
          .width(30)
      }
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}

/**
 * 禁用滑动切换示例
 * 展示如何禁用手势滑动
 */
@ComponentV2
export struct NoScrollTabsExample {
  @Local currentIndex: number = 0

  build() {
    Column({ space: 16 }) {
      Text('禁用滑动切换（只能点击标签切换）')
        .fontSize(14)
        .fontColor('#666666')

      Tabs({ index: this.currentIndex }) {
        TabContent() {
          Column() {
            Text('标签页 1')
              .fontSize(24)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
        }
        .tabBar('标签 1')

        TabContent() {
          Column() {
            Text('标签页 2')
              .fontSize(24)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
        }
        .tabBar('标签 2')
      }
      .width('100%')
      .height(250)
      .scrollable(false)
      .onChange((index: number) => {
        this.currentIndex = index
      })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 无动画切换示例
 * 展示如何禁用切换动画
 */
@ComponentV2
export struct NoAnimationTabsExample {
  @Local currentIndex: number = 0

  build() {
    Column({ space: 16 }) {
      Text('无动画切换')
        .fontSize(14)
        .fontColor('#666666')

      Tabs({ index: this.currentIndex }) {
        TabContent() {
          Column() {
            Text('标签页 1')
              .fontSize(24)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
        }
        .tabBar('标签 1')

        TabContent() {
          Column() {
            Text('标签页 2')
              .fontSize(24)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
        }
        .tabBar('标签 2')
      }
      .width('100%')
      .height(250)
      .animationDuration(0)
      .onChange((index: number) => {
        this.currentIndex = index
      })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 完整的 Tabs 示例页面
 * 集成所有 Tabs 和 TabContent 示例
 */
@ComponentV2
export struct TabsExamplePage {
  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          Text('Tabs & TabContent Component Examples')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .padding({ left: 16, right: 16, top: 16, bottom: 8 })

          // Tabs 相关示例
          BasicTabsExample()
          BottomTabsExample()
          ScrollableTabsExample()
          VerticalTabsExample()
          CustomStyleTabsExample()
          NoScrollTabsExample()
          NoAnimationTabsExample()

          // TabContent 相关示例
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
    .title('Tabs & TabContent 标签页')
    .mode(NavDestinationMode.STANDARD)
  }
}

@Builder
export function TabsExamplePageBuilder() {
  TabsExamplePage()
}

// ============ 从 TabContentExample 复制的组件 ============

/**
 * 文本标签栏示例
 * 展示最简单的文本标签栏用法
 */
@ComponentV2
export struct TextTabBarExample {
  @Local currentIndex: number = 0

  build() {
    Column({ space: 12 }) {
      Text('文本标签栏')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')

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
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .margin({ bottom: 8 })
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
    Column({ space: 12 }) {
      Text('图标标签栏')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')

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
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .margin({ bottom: 8 })
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
    Column({ space: 12 }) {
      Text('带角标的标签栏')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')

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
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .margin({ bottom: 8 })
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
    Column({ space: 12 }) {
      Text('复杂布局标签页')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')

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
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .margin({ bottom: 8 })
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
    Column({ space: 12 }) {
      Text('条件渲染标签页')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')

      Row({ space: 8 }) {
        Button('登录')
          .fontSize(14)
          .onClick(() => {
            this.isLoggedIn = true
          })
        Button('登出')
          .fontSize(14)
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
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .margin({ bottom: 8 })
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
    Column({ space: 12 }) {
      Text('嵌套滚动标签页')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')

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
          .padding(16)
        }
        .tabBar('滚动')
      }
      .width('100%')
      .height(350)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}
