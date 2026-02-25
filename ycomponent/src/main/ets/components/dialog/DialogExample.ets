/**
 * Dialog Component Examples
 * OpenHarmony Dialog Components 使用示例
 *
 * 展示 AlertDialog、ActionSheet、CustomDialog 组件的各种用法
 */

/**
 * AlertDialog 基础示例
 * 展示警告对话框的基本用法
 */
@ComponentV2
export struct BasicAlertDialogExample {
  build() {
    Column({ space: 16 }) {
      Text('AlertDialog 警告对话框')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      Button('显示警告对话框')
        .width('100%')
        .height(45)
        .type(ButtonType.Capsule)
        .backgroundColor('#FF3B30')
        .fontColor(Color.White)
        .onClick(() => {
          AlertDialog.show({
            title: '警告',
            message: '这是一个警告对话框，用于提示用户重要信息。',
            autoCancel: true,
            confirm: {
              value: '知道了',
              action: () => {
                console.info('点击了确认按钮')
              }
            },
            cancel: () => {
              console.info('对话框已关闭')
            }
          })
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * AlertDialog 确认示例
 * 展示确认对话框的使用
 */
@ComponentV2
export struct ConfirmDialogExample {
  @Local message: string = '等待操作...'

  build() {
    Column({ space: 16 }) {
      Text('AlertDialog 确认对话框')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      Button('删除项目')
        .width('100%')
        .height(45)
        .type(ButtonType.Capsule)
        .backgroundColor('#FF3B30')
        .fontColor(Color.White)
        .onClick(() => {
          AlertDialog.show({
            title: '确认删除',
            message: '删除后无法恢复，确定要删除这个项目吗？',
            autoCancel: true,
            primaryButton: {
              value: '取消',
              action: () => {
                this.message = '已取消删除'
              }
            },
            secondaryButton: {
              value: '删除',
              fontColor: '#FF3B30',
              action: () => {
                this.message = '已删除项目'
              }
            },
            cancel: () => {
              this.message = '对话框已关闭'
            }
          })
        })

      Text(this.message)
        .fontSize(14)
        .fontColor('#666666')
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * AlertDialog 输入示例
 * 展示带输入框的对话框
 */
@ComponentV2
export struct InputDialogExample {
  @Local inputValue: string = ''

  build() {
    Column({ space: 16 }) {
      Text('AlertDialog 输入对话框')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      Button('显示输入对话框')
        .width('100%')
        .height(45)
        .type(ButtonType.Capsule)
        .backgroundColor('#007DFF')
        .fontColor(Color.White)
        .onClick(() => {
          AlertDialog.show({
            title: '请输入内容',
            message: '输入您想分享的内容：',
            autoCancel: true,
            confirm: {
              value: '发送',
              action: () => {
                console.info('确认输入')
              }
            },
            cancel: () => {
              console.info('取消输入')
            }
          })
        })

      if (this.inputValue) {
        Text(`输入的内容: ${this.inputValue}`)
          .fontSize(14)
          .fontColor('#666666')
          .padding(12)
          .backgroundColor('#FFFFFF')
          .borderRadius(8)
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * ActionSheet 基础示例
 * 展示动作面板的基本用法
 */
@ComponentV2
export struct BasicActionSheetExample {
  @Local selectedAction: string = '未选择'

  build() {
    Column({ space: 16 }) {
      Text('ActionSheet 动作面板')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      Button('显示动作面板')
        .width('100%')
        .height(45)
        .type(ButtonType.Capsule)
        .backgroundColor('#007DFF')
        .fontColor(Color.White)
        .onClick(() => {
          ActionSheet.show({
            title: '选择操作',
            message: '请选择您要执行的操作',
            autoCancel: true,
            sheets: [
              {
                title: '拍照',
                action: () => {
                  this.selectedAction = '拍照'
                  console.info('选择拍照')
                }
              },
              {
                title: '从相册选择',
                action: () => {
                  this.selectedAction = '从相册选择'
                  console.info('选择相册')
                }
              },
              {
                title: '录制视频',
                action: () => {
                  this.selectedAction = '录制视频'
                  console.info('选择录制视频')
                }
              },
              {
                title: '取消',
                action: () => {
                  this.selectedAction = '取消'
                  console.info('取消操作')
                }
              }
            ],
            cancel: () => {
              console.info('动作面板已关闭')
            }
          })
        })

      Text(`选择: ${this.selectedAction}`)
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * ActionSheet 分组示例
 * 展示带分组和图标的动作面板
 */
@ComponentV2
export struct GroupedActionSheetExample {
  @Local result: string = ''

  build() {
    Column({ space: 16 }) {
      Text('ActionSheet 分组动作面板')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      Button('分享内容')
        .width('100%')
        .height(45)
        .type(ButtonType.Capsule)
        .backgroundColor('#28A745')
        .fontColor(Color.White)
        .onClick(() => {
          ActionSheet.show({
            title: '分享到',
            message: '请选择要分享的平台',
            autoCancel: true,
            sheets: [
              {
                title: '微信',
                action: () => {
                  this.result = '分享到微信'
                }
              },
              {
                title: '朋友圈',
                action: () => {
                  this.result = '分享到朋友圈'
                }
              },
              {
                title: '微博',
                action: () => {
                  this.result = '分享到微博'
                }
              },
              {
                title: 'QQ',
                action: () => {
                  this.result = '分享到QQ'
                }
              },
              {
                title: '邮件',
                action: () => {
                  this.result = '通过邮件分享'
                }
              },
              {
                title: '更多...',
                action: () => {
                  this.result = '更多选项'
                }
              }
            ],
            cancel: () => {
              this.result = '取消分享'
            }
          })
        })

      if (this.result) {
        Text(this.result)
          .fontSize(14)
          .fontColor('#666666')
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 自定义对话框
 * 展示如何使用 @CustomDialog 创建自定义对话框
 */
@CustomDialog
export struct MyCustomDialog {
  title: string = ''
  message: string = ''
  onConfirm: () => void = () => {}
  onCancel: () => void = () => {}
  controller: CustomDialogController = new CustomDialogController({
    builder: MyCustomDialog({}),
    autoCancel: true,
    alignment: DialogAlignment.Center
  })

  build() {
    Column({ space: 16 }) {
      // 标题
      Text(this.title)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')

      // 内容
      Text(this.message)
        .fontSize(16)
        .fontColor('#666666')
        .textAlign(TextAlign.Center)

      // 按钮组
      Row({ space: 12 }) {
        Button('取消')
          .width('45%')
          .height(40)
          .type(ButtonType.Normal)
          .backgroundColor('#E0E0E0')
          .fontColor('#333333')
          .onClick(() => {
            this.onCancel()
            this.controller.close()
          })

        Button('确认')
          .width('45%')
          .height(40)
          .type(ButtonType.Capsule)
          .backgroundColor('#007DFF')
          .fontColor(Color.White)
          .onClick(() => {
            this.onConfirm()
            this.controller.close()
          })
      }
      .width('100%')
    }
    .width(280)
    .padding(24)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .shadow({
      radius: 10,
      color: 'rgba(0, 0, 0, 0.1)',
      offsetX: 0,
      offsetY: 4
    })
  }
}

/**
 * 自定义对话框使用示例
 */
@ComponentV2
export struct CustomDialogExample {
  @Local dialogResult: string = ''

  dialogController: CustomDialogController = new CustomDialogController({
    builder: MyCustomDialog({
      title: '自定义对话框',
      message: '这是一个使用 @CustomDialog 创建的自定义对话框',
      onConfirm: () => {
        this.dialogResult = '点击了确认'
      },
      onCancel: () => {
        this.dialogResult = '点击了取消'
      }
    }),
    autoCancel: true,
    alignment: DialogAlignment.Center,
    customStyle: false
  })

  build() {
    Column({ space: 16 }) {
      Text('CustomDialog 自定义对话框')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      Button('显示自定义对话框')
        .width('100%')
        .height(45)
        .type(ButtonType.Capsule)
        .backgroundColor('#007DFF')
        .fontColor(Color.White)
        .onClick(() => {
          this.dialogController.open()
        })

      if (this.dialogResult) {
        Text(this.dialogResult)
          .fontSize(14)
          .fontColor('#666666')
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 自定义加载对话框
 */
@CustomDialog
export struct LoadingDialog {
  controller: CustomDialogController = new CustomDialogController({
    builder: LoadingDialog({}),
    autoCancel: true,
    alignment: DialogAlignment.Center
  })
  message: string = '加载中...'

  build() {
    Column({ space: 16 }) {
      LoadingProgress()
        .width(40)
        .height(40)
        .color('#007DFF')

      Text(this.message)
        .fontSize(16)
        .fontColor('#666666')
    }
    .width(150)
    .height(150)
    .justifyContent(FlexAlign.Center)
    .backgroundColor('rgba(0, 0, 0, 0.7)')
    .borderRadius(12)
  }
}

/**
 * 加载对话框示例
 */
@ComponentV2
export struct LoadingDialogExample {
  @Local isLoading: boolean = false
  loadingController: CustomDialogController = new CustomDialogController({
    builder: LoadingDialog({
      message: '正在加载...'
    }),
    autoCancel: false,
    alignment: DialogAlignment.Center,
    customStyle: true
  })

  build() {
    Column({ space: 16 }) {
      Text('LoadingDialog 加载对话框')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      Button('显示加载对话框')
        .width('100%')
        .height(45)
        .type(ButtonType.Capsule)
        .backgroundColor('#007DFF')
        .fontColor(Color.White)
        .onClick(() => {
          this.isLoading = true
          this.loadingController.open()

          // 模拟加载完成
          setTimeout(() => {
            this.isLoading = false
            this.loadingController.close()
          }, 2000)
        })

      if (this.isLoading) {
        Text('加载中...')
          .fontSize(14)
          .fontColor('#666666')
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 自定义列表对话框
 */
@CustomDialog
export struct ListDialog {
  items: string[] = []
  title: string = '选择项'
  onSelect: (index: number, item: string) => void = () => {}
  controller: CustomDialogController = new CustomDialogController({
    builder: ListDialog({}),
    autoCancel: true,
    alignment: DialogAlignment.Center
  })

  build() {
    Column({ space: 0 }) {
      // 标题
      Text(this.title)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .width('100%')
        .padding(16)

      // 分割线
      Divider()
        .color('#E0E0E0')

      // 列表项
      ForEach(this.items, (item: string, index: number) => {
        Column() {
          Text(item)
            .fontSize(16)
            .fontColor('#333333')
            .width('100%')
            .padding(16)
            .onClick(() => {
              this.onSelect(index, item)
              this.controller.close()
            })

          if (index < this.items.length - 1) {
            Divider()
              .color('#F0F0F0')
              .margin({ left: 16, right: 16 })
          }
        }
      }, (item: string, index: number) => `${index}_${item}`)
    }
    .width(300)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .shadow({
      radius: 10,
      color: 'rgba(0, 0, 0, 0.1)',
      offsetX: 0,
      offsetY: 4
    })
  }
}

/**
 * 列表对话框示例
 */
@ComponentV2
export struct ListDialogExample {
  @Local selectedItem: string = '未选择'

  listDialogController: CustomDialogController = new CustomDialogController({
    builder: ListDialog({
      title: '选择语言',
      items: ['简体中文', 'English', '日本語', '한국어'],
      onSelect: (index: number, item: string) => {
        this.selectedItem = item
      }
    }),
    autoCancel: true,
    alignment: DialogAlignment.Center
  })

  build() {
    Column({ space: 16 }) {
      Text('ListDialog 列表对话框')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .margin({ bottom: 8 })

      Button('选择语言')
        .width('100%')
        .height(45)
        .type(ButtonType.Capsule)
        .backgroundColor('#007DFF')
        .fontColor(Color.White)
        .onClick(() => {
          this.listDialogController.open()
        })

      Text(`当前语言: ${this.selectedItem}`)
        .fontSize(14)
        .fontColor('#666666')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

/**
 * 完整的对话框示例页面
 * 集成所有对话框示例
 */
@ComponentV2
export struct DialogExamplePage {
  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          Text('Dialog Component Examples')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .width('100%')
            .padding({ left: 16, right: 16, top: 16, bottom: 8 })

          BasicAlertDialogExample()
          ConfirmDialogExample()
          InputDialogExample()
          BasicActionSheetExample()
          GroupedActionSheetExample()
          CustomDialogExample()
          LoadingDialogExample()
          ListDialogExample()
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
    }
    .title('Dialog 对话框组件示例')
    .mode(NavDestinationMode.STANDARD)
  }
}

@Builder
export function DialogExamplePageBuilder() {
  DialogExamplePage()
}
