/**
 * Enterprise Space Kit 示例页面
 * 演示企业空间功能
 */

import { enterpriseSpace } from '@kit.EnterpriseSpaceKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * Enterprise Space Kit 示例 ViewModel
 */
@ObservedV2
export class EnterpriseSpaceKitExampleVM {
  @Trace isJoined: boolean = false
  @Trace spaceName: string = ''
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false

  /**
   * 加入企业空间
   */
  async joinSpace(spaceName: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.isJoined = true
      this.spaceName = spaceName
      hilog.info(0x0000, 'EnterpriseSpaceExample', 'Space joined')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `加入失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'EnterpriseSpaceExample', 'Join failed')
    } finally {
      this.isLoading = false
    }
  }
}

/**
 * Enterprise Space Kit 示例页面
 */
@ComponentV2
export struct EnterpriseSpaceKitExamplePage {
  @Local vm: EnterpriseSpaceKitExampleVM = new EnterpriseSpaceKitExampleVM()
  @Local spaceInput: string = '示例企业'

  build() {
    Column() {
      Text('企业空间 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 加入空间卡片
          this.buildJoinCard()

          // 空间信息卡片
          if (this.vm.isJoined) {
            this.buildSpaceInfoCard()
          }

          // 错误信息
          if (this.vm.errorMessage) {
            Text(this.vm.errorMessage)
              .fontSize(14)
              .fontColor('#FF3B30')
              .margin({ top: 16 })
          }
        }
        .width('100%')
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#F5F5F5')
  }

  @Builder
  buildJoinCard() {
    Column() {
      Text('加入企业空间')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      TextInput({ placeholder: '企业空间名称', text: this.spaceInput })
        .width('100%')
        .margin({ bottom: 12 })
        .onChange((value: string) => {
          this.spaceInput = value
        })

      Button('加入空间')
        .width('100%')
        .enabled(!this.vm.isLoading && !this.vm.isJoined)
        .onClick(() => {
          this.vm.joinSpace(this.spaceInput)
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .alignItems(HorizontalAlign.Start)

    if (this.vm.isLoading) {
      LoadingProgress()
        .width(40)
        .height(40)
        .margin({ top: 16 })
    }
  }

  @Builder
  buildSpaceInfoCard() {
    Column() {
      Text('空间信息')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Text(`企业: ${this.vm.spaceName}`)
        .fontSize(14)
        .width('100%')

      Text('状态: 已加入')
        .fontSize(14)
        .fontColor('#4CAF50')
        .width('100%')
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .margin({ top: 16 })
    .alignItems(HorizontalAlign.Start)
  }
}

@Builder
export function EnterpriseSpaceKitExamplePageBuilder() {
  EnterpriseSpaceKitExamplePage()
}
