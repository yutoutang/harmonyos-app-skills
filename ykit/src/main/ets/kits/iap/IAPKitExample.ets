/**
 * IAP (In-App Purchase) Kit 示例页面
 * 演示应用内购买功能，包括消费型商品、非消费型商品、订阅等
 */

import { iap } from '@kit.IAPKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * 商品信息
 */
interface ProductInfo {
  productId: string
  price: string
  title: string
  description: string
  type: string
}

/**
 * 购买记录
 */
interface PurchaseRecord {
  orderId: string
  productId: string
  purchaseTime: number
  status: string
}

/**
 * IAP Kit 示例 ViewModel
 */
@ObservedV2
export class IAPKitExampleVM {
  @Trace products: ProductInfo[] = []
  @Trace purchases: PurchaseRecord[] = []
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false
  @Trace isReady: boolean = false

  /**
   * 初始化 IAP 服务
   */
  async initializeIAP(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      // 环境准备
      await iap.prepareEnv()
      this.isReady = true
      hilog.info(0x0000, 'IAPKitExample', 'IAP service initialized')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `初始化失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'IAPKitExample', 'Initialize failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 查询商品信息
   */
  async queryProducts(productIds: string[]): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      const productReq = {
        type: iap.ProductType.IN_APP_CONSUMABLE,
        productIds: productIds
      }

      const result = await iap.queryProducts(productReq)
      this.products = result.productInfoList || []
      hilog.info(0x0000, 'IAPKitExample', 'Products queried')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `查询商品失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'IAPKitExample', 'Query products failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 购买商品
   */
  async purchase(productId: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      const purchaseReq = {
        productId: productId,
        type: iap.ProductType.IN_APP_CONSUMABLE
      }

      const result = await iap.createPurchase(purchaseReq)

      const record: PurchaseRecord = {
        orderId: result.orderId || '',
        productId: productId,
        purchaseTime: Date.now(),
        status: result.purchaseState === 0 ? '成功' : '失败'
      }

      this.purchases.unshift(record)
      hilog.info(0x0000, 'IAPKitExample', 'Purchase completed')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `购买失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'IAPKitExample', 'Purchase failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 消费购买
   */
  async consumePurchase(purchaseToken: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      const consumeReq = {
        purchaseToken: purchaseToken,
        developerPayload: ''
      }

      await iap.consumePurchase(consumeReq)
      hilog.info(0x0000, 'IAPKitExample', 'Purchase consumed')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `消费失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'IAPKitExample', 'Consume failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 查询已购商品
   */
  async queryPurchases(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      const result = await iap.queryPurchases()
      // 处理购买记录
      hilog.info(0x0000, 'IAPKitExample', 'Purchases queried')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `查询购买记录失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'IAPKitExample', 'Query purchases failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 清除购买记录
   */
  clearPurchaseHistory(): void {
    this.purchases = []
    hilog.info(0x0000, 'IAPKitExample', 'Purchase history cleared')
  }
}

/**
 * IAP Kit 示例页面
 */
@ComponentV2
export struct IAPKitExamplePage {
  @Local vm: IAPKitExampleVM = new IAPKitExampleVM()
  @Local productIdsInput: string = 'coin100,coin500,coin1000'

  aboutToAppear(): void {
    this.vm.initializeIAP()
  }

  build() {
    Column() {
      // 标题
      Text('应用内购买 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 状态卡片
          this.buildStatusCard()

          // 商品查询卡片
          this.buildProductsCard()

          // 购买记录卡片
          this.buildPurchaseHistoryCard()

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
      Text('服务状态')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Row() {
        Circle()
          .width(12)
          .height(12)
          .fill(this.vm.isReady ? '#4CAF50' : '#999999')
          .margin({ right: 8 })

        Text(this.vm.isReady ? 'IAP 服务已就绪' : 'IAP 服务未就绪')
          .fontSize(14)
          .fontColor(this.vm.isReady ? '#4CAF50' : '#999999')
      }

      Button('初始化服务')
        .width('100%')
        .margin({ top: 12 })
        .enabled(!this.vm.isLoading)
        .onClick(() => {
          this.vm.initializeIAP()
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  buildProductsCard() {
    Column() {
      Text('商品管理')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      // 商品ID输入
      TextInput({ placeholder: '商品ID (逗号分隔)', text: this.productIdsInput })
        .width('100%')
        .onChange((value: string) => {
          this.productIdsInput = value
        })

      Row() {
        Button('查询商品')
          .flexGrow(1)
          .enabled(!this.vm.isLoading && this.vm.isReady)
          .onClick(() => {
            const ids = this.productIdsInput.split(',').map(id => id.trim()).filter(id => id)
            this.vm.queryProducts(ids)
          })

        Button('查询购买记录')
          .flexGrow(1)
          .enabled(!this.vm.isLoading && this.vm.isReady)
          .onClick(() => {
            this.vm.queryPurchases()
          })
      }
      .width('100%')
      .margin({ top: 12 })

      // 商品列表
      if (this.vm.products.length > 0) {
        Text('商品列表:')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .width('100%')
          .margin({ top: 16, bottom: 8 })

       ForEach(this.vm.products, (product: ProductInfo) => {
          Column() {
            Row() {
              Text(product.title)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .layoutWeight(1)

              Text(product.price)
                .fontSize(16)
                .fontColor('#FF6B00')
                .fontWeight(FontWeight.Bold)
            }
            .width('100%')

            Text(product.description)
              .fontSize(14)
              .fontColor('#666666')
              .width('100%')
              .margin({ top: 4 })

            Text(`类型: ${product.type}`)
              .fontSize(12)
              .fontColor('#999999')
              .width('100%')
              .margin({ top: 4 })

            Button('购买')
              .width('100%')
              .margin({ top: 8 })
              .enabled(!this.vm.isLoading)
              .onClick(() => {
                this.vm.purchase(product.productId)
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

  @Builder
  buildPurchaseHistoryCard() {
    Column() {
      Row() {
        Text('购买记录')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)

        Blank()

        if (this.vm.purchases.length > 0) {
          Button('清除')
            .fontSize(12)
            .onClick(() => {
              this.vm.clearPurchaseHistory()
            })
        }
      }
      .width('100%')
      .margin({ bottom: 12 })

      if (this.vm.purchases.length === 0) {
        Text('暂无购买记录')
          .fontSize(14)
          .fontColor('#999999')
      } else {
       ForEach(this.vm.purchases, (record: PurchaseRecord) => {
          Column() {
            Row() {
              Text(`订单: ${record.orderId}`)
                .fontSize(14)
                .layoutWeight(1)

              Text(record.status)
                .fontSize(12)
                .fontColor(record.status === '成功' ? '#4CAF50' : '#FF3B30')
            }
            .width('100%')

            Text(`商品: ${record.productId}`)
              .fontSize(12)
              .fontColor('#666666')
              .width('100%')
              .margin({ top: 4 })

            Text(`时间: ${new Date(record.purchaseTime).toLocaleString()}`)
              .fontSize(12)
              .fontColor('#999999')
              .width('100%')
              .margin({ top: 4 })
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
export function IAPKitExamplePageBuilder() {
  IAPKitExamplePage()
}
