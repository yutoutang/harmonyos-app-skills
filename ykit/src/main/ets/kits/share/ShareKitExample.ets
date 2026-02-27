/**
 * 分享 Kit 示例页面
 * 演示系统分享和 HarmonyOS 分享功能
 */

import {
  systemShare,
  harmonyShare
} from '@kit.ShareKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * 分享数据类型
 */
type ShareContentType = 'text' | 'image' | 'file'

/**
 * 分享 Kit 示例 ViewModel
 */
@ObservedV2
export class ShareKitExampleVM {
  @Trace shareText: string = ''
  @Trace imageUri: string = ''
  @Trace fileUri: string = ''
  @Trace isLoading: boolean = false
  @Trace errorMessage: string = ''
  @Trace successMessage: string = ''

  /**
   * 分享文本
   */
  async shareText(content: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''
    this.successMessage = ''

    try {
      await systemShare.share({
        uri: `text://${content || '这是分享的文本内容'}`
      })

      this.successMessage = '分享文本成功'
      hilog.info(0x0000, 'ShareKitExample', 'Share text success')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `分享文本失败: ${err.message}`
      hilog.error(0x0000, 'ShareKitExample', 'Share text failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 分享图片
   */
  async shareImage(uri: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''
    this.successMessage = ''

    try {
      await systemShare.share({
        uri: uri || 'file:///data/storage/el2/base/haps/entry/files/share_image.png',
        type: 'image'
      })

      this.successMessage = '分享图片成功'
      hilog.info(0x0000, 'ShareKitExample', 'Share image success')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `分享图片失败: ${err.message}`
      hilog.error(0x0000, 'ShareKitExample', 'Share image failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 分享文件
   */
  async shareFile(uri: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''
    this.successMessage = ''

    try {
      await systemShare.share({
        uri: uri || 'file:///data/storage/el2/base/haps/entry/files/share_file.pdf',
        type: 'file'
      })

      this.successMessage = '分享文件成功'
      hilog.info(0x0000, 'ShareKitExample', 'Share file success')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `分享文件失败: ${err.message}`
      hilog.error(0x0000, 'ShareKitExample', 'Share file failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * HarmonyOS 设备间分享
   */
  async shareToHarmonyDevice(content: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''
    this.successMessage = ''

    try {
      await harmonyShare.share({
        uri: `text://${content || 'HarmonyOS 分享内容'}`
      })

      this.successMessage = 'HarmonyOS 分享成功'
      hilog.info(0x0000, 'ShareKitExample', 'HarmonyShare success')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `HarmonyOS 分享失败: ${err.message}`
      hilog.error(0x0000, 'ShareKitExample', 'HarmonyShare failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 清除消息
   */
  clearMessages(): void {
    this.errorMessage = ''
    this.successMessage = ''
  }
}

/**
 * 分享 Kit 示例页面
 */
@ComponentV2
export struct ShareKitExamplePage {
  @Local vm: ShareKitExampleVM = new ShareKitExampleVM()

  build() {
    Column() {
      // 标题
      Text('分享 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      // 文本分享
      Column() {
        Text('文本分享')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .width('100%')
          .margin({ bottom: 12 })

        TextInput({ placeholder: '请输入要分享的文本', text: this.vm.shareText })
          .onChange((value: string) => {
            this.vm.shareText = value
          })
          .margin({ bottom: 12 })

        Row() {
          Button('系统分享')
            .flexGrow(1)
            .enabled(!this.vm.isLoading)
            .onClick(() => {
              this.vm.clearMessages()
              this.vm.shareText(this.vm.shareText)
            })

          Button('HarmonyOS 分享')
            .flexGrow(1)
            .margin({ left: 8 })
            .enabled(!this.vm.isLoading)
            .onClick(() => {
              this.vm.clearMessages()
              this.vm.shareToHarmonyDevice(this.vm.shareText)
            })
        }
        .width('100%')
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F9F9F9')
      .borderRadius(12)

      // 图片分享
      Column() {
        Text('图片分享')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .width('100%')
          .margin({ bottom: 12 })

        TextInput({ placeholder: '图片 URI (可选)', text: this.vm.imageUri })
          .onChange((value: string) => {
            this.vm.imageUri = value
          })
          .margin({ bottom: 12 })

        Button('分享图片')
          .width('100%')
          .enabled(!this.vm.isLoading)
          .onClick(() => {
            this.vm.clearMessages()
            this.vm.shareImage(this.vm.imageUri)
          })
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F9F9F9')
      .borderRadius(12)
      .margin({ top: 16 })

      // 文件分享
      Column() {
        Text('文件分享')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .width('100%')
          .margin({ bottom: 12 })

        TextInput({ placeholder: '文件 URI (可选)', text: this.vm.fileUri })
          .onChange((value: string) => {
            this.vm.fileUri = value
          })
          .margin({ bottom: 12 })

        Button('分享文件')
          .width('100%')
          .enabled(!this.vm.isLoading)
          .onClick(() => {
            this.vm.clearMessages()
            this.vm.shareFile(this.vm.fileUri)
          })
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#F9F9F9')
      .borderRadius(12)
      .margin({ top: 16 })

      // 消息提示
      if (this.vm.successMessage) {
        Text(this.vm.successMessage)
          .fontSize(14)
          .fontColor('#4CAF50')
          .margin({ top: 16 })
      }

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

      Blank()
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
  }
}

/**
 * 页面构建器
 */
@Builder
export function ShareKitExamplePageBuilder() {
  ShareKitExamplePage()
}
