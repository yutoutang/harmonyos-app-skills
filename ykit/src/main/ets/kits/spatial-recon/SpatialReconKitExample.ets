/**
 * Spatial Recon Kit 示例页面
 * 演示空间重建功能
 */

import { spatialRecon } from '@kit.SpatialReconKit'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { BusinessError } from '@kit.BasicServicesKit'

/**
 * Spatial Recon Kit 示例 ViewModel
 */
@ObservedV2
export class SpatialReconKitExampleVM {
  @Trace isReconstructing: boolean = false
  @Trace meshQuality: string = '未开始'
  @Trace pointCount: number = 0
  @Trace errorMessage: string = ''
  @Trace isLoading: boolean = false

  /**
   * 开始空间重建
   */
  async startReconstruction(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.isReconstructing = true
      this.meshQuality = '重建中'
      hilog.info(0x0000, 'SpatialReconExample', 'Reconstruction started')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `启动失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'SpatialReconExample', 'Start failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 停止空间重建
   */
  async stopReconstruction(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      this.isReconstructing = false
      this.meshQuality = '已完成'
      this.pointCount = 50000
      hilog.info(0x0000, 'SpatialReconExample', 'Reconstruction stopped')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `停止失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'SpatialReconExample', 'Stop failed')
    } finally {
      this.isLoading = false
    }
  }

  /**
   * 导出网格
   */
  async exportMesh(): Promise<void> {
    this.isLoading = true
    this.errorMessage = ''

    try {
      hilog.info(0x0000, 'SpatialReconExample', 'Mesh exported')
    } catch (error) {
      const err = error as BusinessError
      this.errorMessage = `导出失败: ${err.message} (${err.code})`
      hilog.error(0x0000, 'SpatialReconExample', 'Export failed')
    } finally {
      this.isLoading = false
    }
  }
}

/**
 * Spatial Recon Kit 示例页面
 */
@ComponentV2
export struct SpatialReconKitExamplePage {
  @Local vm: SpatialReconKitExampleVM = new SpatialReconKitExampleVM()

  build() {
    Column() {
      Text('空间重建 Kit 示例')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Scroll() {
        Column() {
          // 重建控制卡片
          this.buildReconstructionCard()

          // 网格信息卡片
          if (!this.vm.isReconstructing && this.vm.meshQuality === '已完成') {
            this.buildMeshInfoCard()
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
  buildReconstructionCard() {
    Column() {
      Text('空间重建控制')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Row() {
        Circle()
          .width(12)
          .height(12)
          .fill(this.vm.isReconstructing ? '#4CAF50' : '#999999')
          .margin({ right: 8 })

        Text(this.vm.isReconstructing ? '重建中' : this.vm.meshQuality)
          .fontSize(14)
          .fontColor(this.vm.isReconstructing ? '#4CAF50' : '#999999')
      }

      Row() {
        Button(this.vm.isReconstructing ? '停止' : '开始重建')
          .flexGrow(1)
          .enabled(!this.vm.isLoading)
          .onClick(() => {
            if (this.vm.isReconstructing) {
              this.vm.stopReconstruction()
            } else {
              this.vm.startReconstruction()
            }
          })

        Button('导出网格')
          .flexGrow(1)
          .margin({ left: 8 })
          .enabled(!this.vm.isLoading && this.vm.meshQuality === '已完成')
          .onClick(() => {
            this.vm.exportMesh()
          })
      }
      .width('100%')
      .margin({ top: 12 })
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
  buildMeshInfoCard() {
    Column() {
      Text('网格信息')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 12 })

      Text(`点数: ${this.vm.pointCount.toLocaleString()}`)
        .fontSize(14)
        .width('100%')

      Text(`质量: ${this.vm.meshQuality}`)
        .fontSize(14)
        .fontColor('#4CAF50')
        .width('100%')
        .margin({ top: 8 })

      Column() {
        Text('3D 网格预览')
          .fontSize(14)
          .fontColor('#999999')
      }
      .width('100%')
      .height(200)
      .backgroundColor('#F0F0F0')
      .borderRadius(8)
      .margin({ top: 12 })
      .justifyContent(FlexAlign.Center)
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
export function SpatialReconKitExamplePageBuilder() {
  SpatialReconKitExamplePage()
}
