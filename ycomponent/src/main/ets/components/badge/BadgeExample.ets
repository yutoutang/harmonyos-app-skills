/**
 * Badge Component Examples
 * OpenHarmony Badge 徽章组件使用示例
 *
 * 本示例展示 Badge 组件的各种用法，包括数字角标、小红点、文本角标等
 */

/**
 * 数字角标示例
 * 展示如何使用数字角标显示未读消息数量
 */
@ComponentV2
export struct NumericBadgeExample {
  @Local messageCount: number = 99

  build() {
    Column({ space: 16 }) {
      Text('数字角标')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      // 基础数字角标
      Row({ space: 20 }) {
        Badge({
          count: 5,
          position: BadgePosition.Right,
          style: { color: '#FFFFFF', fontSize: 12, badgeSize: 16, badgeColor: '#FF0000' }
        }) {
          Text('消息')
            .fontSize(16)
            .padding(12)
            .backgroundColor('#E3F2FD')
            .borderRadius(8)
        }

        Badge({
          count: 99,
          position: BadgePosition.Right,
          style: { color: '#FFFFFF', fontSize: 12, badgeSize: 20, badgeColor: '#FF0000' }
        }) {
          Text('通知')
            .fontSize(16)
            .padding(12)
            .backgroundColor('#E3F2FD')
            .borderRadius(8)
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)

      // 可调节数量的角标
      Column({ space: 12 }) {
        Text('动态调整数量:')
          .fontSize(14)
          .fontColor('#666666')

        Row({ space: 12 }) {
          Button('减少')
            .onClick(() => {
              if (this.messageCount > 0) {
                this.messageCount--
              }
            })

          Badge({
            count: this.messageCount,
            position: BadgePosition.Right,
            maxCount: 99,
            style: { color: '#FFFFFF', fontSize: 12, badgeSize: 18, badgeColor: '#FF0000' }
          }) {
            Text('收件箱')
              .fontSize(16)
              .padding(12)
              .backgroundColor('#FFF3E0')
              .borderRadius(8)
          }

          Button('增加')
            .onClick(() => {
              this.messageCount++
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#FAFAFA')
      .borderRadius(8)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 小红点示例
 * 展示如何使用小红点标识状态
 */
@ComponentV2
export struct DotBadgeExample {
  @Local hasNotification: boolean = true
  @Local newFeatureCount: number = 0

  build() {
    Column({ space: 16 }) {
      Text('小红点角标')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Row({ space: 20 }) {
        // 小红点
        Badge({
          count: 0,
          position: BadgePosition.Right,
          style: { color: '#FFFFFF', fontSize: 12, badgeSize: 8, badgeColor: '#FF0000' }
        }) {
          Text('通知')
            .fontSize(16)
            .padding(12)
            .backgroundColor('#E3F2FD')
            .borderRadius(8)
        }

        // 可切换的小红点
        Badge({
          count: this.hasNotification ? 0 : -1,
          position: BadgePosition.Right,
          style: { color: '#FFFFFF', fontSize: 12, badgeSize: 10, badgeColor: '#FF0000' }
        }) {
          Text('消息中心')
            .fontSize(16)
            .padding(12)
            .backgroundColor('#E8F5E9')
            .borderRadius(8)
        }
        .onClick(() => {
          this.hasNotification = !this.hasNotification
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)

      // 动态控制小红点
      Column({ space: 12 }) {
        Row({ space: 12 }) {
          Button('显示')
            .onClick(() => {
              this.newFeatureCount = 0
            })

          Button('隐藏')
            .onClick(() => {
              this.newFeatureCount = -1
            })
        }
        .justifyContent(FlexAlign.Center)

        Badge({
          count: this.newFeatureCount,
          position: BadgePosition.Right,
          style: { color: '#FFFFFF', fontSize: 12, badgeSize: 12, badgeColor: '#FF5722' }
        }) {
          Text('新功能')
            .fontSize(16)
            .padding(12)
            .backgroundColor('#F3E5F5')
            .borderRadius(8)
        }
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#FAFAFA')
      .borderRadius(8)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 文本角标示例
 * 展示如何使用自定义文本作为角标
 */
@ComponentV2
export struct TextBadgeExample {
  build() {
    Column({ space: 16 }) {
      Text('文本角标')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Row({ space: 20 }) {
        Badge({
          value: 'NEW',
          position: BadgePosition.Right,
          style: { color: '#FFFFFF', fontSize: 12, badgeColor: '#FF5722' }
        }) {
          Text('商品')
            .fontSize(16)
            .padding(12)
            .backgroundColor('#E3F2FD')
            .borderRadius(8)
        }

        Badge({
          value: 'HOT',
          position: BadgePosition.Right,
          style: { color: '#FFFFFF', fontSize: 12, badgeColor: '#F44336' }
        }) {
          Text('热门')
            .fontSize(16)
            .padding(12)
            .backgroundColor('#E8F5E9')
            .borderRadius(8)
        }

        Badge({
          value: 'VIP',
          position: BadgePosition.Left,
          style: { color: '#FFFFFF', fontSize: 12, badgeColor: '#FFC107' }
        }) {
          Text('会员')
            .fontSize(16)
            .padding(12)
            .backgroundColor('#FFF3E0')
            .borderRadius(8)
        }
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
 * 自定义位置示例
 * 展示 Badge 的不同位置选项
 */
@ComponentV2
export struct BadgePositionExample {
  build() {
    Column({ space: 16 }) {
      Text('角标位置')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Grid() {
        GridItem() {
          Badge({
            count: 5,
            position: BadgePosition.Right,
            style: { color: '#FFFFFF', fontSize: 12, badgeSize: 16, badgeColor: '#FF0000' }
          }) {
            Text('右侧上方')
              .fontSize(14)
              .padding(10)
              .backgroundColor('#E3F2FD')
              .borderRadius(8)
          }
        }

        GridItem() {
          Badge({
            count: 5,
            position: BadgePosition.Right,
            style: { color: '#FFFFFF', fontSize: 12, badgeSize: 16, badgeColor: '#FF0000' }
          }) {
            Text('右侧')
              .fontSize(14)
              .padding(10)
              .backgroundColor('#E8F5E9')
              .borderRadius(8)
          }
        }

        GridItem() {
          Badge({
            count: 5,
            position: BadgePosition.Right,
            style: { color: '#FFFFFF', fontSize: 12, badgeSize: 16, badgeColor: '#FF0000' }
          }) {
            Text('右下方')
              .fontSize(14)
              .padding(10)
              .backgroundColor('#FFF3E0')
              .borderRadius(8)
          }
        }

        GridItem() {
          Badge({
            value: 'TOP',
            position: BadgePosition.Left,
            style: { color: '#FFFFFF', fontSize: 12, badgeSize: 16, badgeColor: '#FFC107' }
          }) {
            Text('左上方')
              .fontSize(14)
              .padding(10)
              .backgroundColor('#F3E5F5')
              .borderRadius(8)
          }
        }

        GridItem() {
          Badge({
            count: 3,
            position: BadgePosition.Left,
            style: { color: '#FFFFFF', fontSize: 12, badgeSize: 16, badgeColor: '#FF0000' }
          }) {
            Text('左侧')
              .fontSize(14)
              .padding(10)
              .backgroundColor('#E0F2F1')
              .borderRadius(8)
          }
        }

        GridItem() {
          Badge({
            value: 'NEW',
            position: BadgePosition.Left,
            style: { color: '#FFFFFF', fontSize: 12, badgeSize: 16, badgeColor: '#F44336' }
          }) {
            Text('左下方')
              .fontSize(14)
              .padding(10)
              .backgroundColor('#FCE4EC')
              .borderRadius(8)
          }
        }
      }
      .columnsTemplate('1fr 1fr 1fr')
      .rowsTemplate('1fr 1fr')
      .width('100%')
      .height(220)
      .columnsGap(12)
      .rowsGap(12)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 自定义样式示例
 * 展示如何自定义角标的颜色、大小等
 */
@ComponentV2
export struct CustomBadgeStyleExample {
  build() {
    Column({ space: 16 }) {
      Text('自定义样式')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      Row({ space: 16 }) {
        // 红色角标
        Badge({
          count: 8,
          position: BadgePosition.Right,
          style: {
            badgeColor: '#F44336',
            badgeSize: 20
          }
        }) {
          Text('红色')
            .fontSize(14)
            .padding(10)
            .backgroundColor('#FFEBEE')
            .borderRadius(8)
        }

        // 蓝色角标
        Badge({
          count: 12,
          position: BadgePosition.Right,
          style: {
            badgeColor: '#2196F3',
            badgeSize: 18
          }
        }) {
          Text('蓝色')
            .fontSize(14)
            .padding(10)
            .backgroundColor('#E3F2FD')
            .borderRadius(8)
        }

        // 绿色角标
        Badge({
          value: 'OK',
          position: BadgePosition.Right,
          style: {
            badgeColor: '#4CAF50',
            badgeSize: 22
          }
        }) {
          Text('绿色')
            .fontSize(14)
            .padding(10)
            .backgroundColor('#E8F5E9')
            .borderRadius(8)
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)

      // 不同大小的角标
      Row({ space: 16 }) {
        Badge({
          count: 5,
          position: BadgePosition.Right,
          style: { color: '#FFFFFF', fontSize: 12, badgeSize: 16 }
        }) {
          Text('小')
            .fontSize(14)
            .padding(10)
            .backgroundColor('#E3F2FD')
            .borderRadius(8)
        }

        Badge({
          count: 5,
          position: BadgePosition.Right,
          style: { color: '#FFFFFF', fontSize: 12, badgeSize: 24 }
        }) {
          Text('中')
            .fontSize(14)
            .padding(10)
            .backgroundColor('#E8F5E9')
            .borderRadius(8)
        }

        Badge({
          count: 5,
          position: BadgePosition.Right,
          style: { color: '#FFFFFF', fontSize: 12, badgeSize: 32 }
        }) {
          Text('大')
            .fontSize(14)
            .padding(10)
            .backgroundColor('#FFF3E0')
            .borderRadius(8)
        }
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
 * 实际应用场景示例
 */
@ComponentV2
export struct RealWorldBadgeExample {
  @Local unreadMessages: number = 3
  @Local hasSystemUpdate: boolean = true
  @Local cartItems: number = 0

  build() {
    Column({ space: 16 }) {
      Text('实际应用场景')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      // 消息应用
      Column({ space: 12 }) {
        Text('消息应用')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .width('100%')

        Row({ space: 16 }) {
          Badge({
            count: this.unreadMessages,
            position: BadgePosition.Right,
            maxCount: 99,
            style: { color: '#FFFFFF', fontSize: 12, badgeSize: 18, badgeColor: '#FF0000' }
          }) {
            Column({ space: 4 }) {
              Text('💬')
                .fontSize(24)
              Text('聊天')
                .fontSize(12)
                .fontColor('#666666')
            }
            .padding(12)
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
            .shadow({ radius: 4, color: '#E0E0E0' })
          }
          .layoutWeight(1)

          Badge({
            count: 0,
            position: BadgePosition.Right,
            style: { color: '#FFFFFF', fontSize: 12, badgeSize: 8, badgeColor: '#FF0000' }
          }) {
            Column({ space: 4 }) {
              Text('📧')
                .fontSize(24)
              Text('邮件')
                .fontSize(12)
                .fontColor('#666666')
            }
            .padding(12)
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
            .shadow({ radius: 4, color: '#E0E0E0' })
          }
          .layoutWeight(1)
        }
        .width('100%')
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#FFFFFF')
      .borderRadius(8)

      // 电商应用
      Column({ space: 12 }) {
        Text('电商应用')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .width('100%')

        Row({ space: 16 }) {
          Badge({
            count: this.cartItems,
            position: BadgePosition.Right,
            style: { color: '#FFFFFF', fontSize: 12, badgeColor: '#FF5722', badgeSize: 20 }
          }) {
            Column({ space: 4 }) {
              Text('🛒')
                .fontSize(24)
              Text('购物车')
                .fontSize(12)
                .fontColor('#666666')
            }
            .padding(12)
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
            .shadow({ radius: 4, color: '#E0E0E0' })
          }
          .layoutWeight(1)
          .onClick(() => {
            this.cartItems++
          })

          Badge({
            value: 'NEW',
            position: BadgePosition.Right,
            style: { color: '#FFFFFF', fontSize: 12, badgeColor: '#FFC107' }
          }) {
            Column({ space: 4 }) {
              Text('🎁')
                .fontSize(24)
              Text('优惠券')
                .fontSize(12)
                .fontColor('#666666')
            }
            .padding(12)
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
            .shadow({ radius: 4, color: '#E0E0E0' })
          }
          .layoutWeight(1)
        }
        .width('100%')
      }
      .width('100%')
      .padding(12)
      .backgroundColor('#FFFFFF')
      .borderRadius(8)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * Badge 主页面
 */
@ComponentV2
export struct BadgeExamplePage {
  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 16 }) {
          // 页面标题
          Text('Badge 徽章组件')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .padding({ left: 16, right: 16, top: 16, bottom: 8 })

          NumericBadgeExample()
          DotBadgeExample()
          TextBadgeExample()
          BadgePositionExample()
          CustomBadgeStyleExample()
          RealWorldBadgeExample()

          // 底部说明
          Column({ space: 8 }) {
            Text('使用说明')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#333333')
              .width('100%')

            Text('• Badge 必须包含一个子组件')
              .fontSize(13)
              .fontColor('#666666')
              .width('100%')

            Text('• count: 数字角标，0 表示小红点，-1 表示隐藏')
              .fontSize(13)
              .fontColor('#666666')
              .width('100%')

            Text('• value: 文本角标内容')
              .fontSize(13)
              .fontColor('#666666')
              .width('100%')

            Text('• position: 角标位置（RightTop、Right、RightBottom 等）')
              .fontSize(13)
              .fontColor('#666666')
              .width('100%')

            Text('• maxCount: 数字角标最大显示值（如 99+）')
              .fontSize(13)
              .fontColor('#666666')
              .width('100%')
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#E3F2FD')
          .borderRadius(12)
          .margin({ bottom: 16 })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
      .scrollBar(BarState.Auto)
    }
    .title('Badge 徽章')
    .mode(NavDestinationMode.STANDARD)
  }
}

@Builder
export function BadgeExamplePageBuilder() {
  BadgeExamplePage()
}
