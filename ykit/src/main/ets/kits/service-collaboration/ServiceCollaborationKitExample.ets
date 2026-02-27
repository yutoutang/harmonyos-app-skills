/**
 * Service Collaboration Kit 示例页面
 * 演示服务协作功能
 */

import { serviceCollaboration } from '@kit.ServiceCollaborationKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * Service Collaboration Kit 示例 ViewModel
 */
@ObservedV2
export class ServiceCollaborationKitExampleVM {
  @Trace collaborationEnabled: boolean = false
  @Trace connectedServices: string[] = []
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false

  /**
   * 启用服务协作
   */
  async enableCollaboration(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.collaborationEnabled = true
      hilog.info(0x0000, 'ServiceCollaborationExample', 'Collaboration enabled')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `启用失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'ServiceCollaborationExample', 'Enable failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 连接服务
   */
  async connectService(serviceName: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.connectedServices.push(serviceName)
      hilog.info(0x0000, 'ServiceCollaborationExample', `Service ${serviceName} connected`)
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `连接失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'ServiceCollaborationExample', 'Connect failed')
    } finally {
      this.isLoading = false
    }
  }
}

/**
 * Service Collaboration Kit 示例页面
 */
@ComponentV2
export struct ServiceCollaborationKitExamplePage {
  @Local vm: ServiceCollaborationKitExampleVM = new ServiceCollaborationKitExampleVM()
  @Local serviceNameInput: string = '健康服务'

  build() {
    Column() {
      Text('服务协作 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 协作状态卡片
          this.buildCollaborationCard()

          // 服务连接卡片
          if (this.vm.collaborationEnabled) {
            this.buildServiceConnectionCard()
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
  buildCollaborationCard() {
    Column() {
      Text('服务协作状态')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Row() {
        Circle()
          .width(12)
          .height(12)
          .fill(this.vm.collaborationEnabled ? '#4CAF50' : '#999999')
          .margin({ right: 8 })

        Text(this.vm.collaborationEnabled ? '已启用' : '未启用')
          .fontSize(14)
          .fontColor(this.vm.collaborationEnabled ? '#4CAF50' : '#999999')
      }

      Button(this.vm.collaborationEnabled ? '禁用协作' : '启用协作')
        .width('100%')
        .margin({ top: 12 })
        .enabled(!this.vm.isLoading)
        .onClick(() => {
          if (this.vm.collaborationEnabled) {
            this.vm.collaborationEnabled = false
          } else {
            this.vm.enableCollaboration()
          }
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
  buildServiceConnectionCard() {
    Column() {
      Text('服务连接')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      TextInput({ placeholder: '服务名称', text: this.serviceNameInput })
        .width('100%')
        .margin({ bottom: 12 })
        .onChange((value: string) => {
          this.serviceNameInput = value
        })

      Button('连接服务')
        .width('100%')
        .enabled(!this.vm.isLoading && this.serviceNameInput.length > 0)
        .onClick(() => {
          this.vm.connectService(this.serviceNameInput)
          this.serviceNameInput = ''
        })

      if (this.vm.connectedServices.length > 0) {
        Text('已连接服务:')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .width('100%')
          .margin({ top: 16, bottom: 8 })

       ForEach(this.vm.connectedServices, (service: string, index: number) => {
          Text(`${index + 1}. ${service}`)
            .fontSize(14)
            .width('100%')
            .padding(8)
            .backgroundColor('#F5F5F5')
            .borderRadius(4)
            .margin({ bottom: 4 })
        })
      }
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
export function ServiceCollaborationKitExamplePageBuilder() {
  ServiceCollaborationKitExamplePage()
}
