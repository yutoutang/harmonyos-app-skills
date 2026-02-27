/**
 * Wallet Kit 示例页面
 * 演示钱包服务功能
 */

import { wallet } from '@kit.WalletKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * 钱包卡片信息
 */
interface WalletCard {
  id: string
  name: string
  type: string
  balance: string
}

/**
 * Wallet Kit 示例 ViewModel
 */
@ObservedV2
export class WalletKitExampleVM {
  @Trace cards: WalletCard[] = []
  @Trace isAdded: boolean = false
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false

  /**
   * 添加卡片
   */
  async addCard(cardName: string, cardType: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      const card: WalletCard = {
        id: `card_${Date.now()}`,
        name: cardName,
        type: cardType,
        balance: '¥0.00'
      }
      this.cards.push(card)
      this.isAdded = true
      hilog.info(0x0000, 'WalletExample', 'Card added')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `添加失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'WalletExample', 'Add card failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 移除卡片
   */
  async removeCard(cardId: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.cards = this.cards.filter(card => card.id !== cardId)
      hilog.info(0x0000, 'WalletExample', 'Card removed')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `移除失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'WalletExample', 'Remove card failed')
    } finally {
      this.isLoading = false
    }
  }
}

/**
 * Wallet Kit 示例页面
 */
@ComponentV2
export struct WalletKitExamplePage {
  @Local vm: WalletKitExampleVM = new WalletKitExampleVM()
  @Local cardNameInput: string = '我的银行卡'
  @Local cardTypeInput: string = '借记卡'

  build() {
    Column() {
      Text('钱包 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 添加卡片卡片
          this.buildAddCardCard()

          // 卡片列表卡片
          this.buildCardListCard()

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
  buildAddCardCard() {
    Column() {
      Text('添加卡片')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      TextInput({ placeholder: '卡片名称', text: this.cardNameInput })
        .width('100%')
        .margin({ bottom: 12 })
        .onChange((value: string) => {
          this.cardNameInput = value
        })

      TextInput({ placeholder: '卡片类型', text: this.cardTypeInput })
        .width('100%')
        .margin({ bottom: 12 })
        .onChange((value: string) => {
          this.cardTypeInput = value
        })

      Button('添加卡片')
        .width('100%')
        .enabled(!this.vm.isLoading && this.cardNameInput.length > 0)
        .onClick(() => {
          this.vm.addCard(this.cardNameInput, this.cardTypeInput)
          this.cardNameInput = ''
          this.cardTypeInput = ''
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
  buildCardListCard() {
    Column() {
      Text('我的卡片')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      if (this.vm.cards.length === 0) {
        Text('暂无卡片')
          .fontSize(14)
          .fontColor('#999999')
      } else {
       ForEach(this.vm.cards, (card: WalletCard) => {
          Column() {
            Row() {
              Column() {
                Text(card.name)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)

                Text(card.type)
                  .fontSize(12)
                  .fontColor('#666666')
                  .margin({ top: 4 })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Text(card.balance)
                .fontSize(18)
                .fontColor('#007DFF')
                .fontWeight(FontWeight.Bold)
            }
            .width('100%')

            Button('移除卡片')
              .width('100%')
              .margin({ top: 8 })
              .fontSize(12)
              .backgroundColor('#FF3B30')
              .enabled(!this.vm.isLoading)
              .onClick(() => {
                this.vm.removeCard(card.id)
              })
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
  }
}

@Builder
export function WalletKitExamplePageBuilder() {
  WalletKitExamplePage()
}
