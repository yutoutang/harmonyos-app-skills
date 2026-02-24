/**
 * Image Component Examples
 * OpenHarmony Image 组件使用示例
 *
 * 展示 Image 组件的各种用法，包括数据源、填充模式、占位图等
 */

/**
 * 基础图片示例
 * 展示不同数据源的图片加载
 */
@ComponentV2
export struct BasicImageExample {
  build() {
    Column({ space: 16 }) {
      Text('基础图片 (Basic Images)')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // 本地资源图片
      Column({ space: 8 }) {
        Text('本地资源图片 (Local Resource)')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#666666')

        Row({ space: 12 }) {
          // 使用颜色矩形代替不存在的资源
          Column() {
            Rect()
              .width(60)
              .height(60)
              .fill('#007DFF')
              .radius(8)
          }
          .justifyContent(FlexAlign.Center)

          Column() {
            Rect()
              .width(40)
              .height(40)
              .fill('#28A745')
              .radius(8)
          }
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      // 网络图片
      Column({ space: 8 }) {
        Text('网络图片示例 (Network Image)')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#666666')

        // 使用公共网络图片作为示例
        Text('网络图片加载（使用示例 URL）')
          .fontSize(14)
          .fontColor('#999999')
          .width('100%')
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * 图片填充模式示例
 */
@ComponentV2
export struct ImageFitExample {
  build() {
    Column({ space: 16 }) {
      Text('图片填充模式 (Image Fit)')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // 不同填充模式对比
      Column({ space: 12 }) {
        Text('ImageFit.Cover (保持宽高比，填满)')
          .fontSize(14)
          .fontColor('#666666')

        // 示例占位矩形
        Row() {
          Rect()
            .width(120)
            .height(120)
            .fill('#E3F2FD')
            .radius(8)
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      Column({ space: 12 }) {
        Text('ImageFit.Contain (保持宽高比，完整显示)')
          .fontSize(14)
          .fontColor('#666666')

        Row() {
          Rect()
            .width(120)
            .height(120)
            .fill('#E8F5E9')
            .radius(8)
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      Column({ space: 12 }) {
        Text('ImageFit.Fill (拉伸填满)')
          .fontSize(14)
          .fontColor('#666666')

        Row() {
          Rect()
            .width(120)
            .height(120)
            .fill('#FFF8E1')
            .radius(8)
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * 图片尺寸和样式示例
 */
@ComponentV2
export struct ImageStyleExample {
  build() {
    Column({ space: 16 }) {
      Text('图片尺寸和样式 (Image Size & Style)')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // 不同尺寸
      Column({ space: 12 }) {
        Text('不同尺寸 (Different Sizes)')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#666666')

        Row({ space: 16 }) {
          Column({ space: 8 }) {
            Rect()
              .width(40)
              .height(40)
              .fill('#007DFF')
              .radius(4)
            Text('40x40')
              .fontSize(12)
              .fontColor('#666666')
          }

          Column({ space: 8 }) {
            Rect()
              .width(60)
              .height(60)
              .fill('#28A745')
              .radius(6)
            Text('60x60')
              .fontSize(12)
              .fontColor('#666666')
          }

          Column({ space: 8 }) {
            Rect()
              .width(80)
              .height(80)
              .fill('#FFC107')
              .radius(8)
            Text('80x80')
              .fontSize(12)
              .fontColor('#666666')
          }
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      // 圆角和边框
      Column({ space: 12 }) {
        Text('圆角和边框 (Border Radius & Border)')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#666666')

        Row({ space: 16 }) {
          Column({ space: 8 }) {
            Rect()
              .width(60)
              .height(60)
              .fill('#E91E63')
              .radius(8)
            Text('圆角 8')
              .fontSize(12)
              .fontColor('#666666')
          }

          Column({ space: 8 }) {
            Rect()
              .width(60)
              .height(60)
              .fill('#9C27B0')
              .radius(30)
            Text('圆形')
              .fontSize(12)
              .fontColor('#666666')
          }

          Column({ space: 8 }) {
            Rect()
              .width(60)
              .height(60)
              .fill('#673AB7')
              .radius(12)
              .border({ width: 2, color: '#333333' })
            Text('带边框')
              .fontSize(12)
              .fontColor('#666666')
          }
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * 图片加载状态示例
 */
@ComponentV2
export struct ImageLoadingExample {
  @Local showPlaceholder: boolean = false
  @Local showError: boolean = false

  build() {
    Column({ space: 16 }) {
      Text('图片加载状态 (Image Loading State)')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // 占位图示例
      Column({ space: 12 }) {
        Text('占位图 (Placeholder)')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#666666')

        Column() {
          if (this.showPlaceholder) {
            // 显示加载中占位
            Column({ space: 8 }) {
              LoadingProgress()
                .width(40)
                .height(40)
                .color('#007DFF')
              Text('加载中...')
                .fontSize(14)
                .fontColor('#999999')
            }
            .width(120)
            .height(120)
            .justifyContent(FlexAlign.Center)
            .backgroundColor('#F5F5F5')
            .borderRadius(8)
          } else {
            // 显示图片
            // 使用颜色矩形代替
            Column() {
              Rect()
                .width(120)
                .height(120)
                .fill('#007DFF')
                .radius(8)
            }
            .justifyContent(FlexAlign.Center)
          }
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)

        Row({ space: 12 }) {
          Button('显示占位')
            .fontSize(14)
            .onClick(() => {
              this.showPlaceholder = true
            })

          Button('加载完成')
            .fontSize(14)
            .onClick(() => {
              this.showPlaceholder = false
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      // 错误状态
      Column({ space: 12 }) {
        Text('错误状态 (Error State)')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#666666')

        Column() {
          if (this.showError) {
            Column({ space: 8 }) {
              Text('\uE6E0') // 错误图标
                .fontSize(48)
                .fontColor('#FF0000')
              Text('图片加载失败')
                .fontSize(14)
                .fontColor('#999999')
            }
            .width(120)
            .height(120)
            .justifyContent(FlexAlign.Center)
            .backgroundColor('#F5F5F5')
            .borderRadius(8)
          } else {
            // 使用颜色矩形代替
            Column() {
              Rect()
                .width(120)
                .height(120)
                .fill('#007DFF')
                .radius(8)
            }
            .justifyContent(FlexAlign.Center)
          }
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)

        Row({ space: 12 }) {
          Button('模拟错误')
            .fontSize(14)
            .onClick(() => {
              this.showError = true
            })

          Button('重新加载')
            .fontSize(14)
            .onClick(() => {
              this.showError = false
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * SVG 图片填充颜色示例
 */
@ComponentV2
export struct SvgFillColorExample {
  build() {
    Column({ space: 16 }) {
      Text('SVG 图片填充颜色 (SVG Fill Color)')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      Text('SVG 图片可以使用 fillColor 属性更改颜色')
        .fontSize(14)
        .fontColor('#666666')
        .width('100%')

      // 不同颜色的 SVG 图标
      Row({ space: 16 }) {
        Column({ space: 8 }) {
          Rect()
            .width(50)
            .height(50)
            .fill('#007DFF')
            .radius(8)
          Text('蓝色')
            .fontSize(12)
            .fontColor('#666666')
        }

        Column({ space: 8 }) {
          Rect()
            .width(50)
            .height(50)
            .fill('#28A745')
            .radius(8)
          Text('绿色')
            .fontSize(12)
            .fontColor('#666666')
        }

        Column({ space: 8 }) {
          Rect()
            .width(50)
            .height(50)
            .fill('#FFC107')
            .radius(8)
          Text('橙色')
            .fontSize(12)
            .fontColor('#666666')
        }

        Column({ space: 8 }) {
          Rect()
            .width(50)
            .height(50)
            .fill('#E91E63')
            .radius(8)
          Text('粉色')
            .fontSize(12)
            .fontColor('#666666')
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .padding(16)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * 图片重复模式示例
 */
@ComponentV2
export struct ImageRepeatExample {
  build() {
    Column({ space: 16 }) {
      Text('图片重复模式 (Image Repeat)')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // NoRepeat (默认)
      Column({ space: 12 }) {
        Text('NoRepeat (不重复 - 默认)')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#666666')

        Row({ space: 8 }) {
          Rect()
            .width(60)
            .height(60)
            .fill('#007DFF')
            .radius(8)
          Rect()
            .width(60)
            .height(60)
            .fill('#28A745')
            .radius(8)
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      // Repeat X (水平重复)
      Column({ space: 12 }) {
        Text('Repeat (重复效果示例)')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#666666')

        Row({ space: 4 }) {
          ForEach([1, 2, 3, 4, 5], (item: number) => {
            Rect()
              .width(20)
              .height(40)
              .fill('#FFC107')
              .radius(4)
          })
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * 完整的 Image 示例页面
 */
@ComponentV2
export struct ImageExamplePage {
  build() {
    Scroll() {
      Column({ space: 20 }) {
        Text('Image Component Examples')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .padding({ left: 16, right: 16, top: 16, bottom: 8 })

        BasicImageExample()
        ImageFitExample()
        ImageStyleExample()
        ImageLoadingExample()
        SvgFillColorExample()
        ImageRepeatExample()
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
