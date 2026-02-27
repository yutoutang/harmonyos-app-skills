/**
 * Push Kit 示例页面
 * 演示推送服务的初始化、令牌获取、主题订阅等功能
 */

import { pushService } from '@kit.PushKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * 推送消息
 */
interface PushMessage {
  title: string
  content: string
  data?: Record<string, string>
}

/**
 * Push Kit 示例 ViewModel
 */
@ObservedV2
export class PushKitExampleVM {
  @Trace token: string = ''
  @Trace topics: string[] = []
  @Trace messages: PushMessage[] = []
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false
  @Trace isEnabled: boolean = false

  /**
   * 初始化推送服务
   */
  async initializePush(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      // 检查推送服务是否可用
      const isAvailable = await pushService.isPushServiceAvailable()
      this.isEnabled = isAvailable

      if (isAvailable) {
        hilog.info(0x0000, 'PushKitExample', 'Push service initialized')
      } else {
        this.errorMessage = '推送服务不可用'
      }
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `初始化失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'PushKitExample', 'Initialize failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 获取推送令牌
   */
  async getPushToken(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      const tokenResult = await pushService.getToken()
      this.token = tokenResult.token
      hilog.info(0x0000, 'PushKitExample', 'Token obtained')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `获取令牌失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'PushKitExample', 'Get token failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 订阅主题
   */
  async subscribeTopic(topic: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      await pushService.subscribe(topic)
      this.topics.push(topic)
      hilog.info(0x0000, 'PushKitExample', `Topic ${topic} subscribed`)
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `订阅失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'PushKitExample', 'Subscribe failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 取消订阅主题
   */
  async unsubscribeTopic(topic: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      await pushService.unsubscribe(topic)
      this.topics = this.topics.filter(t => t !== topic)
      hilog.info(0x0000, 'PushKitExample', `Topic ${topic} unsubscribed`)
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `取消订阅失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'PushKitExample', 'Unsubscribe failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 发送本地消息
   */
  sendLocalMessage(title: string, content: string): void {
    const message: PushMessage = {
      title: title,
      content: content,
      data: { source: 'local' }
    }
    this.messages.unshift(message)
    hilog.info(0x0000, 'PushKitExample', 'Local message sent')
  }

  /**
   * 清除消息历史
   */
  clearMessages(): void {
    this.messages = []
    hilog.info(0x0000, 'PushKitExample', 'Messages cleared')
  }
}

/**
 * Push Kit 示例页面
 */
@ComponentV2
export struct PushKitExamplePage {
  @Local vm: PushKitExampleVM = new PushKitExampleVM()
  @Local topicInput: string = ''
  @Local messageTitle: string = ''
  @Local messageContent: string = ''

  aboutToAppear(): void {
    this.vm.initializePush()
  }

  build() {
    Column() {
      // 标题
      Text('推送 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 状态卡片
          this.buildStatusCard()

          // 令牌卡片
          this.buildTokenCard()

          // 主题订阅卡片
          this.buildTopicCard()

          // 消息测试卡片
          this.buildMessageCard()

          // 消息历史卡片
          this.buildMessageHistoryCard()

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
  buildStatusCard() {
    Column() {
      Text('推送状态')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Row() {
        Circle()
          .width(12)
          .height(12)
          .fill(this.vm.isEnabled ? '#4CAF50' : '#999999')
          .margin({ right: 8 })

        Text(this.vm.isEnabled ? '推送服务已启用' : '推送服务未启用')
          .fontSize(14)
          .fontColor(this.vm.isEnabled ? '#4CAF50' : '#999999')
      }

      Button('刷新状态')
        .width('100%')
        .margin({ top: 12 })
        .enabled(!this.vm.isLoading)
        .onClick(() => {
          this.vm.initializePush()
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  buildTokenCard() {
    Column() {
      Text('推送令牌')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      if (this.vm.token) {
        Text(this.vm.token)
          .fontSize(12)
          .fontColor('#666666')
          .maxLines(3)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      } else {
        Text('未获取令牌')
          .fontSize(14)
          .fontColor('#999999')
      }

      Button('获取令牌')
        .width('100%')
        .margin({ top: 12 })
        .enabled(!this.vm.isLoading && this.vm.isEnabled)
        .onClick(() => {
          this.vm.getPushToken()
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .margin({ top: 16 })
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  buildTopicCard() {
    Column() {
      Text('主题订阅')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      // 主题输入
      TextInput({ placeholder: '输入主题名称', text: this.topicInput })
        .width('100%')
        .onChange((value: string) => {
          this.topicInput = value
        })

      Row() {
        Button('订阅')
          .flexGrow(1)
          .enabled(!this.vm.isLoading && this.topicInput.length > 0)
          .onClick(() => {
            this.vm.subscribeTopic(this.topicInput)
            this.topicInput = ''
          })

        Button('取消订阅')
          .flexGrow(1)
          .enabled(!this.vm.isLoading && this.topicInput.length > 0)
          .onClick(() => {
            this.vm.unsubscribeTopic(this.topicInput)
            this.topicInput = ''
          })
      }
      .width('100%')
      .margin({ top: 12 })

      // 已订阅主题列表
      if (this.vm.topics.length > 0) {
        Text('已订阅主题:')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .width('100%')
          .margin({ top: 16, bottom: 8 })

       ForEach(this.vm.topics, (topic: string) => {
          Row() {
            Text(topic)
              .fontSize(14)
              .layoutWeight(1)

            Button('取消')
              .fontSize(12)
              .onClick(() => {
                this.vm.unsubscribeTopic(topic)
              })
          }
          .width('100%')
          .padding(8)
          .backgroundColor('#F5F5F5')
          .borderRadius(8)
          .margin({ bottom: 8 })
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

  @Builder
  buildMessageCard() {
    Column() {
      Text('发送测试消息')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      TextInput({ placeholder: '消息标题', text: this.messageTitle })
        .width('100%')
        .margin({ bottom: 8 })
        .onChange((value: string) => {
          this.messageTitle = value
        })

      TextArea({ placeholder: '消息内容', text: this.messageContent })
        .width('100%')
        .height(80)
        .margin({ bottom: 12 })
        .onChange((value: string) => {
          this.messageContent = value
        })

      Button('发送本地消息')
        .width('100%')
        .enabled(!this.vm.isLoading && this.messageTitle.length > 0 && this.messageContent.length > 0)
        .onClick(() => {
          this.vm.sendLocalMessage(this.messageTitle, this.messageContent)
          this.messageTitle = ''
          this.messageContent = ''
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .margin({ top: 16 })
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  buildMessageHistoryCard() {
    Column() {
      Row() {
        Text('消息历史')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)

        Blank()

        if (this.vm.messages.length > 0) {
          Button('清除')
            .fontSize(12)
            .onClick(() => {
              this.vm.clearMessages()
            })
        }
      }
      .width('100%')
      .margin({ bottom: 12 })

      if (this.vm.messages.length === 0) {
        Text('暂无消息')
          .fontSize(14)
          .fontColor('#999999')
      } else {
        ForEach(this.vm.messages, (message: PushMessage, index: number) => {
          Column() {
            Text(message.title)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .width('100%')

            Text(message.content)
              .fontSize(14)
              .fontColor('#666666')
              .width('100%')
              .margin({ top: 4 })

            if (message.data) {
              Text(`来源: ${message.data.source}`)
                .fontSize(12)
                .fontColor('#999999')
                .width('100%')
                .margin({ top: 4 })
            }
          }
          .width('100%')
          .padding(12)
          .backgroundColor('#F5F5F5')
          .borderRadius(8)
          .margin({ bottom: 8 })
          .alignItems(HorizontalAlign.Start)
        })
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .margin({ top: 16 })
    .alignItems(HorizontalAlign.Start)

    if (this.vm.isLoading) {
      LoadingProgress()
        .width(40)
        .height(40)
        .margin({ top: 16 })
    }
  }
}

@Builder
export function PushKitExamplePageBuilder() {
  PushKitExamplePage()
}
