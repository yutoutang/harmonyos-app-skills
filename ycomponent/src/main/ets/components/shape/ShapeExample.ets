/**
 * Shape Component Examples
 * OpenHarmony 形状组件使用示例
 * 包括: Divider, Blank, Badge, Circle, Ellipse, Line, Rect
 */

/**
 * Divider 分隔线示例
 */
@ComponentV2
export struct DividerExample {
  build() {
    Column({ space: 16 }) {
      Text('Divider 分隔线示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Column({ space: 12 }) {
        Text('内容 1')
          .fontSize(16)

        Divider()

        Text('内容 2')
          .fontSize(16)

        Divider()
          .color('#FF0000')
          .strokeWidth(4)

        Text('内容 3')
          .fontSize(16)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)
    }
    .width('100%')
    .padding(16)
  }
}

/**
 * Blank 空白占位示例
 */
@ComponentV2
export struct BlankExample {
  build() {
    Column({ space: 16 }) {
      Text('Blank 空白占位示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Flex() {
        Text('左对齐')
          .fontSize(16)
          .padding(12)
          .backgroundColor('#E3F2FD')
          .borderRadius(8)

        Blank()

        Text('右对齐')
          .fontSize(16)
          .padding(12)
          .backgroundColor('#28A745')
          .borderRadius(8)
      }
      .width('100%')
      .padding(20)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)
    }
    .width('100%')
    .padding(16)
  }
}

/**
 * Badge 角标示例
 */
@ComponentV2
export struct BadgeExample {
  @Local messageCount: number = 99

  build() {
    Column({ space: 16 }) {
      Text('Badge 角标示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        Badge({
          count: 5,
          position: BadgePosition.RightTop,
          style: { color: '#FFFFFF', fontSize: 12, badgeSize: 18, badgeColor: '#FF0000' }
        }) {
          Text('消息')
            .fontSize(16)
            .padding(12)
            .backgroundColor('#E3F2FD')
            .borderRadius(8)
        }

        Badge({
          count: this.messageCount,
          position: BadgePosition.RightTop,
          style: { color: '#FFFFFF', fontSize: 12, badgeSize: 18, badgeColor: '#FF0000' }
        }) {
          Text('通知')
            .fontSize(16)
            .padding(12)
            .backgroundColor('#E8F5E9')
            .borderRadius(8)
        }

        Badge({
          count: 0,
          position: BadgePosition.RightTop,
          style: { color: '#FFFFFF', fontSize: 12, badgeSize: 10, badgeColor: '#FF0000' }
        }) {
          Text('状态')
            .fontSize(16)
            .padding(12)
            .backgroundColor('#FFF3E0')
            .borderRadius(8)
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)
    }
    .width('100%')
    .padding(16)
  }
}

/**
 * Circle 圆形示例
 */
@ComponentV2
export struct CircleExample {
  build() {
    Column({ space: 16 }) {
      Text('Circle 圆形示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        Circle({ width: 60, height: 60 })
          .fill('#007DFF')

        Circle({ width: 60, height: 60 })
          .fill('#28A745')

        Circle({ width: 60, height: 60 })
          .fill('#FFC107')
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)
    }
    .width('100%')
    .padding(16)
  }
}

/**
 * Ellipse 椭圆示例
 */
@ComponentV2
export struct EllipseExample {
  build() {
    Column({ space: 16 }) {
      Text('Ellipse 椭圆示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Row({ space: 16 }) {
        Ellipse({ width: 120, height: 60 })
          .fill('#007DFF')

        Ellipse({ width: 100, height: 80 })
          .fill('#28A745')

        Ellipse({ width: 80, height: 100 })
          .fill('#FFC107')
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)
    }
    .width('100%')
    .padding(16)
  }
}

/**
 * Divider 分隔线示例 (代替 Line)
 */
@ComponentV2
export struct LineExample {
  build() {
    Column({ space: 16 }) {
      Text('Divider 分隔线示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Column({ space: 15 }) {
        Divider()
          .color('#007DFF')
          .strokeWidth(2)

        Divider()
          .color('#28A745')
          .strokeWidth(4)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)
    }
    .width('100%')
    .padding(16)
  }
}

/**
 * Rect 矩形示例
 */
@ComponentV2
export struct RectExample {
  build() {
    Column({ space: 16 }) {
      Text('Rect 矩形示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        Rect()
          .width(80)
          .height(80)
          .fill('#007DFF')
          .radius(8)

        Rect()
          .width(80)
          .height(80)
          .fill('#28A745')
          .radius(16)

        Rect()
          .width(80)
          .height(80)
          .fill('#FFC107')
          .radius(40)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)
    }
    .width('100%')
    .padding(16)
  }
}

/**
 * Polygon 多边形示例
 */
@ComponentV2
export struct PolygonExample {
  build() {
    Column({ space: 16 }) {
      Text('Polygon 多边形示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        // 三角形
        Polygon()
          .width(80)
          .height(80)
          .points([[40, 0], [0, 80], [80, 80]])
          .fill('#007DFF')

        // 五边形
        Polygon()
          .width(80)
          .height(80)
          .points([[40, 0], [80, 30], [65, 80], [15, 80], [0, 30]])
          .fill('#28A745')

        // 六边形
        Polygon()
          .width(80)
          .height(80)
          .points([[40, 0], [80, 20], [80, 60], [40, 80], [0, 60], [0, 20]])
          .fill('#FFC107')
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)

      Row({ space: 20 }) {
        // 星形
        Polygon()
          .width(80)
          .height(80)
          .points([
            [40, 0], [49, 30], [80, 30], [55, 50],
            [65, 80], [40, 60], [15, 80], [25, 50],
            [0, 30], [31, 30]
          ])
          .fill('#FFD93D')

        // 菱形
        Polygon()
          .width(80)
          .height(80)
          .points([[40, 0], [80, 40], [40, 80], [0, 40]])
          .fill('#FF6B6B')
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)
    }
    .width('100%')
    .padding(16)
  }
}

/**
 * Polyline 折线示例
 */
@ComponentV2
export struct PolylineExample {
  build() {
    Column({ space: 16 }) {
      Text('Polyline 折线示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        // 简单折线
        Polyline()
          .width(150)
          .height(80)
          .points([[0, 40], [40, 10], [80, 70], [120, 30], [150, 60]])
          .stroke('#007DFF')
          .strokeWidth(3)

        // 锯齿波
        Polyline()
          .width(150)
          .height(80)
          .points([[0, 40], [30, 10], [60, 70], [90, 10], [120, 70], [150, 40]])
          .stroke('#FF6B6B')
          .strokeWidth(3)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)

      // 折线图
      Column({ space: 12 }) {
        Text('数据折线图')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)

        Stack({ alignContent: Alignment.BottomStart }) {
          // 网格背景
          Column() {
            ForEach([0, 1, 2, 3, 4], (index: number) => {
              Divider()
                .color('#E0E0E0')
                .strokeWidth(1)
            })
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.SpaceBetween)

          // 折线
          Polyline()
            .width('100%')
            .height(120)
            .points([[0, 100], [60, 60], [120, 80], [180, 20], [240, 40]])
            .stroke('#007DFF')
            .strokeWidth(3)
        }
        .width('100%')
        .height(120)
        .padding(12)
        .backgroundColor('#FFFFFF')
        .borderRadius(8)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)
    }
    .width('100%')
    .padding(16)
  }
}

/**
 * Path 路径示例
 */
@ComponentV2
export struct PathExample {
  build() {
    Column({ space: 16 }) {
      Text('Path 路径示例')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Row({ space: 20 }) {
        // 二次贝塞尔曲线
        Path()
          .width(120)
          .height(80)
          .commands('M 10 70 Q 60 10 110 70')
          .stroke('#007DFF')
          .strokeWidth(3)
          .fill('transparent')

        // 三次贝塞尔曲线
        Path()
          .width(120)
          .height(80)
          .commands('M 10 70 C 40 10 80 10 110 70')
          .stroke('#28A745')
          .strokeWidth(3)
          .fill('transparent')
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)

      Row({ space: 20 }) {
        // 心形
        Path()
          .width(80)
          .height(80)
          .commands(`
            M 40 70
            C 15 45 0 25 20 10
            C 32 0 40 20 40 20
            C 40 20 48 0 60 10
            C 80 25 65 45 40 70
            Z
          `)
          .fill('#FF6B6B')

        // 箭头
        Path()
          .width(60)
          .height(60)
          .commands('M 30 5 L 5 30 L 20 30 L 20 55 L 40 55 L 40 30 L 55 30 Z')
          .fill('#007DFF')

        // 星形
        Path()
          .width(80)
          .height(80)
          .commands(`
            M 40 5
            L 49 30
            L 75 30
            L 55 45
            L 64 70
            L 40 55
            L 16 70
            L 25 45
            L 5 30
            L 31 30
            Z
          `)
          .fill('#FFD93D')
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)
    }
    .width('100%')
    .padding(16)
  }
}

/**
 * 主页面 - 整合所有形状组件示例
 */
@ComponentV2
export struct ShapeExamplePage {
  build() {
    Scroll() {
      Column({ space: 20 }) {
        Text('Shape Component Examples')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .padding({ left: 16, right: 16, top: 16, bottom: 8 })

        DividerExample()
        BlankExample()
        BadgeExample()
        CircleExample()
        EllipseExample()
        LineExample()
        RectExample()
        PolygonExample()
        PolylineExample()
        PathExample()
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
