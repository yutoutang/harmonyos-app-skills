/**
 * Payment Kit 示例页面
 * 演示华为支付功能
 */

import { pay } from '@kit.PaymentKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * 支付信息
 */
interface PaymentInfo {
  orderId: string
  amount: string
  status: string
  timestamp: number
}

/**
 * Payment Kit 示例 ViewModel
 */
@ObservedV2
export class PaymentKitExampleVM {
  @Trace payments: PaymentInfo[] = []
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false
  @Trace isReady: boolean = false

  /**
   * 检查支付服务可用性
   */
  async checkPaymentAvailability(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      const isAvailable = await pay.isSupportHuaweiPay()
      this.isReady = isAvailable
      hilog.info(0x0000, 'PaymentKitExample', 'Payment service checked')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `检查失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'PaymentKitExample', 'Check failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 发起支付
   */
  async requestPayment(amount: string, orderId: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      const paymentRequest: pay.PaymentRequest = {
        orderId: orderId,
        amount: amount,
        currency: 'CNY',
        merchantName: '示例商户',
        description: '测试支付'
      }

      const result = await pay.pay(paymentRequest)

      const paymentInfo: PaymentInfo = {
        orderId: orderId,
        amount: amount,
        status: result.returnCode === 0 ? '成功' : '失败',
        timestamp: Date.now()
      }

      this.payments.unshift(paymentInfo)
      hilog.info(0x0000, 'PaymentKitExample', 'Payment completed')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `支付失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'PaymentKitExample', 'Payment failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 查询支付状态
   */
  async queryPaymentStatus(orderId: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      const status = await pay.queryPayment(orderId)
      hilog.info(0x0000, 'PaymentKitExample', `Payment status: ${status}`)
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `查询失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'PaymentKitExample', 'Query failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 清除支付记录
   */
  clearPaymentHistory(): void {
    this.payments = []
    hilog.info(0x0000, 'PaymentKitExample', 'Payment history cleared')
  }
}

/**
 * Payment Kit 示例页面
 */
@ComponentV2
export struct PaymentKitExamplePage {
  @Local vm: PaymentKitExampleVM = new PaymentKitExampleVM()
  @Local amountInput: string = '0.01'
  @Local orderIdInput: string = ''

  aboutToAppear(): void {
    this.vm.checkPaymentAvailability()
    this.orderIdInput = `ORDER_${Date.now()}`
  }

  build() {
    Column() {
      // 标题
      Text('支付 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 状态卡片
          this.buildStatusCard()

          // 发起支付卡片
          this.buildPaymentCard()

          // 支付记录卡片
          this.buildPaymentHistoryCard()

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
      Text('支付服务状态')
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

        Text(this.vm.isReady ? '华为支付可用' : '华为支付不可用')
          .fontSize(14)
          .fontColor(this.vm.isReady ? '#4CAF50' : '#999999')
      }

      Button('刷新状态')
        .width('100%')
        .margin({ top: 12 })
        .enabled(!this.vm.isLoading)
        .onClick(() => {
          this.vm.checkPaymentAvailability()
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  buildPaymentCard() {
    Column() {
      Text('发起支付')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      // 订单ID
      TextInput({ placeholder: '订单ID', text: this.orderIdInput })
        .width('100%')
        .margin({ bottom: 12 })
        .enabled(!this.vm.isLoading)
        .onChange((value: string) => {
          this.orderIdInput = value
        })

      // 金额
      TextInput({ placeholder: '金额 (元)', text: this.amountInput })
        .width('100%')
        .type(InputType.Number)
        .margin({ bottom: 12 })
        .enabled(!this.vm.isLoading)
        .onChange((value: string) => {
          this.amountInput = value
        })

      // 支付按钮
      Button('发起支付')
        .width('100%')
        .enabled(!this.vm.isLoading && this.vm.isReady && this.amountInput.length > 0)
        .onClick(() => {
          this.vm.requestPayment(this.amountInput, this.orderIdInput)
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
  buildPaymentHistoryCard() {
    Column() {
      Row() {
        Text('支付记录')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)

        Blank()

        if (this.vm.payments.length > 0) {
          Button('清除')
            .fontSize(12)
            .onClick(() => {
              this.vm.clearPaymentHistory()
            })
        }
      }
      .width('100%')
      .margin({ bottom: 12 })

      if (this.vm.payments.length === 0) {
        Text('暂无支付记录')
          .fontSize(14)
          .fontColor('#999999')
      } else {
       ForEach(this.vm.payments, (payment: PaymentInfo) => {
          Column() {
            Row() {
              Text(`订单: ${payment.orderId}`)
                .fontSize(14)
                .layoutWeight(1)

              Text(payment.status)
                .fontSize(12)
                .fontColor(payment.status === '成功' ? '#4CAF50' : '#FF3B30')
            }
            .width('100%')

            Text(`金额: ¥${payment.amount}`)
              .fontSize(16)
              .fontColor('#FF6B00')
              .fontWeight(FontWeight.Bold)
              .width('100%')
              .margin({ top: 4 })

            Text(`时间: ${new Date(payment.timestamp).toLocaleString()}`)
              .fontSize(12)
              .fontColor('#999999')
              .width('100%')
              .margin({ top: 4 })

            Button('查询状态')
              .width('100%')
              .margin({ top: 8 })
              .enabled(!this.vm.isLoading)
              .onClick(() => {
                this.vm.queryPaymentStatus(payment.orderId)
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

    if (this.vm.isLoading) {
      LoadingProgress()
        .width(40)
        .height(40)
        .margin({ top: 16 })
    }
  }
}

@Builder
export function PaymentKitExamplePageBuilder() {
  PaymentKitExamplePage()
}
