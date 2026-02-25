/**
 * NavRouter Component Examples
 * OpenHarmony NavRouter Component 使用示例
 *
 * 展示 NavRouter 组件的各种用法，包括基础路由、侧边栏导航、标签页导航等
 */

/**
 * 基础 NavRouter 示例
 * 展示最简单的 NavRouter 用法
 */
@ComponentV2
export struct BasicNavRouterExample {
  @Local currentIndex: number = 0

  build() {
    Column() {
      NavRouter() {
        if (this.currentIndex === 0) {
          NavDestination() {
            Column({ space: 16 }) {
              Text('首页')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
              Text('这是首页的内容')
                .fontSize(16)
                .fontColor('#666666')
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .backgroundColor('#FFE4E1')
          }
        } else if (this.currentIndex === 1) {
          NavDestination() {
            Column({ space: 16 }) {
              Text('发现')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
              Text('这是发现页的内容')
                .fontSize(16)
                .fontColor('#666666')
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .backgroundColor('#E1FFE4')
          }
        } else if (this.currentIndex === 2) {
          NavDestination() {
            Column({ space: 16 }) {
              Text('我的')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
              Text('这是我的页的内容')
                .fontSize(16)
                .fontColor('#666666')
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .backgroundColor('#E1E4FF')
          }
        }
      }
      .width('100%')
      .layoutWeight(1)

      // 底部导航
      Row() {
        ForEach(['首页', '发现', '我的'], (title: string, index: number) => {
          Column({ space: 4 }) {
            Text(this.getIcon(index))
              .fontSize(24)
              .fontColor(this.currentIndex === index ? '#007DFF' : '#999999')
            Text(title)
              .fontSize(12)
              .fontColor(this.currentIndex === index ? '#007DFF' : '#999999')
          }
          .layoutWeight(1)
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            this.currentIndex = index
          })
        })
      }
      .width('100%')
      .height(60)
      .backgroundColor('#FFFFFF')
      .border({ width: { top: 1 }, color: '#E0E0E0' })
    }
    .width('100%')
    .height(400)
  }

  getIcon(index: number): string {
    const icons = ['\uE8C6', '\uE8E2', '\uE8C9']
    return icons[index]
  }
}

/**
 * 侧边栏导航示例
 * 展示左右布局的侧边栏导航效果
 */
interface MenuItem {
  id: string
  title: string
  icon: string
}

@ComponentV2
export struct SidebarNavRouterExample {
  @Local selectedMenu: string = 'menu1'
  private menuItems: MenuItem[] = [
    { id: 'menu1', title: '用户管理', icon: '\uE8C6' },
    { id: 'menu2', title: '数据统计', icon: '\uE8E2' },
    { id: 'menu3', title: '系统设置', icon: '\uE8C9' }
  ]

  build() {
    Row() {
      // 左侧导航菜单
      Column({ space: 0 }) {
        ForEach(this.menuItems, (menu: MenuItem) => {
          Column({ space: 8 }) {
            Text(menu.icon)
              .fontSize(24)
              .fontColor(this.selectedMenu === menu.id ? '#007DFF' : '#666666')
            Text(menu.title)
              .fontSize(12)
              .fontColor(this.selectedMenu === menu.id ? '#007DFF' : '#666666')
          }
          .width('100%')
          .padding(16)
          .backgroundColor(this.selectedMenu === menu.id ? '#E3F2FD' : 'transparent')
          .border({ width: { left: 4 }, color: this.selectedMenu === menu.id ? '#007DFF' : 'transparent' })
          .onClick(() => {
            this.selectedMenu = menu.id
          })
        }, (menu: MenuItem) => menu.id)
      }
      .width(100)
      .height(400)
      .backgroundColor('#F5F5F5')

      // 右侧内容区
      NavRouter() {
        if (this.selectedMenu === 'menu1') {
          NavDestination() {
            this.UserManagementContent()
          }
        } else if (this.selectedMenu === 'menu2') {
          NavDestination() {
            this.StatisticsContent()
          }
        } else if (this.selectedMenu === 'menu3') {
          NavDestination() {
            this.SettingsContent()
          }
        }
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height(400)
  }

  @Builder
  UserManagementContent() {
    Column({ space: 16 }) {
      Text('用户管理')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
      ForEach(['用户A', '用户B', '用户C'], (user: string) => {
        Text(user)
          .fontSize(16)
          .padding(12)
          .backgroundColor('#FFFFFF')
          .borderRadius(8)
          .width('100%')
      })
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#FAFAFA')
  }

  @Builder
  StatisticsContent() {
    Column({ space: 16 }) {
      Text('数据统计')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
      Text('统计数据展示区域')
        .fontSize(16)
        .fontColor('#666666')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#FAFAFA')
  }

  @Builder
  SettingsContent() {
    Column({ space: 16 }) {
      Text('系统设置')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
      Text('系统配置选项')
        .fontSize(16)
        .fontColor('#666666')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#FAFAFA')
  }
}

/**
 * 标签页导航示例
 * 展示顶部标签栏导航效果
 */
@ComponentV2
export struct TabNavRouterExample {
  @Local activeTab: number = 0
  private tabs: string[] = ['推荐', '热门', '最新', '关注']

  build() {
    Column() {
      // 顶部标签栏
      Row({ space: 0 }) {
        ForEach(this.tabs, (tab: string, index: number) => {
          Column() {
            Text(tab)
              .fontSize(16)
              .fontWeight(this.activeTab === index ? FontWeight.Bold : FontWeight.Normal)
              .fontColor(this.activeTab === index ? '#007DFF' : '#666666')
              .padding({ top: 12, bottom: 12 })
          }
          .layoutWeight(1)
          .onClick(() => {
            this.activeTab = index
          })
        })
      }
      .width('100%')
      .backgroundColor('#FFFFFF')
      .border({ width: { bottom: 1 }, color: '#E0E0E0' })

      // 内容区
      NavRouter() {
        if (this.activeTab === 0) {
          NavDestination() {
            this.TabContent('推荐内容')
          }
        } else if (this.activeTab === 1) {
          NavDestination() {
            this.TabContent('热门内容')
          }
        } else if (this.activeTab === 2) {
          NavDestination() {
            this.TabContent('最新内容')
          }
        } else if (this.activeTab === 3) {
          NavDestination() {
            this.TabContent('关注内容')
          }
        }
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height(400)
  }

  @Builder
  TabContent(title: string) {
    Column({ space: 16 }) {
      Text(title)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
      ForEach([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], (item: number) => {
        Text(`${title} - 项目 ${item}`)
          .fontSize(14)
          .padding(12)
          .backgroundColor('#FFFFFF')
          .borderRadius(8)
          .width('100%')
      })
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
  }
}

/**
 * 带动画的导航切换示例
 * 展示如何使用动画进行视图切换
 */
@ComponentV2
export struct AnimatedNavRouterExample {
  @Local currentView: string = 'view1'

  build() {
    Column() {
      NavRouter() {
        if (this.currentView === 'view1') {
          NavDestination() {
            Column({ space: 16 }) {
              Text('视图 1')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
              Text('这是第一个视图的内容')
                .fontSize(16)
              Button('切换到视图2')
                .onClick(() => {
                  this.currentView = 'view2'
                })
            }
            .justifyContent(FlexAlign.Center)
            .backgroundColor('#FFE4E1')
          }
        } else if (this.currentView === 'view2') {
          NavDestination() {
            Column({ space: 16 }) {
              Text('视图 2')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
              Text('这是第二个视图的内容')
                .fontSize(16)
              Button('切换到视图1')
                .onClick(() => {
                  this.currentView = 'view1'
                })
            }
            .justifyContent(FlexAlign.Center)
            .backgroundColor('#E1FFE4')
          }
        }
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height(350)
  }
}

/**
 * 动态 NavRouter 示例
 * 展示如何动态加载路由内容
 */
interface RouteItem {
  id: string
  title: string
  content: string
}

@ComponentV2
export struct DynamicNavRouterExample {
  @Local routes: RouteItem[] = []
  @Local currentRoute: string = ''

  aboutToAppear() {
    // 动态加载路由
    this.routes = [
      { id: 'route1', title: '路由1', content: '这是路由1的内容' },
      { id: 'route2', title: '路由2', content: '这是路由2的内容' },
      { id: 'route3', title: '路由3', content: '这是路由3的内容' }
    ]
    this.currentRoute = this.routes[0].id
  }

  build() {
    Column() {
      // 动态菜单
      Row({ space: 8 }) {
        ForEach(this.routes, (route: RouteItem) => {
          Text(route.title)
            .fontSize(14)
            .padding(12)
            .backgroundColor(this.currentRoute === route.id ? '#007DFF' : '#E0E0E0')
            .fontColor(this.currentRoute === route.id ? Color.White : '#333333')
            .borderRadius(8)
            .onClick(() => {
              this.currentRoute = route.id
            })
        }, (route: RouteItem) => route.id)
      }
      .width('100%')
      .padding(16)

      // 动态内容
      NavRouter() {
        ForEach(this.routes, (route: RouteItem) => {
          if (this.currentRoute === route.id) {
            NavDestination() {
              Column({ space: 16 }) {
                Text(route.title)
                  .fontSize(24)
                  .fontWeight(FontWeight.Bold)
                Text(route.content)
                  .fontSize(16)
                  .fontColor('#666666')
              }
              .justifyContent(FlexAlign.Center)
              .backgroundColor('#F5F5F5')
            }
          }
        }, (route: RouteItem) => route.id)
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height(400)
  }
}

/**
 * 完整的 NavRouter 示例页面
 * 集成所有 NavRouter 示例
 */
@ComponentV2
export struct NavRouterExamplePage {
  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          Text('NavRouter Component Examples')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .padding({ left: 16, right: 16, top: 16, bottom: 8 })

          BasicNavRouterExample()
          SidebarNavRouterExample()
          TabNavRouterExample()
          AnimatedNavRouterExample()
          DynamicNavRouterExample()
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
    }
    .title('NavRouter 路由')
    .mode(NavDestinationMode.STANDARD)
  }
}

@Builder
export function NavRouterExamplePageBuilder() {
  NavRouterExamplePage()
}
