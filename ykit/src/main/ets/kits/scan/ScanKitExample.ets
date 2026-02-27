/**
 * 扫码 Kit 示例页面
 * 演示扫码、生成码等功能
 */

import {
  scanBarcode,
  generateBarcode,
  scanCore,
  customScan
} from '@kit.ScanKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { image } from '@kit.ImageKit'
import { BusinessError } from '@kit.BasicServicesKit'
import { abilityAccessCtrl, Permissions } from '@kit.AbilityKit'

/**
 * 扫码结果模型
 */
interface ScanResult {
  originalValue: string
  scanType: scanCore.ScanType
  format: string
}

/**
 * 扫码 Kit 示例 ViewModel
 */
@ObservedV2
export class ScanKitExampleVM {
  @Trace scanResult: string = ''
  @Trace generatedQRCode: image.PixelMap | null = null
  @Trace isLoading: boolean = false
  @Trace errorMessage: string = ''

  /**
   * 请求相机权限
   */
  async requestCameraPermission(): Promise<boolean> {
    try {
      const atManager = abilityAccessCtrl.createAtManager()
      const permissions: Array<Permissions> = ['ohos.permission.CAMERA']
      const result = await atManager.requestPermissionsFromUser(getContext(), permissions)
      return result.authResults[0] === 0
    } catch (error) {
      hilog.error(0x0000, 'ScanKitExample', 'Request camera permission failed')
      return false
    }
  }

  /**
   * 使用默认界面扫码
   */
  async scanWithDefaultView(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    const hasPermission = await this.requestCameraPermission()
    if (!hasPermission) {
      this.errorMessage = '需要相机权限才能扫码'
      this.isLoading = false
      return
    }

    try {
      const result = await scanBarcode.start({
        scanTypes: [scanCore.ScanType.ALL]
      })

      this.scanResult = result.originalValue
      hilog.info(0x0000, 'ScanKitExample', 'Scan result: %{public}s', result.originalValue)
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `扫码失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'ScanKitExample', 'Scan failed: %{public}d', err.code)
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 生成二维码
   */
  async generateQRCode(content: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      const pixelMap = await generateBarcode.create(
        content || 'https://developer.huawei.com',
        scanCore.ScanType.QR_CODE,
        {
          width: 300,
          height: 300,
          backgroundColor: 0xFFFFFFFF,
          foregroundColor: 0xFF000000
        }
      )

      // 释放旧的 PixelMap
      if (this.generatedQRCode) {
        await this.generatedQRCode.release()
      }

      this.generatedQRCode = pixelMap
      hilog.info(0x0000, 'ScanKitExample', 'QR code generated successfully')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `生成二维码失败: ${err.message}`
      hilog.error(0x0000, 'ScanKitExample', 'Generate QR code failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 生成条形码
   */
  async generateBarCode(content: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      const pixelMap = await generateBarcode.create(
        content || '1234567890',
        scanCore.ScanType.EAN_13,
        {
          width: 400,
          height: 150,
          backgroundColor: 0xFFFFFFFF,
          foregroundColor: 0xFF000000
        }
      )

      if (this.generatedQRCode) {
        await this.generatedQRCode.release()
      }

      this.generatedQRCode = pixelMap
      hilog.info(0x0000, 'ScanKitExample', 'Barcode generated successfully')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `生成条形码失败: ${err.message}`
      hilog.error(0x0000, 'ScanKitExample', 'Generate barcode failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 清除生成的码图
   */
  async clearGeneratedCode(): Promise<void> {
    if (this.generatedQRCode) {
      await this.generatedQRCode.release()
      this.generatedQRCode = null
    }
  }

  aboutToRecycle(): void {
    if (this.generatedQRCode) {
      this.generatedQRCode.release()
    }
  }
}

/**
 * 扫码 Kit 示例页面
 */
@ComponentV2
export struct ScanKitExamplePage {
  @Local vm: ScanKitExampleVM = new ScanKitExampleVM()
  @Local inputContent: string = ''

  build() {
    Column() {
      // 标题
      Text('扫码 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      // 扫码区域
      Column() {
        Text('扫码识别')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .width('100%')
          .margin({ bottom: 12 })

        Button('开始扫码')
          .width('100%')
          .enabled(!this.vm.isLoading)
          .onClick(() => {
            this.vm.scanWithDefaultView()
          })

        // 扫码结果
        if (this.vm.scanResult) {
          Column() {
            Text('扫码结果:')
              .fontSize(14)
              .fontColor('#666666')
            Text(this.vm.scanResult)
              .fontSize(16)
              .margin({ top: 8 })
              .copyable(this.vm.scanResult)
          }
          .width('100%')
          .padding(12)
          .backgroundColor('#F5F5F5')
          .borderRadius(8)
          .margin({ top: 12 })
        }
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F9F9F9')
      .borderRadius(12)

      // 生成码区域
      Column() {
        Text('生成码图')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .width('100%')
          .margin({ bottom: 12 })

        // 输入框
        TextInput({ placeholder: '请输入内容', text: this.inputContent })
          .onChange((value: string) => {
            this.inputContent = value
          })
          .margin({ bottom: 12 })

        // 操作按钮
        Row() {
          Button('生成二维码')
            .flexGrow(1)
            .enabled(!this.vm.isLoading)
            .onClick(() => {
              this.vm.generateQRCode(this.inputContent)
            })

          Button('生成条形码')
            .flexGrow(1)
            .margin({ left: 8 })
            .enabled(!this.vm.isLoading)
            .onClick(() => {
              this.vm.generateBarCode(this.inputContent)
            })
        }
        .width('100%')

        // 清除按钮
        if (this.vm.generatedQRCode) {
          Button('清除')
            .width('100%')
            .backgroundColor('#FF3B30')
            .margin({ top: 8 })
            .onClick(() => {
              this.vm.clearGeneratedCode()
            })
        }

        // 生成的码图
        if (this.vm.generatedQRCode) {
          Image(this.vm.generatedQRCode)
            .width(200)
            .height(200)
            .margin({ top: 16 })
            .objectFit(ImageFit.Contain)
        }
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F9F9F9')
      .borderRadius(12)
      .margin({ top: 16 })

      // 错误信息
      if (this.vm.errorMessage) {
        Text(this.vm.errorMessage)
          .fontSize(14)
          .fontColor('#FF3B30')
          .margin({ top: 16 })
      }

      // 加载指示器
      if (this.vm.isLoading) {
        LoadingProgress()
          .width(40)
          .height(40)
          .margin({ top: 20 })
      }

      Scroll() {
        Blank()
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
  }

  aboutToDisappear(): void {
    this.vm.aboutToRecycle()
  }
}

/**
 * 页面构建器
 */
@Builder
export function ScanKitExamplePageBuilder() {
  ScanKitExamplePage()
}
