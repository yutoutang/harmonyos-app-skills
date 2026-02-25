/**
 * FormLink Component Examples
 * OpenHarmony 表单链接组件使用示例
 *
 * 注意：FormLink 是专门用于 ArkTS 卡片（Widget）开发的组件
 * 在普通页面中不可用，此处展示如何模拟类似交互效果
 *
 * FormLink 实际用法：
 * FormLink 只能在卡片环境中使用，配合 postCardAction 实现
 * 三种交互模式：router（导航）、message（消息）、call（调用）
 */

// 定义接口类型
interface TodoItem {
  id: string
  title: string
  desc: string
  completed: boolean
}

interface NewsItem {
  id: string
  title: string
  summary: string
  time: string
}

/**
 * 基础链接效果示例
 * 模拟 FormLink 在静态卡片中的基础用法
 * 实际开发中应使用 FormLink + postCardAction
 */
@ComponentV2
export struct BasicTextLinkExample {
  @Local cityName: string = '北京'
  @Local temperature: string = '25°C'
  @Local weather: string = '晴'

  build() {
    Column({ space: 12 }) {
      Text('天气预报')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Text(this.cityName)
        .fontSize(16)
        .margin({ top: 8 })

      Text(`${this.temperature} ${this.weather}`)
        .fontSize(24)
        .margin({ top: 4 })

      // 模拟 FormLink 的链接效果
      // 在实际卡片中使用：FormLink({ action: 'router', params: {...} })
      Row() {
        Text('查看详情 >')
          .fontSize(14)
          .fontColor('#007DFF')
      }
      .padding(8)
      .backgroundColor('#E3F2FD')
      .borderRadius(4)
      .onClick(() => {
        // 模拟 postCardAction 调用
        console.info('[FormLink模拟] Navigate to weather detail')
        console.info(`[FormLink模拟] Params: city=${this.cityName}`)
        console.info('[卡片开发提示] 实际使用示例：')
        console.info('postCardAction(this, {')
        console.info('  action: "router",')
        console.info('  abilityName: "EntryAbility",')
        console.info('  params: { city: "北京" }')
        console.info('})')
      })
      .margin({ top: 12 })
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#E3F2FD')
    .borderRadius(12)
  }
}

/**
 * 快捷操作示例
 * 模拟卡片中的快捷操作按钮
 */
@ComponentV2
export struct QuickActionsExample {
  @Local likeCount: number = 128
  @Local favoriteCount: number = 56

  build() {
    Column({ space: 16 }) {
      Text('快捷操作')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)

      Row({ space: 20 }) {
        // 点赞按钮（模拟 message 事件）
        Column({ space: 4 }) {
          Text('\uE642') // 心形图标
            .fontSize(24)
            .fontColor('#FF0000')
          Text('点赞')
            .fontSize(12)
            .fontColor('#666666')
          Text(`${this.likeCount}`)
            .fontSize(10)
            .fontColor('#999999')
        }
        .width(60)
        .height(80)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#FAFAFA')
        .borderRadius(8)
        .onClick(() => {
          this.likeCount++
          console.info('[FormLink模拟] Like action')
          console.info('[卡片开发] postCardAction(this, { action: "message", params: { type: "like" } })')
        })

        // 收藏按钮
        Column({ space: 4 }) {
          Text('\uE643') // 星形图标
            .fontSize(24)
            .fontColor('#FFC107')
          Text('收藏')
            .fontSize(12)
            .fontColor('#666666')
          Text(`${this.favoriteCount}`)
            .fontSize(10)
            .fontColor('#999999')
        }
        .width(60)
        .height(80)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#FAFAFA')
        .borderRadius(8)
        .onClick(() => {
          this.favoriteCount++
          console.info('[FormLink模拟] Favorite action')
          console.info('[卡片开发] postCardAction(this, { action: "message", params: { type: "favorite" } })')
        })

        // 分享按钮（模拟 router 事件）
        Column({ space: 4 }) {
          Text('\uE644') // 分享图标
            .fontSize(24)
            .fontColor('#007DFF')
          Text('分享')
            .fontSize(12)
            .fontColor('#666666')
        }
        .width(60)
        .height(80)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#FAFAFA')
        .borderRadius(8)
        .onClick(() => {
          console.info('[FormLink模拟] Share action')
          console.info('[卡片开发] postCardAction(this, { action: "router", abilityName: "EntryAbility", params: { action: "share" } })')
        })
      }
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * 待办事项列表示例
 * 模拟卡片列表项的链接交互
 */
@ComponentV2
export struct TodoListExample {
  @Local todos: TodoItem[] = [
    { id: '1', title: '待办事项1', desc: '完成项目报告', completed: false },
    { id: '2', title: '待办事项2', desc: '团队会议', completed: false },
    { id: '3', title: '待办事项3', desc: '代码审查', completed: true }
  ]

  build() {
    Column({ space: 8 }) {
      Text('待办清单')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      ForEach(this.todos, (todo: TodoItem) => {
        Row()
          .onClick(() => {
            console.info(`[FormLink模拟] Open todo: ${todo.id}`)
            console.info('[卡片开发] postCardAction(this, {')
            console.info('  action: "router",')
            console.info('  abilityName: "EntryAbility",')
            console.info(`  params: { todoId: "${todo.id}" }`)
            console.info('})')
          })
          .width('100%')
          .padding(12)
          .backgroundColor('#F8F8F8')
          .borderRadius(8) {
          Column({ space: 4 }) {
            Text(todo.title)
              .fontSize(16)
              .fontColor('#333333')
              .decoration({
                type: todo.completed ? TextDecorationType.LineThrough : TextDecorationType.None
              })
            Text(todo.desc)
              .fontSize(12)
              .fontColor('#999999')
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Text('\uE645') // 箭头图标
            .fontSize(16)
            .fontColor('#CCCCCC')
        }
      }, (todo: TodoItem) => todo.id)
    }
    .width('100%')
    .height('100%')
    .padding(12)
    .backgroundColor('#FFFFFF')
  }
}

/**
 * 音乐控制卡片示例
 * 模拟卡片中的媒体控制
 */
@ComponentV2
export struct MusicControlExample {
  @Local isPlaying: boolean = false
  @Local songName: string = '夜曲'
  @Local artist: string = '周杰伦'

  build() {
    Column({ space: 16 }) {
      // 歌曲信息（可点击跳转）
      Column({ space: 4 })
        .onClick(() => {
          console.info('[FormLink模拟] Navigate to player page')
          console.info('[卡片开发] postCardAction(this, {')
          console.info('  action: "router",')
          console.info('  abilityName: "EntryAbility",')
          console.info('  params: { page: "player" }')
          console.info('})')
        }) {
        Text(this.songName)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
        Text(this.artist)
          .fontSize(14)
          .fontColor('#666666')
      }

      // 控制按钮
      Row({ space: 32 }) {
        // 上一曲
        Text('\uE646') // 上一曲图标
          .fontSize(24)
          .fontColor('#333333')
          .onClick(() => {
            console.info('[FormLink模拟] Previous track')
            console.info('[卡片开发] postCardAction(this, { action: "message", params: { action: "previous" } })')
          })

        // 播放/暂停
        Text(this.isPlaying ? '\uE647' : '\uE648')
          .fontSize(32)
          .fontColor('#007DFF')
          .onClick(() => {
            this.isPlaying = !this.isPlaying
            console.info(`[FormLink模拟] ${this.isPlaying ? 'Play' : 'Pause'}`)
            console.info('[卡片开发] postCardAction(this, {')
            console.info(`  action: "message",`)
            console.info(`  params: { action: "${this.isPlaying ? 'play' : 'pause'}" }`)
            console.info('})')
          })

        // 下一曲
        Text('\uE649') // 下一曲图标
          .fontSize(24)
          .fontColor('#333333')
          .onClick(() => {
            console.info('[FormLink模拟] Next track')
            console.info('[卡片开发] postCardAction(this, { action: "message", params: { action: "next" } })')
          })
      }
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#F8F8F8')
    .borderRadius(16)
  }
}

/**
 * 新闻卡片示例
 * 模拟新闻卡片和阅读链接
 */
@ComponentV2
export struct NewsCardExample {
  @Local news: NewsItem = {
    id: '001',
    title: '鸿蒙系统 6.0 正式发布，带来全新体验',
    summary: '华为今日正式发布了鸿蒙系统 6.0 版本，新系统在性能、安全性和用户体验方面都有显著提升...',
    time: '2小时前'
  }

  build() {
    Column({ space: 12 }) {
      // 新闻标题
      Text(this.news.title)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      // 新闻摘要
      Text(this.news.summary)
        .fontSize(14)
        .fontColor('#666666')
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      // 时间和阅读链接
      Row() {
        Text(this.news.time)
          .fontSize(12)
          .fontColor('#999999')
          .layoutWeight(1)

        Row({ space: 4 })
          .onClick(() => {
            console.info(`[FormLink模拟] Read full article: ${this.news.id}`)
            console.info('[卡片开发] postCardAction(this, {')
            console.info('  action: "router",')
            console.info('  abilityName: "EntryAbility",')
            console.info(`  params: { newsId: "${this.news.id}" }`)
            console.info('})')
          }) {
          Text('阅读全文')
            .fontSize(14)
            .fontColor('#007DFF')
            .decoration({ type: TextDecorationType.Underline })
        }
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .shadow({
      radius: 8,
      color: '#1F000000',
      offsetX: 0,
      offsetY: 2
    })
  }
}

/**
 * 电商快捷入口示例
 * 模拟电商卡片快捷入口
 */
@ComponentV2
export struct ShopShortcutsExample {
  @Local cartCount: number = 3

  build() {
    Column({ space: 12 }) {
      Text('快捷入口')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)

      Row({ space: 12 }) {
        // 我的订单
        Column({ space: 4 }) {
          Text('\uE64A') // 订单图标
            .fontSize(24)
            .fontColor('#007DFF')
          Text('我的订单')
            .fontSize(12)
            .fontColor('#333333')
        }
        .layoutWeight(1)
        .height(80)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#FAFAFA')
        .borderRadius(8)
        .onClick(() => {
          console.info('[FormLink模拟] Navigate to orders')
          console.info('[卡片开发] postCardAction(this, { action: "router", params: { page: "orders" } })')
        })

        // 购物车
        Column({ space: 4 }) {
          Text('\uE64B') // 购物车图标
            .fontSize(24)
            .fontColor('#FF5722')
          Text('购物车')
            .fontSize(12)
            .fontColor('#333333')
          if (this.cartCount > 0) {
            Text(`${this.cartCount}`)
              .fontSize(10)
              .fontColor('#FF5722')
          }
        }
        .layoutWeight(1)
        .height(80)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#FAFAFA')
        .borderRadius(8)
        .onClick(() => {
          console.info('[FormLink模拟] Navigate to cart')
          console.info(`[FormLink模拟] Items in cart: ${this.cartCount}`)
          console.info('[卡片开发] postCardAction(this, { action: "router", params: { page: "cart" } })')
        })

        // 客服
        Column({ space: 4 }) {
          Text('\uE64C') // 客服图标
            .fontSize(24)
            .fontColor('#28A745')
          Text('客服')
            .fontSize(12)
            .fontColor('#333333')
        }
        .layoutWeight(1)
        .height(80)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#FAFAFA')
        .borderRadius(8)
        .onClick(() => {
          console.info('[FormLink模拟] Contact customer service')
          console.info('[卡片开发] postCardAction(this, { action: "call", params: { method: "openSupport" } })')
        })
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#FAFAFA')
    .borderRadius(12)
  }
}

/**
 * 图片链接示例
 * 模拟卡片中的图片链接
 */
@ComponentV2
export struct ImageLinkExample {
  @Local imageUrl: string = 'example_image.jpg'

  build() {
    Column({ space: 12 }) {
      Text('图片链接')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Column()
        .onClick(() => {
          console.info('[FormLink模拟] View full image')
          console.info('[卡片开发] postCardAction(this, { action: "router", params: { mode: "image_fullscreen" } })')
        })
        .width('100%')
        .height(120)
        .backgroundColor('#E0E0E0')
        .justifyContent(FlexAlign.Center)
        .borderRadius(8) {
        Text('📷')
          .fontSize(48)
        Text('点击查看大图')
          .fontSize(14)
          .fontColor('#FFFFFF')
          .margin({ top: 8 })
      }

      Row({ space: 8 })
        .onClick(() => {
          console.info('[FormLink模拟] Download image')
          console.info('[卡片开发] postCardAction(this, { action: "message", params: { action: "download" } })')
        })
        .margin({ top: 8 }) {
        Text('\uE64D') // 下载图标
          .fontSize(16)
          .fontColor('#007DFF')
        Text('下载图片')
          .fontSize(14)
          .fontColor('#007DFF')
      }
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * 健康数据卡片示例
 * 模拟健康数据卡片
 */
@ComponentV2
export struct HealthDataExample {
  @Local steps: number = 8542
  @Local calories: number = 356
  @Local distance: number = 5.2

  build() {
    Column({ space: 16 }) {
      Text('今日运动')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        Column({ space: 4 }) {
          Text(`${this.steps}`)
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#007DFF')
          Text('步数')
            .fontSize(12)
            .fontColor('#666666')
        }
        .layoutWeight(1)

        Column({ space: 4 }) {
          Text(`${this.calories}`)
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FF5722')
          Text('千卡')
            .fontSize(12)
            .fontColor('#666666')
        }
        .layoutWeight(1)

        Column({ space: 4 }) {
          Text(`${this.distance}`)
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#28A745')
          Text('公里')
            .fontSize(12)
            .fontColor('#666666')
        }
        .layoutWeight(1)
      }
      .width('100%')

      Row({ space: 4 })
        .onClick(() => {
          console.info('[FormLink模拟] View detailed health data')
          console.info(`[FormLink模拟] Steps: ${this.steps}, Calories: ${this.calories}`)
          console.info('[卡片开发] postCardAction(this, { action: "router", params: { page: "health_detail" } })')
        })
        .width('100%')
        .justifyContent(FlexAlign.Center) {
        Text('查看详细数据')
          .fontSize(14)
          .fontColor('#007DFF')
        Text('\uE645')
          .fontSize(14)
          .fontColor('#007DFF')
          .margin({ left: 4 })
      }
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#F0F8FF')
    .borderRadius(12)
  }
}

/**
 * FormLink API 说明卡片
 * 展示 FormLink 的实际用法和注意事项
 */
@ComponentV2
export struct FormLinkApiInfo {
  build() {
    Column({ space: 12 }) {
      Text('FormLink 使用说明')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FF5722')

      Text('FormLink 是 ArkTS 卡片专用组件')
        .fontSize(14)
        .fontColor('#666666')

      Divider()
        .color('#E0E0E0')

      Text('实际使用方法：')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)

      Text('FormLink({ action: "router" }) {')
        .fontSize(12)
        .fontColor('#007DFF')
        .fontFamily('monospace')

      Text('  Text("点击跳转")')
        .fontSize(12)
        .fontColor('#007DFF')
        .fontFamily('monospace')
        .margin({ left: 16 })

      Text('}')
        .fontSize(12)
        .fontColor('#007DFF')
        .fontFamily('monospace')

      Divider()
        .color('#E0E0E0')

      Text('交互模式：')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)

      Text('• router - 跳转到应用页面')
        .fontSize(14)
        .fontColor('#666666')

      Text('• message - 发送消息到应用')
        .fontSize(14)
        .fontColor('#666666')

      Text('• call - 调用应用方法 (API 20+)')
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFF3E0')
    .borderRadius(12)
  }
}

/**
 * 完整的 FormLink 示例页面
 * 集成所有 FormLink 模拟示例
 */
@ComponentV2
export struct FormLinkExamplePage {
  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          Text('FormLink Component Examples')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .padding({ left: 16, right: 16, top: 16, bottom: 8 })

          FormLinkApiInfo()
            .padding({ left: 16, right: 16 })

          BasicTextLinkExample()
            .padding({ left: 16, right: 16 })

          QuickActionsExample()
            .padding({ left: 16, right: 16 })

          TodoListExample()
            .padding({ left: 16, right: 16 })

          MusicControlExample()
            .padding({ left: 16, right: 16 })

          NewsCardExample()
            .padding({ left: 16, right: 16 })

          ShopShortcutsExample()
            .padding({ left: 16, right: 16 })

          ImageLinkExample()
            .padding({ left: 16, right: 16 })

          HealthDataExample()
            .padding({ left: 16, right: 16 })
            .padding({ bottom: 16 })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
    }
    .title('FormLink 表单链接')
    .mode(NavDestinationMode.STANDARD)
  }
}

@Builder
export function FormLinkExamplePageBuilder() {
  FormLinkExamplePage()
}
