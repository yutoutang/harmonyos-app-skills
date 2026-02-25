/**
 * Navigator Component Examples
 * OpenHarmony Navigator Component 使用示例
 *
 * 展示 Navigator 组件的各种用法，包括基础跳转、带参数跳转、不同类型跳转等
 */

/**
 * 基础 Navigator 示例
 * 展示最简单的 Navigator 用法
 */
@ComponentV2
export struct BasicNavigatorExample {
  build() {
    Column({ space: 16 }) {
      Text('Navigator 基础示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      // 普通跳转
      Navigator({ target: 'pages/DetailPage' }) {
        Text('跳转到详情页')
          .fontSize(16)
          .padding(12)
          .backgroundColor('#007DFF')
          .fontColor(Color.White)
          .borderRadius(8)
          .width('100%')
      }

      // 按钮形式跳转
      Navigator({ target: 'pages/DetailPage' }) {
        Button('按钮跳转')
          .width('100%')
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 带参数的 Navigator 示例
 * 展示如何通过 Navigator 实现页面跳转
 * 注意：Navigator 组件主要通过 target 指定页面路径
 * 参数传递需要在目标页面通过路由 API 获取
 */
@ComponentV2
export struct NavigatorWithParamsExample {
  @Local userId: number = 123
  @Local userName: string = '张三'

  build() {
    Column({ space: 16 }) {
      Text('Navigator 跳转示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      // 跳转到用户资料页
      Navigator({ target: 'pages/UserProfile' }) {
        Row({ space: 8 }) {
          Text('用户资料')
            .fontSize(16)
          Text(`(${this.userName})`)
            .fontSize(14)
            .fontColor('#666666')
        }
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(8)
        .width('100%')
      }

      // 跳转到详情页
      Navigator({ target: 'pages/DetailPage' }) {
        Button('查看详情')
          .width('100%')
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 不同类型的 Navigator 示例
 * 展示 Push、Replace、Back 三种跳转类型
 */
@ComponentV2
export struct NavigatorTypeExample {
  build() {
    Column({ space: 16 }) {
      Text('Navigator 类型示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      // Push 类型 - 普通跳转
      Navigator({
        target: 'pages/Page1',
        type: NavigationType.Push
      }) {
        Text('Push 跳转')
          .fontSize(16)
          .padding(12)
          .backgroundColor('#007DFF')
          .fontColor(Color.White)
          .borderRadius(8)
          .width('100%')
      }

      // Replace 类型 - 替换当前页面
      Navigator({
        target: 'pages/Page2',
        type: NavigationType.Replace
      }) {
        Text('Replace 跳转')
          .fontSize(16)
          .padding(12)
          .backgroundColor('#28A745')
          .fontColor(Color.White)
          .borderRadius(8)
          .width('100%')
      }

      // Back 类型 - 返回上一页
      Navigator({
        target: '',
        type: NavigationType.Back
      }) {
        Text('返回上一页')
          .fontSize(16)
          .padding(12)
          .backgroundColor('#6C757D')
          .fontColor(Color.White)
          .borderRadius(8)
          .width('100%')
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 条件性 Navigator 示例
 * 展示如何根据条件显示或隐藏导航
 */
@ComponentV2
export struct ConditionalNavigatorExample {
  @Local isLoggedIn: boolean = false
  @Local hasPermission: boolean = true

  build() {
    Column({ space: 16 }) {
      Text('条件性 Navigator')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      // 模拟登录状态切换
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

      // 根据登录状态显示导航
      if (this.isLoggedIn) {
        Navigator({ target: 'pages/UserCenter' }) {
          Text('用户中心')
            .fontSize(16)
            .padding(12)
            .backgroundColor('#007DFF')
            .fontColor(Color.White)
            .borderRadius(8)
            .width('100%')
        }
      } else {
        Text('请先登录访问用户中心')
          .fontSize(14)
          .fontColor('#999999')
          .padding(12)
          .backgroundColor('#F5F5F5')
          .borderRadius(8)
          .width('100%')
      }

      // 根据权限显示导航
      if (this.hasPermission) {
        Navigator({ target: 'pages/AdminPage' }) {
          Text('管理页面')
            .fontSize(16)
            .padding(12)
            .backgroundColor('#28A745')
            .fontColor(Color.White)
            .borderRadius(8)
            .width('100%')
        }
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 卡片式 Navigator 示例
 * 展示如何创建卡片样式的导航项
 */
interface CardItem {
  title: string
  description: string
  page: string
}

@ComponentV2
export struct CardNavigatorExample {
  @Local items: CardItem[] = [
    { title: '用户管理', description: '管理系统用户', page: 'pages/UserManage' },
    { title: '数据统计', description: '查看数据分析', page: 'pages/Statistics' },
    { title: '系统设置', description: '配置系统参数', page: 'pages/Settings' }
  ]

  build() {
    Column({ space: 16 }) {
      Text('功能导航')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      ForEach(this.items, (item: CardItem) => {
        Navigator({ target: item.page }) {
          Column({ space: 8 }) {
            Row() {
              Text(item.title)
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .layoutWeight(1)
              Text('\uE6E0')
                .fontSize(16)
                .fontColor('#CCCCCC')
            }
            .width('100%')

            Text(item.description)
              .fontSize(14)
              .fontColor('#666666')
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
        }
      }, (item: CardItem) => item.page)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 动态目标 Navigator 示例
 * 展示如何动态设置跳转目标
 */
@ComponentV2
export struct DynamicNavigatorExample {
  @Local selectedPage: string = 'pages/HomePage'
  @Local pages: string[] = ['pages/HomePage', 'pages/DetailPage', 'pages/ProfilePage']

  build() {
    Column({ space: 16 }) {
      Text('动态目标 Navigator')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      // 页面选择器
      Row({ space: 8 }) {
        ForEach(this.pages, (page: string) => {
          Button(page.split('/').pop())
            .onClick(() => {
              this.selectedPage = page
            })
            .backgroundColor(this.selectedPage === page ? '#007DFF' : '#E0E0E0')
            .fontColor(this.selectedPage === page ? Color.White : '#333333')
        })
      }
      .width('100%')

      // 动态目标 Navigator
      Navigator({ target: this.selectedPage }) {
        Row({ space: 8 }) {
          Text('跳转到:')
            .fontSize(14)
          Text(this.selectedPage)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
          Text('\uE6E0')
            .fontSize(14)
        }
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(8)
        .width('100%')
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 嵌套 Navigator 示例
 * 展示如何嵌套使用 Navigator
 */
@ComponentV2
export struct NestedNavigatorExample {
  build() {
    Column({ space: 16 }) {
      Text('嵌套 Navigator')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      // 外层 Navigator
      Navigator({ target: 'pages/OuterPage' }) {
        Column({ space: 8 }) {
          Text('外层导航')
            .fontSize(16)

          // 内层 Navigator
          Navigator({ target: 'pages/InnerPage' }) {
            Text('内层导航')
              .fontSize(14)
              .padding(8)
              .backgroundColor('#E0E0E0')
              .borderRadius(4)
          }
        }
        .padding(16)
        .backgroundColor('#F5F5F5')
        .borderRadius(8)
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * Navigator 事件监听示例
 * 展示如何监听 Navigator 的点击事件
 */
@ComponentV2
export struct NavigatorEventExample {
  @Local clickCount: number = 0

  build() {
    Column({ space: 16 }) {
      Text('Navigator 事件监听')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Text(`点击次数: ${this.clickCount}`)
        .fontSize(16)
        .fontColor('#666666')

      Navigator({ target: 'pages/DetailPage' }) {
        Button('带事件监听的跳转')
          .width('100%')
      }
      .onClick(() => {
        this.clickCount++
        console.info(`Navigator clicked ${this.clickCount} times`)
      })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 完整的 Navigator 示例页面
 * 集成所有 Navigator 示例
 */
@ComponentV2
export struct NavigatorExamplePage {
  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          Text('Navigator Component Examples')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .padding({ left: 16, right: 16, top: 16, bottom: 8 })

          BasicNavigatorExample()
          NavigatorWithParamsExample()
          NavigatorTypeExample()
          ConditionalNavigatorExample()
          CardNavigatorExample()
          DynamicNavigatorExample()
          NestedNavigatorExample()
          NavigatorEventExample()
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
    }
    .title('Navigator 导航器')
    .mode(NavDestinationMode.STANDARD)
  }
}

@Builder
export function NavigatorExamplePageBuilder() {
  NavigatorExamplePage()
}
