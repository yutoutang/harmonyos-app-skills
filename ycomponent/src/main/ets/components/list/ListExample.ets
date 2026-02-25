/**
 * List Component Examples
 * OpenHarmony List 列表组件使用示例
 *
 * 展示 List 列表布局的各种用法
 */

/**
 * 基础列表示例
 */
@ComponentV2
export struct BasicListExample {
  @Local items: string[] = ['列表项 1', '列表项 2', '列表项 3', '列表项 4', '列表项 5']

  build() {
    Column({ space: 16 }) {
      Text('List 基础列表')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      List({ space: 12 }) {
        ForEach(this.items, (item: string, index: number) => {
          ListItem() {
            Row({ space: 12 }) {
              Text(`${index + 1}`)
                .fontSize(16)
                .fontColor('#007DFF')
                .width(30)
              Text(item)
                .fontSize(16)
                .fontColor('#333333')
                .layoutWeight(1)
              Text('>')
                .fontSize(14)
                .fontColor('#999999')
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
            .shadow({ radius: 2, color: '#E0E0E0' })
          }
        }, (item: string, index: number) => `list_${index}`)
      }
      .width('100%')
      .height(300)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)
      .padding(12)

      Text('List 组件是高性能的列表容器，适合展示大量数据')
        .fontSize(12)
        .fontColor('#666666')
        .width('100%')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

/**
 * 分组列表示例
 */
@ComponentV2
export struct GroupedListExample {
  @Local groups: string[] = ['分组 A', '分组 B', '分组 C']

  build() {
    Column({ space: 16 }) {
      Text('分组列表')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')

      List({ space: 12 }) {
        ForEach(this.groups, (group: string) => {
          ListItemGroup({ header: this.groupHeaderBuilder.bind(this)(group) }) {
            ForEach(['项目 1', '项目 2'], (item: string) => {
              ListItem() {
                Text(item)
                  .fontSize(16)
                  .padding(16)
                  .width('100%')
                  .backgroundColor('#FFFFFF')
                  .borderRadius(8)
              }
            }, (item: string) => `item_${item}`)
          }
        }, (group: string) => `group_${group}`)
      }
      .width('100%')
      .height(300)
      .backgroundColor('#F5F5F5')
      .borderRadius(12)
      .padding(12)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }

  @Builder
  groupHeaderBuilder(title: string) {
    Text(title)
      .fontSize(16)
      .fontWeight(FontWeight.Bold)
      .width('100%')
      .padding(12)
  }
}

/**
 * List 主页面
 */
@ComponentV2
export struct ListExamplePage {
  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          Text('List Component Examples')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .padding({ left: 16, right: 16, top: 16, bottom: 8 })

          BasicListExample()
          GroupedListExample()

          // 使用说明
          Column({ space: 8 }) {
            Text('使用说明')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .width('100%')

            Text('• ListItem: 列表项组件')
              .fontSize(13)
              .fontColor('#666666')
              .width('100%')

            Text('• ListItemGroup: 分组列表项，可以设置头部')
              .fontSize(13)
              .fontColor('#666666')
              .width('100%')

            Text('• space 参数控制列表项之间的间距')
              .fontSize(13)
              .fontColor('#666666')
              .width('100%')

            Text('• List 组件支持懒加载，适合长列表')
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
    }
    .title('List 列表布局')
    .mode(NavDestinationMode.STANDARD)
  }
}

@Builder
function groupHeaderBuilder(title: string) {
  Text(title)
    .fontSize(16)
    .fontWeight(FontWeight.Bold)
    .width('100%')
    .padding(12)
}

@Builder
export function ListExamplePageBuilder() {
  ListExamplePage()
}
