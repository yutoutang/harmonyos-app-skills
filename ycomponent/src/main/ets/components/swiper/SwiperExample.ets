/**
 * Swiper Component Examples
 * OpenHarmony 轮播组件使用示例
 *
 * 展示 Swiper 组件的各种用法：
 * - 基础轮播图
 * - 自动播放
 * - 自定义指示器
 * - 垂直滑动
 * - 多卡片显示
 * - 程序化控制
 * - 自定义动画
 * - 引导页效果
 */
import { curves } from '@kit.ArkUI'

/**
 * 基础轮播图示例
 * 展示 Swiper 的基本用法和自动播放功能
 */
@ComponentV2
export struct SwiperBasicExample {
  @Local currentIndex: number = 0
  @Local autoPlay: boolean = true
  private timer: number = -1

  build() {
    Column({ space: 16 }) {
      // 标题
      Text('基础轮播图')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      // Swiper 轮播图
      Swiper() {
        ForEach([1, 2, 3, 4], (item: number) => {
          Column() {
            Text(`Banner ${item}`)
              .fontSize(32)
              .fontColor(Color.White)
              .fontWeight(FontWeight.Bold)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .backgroundColor(`#${item * 50}E0E0`)
        }, (item: number) => `banner_${item}`)
      }
      .width('100%')
      .height(200)
      .loop(true)
      .autoPlay(this.autoPlay)
      .interval(3000)
      .duration(400)
      .indicator(true)
      .onChange((index: number) => {
        this.currentIndex = index
      })

      // 当前索引显示
      Row({ space: 12 }) {
        Text(`当前索引: ${this.currentIndex}`)
          .fontSize(16)
          .fontColor('#333333')

        Button(this.autoPlay ? '暂停播放' : '开始播放')
          .fontSize(14)
          .onClick(() => {
            this.autoPlay = !this.autoPlay
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 自定义指示器示例
 * 展示如何自定义指示器的样式和位置
 */
@ComponentV2
export struct SwiperCustomIndicatorExample {
  @Local currentIndex: number = 0

  build() {
    Column({ space: 16 }) {
      Text('自定义指示器')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      // 自定义指示器样式
      Swiper() {
        ForEach([1, 2, 3], (item: number) => {
          Column() {
            Column() {
              Text(`Page ${item}`)
                .fontSize(30)
                .fontColor(Color.White)
                .fontWeight(FontWeight.Bold)
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .backgroundColor(`#${item * 80}FF80`)
          }
        }, (item: number) => `page_${item}`)
      }
      .width('100%')
      .height(180)
      .loop(true)
      .indicator(true)
      .indicatorStyle({
        left: 16,
        bottom: 16,
        color: Color.White,
        selectedColor: '#FF6B6B',
        size: 8
      })
      .onChange((index: number) => {
        this.currentIndex = index
      })

      // 数字指示器
      Row() {
        Text(`${this.currentIndex + 1}/3`)
          .fontSize(14)
          .fontColor('#666666')
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 垂直滑动示例
 * 展示垂直方向的 Swiper 用法
 */
@ComponentV2
export struct SwiperVerticalExample {
  @Local currentIndex: number = 0

  build() {
    Column({ space: 16 }) {
      Text('垂直滑动')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Swiper() {
        ForEach(['Page 1', 'Page 2', 'Page 3', 'Page 4'], (item: string, index: number) => {
          Column() {
            Column() {
              Text(item)
                .fontSize(30)
                .fontWeight(FontWeight.Bold)
              Text(`垂直滑动页面 ${index + 1}`)
                .fontSize(16)
                .margin({ top: 8 })
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .backgroundColor(index % 2 === 0 ? '#E0F7FA' : '#E1F5FE')
          }
        }, (item: string) => `vertical_${item}`)
      }
      .width('100%')
      .height(300)
      .vertical(true)
      .indicator(true)
      .indicatorStyle({
        right: 16,
        color: '#B0BEC5',
        selectedColor: '#00BCD4'
      })
      .onChange((index: number) => {
        this.currentIndex = index
      })

      Text(`当前页面: ${this.currentIndex + 1}`)
        .fontSize(16)
        .width('100%')
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 多卡片同时显示示例
 * 展示 displayCount 和 itemSpace 的用法
 */
@ComponentV2
export struct SwiperMultipleCardsExample {
  @Local datas: string[] = ['Card 1', 'Card 2', 'Card 3', 'Card 4', 'Card 5']
  @Local currentIndex: number = 0

  build() {
    Column({ space: 16 }) {
      Text('多卡片同时显示')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Swiper() {
        ForEach(this.datas, (item: string) => {
          Column() {
            Column({ space: 12 }) {
              Text(item)
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')

              Text('卡片内容')
                .fontSize(14)
                .fontColor('#999999')
            }
            .width('100%')
            .height(180)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .shadow({
              radius: 8,
              color: '#1F000000',
              offsetX: 0,
              offsetY: 2
            })
            .justifyContent(FlexAlign.Center)
            .padding(16)
          }
        }, (item: string) => `card_${item}`)
      }
      .width('100%')
      .height(220)
      .loop(true)
      .displayCount(2)
      .itemSpace(16)
      .prevMargin(16)
      .nextMargin(16)
      .indicator(false)
      .onChange((index: number) => {
        this.currentIndex = index
      })

      Row({ space: 12 }) {
        Text(`当前: ${this.datas[this.currentIndex]}`)
          .fontSize(16)
          .fontColor('#666666')
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 程序化控制示例
 * 展示使用 SwiperController 进行程序化控制
 */
@ComponentV2
export struct SwiperControllerExample {
  @Local currentIndex: number = 0
  @Local message: string = '点击按钮控制轮播'
  swiperController: SwiperController = new SwiperController()

  build() {
    Column({ space: 16 }) {
      Text('程序化控制')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Swiper(this.swiperController) {
        ForEach(['Page 1', 'Page 2', 'Page 3', 'Page 4', 'Page 5'], (item: string) => {
          Column() {
            Column() {
              Text(item)
                .fontSize(30)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.White)
            }
            .width('100%')
            .height(200)
            .justifyContent(FlexAlign.Center)
            .backgroundColor('#FF6B6B')
          }
        }, (item: string) => `control_${item}`)
      }
      .width('100%')
      .height(200)
      .loop(false)
      .indicator(true)
      .index(this.currentIndex)
      .onChange((index: number) => {
        this.currentIndex = index
        this.message = `切换到页面 ${index + 1}`
      })

      // 消息提示
      Text(this.message)
        .fontSize(14)
        .fontColor('#666666')
        .width('100%')
        .textAlign(TextAlign.Center)
        .height(40)

      // 控制按钮
      Row({ space: 12 }) {
        Button('上一页')
          .type(ButtonType.Normal)
          .fontSize(14)
          .onClick(() => {
            this.swiperController.showPrevious()
          })

        Button('下一页')
          .type(ButtonType.Normal)
          .fontSize(14)
          .onClick(() => {
            this.swiperController.showNext()
          })

        Button('跳转第3页')
          .type(ButtonType.Normal)
          .fontSize(14)
          .onClick(() => {
            this.swiperController.changeIndex(2)
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 自定义动画曲线示例
 * 展示如何使用不同的动画曲线
 */
@ComponentV2
export struct SwiperCustomCurveExample {
  @Local curveType: string = 'EaseInOut'
  @Local duration: number = 400

  build() {
    Column({ space: 16 }) {
      Text('自定义动画曲线')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      // 动画时长控制
      Row({ space: 12 }) {
        Text('动画时长:')
          .fontSize(14)
          .fontColor('#666666')

        Slider({
          value: this.duration,
          min: 200,
          max: 1000,
          step: 100,
          style: SliderStyle.OutSet
        })
          .layoutWeight(1)
          .onChange((value: number) => {
            this.duration = value
          })

        Text(`${this.duration}ms`)
          .fontSize(14)
          .fontColor('#666666')
      }
      .width('100%')

      // 曲线类型选择
      Row({ space: 8 }) {
        ForEach(['Ease', 'EaseInOut', 'Spring'], (curve: string) => {
          Button(curve)
            .type(ButtonType.Normal)
            .fontSize(12)
            .backgroundColor(this.curveType === curve ? '#FF6B6B' : '#E0E0E0')
            .fontColor(this.curveType === curve ? Color.White : '#333333')
            .onClick(() => {
              this.curveType = curve
            })
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)

      // Swiper
      Swiper() {
        ForEach([1, 2, 3, 4], (item: number) => {
          Column() {
            Column() {
              Text(`Page ${item}`)
                .fontSize(30)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.White)
            }
            .width('100%')
            .height(180)
            .justifyContent(FlexAlign.Center)
            .backgroundColor(`#${item * 60}FF60`)
          }
        }, (item: number) => `curve_${item}`)
      }
      .width('100%')
      .height(180)
      .curve(this.curveType === 'Spring' ? Curve.FastOutSlowIn : Curve.EaseInOut)
      .duration(this.duration)
      .indicator(true)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 禁用手势滑动示例
 * 展示如何禁用手势滑动，只通过按钮控制
 */
@ComponentV2
export struct SwiperDisableSwipeExample {
  @Local currentIndex: number = 0
  swiperController: SwiperController = new SwiperController()

  build() {
    Column({ space: 16 }) {
      Text('禁用手势滑动')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Swiper(this.swiperController) {
        ForEach(['Slide 1', 'Slide 2', 'Slide 3'], (item: string) => {
          Column() {
            Column() {
              Text(item)
                .fontSize(30)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.White)
              Text('手势已禁用')
                .fontSize(14)
                .fontColor(Color.White)
                .margin({ top: 8 })
            }
            .width('100%')
            .height(200)
            .justifyContent(FlexAlign.Center)
            .backgroundColor('#4DB6AC')
          }
        }, (item: string) => `disable_${item}`)
      }
      .width('100%')
      .height(200)
      .disableSwipe(true)
      .indicator(true)
      .index(this.currentIndex)
      .onChange((index: number) => {
        this.currentIndex = index
      })

      Row({ space: 12 }) {
        Button('上一页')
          .type(ButtonType.Normal)
          .onClick(() => {
            this.swiperController.showPrevious()
          })

        Button('下一页')
          .type(ButtonType.Normal)
          .onClick(() => {
            this.swiperController.showNext()
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 商品卡片轮播示例
 * 展示实际应用场景 - 商品推荐
 */
@ComponentV2
export struct SwiperProductCardExample {
  @Local products: ProductItem[] = [
    { id: 1, name: '精选商品 1', price: '¥199', discount: '热销' },
    { id: 2, name: '精选商品 2', price: '¥299', discount: '新品' },
    { id: 3, name: '精选商品 3', price: '¥399', discount: '优惠' },
    { id: 4, name: '精选商品 4', price: '¥499', discount: '限时' },
  ]

  build() {
    Column({ space: 16 }) {
      Text('商品推荐')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Swiper() {
        ForEach(this.products, (product: ProductItem) => {
          Column() {
            Column({ space: 12 }) {
              // 商品图片占位
              Stack() {
                Column() {
                  Text('商品图片')
                    .fontSize(16)
                    .fontColor('#999999')
                }
                .width('100%')
                .height(160)
                .backgroundColor('#F5F5F5')
                .justifyContent(FlexAlign.Center)

                // 折扣标签
                Text(product.discount)
                  .fontSize(12)
                  .fontColor(Color.White)
                  .backgroundColor('#FF6B6B')
                  .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                  .borderRadius({ topLeft: 12, bottomRight: 12 })
              }
              .alignContent(Alignment.TopStart)

              // 商品信息
              Column({ space: 8 }) {
                Text(product.name)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#333333')
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })

                Text(product.price)
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#FF6B6B')
              }
              .alignItems(HorizontalAlign.Start)
              .width('100%')
              .padding({ left: 16, right: 16, bottom: 16 })
            }
            .width('100%')
            .height(260)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .shadow({
              radius: 8,
              color: '#1F000000',
              offsetX: 0,
              offsetY: 2
            })
          }
        }, (product: ProductItem) => `product_${product.id}`)
      }
      .width('100%')
      .height(280)
      .loop(true)
      .autoPlay(true)
      .interval(3000)
      .displayCount(1.2)
      .prevMargin(16)
      .nextMargin(16)
      .itemSpace(16)
      .indicator(false)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 商品数据接口
 */
interface ProductItem {
  id: number
  name: string
  price: string
  discount: string
}

/**
 * 引导页示例
 * 展示典型的应用引导页效果
 */
@ComponentV2
export struct SwiperOnboardingExample {
  @Local currentPage: number = 0
  private swiperController: SwiperController = new SwiperController()
  private totalPages: number = 3

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Swiper(this.swiperController) {
        ForEach([
          { title: '欢迎使用', desc: '探索 HarmonyOS 的精彩世界', color: '#FF6B6B' },
          { title: '丰富功能', desc: '体验流畅的原生组件', color: '#4ECDC4' },
          { title: '立即开始', desc: '开启您的开发之旅', color: '#95E1D3' }
        ], (page: OnboardingPage, index: number) => {
          Column() {
            Column({ space: 24 }) {
              // 图标占位
              Column() {
                Text('\uE6E0')
                  .fontSize(80)
                  .fontColor(Color.White)
              }
              .width(120)
              .height(120)
              .backgroundColor('rgba(255, 255, 255, 0.3)')
              .borderRadius(60)
              .justifyContent(FlexAlign.Center)

              Text(page.title)
                .fontSize(28)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.White)

              Text(page.desc)
                .fontSize(16)
                .fontColor('rgba(255, 255, 255, 0.9)')
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .backgroundColor(page.color)
          }
        }, (page: OnboardingPage, index: number) => `onboarding_${index}`)
      }
      .width('100%')
      .height('100%')
      .loop(false)
      .indicator(false)
      .onChange((index: number) => {
        this.currentPage = index
      })

      // 自定义指示器和按钮
      Column({ space: 20 }) {
        // 自定义指示器
        Row({ space: 12 }) {
          ForEach([0, 1, 2], (index: number) => {
            Column()
              .width(this.currentPage === index ? 24 : 8)
              .height(8)
              .borderRadius(4)
              .backgroundColor(this.currentPage === index ? '#FFFFFF' : 'rgba(255, 255, 255, 0.5)')
              .animation({ duration: 300 })
          })
        }
        .margin({ bottom: 20 })

        // 跳过/完成按钮
        if (this.currentPage < this.totalPages - 1) {
          Button('跳过')
            .fontSize(16)
            .backgroundColor('rgba(255, 255, 255, 0.3)')
            .fontColor(Color.White)
            .borderRadius(20)
            .onClick(() => {
              this.swiperController.changeIndex(this.totalPages - 1)
            })
        } else {
          Button('立即开始')
            .fontSize(16)
            .backgroundColor('#FFFFFF')
            .fontColor('#FF6B6B')
            .borderRadius(20)
            .onClick(() => {
              // 跳转到主页
            })
        }
      }
      .width('100%')
      .padding(32)
      .backgroundColor('rgba(0, 0, 0, 0.1)')
    }
    .width('100%')
    .height(400)
    .borderRadius(12)
    .clip(true)
  }
}

/**
 * 引导页数据接口
 */
interface OnboardingPage {
  title: string
  desc: string
  color: string
}

/**
 * 图片预览器示例
 * 展示图片全屏预览功能
 */
@ComponentV2
export struct SwiperImagePreviewExample {
  @Local images: ImageItem[] = [
    { url: '', color: '#FF6B6B', name: '图片 1' },
    { url: '', color: '#4ECDC4', name: '图片 2' },
    { url: '', color: '#95E1D3', name: '图片 3' },
    { url: '', color: '#FFA07A', name: '图片 4' },
  ]
  @Local currentIndex: number = 0

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // 黑色背景
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#000000')

      // Swiper 图片预览
      Swiper() {
        ForEach(this.images, (image: ImageItem) => {
          Column() {
            Column() {
              Text(image.name)
                .fontSize(24)
                .fontColor(Color.White)
                .margin({ bottom: 16 })

              // 图片占位
              Column() {
                Text('图片区域')
                  .fontSize(16)
                  .fontColor('rgba(255, 255, 255, 0.6)')
              }
              .width('100%')
              .height(200)
              .backgroundColor(image.color)
              .borderRadius(8)
              .justifyContent(FlexAlign.Center)
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .padding(32)
          }
        }, (image: ImageItem) => `preview_${image.name}`)
      }
      .width('100%')
      .height('100%')
      .index(this.currentIndex)
      .loop(false)
      .indicator(false)
      .onChange((index: number) => {
        this.currentIndex = index
      })

      // 顶部计数器
      Row() {
        Text(`${this.currentIndex + 1} / ${this.images.length}`)
          .fontSize(16)
          .fontColor(Color.White)
          .backgroundColor('rgba(0, 0, 0, 0.5)')
          .padding({ left: 16, right: 16, top: 8, bottom: 8 })
          .borderRadius(16)
      }
      .width('100%')
      .padding({ top: 16 })
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(350)
    .borderRadius(12)
    .clip(true)
  }
}

/**
 * 图片数据接口
 */
interface ImageItem {
  url: string
  color: string
  name: string
}

/**
 * 事件监听示例
 * 展示 Swiper 的各种事件回调
 */
@ComponentV2
export struct SwiperEventExample {
  @Local eventLog: string[] = []
  @Local currentIndex: number = 0

  build() {
    Column({ space: 16 }) {
      Text('事件监听')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Swiper() {
        ForEach([1, 2, 3], (item: number) => {
          Column() {
            Column() {
              Text(`Page ${item}`)
                .fontSize(30)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.White)
            }
            .width('100%')
            .height(180)
            .justifyContent(FlexAlign.Center)
            .backgroundColor(`#${item * 80}FF80`)
          }
        }, (item: number) => `event_${item}`)
      }
      .width('100%')
      .height(180)
      .loop(true)
      .indicator(true)
      .onChange((index: number) => {
        this.currentIndex = index
        this.addEventLog(`onChange: 索引 ${index}`)
      })
      .onAnimationStart((index: number) => {
        this.addEventLog(`onAnimationStart: 从索引 ${index} 开始动画`)
      })
      .onAnimationEnd((index: number) => {
        this.addEventLog(`onAnimationEnd: 索引 ${index} 动画结束`)
      })

      // 事件日志
      Column({ space: 8 }) {
        Text('事件日志:')
          .fontSize(14)
          .fontColor('#666666')
          .width('100%')

        Scroll() {
          Column() {
            ForEach(this.eventLog, (log: string, index: number) => {
              Text(log)
                .fontSize(12)
                .fontColor('#999999')
                .width('100%')
            }, (log: string, index: number) => `log_${index}`)
          }
          .width('100%')
        }
        .width('100%')
        .height(120)
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(8)

        Row({ space: 12 }) {
          Button('清空日志')
            .fontSize(14)
            .onClick(() => {
              this.eventLog = []
            })

          Button('添加日志')
            .fontSize(14)
            .onClick(() => {
              this.addEventLog(`当前索引: ${this.currentIndex}`)
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }

  private addEventLog(message: string) {
    const timestamp = new Date().toLocaleTimeString()
    this.eventLog = [`[${timestamp}] ${message}`, ...this.eventLog].slice(0, 20)
  }
}

/**
 * Swiper 示例页面
 * 汇总所有示例组件
 */
@Entry
@ComponentV2
export struct SwiperExamplePage {
  @Param navPathStack: NavPathStack = new NavPathStack()

  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          // 页面标题
          Text('Swiper 轮播组件')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .padding({ left: 16, right: 16, top: 16, bottom: 8 })

          // 示例列表
          SwiperBasicExample()
          SwiperCustomIndicatorExample()
          SwiperVerticalExample()
          SwiperMultipleCardsExample()
          SwiperControllerExample()
          SwiperCustomCurveExample()
          SwiperDisableSwipeExample()
          SwiperProductCardExample()
          SwiperOnboardingExample()
          SwiperImagePreviewExample()
          SwiperEventExample()
        }
        .width('100%')
        .padding({ left: 16, right: 16, bottom: 16 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')
      .scrollBar(BarState.Auto)
      .edgeEffect(EdgeEffect.Spring)
    }
    .title('Swiper 示例')
    .mode(NavDestinationMode.STANDARD)
  }
}
