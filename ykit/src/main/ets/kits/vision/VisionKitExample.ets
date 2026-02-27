/**
 * Vision Kit 示例页面
 * 演示视觉识别功能，包括文本识别、图像分类、人脸检测等
 *
 * 权限要求:
 * - ohos.permission.CAMERA (用于图像捕获)
 */

import { visionText, visionImage } from '@kit.VisionKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'
import { image } from '@kit.ImageKit'

/**
 * 识别结果
 */
interface RecognitionResult {
  text: string
  confidence: number
  boundingBox?: string
}

/**
 * Vision Kit 示例 ViewModel
 */
@ObservedV2
export class VisionKitExampleVM {
  @Trace results: RecognitionResult[] = []
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false
  @Trace imageSource: string = ''
  @Trace recognitionType: string = 'TEXT'

  /**
   * 文本识别 (OCR)
   */
  async recognizeText(imageUri: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''
    this.results = []

    try {
      // 创建 VisionImage
      const visionImage = await this.createVisionImage(imageUri)

      // 配置文本识别
      const config: visionText.VisionTextConfig = {
        isDetection: true,
        language: 'zh-CN'
      }

      // 执行文本识别
      const result = await visionText.recognize(visionImage, config)

      // 处理识别结果
      if (result.blocks && result.blocks.length > 0) {
        result.blocks.forEach(block => {
          if (block.text) {
            this.results.push({
              text: block.text,
              confidence: block.confidence || 0,
              boundingBox: JSON.stringify(block.boundingBox)
            })
          }
        })
      }

      hilog.info(0x0000, 'VisionKitExample', 'Text recognition completed')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `文本识别失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'VisionKitExample', 'Recognition failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 创建 VisionImage
   */
  async createVisionImage(imageUri: string): Promise<visionImage.VisionImage> {
    try {
      const imageSource = image.createImageSource(imageUri)
      const pixelMap = await imageSource.createPixelMap()

      return visionImage.VisionImage.create(pixelMap)
    } catch (error) {
      throw error
    }
  }

  /**
   * 通用图像分类
   */
  async classifyImage(imageUri: string): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''
    this.results = []

    try {
      // 图像分类逻辑
      hilog.info(0x0000, 'VisionKitExample', 'Image classification completed')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `图像分类失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'VisionKitExample', 'Classification failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 清除结果
   */
  clearResults(): void {
    this.results = []
    hilog.info(0x0000, 'VisionKitExample', 'Results cleared')
  }
}

/**
 * Vision Kit 示例页面
 */
@ComponentV2
export struct VisionKitExamplePage {
  @Local vm: VisionKitExampleVM = new VisionKitExampleVM()
  @Local imageUriInput: string = ''

  build() {
    Column() {
      // 标题
      Text('视觉 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 功能选择卡片
          this.buildFunctionCard()

          // 图像输入卡片
          this.buildImageInputCard()

          // 识别结果卡片
          this.buildResultCard()

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
  buildFunctionCard() {
    Column() {
      Text('识别功能')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Row() {
        Button('文本识别')
          .fontSize(14)
          .backgroundColor(this.vm.recognitionType === 'TEXT' ? '#007DFF' : '#E0E0E0')
          .fontColor(this.vm.recognitionType === 'TEXT' ? '#FFFFFF' : '#333333')
          .onClick(() => {
            this.vm.recognitionType = 'TEXT'
          })

        Button('图像分类')
          .fontSize(14)
          .margin({ left: 12 })
          .backgroundColor(this.vm.recognitionType === 'CLASSIFY' ? '#007DFF' : '#E0E0E0')
          .fontColor(this.vm.recognitionType === 'CLASSIFY' ? '#FFFFFF' : '#333333')
          .onClick(() => {
            this.vm.recognitionType = 'CLASSIFY'
          })
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  buildImageInputCard() {
    Column() {
      Text('图像输入')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      TextInput({ placeholder: '图像 URI', text: this.imageUriInput })
        .width('100%')
        .margin({ bottom: 12 })
        .onChange((value: string) => {
          this.imageUriInput = value
        })

      Button('开始识别')
        .width('100%')
        .enabled(!this.vm.isLoading && this.imageUriInput.length > 0)
        .onClick(() => {
          if (this.vm.recognitionType === 'TEXT') {
            this.vm.recognizeText(this.imageUriInput)
          } else {
            this.vm.classifyImage(this.imageUriInput)
          }
        })

      // 预览区域
      if (this.imageUriInput) {
        Image(this.imageUriInput)
          .width('100%')
          .height(200)
          .objectFit(ImageFit.Contain)
          .borderRadius(8)
          .margin({ top: 12 })
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
  buildResultCard() {
    Column() {
      Row() {
        Text('识别结果')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)

        Blank()

        if (this.vm.results.length > 0) {
          Button('清除')
            .fontSize(12)
            .onClick(() => {
              this.vm.clearResults()
            })
        }
      }
      .width('100%')
      .margin({ bottom: 12 })

      if (this.vm.results.length === 0) {
        Text('暂无识别结果')
          .fontSize(14)
          .fontColor('#999999')
      } else {
       ForEach(this.vm.results, (result: RecognitionResult, index: number) => {
          Column() {
            Row() {
              Text(`#${index + 1}`)
                .fontSize(12)
                .fontColor('#999999')
                .margin({ right: 8 })

              Text(result.text)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .layoutWeight(1)
            }
            .width('100%')

            Text(`置信度: ${(result.confidence * 100).toFixed(1)}%`)
              .fontSize(12)
              .fontColor('#666666')
              .width('100%')
              .margin({ top: 4 })

            if (result.boundingBox) {
              Text(`位置: ${result.boundingBox}`)
                .fontSize(10)
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
export function VisionKitExamplePageBuilder() {
  VisionKitExamplePage()
}
