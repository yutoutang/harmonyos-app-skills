/**
 * AR Engine 示例页面
 * 演示增强现实功能，包括平面检测、图像跟踪、人脸跟踪等
 *
 * 权限要求:
 * - ohos.permission.CAMERA
 */

import { arEngine } from '@kit.AREngineKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * AR 配置
 */
interface ARConfig {
  mode: string
  enablePlaneDetection: boolean
  enableImageTracking: boolean
}

/**
 * AR Engine 示例 ViewModel
 */
@ObservedV2
export class AREngineExampleVM {
  @Trace isInitialized: boolean = false
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false
  @Trace config: ARConfig = {
    mode: 'WORLD_TRACKING',
    enablePlaneDetection: true,
    enableImageTracking: false
  }
  @Trace detectedObjects: string[] = []

  /**
   * 初始化 AR 引擎
   */
  async initializeAR(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      // AR 引擎初始化逻辑
      this.isInitialized = true
      hilog.info(0x0000, 'AREngineExample', 'AR engine initialized')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `初始化失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'AREngineExample', 'Initialize failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 启动 AR 会话
   */
  async startSession(): Promise<void> {
    if (!this.isInitialized) {
      await this.initializeAR()
    }

    this.isLoading = true
    this.errorMessage = ''

    try {
      // 启动 AR 会话逻辑
      hilog.info(0x0000, 'AREngineExample', 'AR session started')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `启动失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'AREngineExample', 'Start session failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 停止 AR 会话
   */
  async stopSession(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      // 停止 AR 会话逻辑
      hilog.info(0x0000, 'AREngineExample', 'AR session stopped')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `停止失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'AREngineExample', 'Stop session failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 添加虚拟对象
   */
  addVirtualObject(type: string): void {
    this.detectedObjects.push(`${type}_${Date.now()}`)
    hilog.info(0x0000, 'AREngineExample', `Virtual object added: ${type}`)
  }

  /**
   * 清除对象
   */
  clearObjects(): void {
    this.detectedObjects = []
    hilog.info(0x0000, 'AREngineExample', 'Objects cleared')
  }
}

/**
 * AR Engine 示例页面
 */
@ComponentV2
export struct AREngineExamplePage {
  @Local vm: AREngineExampleVM = new AREngineExampleVM()

  build() {
    Column() {
      Text('AR Engine 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 控制面板
          this.buildControlCard()

          // AR 视图预览
          this.buildARPreviewCard()

          // 对象列表
          this.buildObjectsCard()

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
  buildControlCard() {
    Column() {
      Text('AR 控制')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Row() {
        Button('初始化')
          .enabled(!this.vm.isLoading && !this.vm.isInitialized)
          .onClick(() => {
            this.vm.initializeAR()
          })

        Button('启动')
          .margin({ left: 8 })
          .enabled(!this.vm.isLoading && this.vm.isInitialized)
          .onClick(() => {
            this.vm.startSession()
          })

        Button('停止')
          .margin({ left: 8 })
          .backgroundColor('#FF3B30')
          .enabled(!this.vm.isLoading && this.vm.isInitialized)
          .onClick(() => {
            this.vm.stopSession()
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
  buildARPreviewCard() {
    Column() {
      Text('AR 预览')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Column() {
        Text('AR 视图区域')
          .fontSize(14)
          .fontColor('#999999')
      }
      .width('100%')
      .height(300)
      .backgroundColor('#000000')
      .borderRadius(8)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .margin({ top: 16 })
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  buildObjectsCard() {
    Column() {
      Row() {
        Text('虚拟对象')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)

        Blank()

        if (this.vm.detectedObjects.length > 0) {
          Button('清除')
            .fontSize(12)
            .onClick(() => {
              this.vm.clearObjects()
            })
        }
      }
      .width('100%')
      .margin({ bottom: 12 })

      // 添加对象按钮
      Row() {
        Button('立方体')
          .fontSize(12)
          .onClick(() => {
            this.vm.addVirtualObject('cube')
          })

        Button('球体')
          .fontSize(12)
          .margin({ left: 8 })
          .onClick(() => {
            this.vm.addVirtualObject('sphere')
          })

        Button('平面')
          .fontSize(12)
          .margin({ left: 8 })
          .onClick(() => {
            this.vm.addVirtualObject('plane')
          })
      }
      .width('100%')
      .margin({ bottom: 12 })

      // 对象列表
      if (this.vm.detectedObjects.length === 0) {
        Text('暂无虚拟对象')
          .fontSize(14)
          .fontColor('#999999')
      } else {
       ForEach(this.vm.detectedObjects, (obj: string, index: number) => {
          Text(`${index + 1}. ${obj}`)
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

    if (this.vm.isLoading) {
      LoadingProgress()
        .width(40)
        .height(40)
        .margin({ top: 16 })
    }
  }
}

@Builder
export function AREngineExamplePageBuilder() {
  AREngineExamplePage()
}
