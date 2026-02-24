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
    Scroll() {
      Column({ space: 20 }) {
        Text('Tabs & TabContent Component Examples')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .padding({ left: 16, right: 16, top: 16, bottom: 8 })

        BasicTabsExample()
        BottomTabsExample()
        ScrollableTabsExample()
        VerticalTabsExample()
        CustomStyleTabsExample()
        NoScrollTabsExample()
        NoAnimationTabsExample()
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
