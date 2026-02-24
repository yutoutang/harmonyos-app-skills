/**
 * Navigation Component Examples
 * OpenHarmony 导航组件使用示例
 *
 * 展示 Navigation、NavDestination 的各种用法
 */

/**
 * 导航参数接口
 */
interface DetailParams {
  id: number
}

/**
 * Navigation 基础示例
 */
@ComponentV2
export struct NavigationBasicExample {
  @Local navPathStack: NavPathStack = new NavPathStack()

  build() {
    Column({ space: 16 }) {
      Text('Navigation 基础示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Navigation(this.navPathStack) {
        Column({ space: 12 }) {
          Text('首页内容')
            .fontSize(16)

          Button('跳转到详情页')
            .onClick(() => {
              const params: DetailParams = { id: 123 }
              this.navPathStack.pushPathByName('DetailPage', params as Object)
            })
        }
        .width('100%')
        .padding(20)
      }
      .navDestination(this.PageBuilder)
      .height(300)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }

  @Builder
  PageBuilder(name: string, params: Object) {
    if (name === 'DetailPage') {
      Column({ space: 12 }) {
        Text('详情页')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
        Text(`参数: ${JSON.stringify(params)}`)
          .fontSize(14)
        Button('返回')
          .onClick(() => {
            this.navPathStack.pop()
          })
      }
      .width('100%')
      .height('100%')
      .padding(20)
    }
  }
}

/**
 * NavDestination 标准模式示例
 */
@ComponentV2
export struct NavDestinationStandardExample {
  @Local navPathStack: NavPathStack = new NavPathStack()

  build() {
    Column({ space: 16 }) {
      Text('NavDestination 标准模式')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Navigation(this.navPathStack) {
        Button('打开标准页面')
          .onClick(() => {
            this.navPathStack.pushPathByName('StandardPage', null)
          })
      }
      .navDestination(this.PageBuilder)
      .height(350)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }

  @Builder
  PageBuilder(name: string, params: Object) {
    if (name === 'StandardPage') {
      NavDestination() {
        Column({ space: 12 }) {
          Text('标准模式页面')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
          Text('这是全屏显示的标准页面')
            .fontSize(14)
            .fontColor('#666666')
          Button('返回')
            .onClick(() => {
              this.navPathStack.pop()
            })
        }
        .width('100%')
        .height('100%')
        .padding(20)
        .justifyContent(FlexAlign.Center)
      }
      .title('标准页面')
      .mode(NavDestinationMode.STANDARD)
    }
  }
}

/**
 * NavDestination 弹窗模式示例
 */
@ComponentV2
export struct NavDestinationDialogExample {
  @Local navPathStack: NavPathStack = new NavPathStack()

  build() {
    Column({ space: 16 }) {
      Text('NavDestination 弹窗模式')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Navigation(this.navPathStack) {
        Button('打开弹窗页面')
          .onClick(() => {
            this.navPathStack.pushPathByName('DialogPage', null)
          })
      }
      .navDestination(this.PageBuilder)
      .height(350)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }

  @Builder
  PageBuilder(name: string, params: Object) {
    if (name === 'DialogPage') {
      NavDestination() {
        Column({ space: 16 }) {
          Text('弹窗模式页面')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
          Text('这是以弹窗形式显示的页面')
            .fontSize(14)
            .fontColor('#666666')

          Row({ space: 12 }) {
            Button('取消')
              .backgroundColor('#6C757D')
              .onClick(() => {
                this.navPathStack.pop()
              })

            Button('确认')
              .backgroundColor('#007DFF')
              .onClick(() => {
                this.navPathStack.pop()
              })
          }
        }
        .width('100%')
        .padding(24)
        .backgroundColor(Color.White)
        .borderRadius(12)
      }
      .title('弹窗标题')
      .mode(NavDestinationMode.DIALOG)
    }
  }
}

/**
 * 自定义标题栏示例
 */
@ComponentV2
export struct CustomTitleBarExample {
  @Local navPathStack: NavPathStack = new NavPathStack()

  build() {
    Column({ space: 16 }) {
      Text('自定义标题栏')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Navigation(this.navPathStack) {
        Button('打开自定义标题栏页面')
          .onClick(() => {
            this.navPathStack.pushPathByName('CustomTitlePage', null)
          })
      }
      .navDestination(this.PageBuilder)
      .height(350)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }

  @Builder
  PageBuilder(name: string, params: Object) {
    if (name === 'CustomTitlePage') {
      NavDestination() {
        Column() {
          Text('页面内容区域')
            .fontSize(16)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .title('自定义标题')
      .subtitle('副标题说明')
      .leading(() => {
        Button('返回')
          .fontSize(14)
          .type(ButtonType.Normal)
          .onClick(() => {
            this.navPathStack.pop()
          })
      })
      .trailing(() => {
        Row({ space: 8 }) {
          Button('分享')
            .fontSize(14)
            .type(ButtonType.Normal)
          Button('更多')
            .fontSize(14)
            .type(ButtonType.Normal)
        }
      })
    }
  }
}

/**
 * 隐藏标题栏示例
 */
@ComponentV2
export struct HideTitleBarExample {
  @Local navPathStack: NavPathStack = new NavPathStack()

  build() {
    Column({ space: 16 }) {
      Text('隐藏标题栏')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Navigation(this.navPathStack) {
        Button('打开无标题栏页面')
          .onClick(() => {
            this.navPathStack.pushPathByName('NoTitlePage', null)
          })
      }
      .navDestination(this.PageBuilder)
      .height(350)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }

  @Builder
  PageBuilder(name: string, params: Object) {
    if (name === 'NoTitlePage') {
      NavDestination() {
        Column({ space: 16 }) {
          Text('无标题栏页面')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          Text('这个页面隐藏了系统标题栏')
            .fontSize(14)
            .fontColor('#666666')

          Button('关闭页面')
            .onClick(() => {
              this.navPathStack.pop()
            })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .hideTitleBar(true)
    }
  }
}

/**
 * 页面栈操作示例
 */
@ComponentV2
export struct StackOperationsExample {
  @Local navPathStack: NavPathStack = new NavPathStack()
  @Local stackSize: number = 1
  @Local stackInfo: string = '首页'

  build() {
    Column({ space: 16 }) {
      Text('页面栈操作')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Navigation(this.navPathStack) {
        Column({ space: 12 }) {
          Text(`当前栈大小: ${this.stackSize}`)
            .fontSize(14)
          Text(`${this.stackInfo}`)
            .fontSize(12)
            .fontColor('#666666')

          Row({ space: 8 }) {
            Button('Push A')
              .fontSize(14)
              .onClick(() => {
                this.navPathStack.pushPathByName('PageA', null)
                this.updateStackInfo()
              })

            Button('Push B')
              .fontSize(14)
              .onClick(() => {
                this.navPathStack.pushPathByName('PageB', null)
                this.updateStackInfo()
              })
          }

          Row({ space: 8 }) {
            Button('Pop')
              .fontSize(14)
              .onClick(() => {
                this.navPathStack.pop()
                this.updateStackInfo()
              })

            Button('PopTo A')
              .fontSize(14)
              .onClick(() => {
                this.navPathStack.popToName('PageA')
                this.updateStackInfo()
              })
          }

          Button('Clear Stack')
            .fontSize(14)
            .backgroundColor('#FF6B6B')
            .onClick(() => {
              this.navPathStack.clear()
              this.updateStackInfo()
            })
        }
      }
      .navDestination(this.PageBuilder)
      .height(350)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }

  @Builder
  PageBuilder(name: string, params: Object) {
    if (name === 'PageA') {
      NavDestination() {
        Column({ space: 12 }) {
          Text('页面 A')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          Button('返回')
            .onClick(() => {
              this.navPathStack.pop()
              this.updateStackInfo()
            })
          Button('Replace 为 B')
            .onClick(() => {
              this.navPathStack.replacePathByName('PageB', null)
              this.updateStackInfo()
            })
        }
        .width('100%')
        .padding(20)
      }
      .title('Page A')
    } else if (name === 'PageB') {
      NavDestination() {
        Column({ space: 12 }) {
          Text('页面 B')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          Button('返回')
            .onClick(() => {
              this.navPathStack.pop()
              this.updateStackInfo()
            })
        }
        .width('100%')
        .padding(20)
      }
      .title('Page B')
    }
  }

  private updateStackInfo(): void {
    this.stackSize = this.navPathStack.size()
    const names = this.navPathStack.getAllPathName()
    this.stackInfo = `栈: ${names.join(' -> ')}`
  }
}

/**
 * 页面参数传递示例
 */
@ComponentV2
export struct ParamsPassingExample {
  @Local navPathStack: NavPathStack = new NavPathStack()

  build() {
    Column({ space: 16 }) {
      Text('页面参数传递')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Navigation(this.navPathStack) {
        Column({ space: 12 }) {
          Button('传递用户信息')
            .onClick(() => {
              interface UserInfo {
                id: number
                name: string
                role: string
                department: string
              }
              const params: UserInfo = {
                id: 1001,
                name: '张三',
                role: '管理员',
                department: '技术部'
              }
              this.navPathStack.pushPathByName('UserInfoPage', params as Object)
            })

          Button('传递商品信息')
            .onClick(() => {
              interface ProductInfo {
                productId: string
                name: string
                price: number
                stock: number
              }
              const params: ProductInfo = {
                productId: 'P12345',
                name: 'iPhone 15 Pro',
                price: 7999,
                stock: 100
              }
              this.navPathStack.pushPathByName('ProductInfoPage', params as Object)
            })
        }
      }
      .navDestination(this.PageBuilder)
      .height(350)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }

  @Builder
  PageBuilder(name: string, params: Object) {
    if (name === 'UserInfoPage') {
      NavDestination() {
        Column({ space: 12 }) {
          Text('用户信息')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)

          ForEach(Object.entries(params), (entry: [string, Object], index: number) => {
            Row({ space: 8 }) {
              Text(`${entry[0]}:`)
                .fontSize(14)
                .fontColor('#666666')
                .width(80)
              Text(`${entry[1]}`)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
            })
            .width('100%')
          })

          Button('返回')
            .onClick(() => {
              this.navPathStack.pop()
            })
        }
        .width('100%')
        .padding(20)
      }
      .title('用户详情')
    } else if (name === 'ProductInfoPage') {
      NavDestination() {
        Column({ space: 12 }) {
          Text('商品信息')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)

          ForEach(Object.entries(params), (entry: [string, Object], index: number) => {
            Row({ space: 8 }) {
              Text(`${entry[0]}:`)
                .fontSize(14)
                .fontColor('#666666')
                .width(100)
              Text(`${entry[1]}`)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
            }
            .width('100%')
          })

          Button('返回')
            .onClick(() => {
              this.navPathStack.pop()
            })
        }
        .width('100%')
        .padding(20)
      }
      .title('商品详情')
    }
  }
}

/**
 * NavDestination 原始示例（保留兼容性）
 */
@ComponentV2
export struct NavDestinationExample {
  @Local navPathStack: NavPathStack = new NavPathStack()

  build() {
    Column({ space: 16 }) {
      Text('NavDestination 示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Navigation(this.navPathStack) {
        Button('打开 NavDestination')
          .onClick(() => {
            this.navPathStack.pushPathByName('MyDestination', null)
          })
      }
      .navDestination(this.PageBuilder)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }

  @Builder
  PageBuilder(name: string, params: Object) {
    if (name === 'MyDestination') {
      NavDestination() {
        Column({ space: 12 }) {
          Text('目标页面')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          Text('这是 NavDestination 的内容')
            .fontSize(14)
          Button('返回')
            .onClick(() => {
              this.navPathStack.pop()
            })
        }
        .width('100%')
        .padding(20)
      }
      .title('页面标题')
      .mode(NavDestinationMode.STANDARD)
    }
  }
}

/**
 * 主页面 - 整合所有导航组件示例
 */
@ComponentV2
export struct NavigationExamplePage {
  build() {
    Scroll() {
      Column({ space: 20 }) {
        Text('Navigation Component Examples')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .padding({ left: 16, right: 16, top: 16, bottom: 8 })

        NavigationBasicExample()
        NavDestinationStandardExample()
        NavDestinationDialogExample()
        CustomTitleBarExample()
        HideTitleBarExample()
        StackOperationsExample()
        ParamsPassingExample()
        NavDestinationExample()
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
