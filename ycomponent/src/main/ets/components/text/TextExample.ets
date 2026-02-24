/**
 * Text Component Examples
 * OpenHarmony Text 组件使用示例
 *
 * 展示 Text 组件的各种用法，包括字体样式、对齐方式、文本溢出、装饰效果等
 */

/**
 * 基础文本样式示例
 * 展示不同的字体大小、颜色、粗细、样式
 */
@ComponentV2
export struct BasicTextStyleExample {
  build() {
    Column({ space: 16 }) {
      Text('基础文本样式 (Basic Text Styles)')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // 不同字体大小
      Column({ space: 8 }) {
        Text('不同字体大小 (Font Size)')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#666666')

        Text('小号文本 (12fp)')
          .fontSize(12)

        Text('正常文本 (16fp)')
          .fontSize(16)

        Text('中号文本 (20fp)')
          .fontSize(20)

        Text('大号文本 (24fp)')
          .fontSize(24)

        Text('特大号文本 (32fp)')
          .fontSize(32)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      // 字体粗细
      Column({ space: 8 }) {
        Text('字体粗细 (Font Weight)')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#666666')

        Text('Light (300)')
          .fontWeight(300)

        Text('Regular (400)')
          .fontWeight(400)

        Text('Medium (500)')
          .fontWeight(500)

        Text('Bold (700)')
          .fontWeight(700)

        Text('Black (900)')
          .fontWeight(900)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      // 字体样式和颜色
      Column({ space: 8 }) {
        Text('字体样式和颜色 (Font Style & Color)')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#666666')

        Row({ space: 16 }) {
          Text('正常')
            .fontStyle(FontStyle.Normal)

          Text('斜体')
            .fontStyle(FontStyle.Italic)

          Text('蓝色')
            .fontColor('#007DFF')

          Text('红色')
            .fontColor('#FF0000')

          Text('绿色')
            .fontColor('#28A745')
        }
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
 * 文本对齐示例
 * 展示不同的对齐方式
 */
@ComponentV2
export struct TextAlignmentExample {
  build() {
    Column({ space: 16 }) {
      Text('文本对齐 (Text Alignment)')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // 水平对齐
      Column({ space: 12 }) {
        Text('水平对齐 (Horizontal Alignment)')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#666666')

        Column({ space: 8 }) {
          Text('Start 对齐')
            .width('100%')
            .textAlign(TextAlign.Start)
            .padding(12)
            .backgroundColor('#E8F4FD')

          Text('Center 对齐')
            .width('100%')
            .textAlign(TextAlign.Center)
            .padding(12)
            .backgroundColor('#FFF8E1')

          Text('End 对齐')
            .width('100%')
            .textAlign(TextAlign.End)
            .padding(12)
            .backgroundColor('#E8F5E9')
        }
        .width('100%')
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      // 两端对齐
      Column({ space: 8 }) {
        Text('两端对齐 (Justify)')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#666666')

        Text('两端对齐文本需要配合 wordBreak 使用。这是一段较长的文本内容，用于展示两端对齐的效果。')
          .width('100%')
          .textAlign(TextAlign.JUSTIFY)
          .wordBreak(WordBreak.BREAK_ALL)
          .lineHeight(24)
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
 * 文本溢出示例
 * 展示文本超出容器时的处理方式
 */
@ComponentV2
export struct TextOverflowExample {
  build() {
    Column({ space: 16 }) {
      Text('文本溢出 (Text Overflow)')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // 单行省略
      Column({ space: 12 }) {
        Text('单行省略 (Single Line Ellipsis)')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#666666')

        Text('这是一段很长的文本内容，超出的部分会显示省略号，这是单行文本溢出的效果。')
          .width('100%')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .fontSize(16)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      // 多行省略
      Column({ space: 12 }) {
        Text('多行省略 (Multiple Lines Ellipsis)')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#666666')

        Text('这是一段很长的文本内容，超出两行的部分会显示省略号。Text 组件支持多行文本溢出显示，当内容超出指定的行数时会自动显示省略号。')
          .width('100%')
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .fontSize(16)
          .lineHeight(24)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      // 省略号位置
      Row({ space: 12 }) {
        Column({ space: 8 }) {
          Text('开始省略')
            .fontSize(14)
            .fontColor('#666666')

          Text('这是一段很长的文本内容')
            .width(120)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .ellipsisMode(EllipsisMode.START)
            .fontSize(16)
        }
        .layoutWeight(1)

        Column({ space: 8 }) {
          Text('中间省略')
            .fontSize(14)
            .fontColor('#666666')

          Text('这是一段很长的文本内容')
            .width(120)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .ellipsisMode(EllipsisMode.CENTER)
            .fontSize(16)
        }
        .layoutWeight(1)

        Column({ space: 8 }) {
          Text('结尾省略')
            .fontSize(14)
            .fontColor('#666666')

          Text('这是一段很长的文本内容')
            .width(120)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .ellipsisMode(EllipsisMode.END)
            .fontSize(16)
        }
        .layoutWeight(1)
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * 文本装饰示例
 * 展示下划线、删除线、顶划线等效果
 */
@ComponentV2
export struct TextDecorationExample {
  build() {
    Column({ space: 16 }) {
      Text('文本装饰 (Text Decoration)')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // 装饰线类型
      Column({ space: 12 }) {
        Text('装饰线类型 (Decoration Type)')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#666666')

        Row({ space: 24 }) {
          Text('下划线')
            .decoration({
              type: TextDecorationType.Underline,
              color: '#007DFF'
            })
            .fontSize(18)

          Text('删除线')
            .decoration({
              type: TextDecorationType.LineThrough,
              color: '#FF0000'
            })
            .fontSize(18)

          Text('顶划线')
            .decoration({
              type: TextDecorationType.Overline,
              color: '#28A745'
            })
            .fontSize(18)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      // 字符间距和大小写转换
      Column({ space: 12 }) {
        Text('字符间距和大小写 (Letter Spacing & Case)')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#666666')

        Row({ space: 16 }) {
          Text('紧密')
            .letterSpacing(-2)
            .fontSize(16)

          Text('正常')
            .letterSpacing(0)
            .fontSize(16)

          Text('宽松')
            .letterSpacing(4)
            .fontSize(16)
        }
        .width('100%')

        Row({ space: 16 }) {
          Text('小写')
            .textCase(TextCase.LowerCase)
            .fontSize(16)

          Text('大写')
            .textCase(TextCase.UpperCase)
            .fontSize(16)
        }
        .width('100%')
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      // 文本阴影
      Column({ space: 12 }) {
        Text('文本阴影 (Text Shadow)')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#666666')

        Row({ space: 16 }) {
          Text('简单阴影')
            .fontSize(20)
            .fontColor('#FFFFFF')
            .textShadow({
              radius: 8,
              color: 'rgba(0, 0, 0, 0.5)',
              offsetX: 2,
              offsetY: 2
            })
            .padding(12)
            .backgroundColor('#007DFF')
            .borderRadius(8)

          Text('彩色阴影')
            .fontSize(20)
            .fontColor('#FFFFFF')
            .textShadow({
              radius: 10,
              color: '#FFC107',
              offsetX: 3,
              offsetY: 3
            })
            .padding(12)
            .backgroundColor('#28A745')
            .borderRadius(8)

          Text('多重阴影')
            .fontSize(20)
            .fontColor('#FFFFFF')
            .textShadow([
              { radius: 5, color: '#007DFF', offsetX: 2, offsetY: 2 },
              { radius: 10, color: '#FFC107', offsetX: -2, offsetY: -2 }
            ])
            .padding(12)
            .backgroundColor('#E91E63')
            .borderRadius(8)
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
 * 文本行高和间距示例
 */
@ComponentV2
export struct LineHeightExample {
  build() {
    Column({ space: 16 }) {
      Text('行高和间距 (Line Height & Spacing)')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // 不同行高
      Column({ space: 12 }) {
        Text('不同行高 (Line Height)')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#666666')

        Column({ space: 8 }) {
          Text('行高 1.5')
            .lineHeight(24)
            .fontSize(16)

          Text('行高 2.0')
            .lineHeight(32)
            .fontSize(16)

          Text('行高 2.5')
            .lineHeight(40)
            .fontSize(16)
        }
        .width('100%')
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      // 不同行高对比
      Column({ space: 12 }) {
        Text('不同行高对比 (Line Height Comparison)')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#666666')

        Row({ space: 16 }) {
          Column({ space: 8 }) {
            Text('紧凑行高')
              .lineHeight(20)
              .fontSize(14)
            Text('这是第二行文本')
              .lineHeight(20)
              .fontSize(14)
            Text('这是第三行文本')
              .lineHeight(20)
              .fontSize(14)
          }
          .layoutWeight(1)

          Column({ space: 8 }) {
            Text('舒适行高')
              .lineHeight(28)
              .fontSize(14)
            Text('这是第二行文本')
              .lineHeight(28)
              .fontSize(14)
            Text('这是第三行文本')
              .lineHeight(28)
              .fontSize(14)
          }
          .layoutWeight(1)
        }
        .width('100%')
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F5F5F5')
      .borderRadius(8)

      // 首行缩进
      Column({ space: 12 }) {
        Text('首行缩进 (Text Indent)')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#666666')

        Text('首行缩进的文本效果。这是第二行文本，不会缩进显示。这是第三行文本，同样不会缩进。首行缩进常用于段落开头，使文本排版更加美观。')
          .width('100%')
          .fontSize(16)
          .textIndent(32)
          .lineHeight(26)
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
 * 文本复制和选择示例
 */
@ComponentV2
export struct TextCopyExample {
  build() {
    Column({ space: 16 }) {
      Text('文本复制和选择 (Text Copy & Selection)')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // 复制选项
      Column({ space: 12 }) {
        Text('长按下方文本可复制')
          .fontSize(14)
          .fontColor('#666666')

        Text('这段文本可以长按复制。请尝试长按此文本，将会弹出复制菜单。')
          .width('100%')
          .fontSize(16)
          .copyOption(CopyOptions.InApp)
          .padding(12)
          .backgroundColor('#F5F5F5')
          .borderRadius(8)
          .border({ width: 1, color: '#E0E0E0' })
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#E8F4FD')
      .borderRadius(8)

      // 可拖拽文本
      Column({ space: 12 }) {
        Text('可拖拽选中文本')
          .fontSize(14)
          .fontColor('#666666')

        Text('这段文本可以被选中和拖拽。请尝试长按并拖拽此文本。')
          .width('100%')
          .fontSize(16)
          .copyOption(CopyOptions.InApp)
          .draggable(true)
          .padding(12)
          .backgroundColor('#F5F5F5')
          .borderRadius(8)
          .border({ width: 1, color: '#E0E0E0' })
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFF8E1')
      .borderRadius(8)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * 自适应字体大小示例
 */
@ComponentV2
export struct AdaptiveFontSizeExample {
  build() {
    Column({ space: 16 }) {
      Text('自适应字体大小 (Adaptive Font Size)')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      // 字体大小自适应
      Row({ space: 12 }) {
        Column({ space: 8 }) {
          Text('小容器')
            .fontSize(14)
            .fontColor('#666666')

          Text('自适应文本')
            .width(100)
            .height(50)
            .maxLines(1)
            .minFontSize(12)
            .maxFontSize(24)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .backgroundColor('#007DFF')
            .fontColor(Color.White)
            .borderRadius(8)
            .padding(8)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        Column({ space: 8 }) {
          Text('中容器')
            .fontSize(14)
            .fontColor('#666666')

          Text('自适应文本')
            .width(150)
            .height(50)
            .maxLines(1)
            .minFontSize(12)
            .maxFontSize(24)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .backgroundColor('#28A745')
            .fontColor(Color.White)
            .borderRadius(8)
            .padding(8)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        Column({ space: 8 }) {
          Text('大容器')
            .fontSize(14)
            .fontColor('#666666')

          Text('自适应文本')
            .width(200)
            .height(50)
            .maxLines(1)
            .minFontSize(12)
            .maxFontSize(24)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .backgroundColor('#FFC107')
            .fontColor(Color.White)
            .borderRadius(8)
            .padding(8)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')

      // 自适应策略对比
      Column({ space: 12 }) {
        Text('自适应策略对比 (Adaptive Policy)')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#666666')

        Row({ space: 12 }) {
          Column({ space: 8 }) {
            Text('MAX_LINES_FIRST')
              .fontSize(12)
              .fontColor('#666666')

            Text('自适应文本')
              .width(120)
              .height(40)
              .maxLines(1)
              .minFontSize(10)
              .maxFontSize(20)
              .heightAdaptivePolicy(TextHeightAdaptivePolicy.MAX_LINES_FIRST)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .backgroundColor('#007DFF')
              .fontColor(Color.White)
              .borderRadius(8)
              .padding(8)
          }
          .layoutWeight(1)

          Column({ space: 8 }) {
            Text('MIN_FONT_SIZE_FIRST')
              .fontSize(12)
              .fontColor('#666666')

            Text('自适应文本')
              .width(120)
              .height(40)
              .maxLines(1)
              .minFontSize(10)
              .maxFontSize(20)
              .heightAdaptivePolicy(TextHeightAdaptivePolicy.MIN_FONT_SIZE_FIRST)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .backgroundColor('#E91E63')
              .fontColor(Color.White)
              .borderRadius(8)
              .padding(8)
          }
          .layoutWeight(1)
        }
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
 * 完整的 Text 示例页面
 */
@ComponentV2
export struct TextExamplePage {
  build() {
    Scroll() {
      Column({ space: 20 }) {
        Text('Text Component Examples')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .padding({ left: 16, right: 16, top: 16, bottom: 8 })

        BasicTextStyleExample()
        TextAlignmentExample()
        TextOverflowExample()
        TextDecorationExample()
        LineHeightExample()
        TextCopyExample()
        AdaptiveFontSizeExample()
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
