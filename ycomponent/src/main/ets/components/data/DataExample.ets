/**
 * Data Display Components Examples
 * OpenHarmony Data Display Components 使用示例
 *
 * 展示 Gauge、LoadingProgress、DataPanel、Progress、Refresh 组件的各种用法
 */

/**
 * Gauge 仪表盘组件示例
 * 展示基础仪表盘、渐变仪表盘和多仪表盘
 */
@ComponentV2
export struct GaugeExample {
  @Local speed: number = 60
  @Local temperature: number = 35

  build() {
    Column({ space: 16 }) {
      Text('Gauge 仪表盘')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // 速度仪表盘
      Column({ space: 12 }) {
        Text('速度')
          .fontSize(16)
          .fontColor('#666666')

        Gauge({ value: this.speed, min: 0, max: 120 })
          .width(150)
          .height(150)
          .colors([[0x007DFF, 1.0]])

        Text(`${this.speed} km/h`)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)

        Row({ space: 12 }) {
          Button('减速')
            .fontSize(14)
            .onClick(() => {
              this.speed = Math.max(0, this.speed - 10)
            })

          Button('加速')
            .fontSize(14)
            .onClick(() => {
              this.speed = Math.min(120, this.speed + 10)
            })
        }
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)

      // 温度仪表盘 - 渐变色
      Column({ space: 12 }) {
        Text('温度')
          .fontSize(16)
          .fontColor('#666666')

        Gauge({ value: this.temperature, min: 0, max: 100 })
          .width(150)
          .height(150)
          .colors([
            [0x007DFF, 1.0],  // 蓝色(低温)
            [0xFFFF00, 1.0],  // 黄色(中温)
            [0xFF0000, 1.0]   // 红色(高温)
          ])

        Text(`${this.temperature}°C`)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)

        Row({ space: 12 }) {
          Button('降温')
            .fontSize(14)
            .onClick(() => {
              this.temperature = Math.max(0, this.temperature - 5)
            })

          Button('升温')
            .fontSize(14)
            .onClick(() => {
              this.temperature = Math.min(100, this.temperature + 5)
            })
        }
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * LoadingProgress 加载组件示例
 * 展示不同尺寸、颜色和加载状态
 */
@ComponentV2
export struct LoadingProgressExample {
  @Local isLoading: boolean = false
  @Local isButtonLoading: boolean = false

  build() {
    Column({ space: 16 }) {
      Text('LoadingProgress 加载进度')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // 不同尺寸
      Column({ space: 12 }) {
        Text('不同尺寸')
          .fontSize(16)
          .fontColor('#666666')

        Row({ space: 20 }) {
          Column({ space: 8 }) {
            LoadingProgress()
              .width(30)
              .height(30)
              .color('#007DFF')
            Text('小')
              .fontSize(12)
          }

          Column({ space: 8 }) {
            LoadingProgress()
              .width(50)
              .height(50)
              .color('#28A745')
            Text('中')
              .fontSize(12)
          }

          Column({ space: 8 }) {
            LoadingProgress()
              .width(70)
              .height(70)
              .color('#FFC107')
            Text('大')
              .fontSize(12)
          }
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)

      // 不同颜色
      Column({ space: 12 }) {
        Text('不同颜色')
          .fontSize(16)
          .fontColor('#666666')

        Row({ space: 20 }) {
          LoadingProgress()
            .width(50)
            .height(50)
            .color('#007DFF')

          LoadingProgress()
            .width(50)
            .height(50)
            .color('#28A745')

          LoadingProgress()
            .width(50)
            .height(50)
            .color('#FFC107')

          LoadingProgress()
            .width(50)
            .height(50)
            .color('#DC3545')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)

      // 带文本的加载
      Column({ space: 12 }) {
        Text('加载状态示例')
          .fontSize(16)
          .fontColor('#666666')

        if (this.isLoading) {
          Column({ space: 16 }) {
            LoadingProgress()
              .width(60)
              .height(60)
              .color('#007DFF')

            Text('正在加载数据...')
              .fontSize(16)
              .fontColor('#666666')
          }
          .width('100%')
          .padding(20)
          .backgroundColor('#FFFFFF')
          .borderRadius(8)
        } else {
          Button('开始加载')
            .width('100%')
            .type(ButtonType.Capsule)
            .onClick(() => {
              this.isLoading = true
              setTimeout(() => {
                this.isLoading = false
              }, 3000)
            })
        }
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)

      // 按钮内加载
      Column({ space: 12 }) {
        Text('按钮内加载')
          .fontSize(16)
          .fontColor('#666666')

        Button() {
          if (this.isButtonLoading) {
            Row({ space: 8 }) {
              LoadingProgress()
                .width(20)
                .height(20)
                .color(Color.White)
              Text('提交中...')
                .fontSize(16)
                .fontColor(Color.White)
            }
          } else {
            Text('提交')
              .fontSize(16)
              .fontColor(Color.White)
          }
        }
        .width('100%')
        .height(45)
        .type(ButtonType.Capsule)
        .backgroundColor(this.isButtonLoading ? '#CCCCCC' : '#007DFF')
        .enabled(!this.isButtonLoading)
        .onClick(() => {
          if (!this.isButtonLoading) {
            this.isButtonLoading = true
            setTimeout(() => {
              this.isButtonLoading = false
            }, 2000)
          }
        })
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * DataPanel 数据面板组件示例
 * 展示环形和线型数据面板
 */
@ComponentV2
export struct DataPanelExample {
  @Local storageUsed: number = 75
  @Local values: number[] = [30, 40, 20]

  build() {
    Column({ space: 16 }) {
      Text('DataPanel 数据面板')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // 环形数据面板
      Column({ space: 12 }) {
        Text('环形数据面板')
          .fontSize(16)
          .fontColor('#666666')

        Stack() {
          DataPanel({ values: [this.storageUsed], max: 100, type: DataPanelType.Circle })
            .width(150)
            .height(150)
            .closeEffect(false)

          Column({ space: 4 }) {
            Text(`${this.storageUsed}%`)
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
            Text('已使用')
              .fontSize(14)
              .fontColor('#666666')
          }
        }

        Button('更新数据')
          .fontSize(14)
          .onClick(() => {
            this.storageUsed = Math.floor(Math.random() * 100)
          })
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)

      // 多值环形面板
      Column({ space: 12 }) {
        Text('多值环形面板')
          .fontSize(16)
          .fontColor('#666666')

        DataPanel({ values: this.values, max: 100, type: DataPanelType.Circle })
          .width(180)
          .height(180)
          .closeEffect(false)

        // 图例
        Row({ space: 20 }) {
          Row({ space: 6 }) {
            Row()
              .width(12)
              .height(12)
              .backgroundColor('#007DFF')
              .borderRadius(6)
            Text('A')
              .fontSize(12)
          }

          Row({ space: 6 }) {
            Row()
              .width(12)
              .height(12)
              .backgroundColor('#28A745')
              .borderRadius(6)
            Text('B')
              .fontSize(12)
          }

          Row({ space: 6 }) {
            Row()
              .width(12)
              .height(12)
              .backgroundColor('#FFC107')
              .borderRadius(6)
            Text('C')
              .fontSize(12)
          }
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        Button('随机数据')
          .fontSize(14)
          .onClick(() => {
            this.values = [
              Math.floor(Math.random() * 50),
              Math.floor(Math.random() * 50),
              Math.floor(Math.random() * 50)
            ]
          })
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)

      // 线型数据面板
      Column({ space: 12 }) {
        Text('线型数据面板')
          .fontSize(16)
          .fontColor('#666666')

        DataPanel({ values: this.values, max: 100, type: DataPanelType.Line })
          .width('100%')
          .height(20)
          .closeEffect(false)

        Row({ space: 20 }) {
          Text(`${this.values[0]}%`)
            .fontSize(14)
            .fontColor('#007DFF')

          Text(`${this.values[1]}%`)
            .fontSize(14)
            .fontColor('#28A745')

          Text(`${this.values[2]}%`)
            .fontSize(14)
            .fontColor('#FFC107')
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * Progress 进度条组件示例
 * 展示线性、环形和胶囊形进度条
 */
@ComponentV2
export struct ProgressExample {
  @Local linearProgress: number = 30
  @Local ringProgress: number = 75
  @Local eclipseProgress: number = 50

  build() {
    Column({ space: 16 }) {
      Text('Progress 进度条')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // 线性进度条
      Column({ space: 12 }) {
        Text('线性进度条')
          .fontSize(16)
          .fontColor('#666666')

        Progress({ value: this.linearProgress, total: 100, type: ProgressType.Linear })
          .width('100%')
          .color('#007DFF')

        Text(`${this.linearProgress}%`)
          .fontSize(16)
          .fontColor('#666666')

        Button('更新进度')
          .fontSize(14)
          .onClick(() => {
            this.linearProgress = Math.min(100, this.linearProgress + 10)
          })
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)

      // 环形进度条
      Column({ space: 12 }) {
        Text('环形进度条')
          .fontSize(16)
          .fontColor('#666666')

        Stack() {
          Progress({ value: this.ringProgress, total: 100, type: ProgressType.Ring })
            .width(100)
            .height(100)
            .color('#28A745')

          Column({ space: 4 }) {
            Text(`${this.ringProgress}%`)
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
            Text('进度')
              .fontSize(12)
              .fontColor('#666666')
          }
        }

        Button('更新进度')
          .fontSize(14)
          .onClick(() => {
            this.ringProgress = Math.min(100, this.ringProgress + 10)
          })
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)

      // 胶囊形进度条
      Column({ space: 12 }) {
        Text('胶囊形进度条')
          .fontSize(16)
          .fontColor('#666666')

        Row({ space: 20 }) {
          Progress({ value: 30, total: 100, type: ProgressType.Eclipse })
            .width(80)
            .height(40)
            .color('#28A745')

          Progress({ value: 60, total: 100, type: ProgressType.Eclipse })
            .width(80)
            .height(40)
            .color('#FFC107')

          Progress({ value: 90, total: 100, type: ProgressType.Eclipse })
            .width(80)
            .height(40)
            .color('#DC3545')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * Refresh 下拉刷新组件示例
 * 展示下拉刷新功能
 */
@ComponentV2
export struct RefreshExample {
  @Local isRefreshing: boolean = false
  @Local items: string[] = []

  aboutToAppear(): void {
    // 初始化数据
    for (let i = 1; i <= 10; i++) {
      this.items.push(`Item ${i}`)
    }
  }

  refreshData(): void {
    this.isRefreshing = true

    setTimeout(() => {
      this.items = []
      for (let i = 1; i <= 10; i++) {
        this.items.push(`New Item ${i} - ${Date.now()}`)
      }
      this.isRefreshing = false
    }, 2000)
  }

  build() {
    Column({ space: 16 }) {
      Text('Refresh 下拉刷新')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // 下拉刷新示例
      Refresh({ refreshing: this.isRefreshing }) {
        List({ space: 8 }) {
          ForEach(this.items, (item: string, index: number) => {
            ListItem() {
              Row({ space: 12 }) {
                Text(`${index + 1}`)
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#007DFF')
                  .width(40)

                Text(item)
                  .fontSize(16)
                  .layoutWeight(1)
              }
              .width('100%')
              .padding(16)
              .backgroundColor('#FFFFFF')
              .borderRadius(8)
            }
          })
        }
        .width('100%')
        .padding({ left: 16, right: 16 })
      }
      .backgroundColor('#F5F5F5')
      .layoutWeight(1)
      .height(400)
      .borderRadius(12)
      .onStateChange((state: RefreshStatus) => {
        this.isRefreshing = state === RefreshStatus.Refresh
      })
      .onRefreshing(() => {
        this.refreshData()
      })

      // 提示文本
      Text('下拉列表可刷新数据')
        .fontSize(14)
        .fontColor('#666666')
        .textAlign(TextAlign.Center)
        .width('100%')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * 完整的数据显示组件示例页面
 * 集成所有数据显示组件示例
 */
@ComponentV2
export struct DataExamplePage {
  build() {
    Scroll() {
      Column({ space: 20 }) {
        Text('Data Display Components Examples')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .padding({ left: 16, right: 16, top: 16, bottom: 8 })

        GaugeExample()
        LoadingProgressExample()
        DataPanelExample()
        ProgressExample()
        RefreshExample()
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
